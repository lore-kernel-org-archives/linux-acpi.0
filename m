From: Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Subject: RE: redhat comment about intel not taking patches? - Compaq
	Hardware
Date: 13 Feb 2003 07:45:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045140314.14099.5.camel@p2710>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3DB@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3DB-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John     (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Last year (January 2002) I purchased a Compaq Presario 2710CA notebook,
before the Compaq/HP deal went through.  After looking at the various
notebooks I was able to find in Toronto, ON, Canada I settled for this
one.  I knew is was "Designed for Windows XP" but I had every intention
of running Linux as my main OS.  I was not even able to buy this
notebook without XP if I wanted to!

I was forced to use the ACPI patches as the notebook has no APM support
and would not even power-off without it.  I also had to "correct" the
DSDT to fix several errors which were easily found.  All of this I was
quite happy to do since I knew I was in unsupported territory.

My biggest disappointment came when I called Compaq Tech support to
inform them of the errors in the DSDT/BIOS.  I was very quickly told
that system was only intended to run Windows XP, they had no intention
of looking at the DSDT to fix it unless there were problems under XP,
and also that my warranty would be void for running an untested OS.  

I found this rather strange, to treat Linux as a detriment to the
computer!  With my configuration the system runs much cooler under Linux
and also gives me almost 30 minutes more battery life as compared to
Windows XP on the same system.  I use my notebook an a daily basis, as a
production box, an average of 10 hours per day.

The thing is that I run several packages that will not run under Windows
XP, and never will.  As a developer of embedded systems and industrial
hardware I still have to run several legacy packages, some only
available for DOS.  For these reasons I run Linux as my primary OS and
run VMware to support the other OS's that I have to run periodically.  I
also have the system set up to dual-boot into Windows XP natively but
have only done so less than 10 times since I purchased the system.  I
had tried VMware under Windows XP, but the Linux host gives me more
control over things and behaves better with a couple of the legacy
packages in the guest OS's.  Linux is also my OS of choice.

I feel one of the biggest stumbling blocks for Linux, especially on the
desktop, is the computer manufacturers themselves.  I realize that Linux
does not represent a large share of the marketplace (at this time), but
it is most certainly a viable OS and much more than just a toy.  On a
daily basis I am able to perform approx. 90% of everything I want to
directly under Linux and the remaining 10% is normally very specific
software that I would normally not be able to run under XP anyhow.

I would hope that now with the Compaq/HP deal finalized the consumer
should see a more harmonized approach to everything.  I am also hopeful
that as one of the major players that a bit more emphasis may be placed
on so called alternate OS's.  Linux has its place on the desktop as
well!


On Wed, 2003-02-12 at 23:11, Cagle, John (ISS-Houston) wrote: 
> Can you be more specific in your comments regarding Compaq hardware?  We
> test our ProLiant servers with Linux and ACPI, and our BIOS is designed
> for many different operating systems, including Linux, Unix and NetWare.
> On the other hand, it is unreasonable to expect that our laptop and
> desktop divisions test with Linux ACPI for two big reasons: first, the
> Linux OS has a very small share of those markets, and second, Red Hat's
> releases don't even have ACPI support.
> 
> Thanks,
> John
> --
> John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> Principal Member Technical Staff
>    Industry Standard Servers
>     Hewlett-Packard Company
>     http://www.hp.com/linux
>        jcagle-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org

The newer ACPI patches do allow me to run with the native DSDT, but
there are still a few problems with the DSDT.

As for the Red Hat concern, I run a Red Hat distribution but do not run
their kernel or XFree.  My current configuration runs a stock 2.4.20
kernel with ACPI 20021212.  Prior configurations that worked best were;
kernel 2.4.19 with ACPI 20020821, and kernel 2.418 with kernel 

The only other change I have had to make is to disable the CPU idle
handler in ACPI since there are some problems with VMware and some guest
OS's.  The problem seems to be in VMware itself but so far they have not
fixed it.

Best Regards
- 
Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
