From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.9-rc3+: reports battery as 0 mWh capacity on thinkpad x60
Date: Sat, 23 Mar 2013 21:21:56 +0100
Message-ID: <20130323202155.GC18732@amd.pavel.ucw.cz>
References: <20130323114011.GA11092@amd.pavel.ucw.cz>
 <1364045783.tg02458AIS@vostro.rjw.lan>
 <87zjxu9spk.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44641 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3CWUWV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Mar 2013 16:22:21 -0400
Content-Disposition: inline
In-Reply-To: <87zjxu9spk.fsf@nemi.mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Sat 2013-03-23 14:00:23, Bj=F8rn Mork wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > On Saturday, March 23, 2013 12:40:12 PM Pavel Machek wrote:
> >> Hi!
> >>=20
> >> pavel@amd:~$ cat /proc/acpi/battery/BAT0/info=20
> >> present:                 yes
> >> design capacity:         0 mWh
> >> last full capacity:      0 mWh
> >> battery technology:      rechargeable
> >> design voltage:          14400 mV
> >>=20
> >> This worked before... at least it works in 2.6 kernel used by debi=
an.
> >
> > This works for me in 3.9-rc3.  May I see your .config?
>=20
> Well, if this works, then maybe the Kconfig help text should be updat=
ed:
>=20
> config ACPI_PROCFS_POWER
>         bool "Deprecated power /proc/acpi directories"
>         depends on PROC_FS
>         help
>           For backwards compatibility, this option allows
>           deprecated power /proc/acpi/ directories to exist, even whe=
n
>           they have been replaced by functions in /sys.
>           The deprecated directories (and their replacements) include=
:
>           /proc/acpi/battery/* (/sys/class/power_supply/*)
>           /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
>           This option has no effect on /proc/acpi/ directories
>           and functions, which do not yet exist in /sys
>           This option, together with the proc directories, will be
>           deleted in 2.6.39.
>=20
>=20
> Time to call the bluff now :)

This should probably be "default y", BTW.

But problem is not in /proc, /sys has zeros, too.

pavel@amd:~$ cat /sys/class/power_supply/BAT0/energy_full
0
pavel@amd:~$ cat /sys/class/power_supply/BAT0/energy_full_design=20
0
pavel@amd:~$ cat /sys/class/power_supply/BAT0/model_name=20
93P5030
pavel@amd:~$=20


		      	   	       	  	    	     Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
