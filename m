From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: Compaq 1700, 2.4.18, acpi-7,24 - SUCCESS (I think)
Date: Thu, 15 Aug 2002 11:32:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020815103244.GA7621@clara.net>
References: <15706.48376.457358.298696@chaos.crhc.uiuc.edu> <Pine.GSO.4.21.0208142004370.16304-100000@sediment.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208142004370.16304-100000-Bq+f90TzBY23n+kRt3O4EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Prabhakar Reddy Gudla Venkata Siva [reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org] wrote:
> Graham, nice to see that I am not all alone :) I too have the same status
> with the acpi-20020726 patch on a similar model (mine is 1720US).
> 
> However, my kernel just keeps repeating "schedule_task(): kevent has not
> started" after the alleged two "PCI Interrupt Link enabled" statements. It
> never freezes.

My kernel would freeze if I enabled Local APIC on Uniprocessor.  Since
ACPI does the IRQ routing this is probably what is confusing things.
It would be useful if the one could override the other if it's being
used.  I make mention of this on my website and my kernel patch's default
configuration has these options disabled.

Other people have mentioned a problem with losing interrupts on some
models of Compaq - I haven't suffered from this and there is a patch for
this which someone has made (which since I don't use it hasn't stuck in
my memory I'm afraid).

I do get the warning about the unknown device, but I ignored it as I
knew I didn't have the device.  I will remove it from my DSDT now I know
what's causing it ;)


Faye

-- 
Faye Pearson,
Software Development Manager,
ClaraNET Ltd.       Tel 020 7903 3000

Even God lends a hand to honest boldness.
		-- Menander


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
