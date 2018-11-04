from ranger.api.commands import Command
import os

class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.
    """
    def execute(self):
        import subprocess
        if self.quantifier:
            # match only directories
            command = "fd --type d --hidden --follow --exclude .git . | fzf +m"
        else:
            # match files and directories
            command = "fd --hidden --follow --exclude .git . | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
