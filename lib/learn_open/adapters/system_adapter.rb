module LearnOpen
  class SystemAdapter
    def self.open_editor(editor, path:)
      system("#{editor} .")
    end

    def self.open_login_shell(shell)
      exec("#{shell} -l")
    end

    def self.watch_dir(dir, action)
      spawn("while inotifywait -e close_write,create,moved_to -r #{dir}; do #{action}; done")
    end

    def self.spawn(command, block: false)
      pid = Process.spawn(command, [:out, :err] => File::NULL)
      Process.waitpid(pid) if block
    end

    def self.run_command(command)
      system(command)
    end
  end
end
