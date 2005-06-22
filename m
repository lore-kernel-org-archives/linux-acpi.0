From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] VIA IRQ quirk for 2.6.12-rc5
Date: Wed, 22 Jun 2005 10:17:04 -0600
Message-ID: <200506221017.04981.bjorn.helgaas@hp.com>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net> <1117188546.5730.175.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1117188546.5730.175.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Len Brown <lenb-g3qfMnKXm6l/wjb6y0L7XlrsPObopucw0e7PPNI6Mm0@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 27 May 2005 4:09 am, Alan Cox wrote:
> On Gwe, 2005-05-27 at 09:21, Len Brown wrote:
> > Delete quirk_via_bridge(), restore quirk_via_irqpic() --
> > but now improved to be invoked upon device ENABLE, and
> > now only for VIA devices -- not all devices behind VIA bridges.
> 
> Properly you should apply the fixup to all VBUS devices. I've not seen a
> clean way to identify which devices fall into that category but there
> are public 
> data sheets for many of the chips.

Do you have any specific references?  I've browsed through the VIA specs
here: http://gkernel.sourceforge.net/specs/via/, but I haven't seen any
mention of VBUS or any notes about programming PCI_INTERRUPT_LINE.

Or do you have any contacts at VIA?  This is going to take a long time
to untangle by trial and error.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
