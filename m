From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ACPI Thermal Shutdown on Boot
Date: Wed, 11 Feb 2004 09:48:05 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040211094538.D91991@root.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB690@PDSMSX403.ccr.corp.intel.com>
 <20040210215906.H85854@root.org> <20040211105908.GB30647@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040211105908.GB30647-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 11 Feb 2004, Karol Kozimor wrote:
> Thus wrote Nate Lawson:
> > I think he just meant 57C.  In any case, we decided to set the _TMP poll
> > interval to 10 seconds.  After 2 readings above _CRT/_HOT, userland
> > receives an event and a message is logged saying the temperature is too
> > high.  On the 3rd one, we shutdown/power off the system.  I think Linux
>
> If I understand you correctly, 30 seconds is certainly enough time to burn
> a CPU when the fan has failed, isn't it?

Our old default poll interval was 30 seconds so this doesn't change
anything.  I know DeadRat takes more than 30 seconds from "shutdown -h
now" to power off.  All modern CPUs have a thermal shutdown builtin.
Think of _CRT as more of "system temp too high, shut down as soon as you
can."

-Nate


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
