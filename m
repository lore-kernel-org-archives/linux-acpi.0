From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Thu, 29 Jun 2006 09:13:36 +0800
Message-ID: <1151543616.21189.99.camel@sli10-desk.sh.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>
	 <1151409746.44a11e52e7002@imp8-g19.free.fr>
	 <1151456568.21189.84.camel@sli10-desk.sh.intel.com>
	 <200606281055.26887.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13607 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751851AbWF2BQL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jun 2006 21:16:11 -0400
In-Reply-To: <200606281055.26887.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: castet.matthieu@free.fr, Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, uwe.bugla@gmx.de

On Wed, 2006-06-28 at 10:55 -0600, Bjorn Helgaas wrote:
> On Tuesday 27 June 2006 19:02, Shaohua Li wrote:
> > On Tue, 2006-06-27 at 14:02 +0200, castet.matthieu@free.fr wrote:
> > > Is only PNP0A03 is producer type in __all__ ACPI possible devices ?
> > > If not we will have the same problem with others devices...
> > > 
> > > I don't think blacklist is the solution : pnpacpi should be able to handle all
> > > ressources types : we should complete the implementation instead of blacklist
> > > devices our implementation doesn't support.
> > > 
> > > If there are broken ACPI bios, there should be firmware update, a patched dsdt
> > > or a quirk, but no "quirk and no generic solution".
> 
> > From my understanding, if the device is really a PNP device its resource
> > should not be producer.
> 
> I know PNP as currently implemented doesn't support resource producers.
> But I don't think of that as a restriction of PNP itself.  I think of
> it as an area where a new back end (PNPACPI) added functionality, and
> PNP should be enhanced to comprehend it.
Ok, it's fine ACPI PNP handles resource producers.

> I think the current scheme where some devices are claimed using
> PNPACPI and pnp_register_driver(), and others are claimed using
> acpi_bus_register_driver() directly, is confusing at best.
> 
> I'd rather have ALL devices handled by PNPACPI, and either extend
> the PNP infrastructure to comprehend the new functionality of ACPI
> (e.g., new resource types like PCI bus numbers, ACPI events), or
> maybe just provide a "to_acpi_dev()" that takes a PNP device and
> returns the corresponding ACPI device.
That's a big deal. We had a lot of discussions about this like
introducing ACPI bus, but frankly there isn't a solid direction which
bus ACPI devices should belong to.

> > Or could we take this way, merge both patches (both patches are good to
> > me), which should be safer. Anyway, it doesn't make sense to export root
> > bridge to pnp layer to me.
> 
> One reason I don't like the blacklist is because it just papers over
> the problem without leaving a clue about how to really solve it.
> For example, if PNP is enhanced later to comprehend resource producers,
> we won't know to go back and remove things from the blacklist.
So lets have a note there. It (no blacklist) is meaningful to have all
ACPI devices handled by PNP layer, but currently not. We don't expect a
PNP driver for root bridge. And we will take risk of buggy BIOS.

Thanks,
Shaohua
