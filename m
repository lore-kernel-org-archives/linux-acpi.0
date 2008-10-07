From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] WDRT based watchdog timer
Date: Tue, 07 Oct 2008 09:44:44 +0200
Message-ID: <878wt0n91v.fsf@basil.nowhere.org>
References: <20080926232752.GA6061@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34466 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbYJGHou (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Oct 2008 03:44:50 -0400
In-Reply-To: <20080926232752.GA6061@cosmic.amd.com> (Jordan Crouse's message of "Fri, 26 Sep 2008 17:27:52 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org

Jordan Crouse <jordan.crouse@amd.com> writes:

> Attached is a patch to support watchdog timers as described
> by the WDRT (Watch Dog Resource Table).  This has been tested on
> the AMD SB600 chipset, but it should work for any chipset / BIOS
> that implements the WDRT table.

Nice. I remember thinking about writing such a driver a long time
ago.

> I'm not in love with the name - but I couldn't think of anything
> better, so I'm open to suggestions.  I have a limited number of
> systems that implement this interface, so I would be very happy
> to hear from other users, especially ones not using AMD chipsets.

acpi-watchdog ? 

> +struct wdrt_table {
> +	struct acpi_table_header header;
> +	struct acpi_generic_address ctrl_addr;
> +	struct acpi_generic_address count_addr;
> +	u16 pci_devid;
> +	u16 pci_venid;
> +	u8 pci_bus;
> +	u8 pci_device;
> +	u8 pci_function;
> +	u8 pci_segment;

You don't seem to use the PCI device information currently, but
they would be needed on IOMMU enabled systems to map the correct
device, wouldn't they?

> +static int acpiwdt_set_heartbeat(unsigned int interval)
> +{
> +	u32 val;
> +
> +	/* Make sure the interval is sane */
> +
> +	if (((interval * 1000) / wdt_units) > wdt_max_count)
> +		return -EINVAL;

It's probably not a big issue in this context, but the check
can overflow and miss wrong intervals.

> +
> +	/* Enable the timer */
> +
> +	val = readl(wdt_ctrl_reg);
> +	writel(val | WDT_CTRL_RUN, wdt_ctrl_reg);
> +
> +	timeout = interval;
> +
> +	return 0;
> +}
> +
> +static int acpiwdt_open(struct inode *inode, struct file *file)
> +{
> +	if (test_and_set_bit(WDT_FLAGS_OPEN, &wdt_flags))
> +		return -EBUSY;
> +	if (!test_and_clear_bit(WDT_FLAGS_ORPHAN, &wdt_flags))
> +		__module_get(THIS_MODULE);

This shouldn't be needed because the VFS does that. Also doing it in
the module itself is always racy because the module can be unloaded
before it increases its count. That is why the VFS does it.

I suppose you copied that from somehere, that somewhere is also wrong
and should be ideally fixed too.

In general these watchdog drivers seem to have all a lot of copied
code and at some point it would be nice to write a generic driver
where the backend code is just plugged in.

-Andi
-- 
ak@linux.intel.com
