From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: first shoot for smartbattery
Date: Sun, 09 Jan 2005 14:41:52 +0100
Message-ID: <m2oefyzplr.fsf@phoenix.squirrel.nl>
References: <41D56002.5060008@mega.ist.utl.pt>
	<20041231150724.GK19199@poupinou.org>
	<20041231181628.GL19199@poupinou.org>
	<20050101082605.GA24896@phys.ethz.ch>
	<m2acrth375.fsf@phoenix.squirrel.nl>
	<20050103143902.GQ19199@poupinou.org>
	<41D97AF3.7000409@arrakis.dhis.org>
	<41D98251.9020002@arrakis.dhis.org>
	<20050103180219.GX19199@poupinou.org>
	<41D9A1F5.1060508@arrakis.dhis.org>
	<20050104100844.GA19199@poupinou.org>
	<41DAB539.2020605@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41DAB539.2020605-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org> (Pedro Venda's message of
 "Tue, 04 Jan 2005 15:24:41 +0000")
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

Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org> writes:

> I actually read some of the pdf you pointed me to and implemented a
> couple of functions on the smartbattery.c. It now gets much more
> information from the battery. If you find it relevant, I'll clean it
> up a bit and post a patch for you. I know it will soon be dumped,
> but it may show useful when debugging other driver informations.

The attached program produces a nice battery status display using your
modified version of battstat. It may be temporary, but at least now I
have decent battery info at hand.

-- Johan


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=battstat.pl

#!/usr/bin/perl -w

# Quick hack to get a battery status display.
# Uses Pedro Venda's modified version of Bruno Ducrot's version
# of the smart battery reader (not included).
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

################ Configuration ################

my $interval = 10;		# Poll interval
my $prog = "smartbattery2 0";	# command

# Regular output of $prog is:
#
#	status:			discharging	initialized
#	mode:			capacity in 10 mW/mWh
#	design voltage:		14800 mV
#	design charge capacity:	4400 mAh or mWh
#	absolute charge:	90%
#	full charge capacity:	4270 mAh or mWh
#	relative charge:	93%
#	current:		-908 mA
#	voltage:		16271 mV
#	remain:			3966 mA
#	average time to empty:	261 minutes
#	average time to full:	65535 minutes
#	temperature:		24.2 C
#	cycle count:		12

################ End Configuration ################

my $status = 0;

my $mw = MainWindow->new;
$mw->title("Battery: Starting");

my $p = $mw->ProgressBar
  (-troughcolor => 'LightSkyBlue3',
   -borderwidth => 0,
   -length => 120,
   -width => 8,
   -variable => \$status,
   -colors => [0 => 'red', 10 => 'yellow', 20 => 'green'],
   #	 -blocks => 10,		# default
   -anchor => 'w',
   -from => 0,
   -to => 100,
  )->pack(-expand => 1);

# Check every 10 seconds.
$mw->repeat (10000, \&update);

my $state = 0;
update();

MainLoop;

sub update {

    my $res = `smartbattery2 $smbus 2>&1`;
    return unless $res;

    my ($current, $fill, $time, $tp);
    $current = $1 if $res =~ /current:\s+(-?\d+)\s+ma/i;
    $tp = $current < 0 ? 'empty' : 'full';
    $fill = $1    if $res =~ /relative charge:\s+(\d+)%/i;
    $time = $1    if $res =~ /average time to $tp:\s+(\d+)\s+minutes/i;
    if ( $time ) {
	my ($h, $m);
	$h = int($time / 60);
	$m = $time % 60;
	$time = sprintf("%d:%02d", $h, $m);
    }

    if ( $current > 0 ) {	# charging
	$status = 0;
    }
    elsif ( $current < 0 ) {	# discharging
	$status = $fill;
    }
    else {			# fully charged
	$status = 100;
    }
    $mw->title("Battery: $time ($status%)");

    # This is a kludge to get the ProgressBar to display uniform, but
    # different colours depending on the fill status.

    if ( $status >= 30 ) {
	if ( $state < 30 ) {
	    $p->{Configure}{-colors} = [ 0, 'green' ];
	    $p->{Configure}{-troughcolor} = 'darkgreen';
	    Tk::ProgressBar::_layoutRequest($p, 1);
	    $state = 30;
	}
    }
    elsif ( $status >= 10 ) {
	if ( $state < 10 || $state >= 30 ) {
	    $p->{Configure}{-colors} = [ 0, 'yellow' ];
	    $p->{Configure}{-troughcolor} = 'orange';
	    Tk::ProgressBar::_layoutRequest($p, 1);
	    $state = 10;
	}
    }
    elsif ( $state >= 10 ) {
	$p->{Configure}{-colors} = [ 0, 'red' ];
	$p->{Configure}{-troughcolor} = 'darkred';
	Tk::ProgressBar::_layoutRequest($p, 1);
	$state = 0;
    }
}

--=-=-=--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
