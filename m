From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 4/7] PCI / PCIe: Disable PCIe port services during port
 initialization
Date: Mon, 02 Aug 2010 18:21:03 +0900
Message-ID: <4C568DFF.3090708@jp.fujitsu.com>
References: <201007310020.56546.rjw@sisk.pl> <201007310034.20027.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43661 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab0HBJVT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Aug 2010 05:21:19 -0400
In-Reply-To: <201007310034.20027.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

(2010/07/31 7:34), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PCI / PCIe: Disable PCIe port services during port initialization
> 
> In principle PCIe port services may be enabled by the BIOS, so it's
> better to disable them during port initialization to avoid spurious
> events from being generated.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pcie/portdrv_core.c |   29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
> +++ linux-2.6/drivers/pci/pcie/portdrv_core.c
> @@ -256,20 +256,43 @@ static int get_port_device_capability(st
>  	/* Hot-Plug Capable */
>  	if ((cap_mask & PCIE_PORT_SERVICE_HP) && (reg16 & PCI_EXP_FLAGS_SLOT)) {
>  		pci_read_config_dword(dev, pos + PCI_EXP_SLTCAP, &reg32);
> -		if (reg32 & PCI_EXP_SLTCAP_HPC)
> +		if (reg32 & PCI_EXP_SLTCAP_HPC) {
>  			services |= PCIE_PORT_SERVICE_HP;
> +			/*
> +			 * Disable hot-plug interrupts in case they have been
> +			 * enabled by the BIOS and the hot-plug service driver
> +			 * is not loaded.
> +			 */
> +			pos += PCI_EXP_SLTCTL;
> +			pci_read_config_word(dev, pos, &reg16);
> +			reg16 &= ~(PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +			pci_write_config_word(dev, pos, reg16);
> +		}
>  	}
>  	/* AER capable */
>  	if ((cap_mask & PCIE_PORT_SERVICE_AER)
> -	    && pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
> +	    && pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)) {
>  		services |= PCIE_PORT_SERVICE_AER;
> +		/*
> +		 * Disable AER on this port in case it's been enabled by the
> +		 * BIOS (the AER service driver will enable it when necessary).
> +		 */
> +		pci_disable_pcie_error_reporting(dev);
> +	}
>  	/* VC support */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
>  		services |= PCIE_PORT_SERVICE_VC;
>  	/* Root ports are capable of generating PME too */
>  	if ((cap_mask & PCIE_PORT_SERVICE_PME)
> -	    && dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
> +	    && dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT) {
>  		services |= PCIE_PORT_SERVICE_PME;
> +		/*
> +		 * Disable PME interrupt on this port in case it's been enabled
> +		 * by the BIOS (the PME service driver will enable it when
> +		 * necessary).
> +		 */
> +		pcie_pme_interrupt_enable(dev, false);
> +	}
>  
>  	return services;
>  }
> 

I believe that comments described well are always welcomed.

Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

