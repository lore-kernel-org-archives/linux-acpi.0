From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: WDRT based watchdog timer
Date: Tue, 7 Oct 2008 09:39:08 -0600
Message-ID: <20081007153908.GE11964@cosmic.amd.com>
References: <20080926232752.GA6061@cosmic.amd.com> <878wt0n91v.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:12636 "EHLO
	IE1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbYJGPip (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Oct 2008 11:38:45 -0400
Content-Disposition: inline
In-Reply-To: <878wt0n91v.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org

On 07/10/08 09:44 +0200, Andi Kleen wrote:
> Jordan Crouse <jordan.crouse@amd.com> writes:
> 
> > Attached is a patch to support watchdog timers as described
> > by the WDRT (Watch Dog Resource Table).  This has been tested on
> > the AMD SB600 chipset, but it should work for any chipset / BIOS
> > that implements the WDRT table.
> 
> Nice. I remember thinking about writing such a driver a long time
> ago.
> 
> > I'm not in love with the name - but I couldn't think of anything
> > better, so I'm open to suggestions.  I have a limited number of
> > systems that implement this interface, so I would be very happy
> > to hear from other users, especially ones not using AMD chipsets.
> 
> acpi-watchdog ? 

Sure.  The only thing I worry about with "acpi" in the name is that
somebody think this might be a watchdog implemented by ACPI, which 
is a half truth.  You also need the hardware interface to come along
for the ride.

> > +struct wdrt_table {
> > +	struct acpi_table_header header;
> > +	struct acpi_generic_address ctrl_addr;
> > +	struct acpi_generic_address count_addr;
> > +	u16 pci_devid;
> > +	u16 pci_venid;
> > +	u8 pci_bus;
> > +	u8 pci_device;
> > +	u8 pci_function;
> > +	u8 pci_segment;
> 
> You don't seem to use the PCI device information currently, but
> they would be needed on IOMMU enabled systems to map the correct
> device, wouldn't they?

I think so, but I have to admit a certain amount of ignorance about
how the IOMMU operates.  All the ACPI implementations I've seen that
include the WDRT are not IOMMU aware (yet).

> > +static int acpiwdt_set_heartbeat(unsigned int interval)
> > +{
> > +	u32 val;
> > +
> > +	/* Make sure the interval is sane */
> > +
> > +	if (((interval * 1000) / wdt_units) > wdt_max_count)
> > +		return -EINVAL;
> 
> It's probably not a big issue in this context, but the check
> can overflow and miss wrong intervals.

Okay - I'll adjust it.  

> > +
> > +	/* Enable the timer */
> > +
> > +	val = readl(wdt_ctrl_reg);
> > +	writel(val | WDT_CTRL_RUN, wdt_ctrl_reg);
> > +
> > +	timeout = interval;
> > +
> > +	return 0;
> > +}
> > +
> > +static int acpiwdt_open(struct inode *inode, struct file *file)
> > +{
> > +	if (test_and_set_bit(WDT_FLAGS_OPEN, &wdt_flags))
> > +		return -EBUSY;
> > +	if (!test_and_clear_bit(WDT_FLAGS_ORPHAN, &wdt_flags))
> > +		__module_get(THIS_MODULE);
> 
> This shouldn't be needed because the VFS does that. Also doing it in
> the module itself is always racy because the module can be unloaded
> before it increases its count. That is why the VFS does it.
> 
> I suppose you copied that from somehere, that somewhere is also wrong
> and should be ideally fixed too.

Yep - I shared this from the the geodewdt driver, which got it from
one of the other drivers in the directory.

> In general these watchdog drivers seem to have all a lot of copied
> code and at some point it would be nice to write a generic driver
> where the backend code is just plugged in.

This is my second WDT driver in the last year, and I have to admit,
that idea occurred to me as well.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.

