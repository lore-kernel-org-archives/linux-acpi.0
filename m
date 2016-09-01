From: Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06
 controllers driver to preapare for ACPI
Date: Thu, 1 Sep 2016 10:05:29 +0800
Message-ID: <57C78CE9.3010707@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
 <1472644094-82731-2-git-send-email-liudongdong3@huawei.com>
 <4925807.5nZM1s8II1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:58518 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbcIACGW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2016 22:06:22 -0400
In-Reply-To: <4925807.5nZM1s8II1@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com


在 2016/8/31 19:45, Arnd Bergmann 写道:
> On Wednesday, August 31, 2016 7:48:12 PM CEST Dongdong Liu wrote:
>> +
>> +/* HipXX PCIe host only supports 32-bit config access */
>> +int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
>> +                             u32 *val)
>> +{
>> +       u32 reg;
>> +       u32 reg_val;
>> +       void *walker = &reg_val;
>> +
>> +       walker += (where & 0x3);
>> +       reg = where & ~0x3;
>> +       reg_val = readl(reg_base + reg);
>> +
>> +       if (size == 1)
>> +               *val = *(u8 __force *) walker;
>> +       else if (size == 2)
>> +               *val = *(u16 __force *) walker;
>
> What is the __force for?

Hi Arnd, thanks for replying.

__force is used to, well, force a conversion, like casting from or to a bitwise type, else the Sparse checker will throw a warning.

>
>> +       else if (size == 4)
>> +               *val = reg_val;
>> +       else
>> +               return PCIBIOS_BAD_REGISTER_NUMBER;
>> +
>> +       return PCIBIOS_SUCCESSFUL;
>
> It looks like you are reimplementing pci_generic_config_read32/pci_generic_config_write32
> read here, better use them directly.
>

For our host bridge, access RC and EP config space are not the same way.
Our host bridge is non ECAM only for the RC bus config space;
for any other bus underneath the root bus we support ECAM access.

hisi_pcie_common_cfg_read is used to read RC config space, only supports 32-bit config access.
hisi_pcie_common_cfg_read/hisi_pcie_common_cfg_write may change as below will be better.

/* HipXX PCIe host only supports 32-bit config access */
int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
			      u32 *val)
{
	void __iomem *addr;

	addr = reg_base + (where & ~0x3);
	*val = readl(addr);

	if (size <= 2)
		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);

	return PCIBIOS_SUCCESSFUL;
}

/* HipXX PCIe host only supports 32-bit config access */
int hisi_pcie_common_cfg_write(void __iomem *reg_base, int where, int  size,
				u32 val)
{
	void __iomem *addr;
	u32 mask, tmp;

	addr = reg_base + (where & ~0x3);
	if (size == 4) {
		writel(val, addr);
		return PCIBIOS_SUCCESSFUL;
	} else {
		mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
	}

	tmp = readl(addr) & mask;
	tmp |= val << ((where & 0x3) * 8);
	writel(tmp, addr);

	return PCIBIOS_SUCCESSFUL;
}


Thanks
Dongdong

> 	Arnd
>
> .
>

