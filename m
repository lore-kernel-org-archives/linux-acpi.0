From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Compaq presario 2556EU
Date: Fri, 27 Aug 2004 21:55:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040827195546.GC709@openzaurus.ucw.cz>
References: <200408230852.48290.hp@syntomax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408230852.48290.hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hein-Pieter van Braam <hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!


> S3 state:
> I've tried to do everything I could find on the mailing lists, in 
> Documentation/power/tricks.txt and Documentation/power/video.txt.
> I've tried this with kernel versions 2.6.7 and 2.6.8.1 with and without the 
> acpi patches from acpi.sf.net, doesn't make a lick of difference.
> I've also tried with acpi=noirc pci=noacpi acpi_sleep=s3_mode 
> acpi_sleep=s3_bios (and all possible combinations of those) tried various 
> apic settings off,on and whatever I could find in kernel-parameters.txt
> with or without device drivers loaded, with a kernel whith no hardware support 
> other than what's needed to get the thing booting (+acpi) in single user mode 
> and with init=/bin/bash 
> 
> Well, suspending seems to go fine, but the resuming is where things start to 
> go wrong :) the system enters the state in a normal way, stopping tasks, 
> entering state etc. and the power led starts to glow (or blink what you want 
> to call it)
> 
> As soon as I press the power button again, the power led lights up again, and 
> the led behind my power button lights up again to, my keyboard leds flash, 
> and I get a second or something of HDD activity. After that, nothing. My 
> keyboard leds (IE capslock) won't work anymore, and I can't get any hdd 
> activity (I tried typing in hdparm -t /dev/hda to get some) 
> I've got no networking (if I enable that, which doesn't seem to matter for the 
> overall effect) 
> 
> The thing's a brick basically :)
> 
> I've also tried the following advanced script :)
> #!/bin/bash
> echo mem > /sys/power/state
> touch isitworking

sync missing here :-).

> well, no "isitworking"
> 
> One other weird thing I noticed is that as soon as I press the power button 
> and keep hitting the capslock key frantically it keeps responding for about 5 
> seconds until it's stuck in the state that it's in (ie if it crashes with the 
> caps lock led on, it stays on, and vice versa)

Try mapping capslock on something else, see if that still works.

But this is very hard to debug, and nearly impossible to do remotely.
You are probably hitting 2 bugs at same time. Solve video somehow, and
then you can debug second one...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
