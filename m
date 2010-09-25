From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI / PCIe / AER: Disable native AER service if BIOS
 has precedence (v2) (was: Re: [PATCH]  PCI / PCIe / AER ...)
Date: Sat, 25 Sep 2010 13:51:02 +0800
Message-ID: <1285393862.15685.37.camel@yhuang-dev>
References: <201009200002.15609.rjw@sisk.pl>
	 <4C96FCA3.2060704@linux.intel.com>  <201009201850.00626.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52165 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788Ab0IYFvG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Sep 2010 01:51:06 -0400
In-Reply-To: <201009201850.00626.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chen Gong <gong.chen@linux.intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi, Rafael,

On Tue, 2010-09-21 at 00:50 +0800, Rafael J. Wysocki wrote:
> --- linux-2.6.orig/drivers/pci/pcie/portdrv_acpi.c
> +++ linux-2.6/drivers/pci/pcie/portdrv_acpi.c
> @@ -49,7 +49,7 @@ int pcie_port_acpi_setup(struct pci_dev 
>  		| OSC_PCI_EXPRESS_PME_CONTROL;
>  
>  	if (pci_aer_available()) {
> -		if (pcie_aer_get_firmware_first(port))
> +		if (aer_acpi_firmware_first())
>  			dev_dbg(&port->dev, "PCIe errors handled by BIOS.\n");
>  		else
>  			flags |= OSC_PCI_EXPRESS_AER_CONTROL;

The original per-device firmware_first is overridden by the new global
firmware_first? If it is, why keep the original per-device
firmware_first?

Best Regards,
Huang Ying


