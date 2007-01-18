From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Thu, 18 Jan 2007 16:36:45 -0700
Message-ID: <200701181636.45590.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:46439 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932757AbXARXhi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jan 2007 18:37:38 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

The ACPI motherboard driver is mostly redundant with the PNP system
driver.  This series moves the little bit of ACPI-specific stuff out
of the motherboard driver into acpi/osl.c, adds a little bit to the
PNP system driver so it covers all the remaining functionality of
the ACPI driver, and removes the ACPI driver.

Thanks for the comments on the previous version.  This set of patches:

  - Makes acpi_reserve_resources() a device_initcall(), so the FADT
    resources will be reserved after the pnp/system driver claims its
    resources.  This lets us reserve a motherboard region larger than
    the FADT describes without conflicts.

  - Adds CONFIG_PNPACPI=y to the i386/defconfig patch.  This is needed
    for the pnp/system driver to find its devices.

Len asked about the CONFIG_PNP=n, CONFIG_ACPI=y case.  In this case,
we won't have a pnp/system driver to claim motherboard resources.  But
we already have this situation with other devices.  My IR device
responds to ioports 0x100-0x10f and my ECP parallel port responds to
ioports 0x778-0x77a.  If those drivers aren't loaded (or if they
aren't smart enough to claim all the resources), the resources just
aren't claimed.

So I think a better solution for this problem would be to make the
PNP core reserve all the regions for every active device, similar to
what PCI does.

Bjorn
