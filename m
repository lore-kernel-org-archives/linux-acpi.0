From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Ipw2100-devel] Re: [ipw2200]Confirmation of power management problem
Date: Thu, 21 Oct 2004 16:50:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410211650.08013.shawn.starr@rogers.com>
References: <200410101932.12431.shawn.starr@rogers.com> <20041018133530.GA17754@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041018133530.GA17754-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It's been resolved by Len, his newest ACPI updates in 2.6.9-rc4+ fixed that 
problem. ACPI was not shutting the device down, the only buzzing heard now is 
when the laptop is in S3 mode, but I believe this to be normal since it needs 
to resume w/o reloading the firmware. This does work upon resumption of 
system.

When I press power button, after the system has turned 'off', the CPU fan 
shuts down and so does the ipw2200bg card.

Hardware is all good :)

Shawn.

On October 18, 2004 09:35, Pavel Machek wrote:
> Hi!
>
> > I managed to install Windows XP and test the ipw2200 wireless card, when
> > I shut down the system with Windows, ACPI turned off the ipw2200 card, In
> > Linux, because ACPI does not work for the T42 thinkpad, the wifi card
> > remains on even after holding the power button to cut power.
>
> So you hold power button for four seconds and it does not turn the
> ipw2200 off? Well, IBM has some broken hardware to fix if that is the
> case.
>
>         Pavel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
