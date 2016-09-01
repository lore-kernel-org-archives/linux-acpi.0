From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Thu, 01 Sep 2016 09:41:03 +0200
Message-ID: <5913196.I3zIbc2qla@wuerfel>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <4925807.5nZM1s8II1@wuerfel> <57C78CE9.3010707@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51730 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbcIAHlW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2016 03:41:22 -0400
In-Reply-To: <57C78CE9.3010707@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com

On Thursday, September 1, 2016 10:05:29 AM CEST Dongdong Liu wrote:
> 
> 在 2016/8/31 19:45, Arnd Bergmann 写道:
> > On Wednesday, August 31, 2016 7:48:12 PM CEST Dongdong Liu wrote:
> >> +
> >> +/* HipXX PCIe host only supports 32-bit config access */
> >> +int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
> >> +                             u32 *val)
> >> +{
> >> +       u32 reg;
> >> +       u32 reg_val;
> >> +       void *walker = &reg_val;
> >> +
> >> +       walker += (where & 0x3);
> >> +       reg = where & ~0x3;
> >> +       reg_val = readl(reg_base + reg);
> >> +
> >> +       if (size == 1)
> >> +               *val = *(u8 __force *) walker;
> >> +       else if (size == 2)
> >> +               *val = *(u16 __force *) walker;
> >
> > What is the __force for?
> 
> Hi Arnd, thanks for replying.
> 
> __force is used to, well, force a conversion, like casting from or to a bitwise type, else the Sparse checker will throw a warning.

I know what it's for in general, but in this case there is no __bitwise
or __iomem or any other annotation on either side of the assignment.

> >
> >> +       else if (size == 4)
> >> +               *val = reg_val;
> >> +       else
> >> +               return PCIBIOS_BAD_REGISTER_NUMBER;
> >> +
> >> +       return PCIBIOS_SUCCESSFUL;
> >
> > It looks like you are reimplementing pci_generic_config_read32/pci_generic_config_write32
> > read here, better use them directly.
> >
> 
> For our host bridge, access RC and EP config space are not the same way.
> Our host bridge is non ECAM only for the RC bus config space;
> for any other bus underneath the root bus we support ECAM access.
> 
> hisi_pcie_common_cfg_read is used to read RC config space, only supports 32-bit config access.
> hisi_pcie_common_cfg_read/hisi_pcie_common_cfg_write may change as below will be better.
> 
> /* HipXX PCIe host only supports 32-bit config access */
> int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
> 			      u32 *val)
> {
> 	void __iomem *addr;
> 
> 	addr = reg_base + (where & ~0x3);
> 	*val = readl(addr);
> 
> 	if (size <= 2)
> 		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
> 
> 	return PCIBIOS_SUCCESSFUL;
> }

My point was: why not call pci_generic_config_read32() when accessing
the RC config space instead of duplicating the code from it?

	Arnd
