From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: CPU status display
Date: Sun, 09 Jan 2005 15:06:07 +0100
Message-ID: <m2k6qmzohb.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

This little program shows the current state of the CPU.
It displays the current CPU frequency step (1 box = lowest,
2 boxes = one step higher, etc.
The box colour reflects the sleep state: blu e= C4, green = C3,
yellow = C2 and red = C1.

It's a hack, but fun.

-- Johan


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=cpustat.pl

#!/usr/bin/perl -w

# Quick hack to get CPU status display.
#
# It displays the current CPU frequency step (1 box = lowest,
# 2 boxes = one step higher, etc.
# The box colour reflects the sleep state: blu e= C4, green = C3,
# yellow = C2 and red = C1.
#
# Copyright 2005 Johan Vromans, Squirrel Consultancy.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

use strict;
use Tk;
use Tk::ProgressBar;

my $freq = "/sys/devices/system/cpu/cpu0/cpufreq";
my $power = "/proc/acpi/processor";

my @freqs = split(' ', cat($freq."/scaling_available_frequencies"));

# warn("@freqs\n");
exit(1) unless @freqs > 1;

my $status = 0;
my $prevstate = '';
my %stcol = ( C4 => 'blue',
	      C3 => 'green',
	      C2 => 'orange',
	      C1 => 'red' );

my $mw = MainWindow->new;
$mw->title("CPU Status");

my $max = @freqs;

my $p = $mw->ProgressBar
  (-troughcolor => 'LightSkyBlue3',
   -borderwidth => 0,
   -length => 120,
   -width => 8,
   -variable => \$status,
   -colors => [0 => 'black' ],
   -blocks => $max,
   -anchor => 'w',
   -from => 0,
   -to => $max,
  )->pack(-expand => 1);

$mw->repeat (2000, \&update);
update();
MainLoop;

sub update {
    my $cur = 0 + cat($freq."/scaling_cur_freq");

    my $t = cat("$power/CPU0/power");
    my $state;
    my $title = "CPU: ";
    if ( $t =~ /^active state:\s+(\S+)/m ) {
	my $s = $1;
	$title .= " $s";
	# $state .= "CPU state: $1";
	# $state = " [$1]" if $t =~ /\s\*?$s:\s+type\[(.*?)\]/m;
	if ( $t =~ /\s\*?$s:\s+type\[(.*?)\]/m ) {
	    $state = $1;
	    $title .= " [$state]";
	}
    }

    if ( $prevstate ne $state ) {
	$p->{Configure}{-colors} = [ 0,
				     $stcol{$state} || 'black' ];
	Tk::ProgressBar::_layoutRequest($p, 1);
	$prevstate = $state;
    }

    for ( my $i = 0; $i < @freqs; $i ++ ) {
	if ( $cur == $freqs[$i] ) {
	    $status = @freqs - $i;
	    # warn("cur = $cur @ $status [$state => $stcol{$state}]\n");
	    $t = int($cur / 1000);
	    if ( $t >= 1000 ) {
		$cur = sprintf("%.1fGHz", $t/1000);
	    }
	    else {
		$cur = $t . "MHz";
	    }
	    $title .= " @ $cur";
	    $mw->title($title);
	    return;
	}
    }
    $status = 0;
}

sub cat {
    my $file = shift;
    local($/) = undef;
    my $ret = "";
    my $cat;
    open($cat, $file) and
      $ret = <$cat> and
	close($cat);
    $ret;
}

--=-=-=--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
