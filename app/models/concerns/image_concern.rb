module ImageConcern

    extend ActiveSupport::Concern

    module ClassMethods
      def has_image(field, options = {})

        options[:resize] = 150 if options[:resize].nil?

        after_save "#{field}_after_upload".to_sym
        before_save "#{field}_before_upload".to_sym
        after_destroy_commit "#{field}_destroy".to_sym

        attr_accessor "#{field}_file".to_sym
        validates "#{field}_file".to_sym, file: {ext: [:jpg, :png]}

        class_eval <<-METHODS, __FILE__, __LINE__
          def #{field}_url
            '/' + ['images',
                    self.class.name.downcase.pluralize,
                    id.to_s,
                    '#{field}.jpg'
                  ].join('/')
          end

          def #{field}_path
            File.join(
              Rails.public_path,
              'images',
              self.class.name.downcase.pluralize,
              id.to_s,
              '#{field}.jpg'
            )
          end

          private

            def #{field}_before_upload
              if #{field}_file.respond_to? :path and self.respond_to?(:#{field})
                self.#{field} = true
              end
            end

          def #{field}_after_upload
            path = #{field}_path
            if #{field}_file.respond_to? :path
              dir = File.dirname(path)
              FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
              image = MiniMagick::Image.new(#{field}_file.path) do |i|
                i.resize '#{options[:resize]}x#{options[:resize]}^'
                i.gravity 'Center'
                i.crop '#{options[:resize]}x#{options[:resize]}+0+0'
              end
              image.format 'jpg'
              image.write path
            end
          end

          def #{field}_destroy
            dir = File.dirname(#{field}_path)
            FileUtils.rm_r(dir) if Dir.exist?(dir)
          end


        METHODS
      end
    end

end
