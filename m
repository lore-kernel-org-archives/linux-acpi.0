From: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
Subject: Re: Mandrake 10 weird acpi behaviour
Date: Tue, 16 Mar 2004 17:50:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079455814.3084.6.camel@M2400N>
References: <1079031999.3679.1.camel@darkstar>
	 <20040311230047.GA20345@stikine.ucs.sfu.ca>
	 <Pine.LNX.4.58.0403121055010.1203@frog.athome>
	 <20040312193716.GC25056@stikine.ucs.sfu.ca>
	 <Pine.LNX.4.58.0403131152490.1228@frog.athome>
	 <1079429336.10065.8.camel@skinnerup.mip.sdu.dk>
	 <20040316132759.GA12230@hell.org.pl>
	 <20040316134456.GA1396@dreamcraft.com.au>
	 <1079444879.10067.19.camel@skinnerup.mip.sdu.dk>
	 <20040316141734.GA2392@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040316141734.GA2392-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Tomasz Ciolek <tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have now tried to compare different acpi related scripts in mandrake
9.1 and 10.0.

the servcice script which is used to start and stop daemons have no
differences.

The /etc/acpi/event/power script has changed from:

event=button/power PWR.
action=/sbin/poweroff

to

event=button/power (PWR.|PBTN)
action=/sbin/poweroff

I have tried to change it back, but this obviously didnt help anything.

Furthermore, I have investigated a little bit more.

the poweroff script is just a link to /sbin/halt. If I restart acpid and
call halt myself, everything shuts down og.

If I restart acpid and pushes the powerbutton, the shutdown sequence is
started, and the last thing output before poweroff is "Shutting down
acpi daemon"

Don't know why this acpi event has something to do with the acpi daemon
calling poweroff prematurely... ???

/Mads




On Tue, 2004-03-16 at 15:17, Karol Kozimor wrote: 
> Thus wrote Mads Paulin:
> > - Correct - it just shuts down acpid and then starts it over again. I
> > will look at the script and compare it to the old mandrake 9.1 scipt
> > (which worked). My guess is that this is not a problem if the script,
> > but rather the acpid daemon (if it has changed lately) or the newer
> 
> There were no substantial changes, as far as I know. However, it is likely
> that your event helper scripts have changed if you experience such a
> behaviour.
> 
> > version of acpi used in my new kernel..
> 
> Might be.
> Best regards,



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
