From: Nico Sabbi <nsabbi-IWqWACnzNjyonA0d6jMUrA@public.gmane.org>
Subject: Re: Problem with acpi_power_off
Date: Fri, 25 Jun 2004 15:34:16 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40DC45F8.7020706@tiscali.it>
References: <40DB37BD.3050904@accelerated.org>	<Pine.LNX.4.60.0406251252280.1488@frog.athome> <16604.8649.415502.900850@aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16604.8649.415502.900850-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
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

Fred Labrosse wrote:

>hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org writes:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Salut Charles,
> > 
> > On Thu, 24 Jun 2004, Charles Kendricks wrote:
> > > I am in charge of several linux 2.6.4 systems with Dragon P4I875P 
> > > motherboards.  I am relatively new to acpi so my question might seem a little 
> > > elementary, but I can't seem to get my systems to power off consistently when 
> > > I issue an init 0.  It seems that all of them will power down sometimes, and 
> > > at other times the same systems won't power down.  Once powered down I have 
> > > no problem (at least not yet anyway) waking the systems back up.  What can be 
> > > causing this inconsistent behavior?????
> > there are two things you may try:
> >   1. If your system does not use the local APIC you might build a kernel
> >    without "Local APIC support on uniprocessors" CONFIG_X86_UP_APIC
> >   2. do not use the rtc-module "Enhanced Real Time Clock Support", but if
> >    you need the generic RTC CONFIG_GEN_RTC instead.
>
>As some of you may remember, this is what solved the problem for me some
>times ago.  However, in the last few days, I noticed on 2 occasions that my
>laptop did not power off.  The only thing I changed was playing with usb
>stuff, making some of it as modules and not.
>
>The worrying thing is that it is not consistent.  At least I haven't been
>able to see the pattern yet (as it only happened twice).  Will try to
>figure out and report back if/when I do.
>
>Fred
>  
>

the same thing happens to my Abit mainboard, yet if I press AltGR-Print-O
the pc *really* shuts  down, so I guess the real power_off() isn't being 
called
during init 0.

        Nico


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
