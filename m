From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (2/2)
Date: Tue, 26 Jul 2005 23:37:42 +0200
Message-ID: <200507262337.43208.rjw@sisk.pl>
References: <200507261247.05684.rjw@sisk.pl> <200507262302.37488.rjw@sisk.pl> <42E6A6E7.5000402@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42E6A6E7.5000402-1HAy0Et5u51Wk0Htik3J/w@public.gmane.org>
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
Cc: Peter Buckingham <peter-1HAy0Et5u51Wk0Htik3J/w@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, 26 of July 2005 23:11, Peter Buckingham wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday, 26 of July 2005 14:25, Carl-Daniel Hailfinger wrote:
> >>The current in-kernel sk98lin driver is years behind the version
> >>downloadable from Syskonnect. Maybe it would make sense to update
> >>it first before applying any new patches.
> >>http://www.syskonnect.com/support/driver/d0102_driver.html
> > 
> > 
> > You are right, but I don't know who should do this.  I have only submitted
> > the patch to eliminate a problem with the current kernel.
> 
> have a look at the skge driver, this is a cleaned up version of the 
> sk98lin. Although it doesn't support all of the devices, ie ones based 
> on the Yukon 2.

Thanks for the hint, I will.  From the first look it's missing the
free_irq()/request_irq() on suspend/resume however.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
