From: Rui Wang <rui.y.wang@intel.com>
Subject: Re: [PATCH V5 1/3] x86/ioapic: Support hot-removal of IOAPICs present during boot
Date: Tue,  9 Aug 2016 11:23:25 +0800
Message-ID: <1470713005-23690-1-git-send-email-rui.y.wang@intel.com>
References: <20160808202251.GB6129@localhost>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17790 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbcHIDkG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Aug 2016 23:40:06 -0400
In-Reply-To: <20160808202251.GB6129@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: helgaas@kernel.org
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rui.y.wang@intel.com

On Tuesday, Aug 9, 2016 4:23 AM, Bjorn Helgaas wrote:
> On Sun, Jun 26, 2016 at 11:44:57AM +0800, Rui Wang wrote:
> > v5: Remove #ifdef CONFIG_X86 from setup-bus.c, making it neutral to
> archs.
> > v4: Add comments explaining when to call acpi_ioapic_add().
> > v3: Previous versions break mips. This version fixes it.
> >
> > IOAPICs present during system boot aren't added to ioapic_list, thus
> > are unable to be hot-removed. Fix it by calling
> > acpi_ioapic_add() during root bus enumeration.
> >
> > Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> 
> Hi Rui,
> 
> Where are we at with this?  If there's anything that still needs to be merged,
> can you rebase it to v4.8-rc1 and post a new, complete, series?
> 
Hi Bjorn,

Yes. These patches are needed for IOAPIC hotplug to work.

So Thomas & Rafael, any advice?

Thanks
Rui

