From: John <cirrus-m8NPtmh9OiN1HeySrBk8eLVCufUGDwFn@public.gmane.org>
Subject: Re: Acer 1703 and DSDT fixing questions
Date: Wed, 11 Feb 2004 16:50:55 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402111650.55343.cirrus@the-penguin.org.uk>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68B@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB68B-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 11 February 2004 01:43, Yu, Luming wrote:
> > $ cat /proc/acpi/battery/BAT1/state
> > present:                 yes
> > capacity state:          ok
> > charging state:          unknown
> > present rate:            unknown
> > remaining capacity:      5579 mAh
> > present voltage:         16660 mV
>
> Presumably, this battery is full. And there is no charging/discharging
> activity.
>
Yes in this instant the battery was full, but still:
$ cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            unknown
remaining capacity:      5524 mAh
present voltage:         16249 mV

The present rate is unknown. Also alarms are not working. 
$ cat /proc/acpi/battery/BAT1/alarm
alarm:                   unsupported

I presume that this is a DSDT problem isn't it?

> Could you post the buggy part of DSDT code to let me understand it's not
> ACPI interpreter bug.
What do you mean exactly?
I don't know where the problem in the DSDT is. Thats why I posted it.
Again the address you can have a look at it is:
http://www.zen34434.zen.co.uk/acer.dsl

Am I missing something here?

Thanks,
Cirrus

-- 
panic("Oh boy, that early out of memory?");
	2.2.16 /usr/src/linux/arch/mips/mm/init.c


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
