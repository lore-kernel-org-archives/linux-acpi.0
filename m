From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: constant processor 0x80 events
Date: Thu, 2 Jan 2003 22:03:09 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030102220309.GA10618@clara.net>
References: <20030102135937.GA9257@clara.net> <000201c2b284$89a033c0$232202d3@sayonara>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000201c2b284$89a033c0$232202d3-F8JvWDuGsZU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Adachi, Kenichi [aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org] wrote:
> Do you mean, because of your hack in DSDT, your processor is forced to
> be in P1 upon GPE0 and it saves you from turbulent storm of event
> handlings by cooling your box? And after your processor is relatively
> chilled, you (manually?) initiate P-State transition to P0 (by
> autospeedstep?), since your processor stays in P1? 
> Interesting...

GPE0, L00 method is called, it only does anything if THRT is false.
if THRT is false, it is set to one, and stops the flood of 0x80
processor events.

The event is received by the OS which calls _PPC method.  This checks
the state of THRT and if 1, it is reset and returns one, setting the
processor to P1.

Autospeedstep sets the state to P0 if the load is above 70% but only
once it has set the load to P1 itself.

> Can you take a look at "BIOS-provided physical RAM map" in your dmesg
> and verify MNVS OpRegion (0x20 bytes starting from 0x1FF73E7D) is within
> ACPI NVS Memory? ACPI NVS is saved/restored across system sleep/wake
> cycle and if THRT is in this range, any possible side effects are less
> harmful, as it's not mapped to critical hardware resource. 

 BIOS-e820: 000000001ff73c00 - 000000001ff80000 (ACPI NVS)

That's good news.

I'll run with this for a while and see how it goes.

I had some messages a while back from someone who said he was in touch
with the BIOS people.  I'll see if I can get back in touch and find out
what they actually intended!

Thanks for all your help.


Faye

-- 
Mount St. Helens should have used earth control.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
