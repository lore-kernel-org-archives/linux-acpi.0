From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Thu, 8 Nov 2012 22:04:45 +0200
Message-ID: <20121108200445.GC16012@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <3455360.Z6cZSC3BtR@vostro.rjw.lan>
 <CAErSpo5xEO4M_Fb0dJ6w7Qxck-0RcKKwQjKj1QZgFxhof7X5Rw@mail.gmail.com>
 <1523215.Pon1eKPQDb@vostro.rjw.lan>
 <20121107095608.GX24532@intel.com>
 <CAErSpo5My6+ypp9zsxR8vh8k1px0otOWfAcacWaLNs2xjsc7UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:57763 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab2KHUCE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2012 15:02:04 -0500
Content-Disposition: inline
In-Reply-To: <CAErSpo5My6+ypp9zsxR8vh8k1px0otOWfAcacWaLNs2xjsc7UA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Thu, Nov 08, 2012 at 12:32:25PM -0700, Bjorn Helgaas wrote:
> Struct device_driver is a generic structure, so it seems strange to
> have to include non-generic things like of_device_id and now
> acpi_match_table there.

Yes, but in a sense the DT and ACPI are "generic". So that they are used to
describe the configuration of a machine.

> I'm actually interested in the details you didn't include above, too.
> For example, I don't know of a generic way to get resource information
> from a "struct device *", so I assume you need to figure out what sort
> of device it is and then do the appropriate PCI/ACPI/OF/DT/etc
> operations to learn the resources?

Right. Typically you check, dev->of_node (or dev->acpi_handle) in a driver
and if it is non-NULL you can extract the resources using DT or ACPI
specific API calls.

Some things like IRQs and MMIO addresses can be passed to the driver using
the struct resource (and we do that already) but others we can't, like
GPIOs and some DT specific properties. Also with ACPI there might be need
to call some ACPI method, like _DSM where we need to have access to the
ACPI handle.

> I think it would be cool if there *were* a generic way to get "struct
> device" resources.  Then you could imagine a mechanism where a driver
> supplied a list of identifiers it could claim, e.g.,
> PCI_VEN_DEV(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART),
> ACPI_ID("PNP0501"), etc.,  and it might not need to know anything more
> than what the identifier is.

Indeed that would be cool, and we should probably try to implement
something like that, eventually. If you have followed the discusion there
is already talks about having a single API to get GPIOs to the driver in a
generic way.
