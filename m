From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Patch v5 05/15] PCI: Remove PCI ioapic driver
Date: Tue, 16 Sep 2014 17:23:30 -0600
Message-ID: <20140916232330.GH5050@google.com>
References: <1410422758-24942-1-git-send-email-jiang.liu@linux.intel.com>
 <1410422758-24942-6-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51073 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbaIPXXe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2014 19:23:34 -0400
Received: by mail-pa0-f54.google.com with SMTP id lj1so786150pab.27
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2014 16:23:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410422758-24942-6-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Grant Likely <grant.likely@linaro.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Sep 11, 2014 at 04:05:48PM +0800, Jiang Liu wrote:
> To support IOAPIC hotplug on x86 and IA64 platforms, OS needs to figu=
re
> out global interrupt source number(GSI) and IOAPIC enumeration ID
> through ACPI interfaces. So BIOS must implement an ACPI IOAPIC device
> with _GSB/_UID or _MAT method to support IOAPIC hotplug. OS also need=
s
> to figure out base physical address to access IOAPIC registers. OS ma=
y
> get the base physical address through PCI BARs if IOAPIC device is
> visible in PCI domain, otherwise OS may get the address by ACPI _CRS
> method if IOAPIC device is hidden from PCI domain by BIOS.
>=20
> When adding a PCI subtree, we need to add IOAPIC devices before enabl=
ing
> all other PCI devices because other PCI devices may use the IOAPIC to
> allocate PCI interrupts.
>=20
> So we plan to reimplement IOAPIC driver as an ACPI instead of PCI dri=
ver
> due to:
> 1) hot-pluggable IOAPIC devices are always visible in ACPI domain,
>    but may or may not be visible in PCI domain.
> 2) we could explicitly control the order between IOAPIC and other PCI
>    devices.
>=20
> We also have another choice to use a PCI driver to manage IOAPIC devi=
ce
> if it's visible in PCI domain and use an ACPI driver if it's only
> visible in ACPI domain. But this solution is a little complex.
>=20
> It shouldn't cause serious backward compatibility issues because:
> 1) IOAPIC hotplug is never supported on x86 yet because it hasn't
>    implemented the required acpi_register_ioapic() and
>    acpi_unregister_ioapic().
> 2) Currently only ACPI based IOAPIC hotplug is possible on x86 and
>    IA64, we don't know other specifications and interfaces to support
>    IOAPIC hotplug yet.
> 3) We will reimplement an ACPI IOAPIC=EF=BD=94driver support IOAPIC h=
otplug.
>=20
> This change also helps to get rid of the false alarm on all current
> Linux distributions:
> [    6.952497] ioapic: probe of 0000:00:05.4 failed with error -22
> [    6.959542] ioapic: probe of 0000:80:05.4 failed with error -22
>=20
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this will be merged with the rest of the series, through a non=
-PCI
tree.

> ---
>  drivers/pci/Kconfig  |    7 ---
>  drivers/pci/Makefile |    2 -
>  drivers/pci/ioapic.c |  121 ----------------------------------------=
----------
>  3 files changed, 130 deletions(-)
>  delete mode 100644 drivers/pci/ioapic.c
>=20
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 893503fa1782..39866d18004e 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -104,13 +104,6 @@ config PCI_PASID
> =20
>  	  If unsure, say N.
> =20
> -config PCI_IOAPIC
> -	bool "PCI IO-APIC hotplug support" if X86
> -	depends on PCI
> -	depends on ACPI
> -	depends on X86_IO_APIC
> -	default !X86
> -
>  config PCI_LABEL
>  	def_bool y if (DMI || ACPI)
>  	select NLS
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index e04fe2d9df3b..73e4af400a5a 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -13,8 +13,6 @@ obj-$(CONFIG_PCI_QUIRKS) +=3D quirks.o
>  # Build PCI Express stuff if needed
>  obj-$(CONFIG_PCIEPORTBUS) +=3D pcie/
> =20
> -obj-$(CONFIG_PCI_IOAPIC) +=3D ioapic.o
> -
>  # Build the PCI Hotplug drivers if we were asked to
>  obj-$(CONFIG_HOTPLUG_PCI) +=3D hotplug/
>  ifdef CONFIG_HOTPLUG_PCI
> diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
> deleted file mode 100644
> index f6219d36227f..000000000000
> --- a/drivers/pci/ioapic.c
> +++ /dev/null
> @@ -1,121 +0,0 @@
> -/*
> - * IOAPIC/IOxAPIC/IOSAPIC driver
> - *
> - * Copyright (C) 2009 Fujitsu Limited.
> - * (c) Copyright 2009 Hewlett-Packard Development Company, L.P.
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -/*
> - * This driver manages PCI I/O APICs added by hotplug after boot.  W=
e try to
> - * claim all I/O APIC PCI devices, but those present at boot were re=
gistered
> - * when we parsed the ACPI MADT, so we'll fail when we try to re-reg=
ister
> - * them.
> - */
> -
> -#include <linux/pci.h>
> -#include <linux/module.h>
> -#include <linux/acpi.h>
> -#include <linux/slab.h>
> -
> -struct ioapic {
> -	acpi_handle	handle;
> -	u32		gsi_base;
> -};
> -
> -static int ioapic_probe(struct pci_dev *dev, const struct pci_device=
_id *ent)
> -{
> -	acpi_handle handle;
> -	acpi_status status;
> -	unsigned long long gsb;
> -	struct ioapic *ioapic;
> -	int ret;
> -	char *type;
> -	struct resource *res;
> -
> -	handle =3D ACPI_HANDLE(&dev->dev);
> -	if (!handle)
> -		return -EINVAL;
> -
> -	status =3D acpi_evaluate_integer(handle, "_GSB", NULL, &gsb);
> -	if (ACPI_FAILURE(status))
> -		return -EINVAL;
> -
> -	/*
> -	 * The previous code in acpiphp evaluated _MAT if _GSB failed, but
> -	 * ACPI spec 4.0 sec 6.2.2 requires _GSB for hot-pluggable I/O APIC=
s.
> -	 */
> -
> -	ioapic =3D kzalloc(sizeof(*ioapic), GFP_KERNEL);
> -	if (!ioapic)
> -		return -ENOMEM;
> -
> -	ioapic->handle =3D handle;
> -	ioapic->gsi_base =3D (u32) gsb;
> -
> -	if (dev->class =3D=3D PCI_CLASS_SYSTEM_PIC_IOAPIC)
> -		type =3D "IOAPIC";
> -	else
> -		type =3D "IOxAPIC";
> -
> -	ret =3D pci_enable_device(dev);
> -	if (ret < 0)
> -		goto exit_free;
> -
> -	pci_set_master(dev);
> -
> -	if (pci_request_region(dev, 0, type))
> -		goto exit_disable;
> -
> -	res =3D &dev->resource[0];
> -	if (acpi_register_ioapic(ioapic->handle, res->start, ioapic->gsi_ba=
se))
> -		goto exit_release;
> -
> -	pci_set_drvdata(dev, ioapic);
> -	dev_info(&dev->dev, "%s at %pR, GSI %u\n", type, res, ioapic->gsi_b=
ase);
> -	return 0;
> -
> -exit_release:
> -	pci_release_region(dev, 0);
> -exit_disable:
> -	pci_disable_device(dev);
> -exit_free:
> -	kfree(ioapic);
> -	return -ENODEV;
> -}
> -
> -static void ioapic_remove(struct pci_dev *dev)
> -{
> -	struct ioapic *ioapic =3D pci_get_drvdata(dev);
> -
> -	acpi_unregister_ioapic(ioapic->handle, ioapic->gsi_base);
> -	pci_release_region(dev, 0);
> -	pci_disable_device(dev);
> -	kfree(ioapic);
> -}
> -
> -
> -static const struct pci_device_id ioapic_devices[] =3D {
> -	{ PCI_DEVICE_CLASS(PCI_CLASS_SYSTEM_PIC_IOAPIC, ~0) },
> -	{ PCI_DEVICE_CLASS(PCI_CLASS_SYSTEM_PIC_IOXAPIC, ~0) },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(pci, ioapic_devices);
> -
> -static struct pci_driver ioapic_driver =3D {
> -	.name		=3D "ioapic",
> -	.id_table	=3D ioapic_devices,
> -	.probe		=3D ioapic_probe,
> -	.remove		=3D ioapic_remove,
> -};
> -
> -static int __init ioapic_init(void)
> -{
> -	return pci_register_driver(&ioapic_driver);
> -}
> -module_init(ioapic_init);
> -
> -MODULE_LICENSE("GPL");
> --=20
> 1.7.10.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
