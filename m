From: Dan Moore <dan-2czqXp8lH1M@public.gmane.org>
Subject: Compaq Proliant DL380 G1
Date: Sat, 6 Mar 2004 20:03:52 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0402270933510.770@andromeda.68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Greetings,

I have, as the subject vaguely implies, a G1 Compaq Proliant DL380 with
two CPUs.  I'm running 2.4.24 (plus the latest ACPI patch), and ACPI on it
is lacking in two particular cases:

Power Button - the power button does not seem to produce events (no output
on 'cat /proc/acpi/event'), though it also doesn't immediately power down
the system as it does when ACPI is not enabled in the kernel at all.  So
it seems to just be eating the power button events.

Temperature - the one temperature reading (thermal_zone/THM0/temperature)
*always* reads "8 C", which I very much doubt is the case.  This, however,
is less of a concern to me than the power button.


First off, my question is whether anyone here has done any work on this
so far.  I can't find any evidence of work in the archives nor in the DSDT
database.  I did find this:
  http://www.cpqlinux.com/acpi-howto.html#proliant
which mentions ACPI on the Proliant DL series, but I think he's talking
about the G2 and G3 DL380s, not the G1 (which only supports up to 2x1Ghz
P3s).

I have done a little work on this and have made some progress in the
investigation of what's going on, but I've got some more research to do
before asking more detailed questions.

Thanks.

-- 
Dan-ZpabqtIHBis@public.gmane.org
moore.cx/dan


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
