From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/1] Recent Lenovo ThinkPads define a
	dummy grahpics	device, find it and ignore it
Date: Tue, 16 Oct 2007 17:11:03 +0200
Message-ID: <1192547463.9847.611.camel@queen.suse.de>
References: <1192465985.9847.585.camel@queen.suse.de>
	<20071015164816.GA5021@srcf.ucam.org>
	<1192545541.9847.600.camel@queen.suse.de>
	<20071016144901.GB21749@srcf.ucam.org>
Reply-To: trenn-l3A5Bk7waGM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071016144901.GB21749-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux-acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li,  Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel <ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2007-10-16 at 15:49 +0100, Matthew Garrett wrote:
> On Tue, Oct 16, 2007 at 04:39:01PM +0200, Thomas Renninger wrote:
> 
> > +	/*
> > +	 *	Check whether we have really  a graphics device physically
> > +	 *      in the slot and registered at the system.
> > +	 */
> > +	dev = acpi_get_physical_device(device->handle);
> > +	if (!dev) {
> > +		printk (KERN_DEBUG PREFIX "Video device %s.%s not physically"
> > +			" connected, ignoring\n", acpi_device_bid(device),
> > +			device->parent ? acpi_device_bid(device->parent) : "");
> > +		return -ENODEV;
> > +	}
> > +
> 
> I suspect this will break other machines. Not all video extension 
> implementations are directly associated with the PCI ID. The Toshiba 
> M200 (for example) has
> 
>             Device (PCI1)
>             {
>                 Name (_ADR, 0x00010000)
>                 Device (VGA)
>                 {
>                     Name (_ADR, 0x00)
> 
> which will result in VGA not having a physical device. You might be able 
> to get away with walking the parents until you find a pci ID and then 
> checking whether it matches the graphics adaptor, but I'm not certain of 
> that.
You mean like I did in my previous approach?

> To make things more entertaining, Dell tend to implement a video 
> extension for both the 00:02.0 and 00:02.1 devices on Intel systems. We 
> need to be smarter about this, but I don't think simply looking for a 
> physical device is the solution.

Li, could you help here, pls.
I don't know enough about different possible PCI setups...

Thanks,

   Thomas


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
