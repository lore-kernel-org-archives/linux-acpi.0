From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Mon, 31 May 2004 10:47:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040531084701.GC24008@elf.ucw.cz>
References: <200405180213.34603.andre@eisenbach.com> <200405280536.50261.andre@eisenbach.com> <20040529114512.GD25121@elf.ucw.cz> <200405302100.36915.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200405302100.36915.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Am Samstag Mai 29 2004 04:45 schrieb Pavel Machek:
> > Can you get any data out of notebook? Like 8 leds on paralel port, pci
> > card decoding port 0x80 etc? [That's where soldering iron might be
> > usefull].
> 
> Yes, I can hook up the parallel port. Just let me know where we're gonna use 
> it.

Not yet, but something like that is neccessary for debugging wakeup
phase.

> > > 7. --> Not even 1/2 second later, all off. Notebook is off. On/Off
> > > LED off
> >
> > Easy. Insert infinite loop at begining of wakeup_start. If it hangs,
> > you know it reached wakeup_start, and fix wakeup code. If it does not,
> > we left hardware at "bad" (i.e. bios did not like it) state before
> > suspend, fix suspend code. (Turn off APIC etc). [This is where your
> > assembly skills come handy.]
> 
> I put an endless loop into wakeup_start. Nothing changed. Same behaviour. I 
> also recompiled the kernel without APIC, but I'm not sure thats what you 
> meant.

Okay, so problem is with suspend. Recompiling without APIC was good
idea, see also tricks.txt what more you can do.

> Where do I find the suspend code?

Its all around acpi, last thing it does is in
drivers/acpi/hardware/hwsleep.c.
									Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
