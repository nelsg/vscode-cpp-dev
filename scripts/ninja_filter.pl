use strict;
use warnings;
use utf8;
use FindBin;
use File::Basename;
use Cwd qw(abs_path realpath);

my $workspace_dir = dirname($FindBin::Bin);
my $show_cache = 0;
my $out_log = "";
while (my $line = <>) {
    if ($line =~ /no work to do/) {
        $show_cache = 1;
        next;
    }
    $line =~ s/([\.\/][^:]+)(:\d+:)/File::Spec->abs2rel(abs_path($1), $workspace_dir) . $2/e;
    print "$line";
    $out_log .= $line;
}

if ($show_cache) {
    open (my $fh, '< ninja_build.log') or die "$!";
    local $/ = undef;
    $out_log = <$fh>;
    print $out_log;
    close ($fh);
} else {
    open (my $fh, '> ninja_build.log') or die "$!";
    print $fh $out_log;
    close ($fh);
}
