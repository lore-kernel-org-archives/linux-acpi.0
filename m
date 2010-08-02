From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/7] PCI / PCIe: Remove the port driver module exit routine
Date: Mon, 2 Aug 2010 16:18:37 +0200
Message-ID: <201008021618.37552.rjw@sisk.pl>
References: <201007310020.56546.rjw@sisk.pl> <201007310035.14232.rjw@sisk.pl> <4C568E34.5080206@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56343 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab0HBOUX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 10:20:23 -0400
In-Reply-To: <4C568E34.5080206@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, August 02, 2010, Hidetoshi Seto wrote:
> (2010/07/31 7:35), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PCI / PCIe: Remove the port driver module exit routine
> > 
> > The PCIe port driver's module exit routine is never used, so drop it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/pci/pcie/portdrv_pci.c |    7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
> > +++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
> > @@ -345,11 +345,4 @@ static int __init pcie_portdrv_init(void
> >  	return retval;
> >  }
> >  
> > -static void __exit pcie_portdrv_exit(void)
> > -{
> > -	pci_unregister_driver(&pcie_portdriver);
> > -	pcie_port_bus_unregister();
> > -}
> > -
> >  module_init(pcie_portdrv_init);
> > -module_exit(pcie_portdrv_exit);
> 
> This is exactly Kaneshige-san's [6/6].

You're right, sorry for not getting the sign-offs right.

> And it seems that this patch can be applied alone.
> 
> Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Thanks,
Rafael
