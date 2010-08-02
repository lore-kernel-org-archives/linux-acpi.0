From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 5/7] PCI / PCIe: Remove the port driver module exit routine
Date: Mon, 02 Aug 2010 18:21:56 +0900
Message-ID: <4C568E34.5080206@jp.fujitsu.com>
References: <201007310020.56546.rjw@sisk.pl> <201007310035.14232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201007310035.14232.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

(2010/07/31 7:35), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PCI / PCIe: Remove the port driver module exit routine
> 
> The PCIe port driver's module exit routine is never used, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pcie/portdrv_pci.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
> +++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
> @@ -345,11 +345,4 @@ static int __init pcie_portdrv_init(void
>  	return retval;
>  }
>  
> -static void __exit pcie_portdrv_exit(void)
> -{
> -	pci_unregister_driver(&pcie_portdriver);
> -	pcie_port_bus_unregister();
> -}
> -
>  module_init(pcie_portdrv_init);
> -module_exit(pcie_portdrv_exit);

This is exactly Kaneshige-san's [6/6].

And it seems that this patch can be applied alone.

Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
