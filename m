From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Various Lockups with IBM T30
Date: Thu, 24 Oct 2002 09:42:32 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B899@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Ti Leggett' <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


This looks like the problem:

evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
successful
ACPI: Found ECDT
ACPI: Could not use ECDT
evxfevnt-0118 [06] Acpi_disable          : Transition to LEGACY mode
successful



-----Original Message-----
From: Ti Leggett [mailto:leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org] 
Sent: Wednesday, October 23, 2002 3:36 PM
To: ACPI List
Subject: Re: [ACPI] Various Lockups with IBM T30

Good news! As of the latest patch against 2.4.20-pre11 I can boot with
all ACPI options compiled in. The only downside is that it kinda fails
and disables ACPI. I'm attaching my dmesg.

I haven't gotten anymore warnings since long time ago so I'm not even
sure where to start to futz with the DSDT.

On Fri, 2002-10-04 at 11:51, Ti Leggett wrote:
> I'm still trying to get my IBM T30 to even boot with ACPI enabled. I've
> managed to output my console over serial so I can capture the output and
> here's what happens.
> 
> 2.4.20-pre8 (with 20021002 patch):
>   - hangs trying to initialize NET4
> 2.4.20-pre8-ac3 (no acpi patch applied)
>   - Oopses at some point during init but spews out a bunch of ACPI
> errors before
> 2.5.40 (with 20021002 patch):
>   - Oopses right after ACPI Power Resource
> 
> I'm attaching the ouputs of each of these logs. I've also managed to
> dump my DSDT so if that's needed (because I really don't know what to do
> with it) I'll send it as well.
-- 
Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
