From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V6 2/2] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
Date: Tue, 22 Nov 2016 14:58:13 +0100
Message-ID: <026faf89-93de-4238-f69a-ea02c57e5ee0@semihalf.com>
References: <1479816529-97410-1-git-send-email-liudongdong3@huawei.com>
 <1479816529-97410-3-git-send-email-liudongdong3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35755 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932931AbcKVN6R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Nov 2016 08:58:17 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so26654052wmd.0
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2016 05:58:16 -0800 (PST)
In-Reply-To: <1479816529-97410-3-git-send-email-liudongdong3@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongdong Liu <liudongdong3@huawei.com>, helgaas@kernel.org, arnd@arndb.de, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com

On 22.11.2016 13:08, Dongdong Liu wrote:
> PCIe controller in Hip05/HIP06/HIP07 SoCs is not ECAM compliant.
> It is non ECAM only for the RC bus config space;for any other bus
> underneath the root bus we support ECAM access.
> Add specific quirks for PCI config space accessors.This involves:
> 1. New initialization call hisi_pcie_init() to obtain rc base
> addresses from PNP0C02 at the root of the ACPI namespace (under \_SB).
> 2. New entry in common quirk array.
>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/acpi/pci_mcfg.c           |  13 +++++
>  drivers/pci/host/Kconfig          |   7 +++
>  drivers/pci/host/Makefile         |   1 +
>  drivers/pci/host/pcie-hisi-acpi.c | 119 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-ecam.h          |   5 ++
>  6 files changed, 146 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1cd38a7..b224caa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9358,6 +9358,7 @@ L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>  F:	drivers/pci/host/pcie-hisi.c
> +F:	drivers/pci/host/pcie-hisi-acpi.c
>
>  PCIE DRIVER FOR ROCKCHIP
>  M:	Shawn Lin <shawn.lin@rock-chips.com>
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index ac21db3..3297c5a 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -57,6 +57,19 @@ struct mcfg_fixup {
>  	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
>  	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
>  	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
> +#ifdef CONFIG_PCI_ECAM_QUIRKS
> +	#define PCI_ACPI_QUIRK_QUAD_DOM(table_id, seg, ops) \
> +	{ "HISI  ", table_id, 0, seg + 0, MCFG_BUS_ANY, ops }, \
> +	{ "HISI  ", table_id, 0, seg + 1, MCFG_BUS_ANY, ops }, \
> +	{ "HISI  ", table_id, 0, seg + 2, MCFG_BUS_ANY, ops }, \
> +	{ "HISI  ", table_id, 0, seg + 3, MCFG_BUS_ANY, ops }
> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP05   ", 0, &hisi_pcie_ops),
> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP06   ", 0, &hisi_pcie_ops),
> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 0, &hisi_pcie_ops),
> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 4, &hisi_pcie_ops),
> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 8, &hisi_pcie_ops),
> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
> +#endif
>  };
>
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index ae98644..1fbade5 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -301,4 +301,11 @@ config VMD
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vmd.
>
> +config PCI_ECAM_QUIRKS
> +	bool "PCI ECAM quirks for ARM64 platform"
> +	depends on PCI_ECAM && ARM64 && ACPI
> +	help
> +	  Say y here to enable your platform-specific config access that
> +	  is not ECAM compliant.
> +

ARM64 selects PCI_ECAM for ACPI anyway so we can skip it here.

How about selecting PCI_ECAM_QUIRKS from ARM64 Kconfig:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30398db..9743186 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -105,6 +105,7 @@ config ARM64
         select OF_EARLY_FLATTREE
         select OF_RESERVED_MEM
         select PCI_ECAM if ACPI
+       select PCI_ECAM_QUIRKS if ACPI
         select POWER_RESET
         select POWER_SUPPLY
         select SPARSE_IRQ

I agree with Bjorn, we should not have to turn on platform-specific 
config options for ARM64 & ACPI.

Thanks,
Tomasz
