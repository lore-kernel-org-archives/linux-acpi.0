From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Which laptops don't work/have problems w/o ACPI
Date: 16 Aug 2002 19:04:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m37kiqka63.fsf@lapper.ihatent.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD96@orsmsx119.jf.intel.com>
	<200208151636.45037.jasonb42lists@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208151636.45037.jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Jason Bowman <jasonb42lists-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org> writes:

> On Thursday 15 August 2002 12:01 pm, Grover, Andrew wrote:
> > Hi all,
> >
> > I'm trying to compile a list of systems that do not work, or have reduced
> > functionality, without ACPI.
> >
> > Would people who have these mind shooting me a quick private email with the
> > exact make and model, and I'll summarize to the list?
> >
> > Thanks -- Regards -- Andy
> >
> 
> HP1100 series (and its european clone the XT1100 series) does not have sound 
> without ACPI. I have heard that sound may be possible with ALSA v9 but I can 
> not confirm that. Also you must always do a manual poweroff w/o ACPI b/c 
> there is no APM support.
> 

If it counts, the Compaq Evo n800c series. It works without, but ACPI
only sees limited resources (no battry info and it seems to wrong CPU
temps, as my P4m shouldn't be as "cold" as 50C when compiling a
kernel).

ttfn,
A

PS: Judging by the Compaq driver site, it shares a lot of hardware
with the Presario 2800 series

-- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
