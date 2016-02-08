From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Mon, 08 Feb 2016 14:50:15 +0100
Message-ID: <2409806.1aGBrN4l0X@wuerfel>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com> <1454935264-6076-2-git-send-email-gabriele.paoloni@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:52047 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbcBHNvM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2016 08:51:12 -0500
In-Reply-To: <1454935264-6076-2-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, guohanjun@huawei.com, wangzhou1@hisilicon.com, liudongdong3@huawei.com, linuxarm@huawei.com, qiujiang@huawei.com, bhelgaas@google.com, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, linux-acpi@vger.kernel.org, jcm@redhat.com, zhangjukuo@huawei.com, liguozhu@hisilicon.com

On Monday 08 February 2016 12:41:02 Gabriele Paoloni wrote:
> +
> +/* HipXX PCIe host only supports 32-bit config access */
> +int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
> +			      u32 *val)
> +{
> +	u32 reg;
> +	u32 reg_val;
> +	void *walker = &reg_val;
> +
> +	walker += (where & 0x3);
> +	reg = where & ~0x3;
> +	reg_val = readl(reg_base + reg);
> +
> +	if (size == 1)
> +		*val = *(u8 __force *) walker;
> +	else if (size == 2)
> +		*val = *(u16 __force *) walker;
> +	else if (size == 4)
> +		*val = reg_val;
> +	else
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}

Isn't this the same hack that Qualcomm are using?

	Arnd
