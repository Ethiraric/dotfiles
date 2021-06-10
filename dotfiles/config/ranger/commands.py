# {{@@ header() @@}}

# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------
from ranger.api.commands import Command

class fzf_select(Command):
    """
    :fzf_select
    Find a file using fzf.
    With a prefix argument select only directories.
    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            command="find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        else:
            # match files and directories
            command="find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to filemap <C-f> fzf_select'"
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class tar(Command):
    def execute(self):
        import os
        src_paths = [os.path.relpath(f.realpath, self.fm.thisdir.path) for f in self.fm.thistab.get_selection()]
        if len(src_paths) == 0:
            self.fm.notify("No selection to send to tar", bad=True)
            return
        if len(self.args) > 1:
            if self.args[1] != '--name' or len(self.args) != 3:
                self.fm.notify("Usage: tar [--name [<destination.tar>]]", bad=True)
                return
            else:
                if not self.args[2].endswith('.tar'):
                    self.args[2] = self.args[2] + '.tar'
                cmd = ['tar', '-cf', self.args[2]]
                for path in src_paths:
                    cmd.append(path)
                self.fm.execute_command(cmd)
                self.fm.mark_files(all=True, val=False)
                # self.fm.notify(cmd)
                self.fm.notify('Archive crated');
                return
        else:
            if len(src_paths) == 1:
                self.fm.execute_console(f'tar --name {src_paths[0]}.tar')
            else:
                self.fm.open_console('tar --name ')
