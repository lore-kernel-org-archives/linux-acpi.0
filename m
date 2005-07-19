From: pumpkin <pumpkin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: C2, C3 and bus master activity
Date: Tue, 19 Jul 2005 23:59:55 +0200
Message-ID: <200507192359.56553.pumpkin@gmx.de>
References: <200507192050.28343.pumpkin@gmx.de> <200507192118.37528.bob@diamond.demon.co.uk>
Reply-To: pumpkin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507192118.37528.bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello

I tested this by removing kernel/driver/usb/* and rebuilding initrd (just to 
be sure). It did not change anything for console (still 50:50 between C2 and 
C3) and made Xorg crash pretty hard.

Do you think removing all the other external buses (Firewire, ethernet, 
WLAN ,..) would change something ? 

Could cpufreqd be part of the problem ?

Thanks,

On Tuesday 19 July 2005 22:18, Bob Lees wrote:
> Hi
>
> In a word USB.  I don't fully understand why, but if I disable USB then
> both my laptops will go into C3 or C4, with USB enabled stays in C2.
>
> Laptops are Compaq EVO 800c and IBM T42p both running SUSE 9.3 with a stock
> SuSE kernel 2.6.11-suse modified
>
> Bob
>
> On Tuesday 19 July 2005 19:50, pumpkin wrote:
> > Hello
> >
> > My CPU does not enter C3 if i run the stock configuration. Way too much
> > bus master activity. I want to find out what is causing it. Any hints how
> > to do that ?
> >
> > I found one possible cause for some of the activity. Without X i have a
> > 50:50 mix between C2 and C3. Using the vesa-driver the mix stays at
> > 50:50. Using the radeon-driver (dri disabled) the CPU stops using C3.
> >
> > the facts in case somebody already has a idea:
> > - ibm R51
> > - PentiumM 725 (1.6GHz)
> > - Intel 855PM chipset
> > - radeon 7500 mobil
> > - xorg 6.8.2
> > - kernel 2.6.11-1-686 (debian stock-kernel)
> >
> > thanks.
> >
> >
> > -------------------------------------------------------
> > SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> > from IBM. Find simple to follow Roadmaps, straightforward articles,
> > informative Webcasts and more! Get everything you need to get up to
> > speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
