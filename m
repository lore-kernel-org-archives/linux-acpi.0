From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Sat, 29 May 2004 13:45:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040529114512.GD25121@elf.ucw.cz>
References: <200405180213.34603.andre@eisenbach.com> <200405280221.52819.andre@eisenbach.com> <20040528093102.GG1808@elf.ucw.cz> <200405280536.50261.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200405280536.50261.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
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

Can you get any data out of notebook? Like 8 leds on paralel port, pci
card decoding port 0x80 etc? [That's where soldering iron might be usefull].

> Stupid question of the evening:
> 
> It's 5am here and I've just spent about the whole night playing witch ACPI, 
> DSDTs etc...
> 
> The notebook I have can only resume from standby by pressing the power button. 
> Could it be, that when the power button is pressed, the system starts to wake 
> up, but the "power button event" is not intercepted by ACPI and passes 
> through to "the hardware", causing the notebook to shut down for
> good?

Improbable.

> I know thats in very rough laymans terms, but I hope it's enough for you guys 
> to tell me just how wrong I am ;).
> 
> Here's a rought flowchart of what's happening on my notebook (afer 6. is the 
> problem):
> 
> 1. echo 3 > proc/acpi/sleep
> 2. PM: Preparing system for suspend
> 3. Stopping tasks: ==================|
> 
> 4. --> Notebook enters standby. HD quiet, LCD off, fans off, On/Off LED pulses 
> slowly
> 
> 5. Press power button to wake notebok
> 
> 6. --> Notebook tries to leave standby. HD spins up, LCD light on but no text, 
> fans start...
> 7. --> Not even 1/2 second later, all off. Notebook is off. On/Off
> LED off

Easy. Insert infinite loop at begining of wakeup_start. If it hangs,
you know it reached wakeup_start, and fix wakeup code. If it does not,
we left hardware at "bad" (i.e. bios did not like it) state before
suspend, fix suspend code. (Turn off APIC etc). [This is where your
assembly skills come handy.]

> 8. Press power button again.
> 9. --> Normal boot...
> 
> Could it be that there's some magic power-off event queued up when you press 
> the button?

If ACPI event was queued, it would do clean shutdown; you'd notice
that.
								Pavel
PS: When stuck, try asking your black cat :-).

-- 
934a471f20d6580d5aad759bf0d97ddc


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
