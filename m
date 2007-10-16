From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/1] Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it
Date: Tue, 16 Oct 2007 15:49:01 +0100
Message-ID: <20071016144901.GB21749@srcf.ucam.org>
References: <1192465985.9847.585.camel@queen.suse.de> <20071015164816.GA5021@srcf.ucam.org> <1192545541.9847.600.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:46392 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbXJPOtR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Oct 2007 10:49:17 -0400
Content-Disposition: inline
In-Reply-To: <1192545541.9847.600.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Christian Birchinger <joker@netswarm.net>, "Li, Shaohua" <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

On Tue, Oct 16, 2007 at 04:39:01PM +0200, Thomas Renninger wrote:

> +	/*
> +	 *	Check whether we have really  a graphics device physically
> +	 *      in the slot and registered at the system.
> +	 */
> +	dev = acpi_get_physical_device(device->handle);
> +	if (!dev) {
> +		printk (KERN_DEBUG PREFIX "Video device %s.%s not physically"
> +			" connected, ignoring\n", acpi_device_bid(device),
> +			device->parent ? acpi_device_bid(device->parent) : "");
> +		return -ENODEV;
> +	}
> +

I suspect this will break other machines. Not all video extension 
implementations are directly associated with the PCI ID. The Toshiba 
M200 (for example) has

            Device (PCI1)
            {
                Name (_ADR, 0x00010000)
                Device (VGA)
                {
                    Name (_ADR, 0x00)

which will result in VGA not having a physical device. You might be able 
to get away with walking the parents until you find a pci ID and then 
checking whether it matches the graphics adaptor, but I'm not certain of 
that.

To make things more entertaining, Dell tend to implement a video 
extension for both the 00:02.0 and 00:02.1 devices on Intel systems. We 
need to be smarter about this, but I don't think simply looking for a 
physical device is the solution.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
