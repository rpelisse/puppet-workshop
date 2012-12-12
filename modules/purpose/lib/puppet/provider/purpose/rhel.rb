Puppet::Type.type(:purpose).provide(:rhel) do
    desc = "..."

    def create
        begin
            file = File.open("/etc/purpose", "w")
                file.write("I have a purpose in life - and you ?")
        rescue IOError => e
              #some error occur, dir not writable etc.
        ensure
              file.close unless file == nil
        end
    end

    def destroy
        File.unlink('/etc/purpose')
    end

    def exists?
        File.exists?('/etc/purpose')
    end
end
