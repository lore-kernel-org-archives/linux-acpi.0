From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Mandrake 10 weird acpi behaviour
Date: Wed, 17 Mar 2004 11:09:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040317100936.GC19994@hell.org.pl>
References: <20040311230047.GA20345@stikine.ucs.sfu.ca> <Pine.LNX.4.58.0403121055010.1203@frog.athome> <20040312193716.GC25056@stikine.ucs.sfu.ca> <Pine.LNX.4.58.0403131152490.1228@frog.athome> <1079429336.10065.8.camel@skinnerup.mip.sdu.dk> <20040316132759.GA12230@hell.org.pl> <20040316134456.GA1396@dreamcraft.com.au> <1079444879.10067.19.camel@skinnerup.mip.sdu.dk> <20040316141734.GA2392@hell.org.pl> <1079455814.3084.6.camel@M2400N>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1079455814.3084.6.camel-m6aJA0iQrH4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
Cc: Tomasz Ciolek <tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Mads Paulin:
> I have now tried to compare different acpi related scripts in mandrake
> 9.1 and 10.0.

I'm unfortunately not familiar with Mandrake...

> Furthermore, I have investigated a little bit more.
> 
> the poweroff script is just a link to /sbin/halt. If I restart acpid and
> call halt myself, everything shuts down og.
> 
> If I restart acpid and pushes the powerbutton, the shutdown sequence is
> started, and the last thing output before poweroff is "Shutting down
> acpi daemon"
> 
> Don't know why this acpi event has something to do with the acpi daemon
> calling poweroff prematurely... ???

Prepend the poweroff / halt calls with echo, see /var/log/acpid, see if
/proc/acpi/events spits the same event each time...
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
