From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI on SONY laptop
Date: Wed, 25 Feb 2004 00:37:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040224233757.GC438@elf.ucw.cz>
References: <1077480804.4085.19.camel@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1077480804.4085.19.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Roman Jordan <RomanJordan-Mmb7MZpHnFY@public.gmane.org>
Cc: ACPI Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> i use the linux kernel 2.6.3 and a PCG-FX505 sony laptop, based of AMD
> 1200 mobile processor.
> I have compiled in ACPI support. The /sys filesystem is mounted. If i
> run 'echo -n "disk" > /sys/power/state" the system is shutting down and
> restarts immediately. The backlight is also not switched off.

Try it without network driver, and try using swsusp, not pmdisk.

								Pavel

> 
> Stopping tasks:
> ==============================================================|
> Freeing memory: ...................|
> hdc: start_power_step(step: 0)
> hdc: completing PM request, suspend
> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_step(step: 1, stat: 50, err: 0)
> hda: completing PM request, suspend
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.
> eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
> hda: Wakeup request inited, waiting for !BSY...
> hda: start_power_step(step: 1000)
> hda: completing PM request, resume
> hdc: Wakeup request inited, waiting for !BSY...
> hdc: start_power_step(step: 1000)
> hdc: completing PM request, resume
> Restarting tasks... done
> 
> 
> 
> Any ideas,
> Roman Jordan
> 
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
