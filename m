From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Thu, 01 Sep 2016 16:02:19 +0200
Message-ID: <6532722.cVEMfv9Kqj@wuerfel>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <5913196.I3zIbc2qla@wuerfel> <57C822C1.9000203@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62278 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbcIAOCz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2016 10:02:55 -0400
In-Reply-To: <57C822C1.9000203@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com

On Thursday, September 1, 2016 8:44:49 PM CEST Dongdong Liu wrote:
> 在 2016/9/1 15:41, Arnd Bergmann 写道:
> > On Thursday, September 1, 2016 10:05:29 AM CEST Dongdong Liu wrote:
> >> 在 2016/8/31 19:45, Arnd Bergmann 写道:
> >>> On Wednesday, August 31, 2016 7:48:12 PM CEST Dongdong Liu wrote:
> I know your point.
> 
> 1. For our host bridge , ".map_bus = pci_ecam_map_bus" is only suitable for
> accessing the EP config space.
> pci_generic_config_read32() need to call "addr = bus->ops->map_bus(bus, devfn, where & ~0x3);",
> 
> drivers/pci/host/pcie-hisi-acpi.c
> static struct pci_ops hisi_pcie_ops = {
> 	.map_bus = pci_ecam_map_bus,
> 	.read = hisi_pcie_acpi_rd_conf,
> 	.write = hisi_pcie_acpi_wr_conf,
> };
> 
> Yes, we can change ".map_bus = pci_ecam_map_bus" to ".map_bus = hisi_pci_map_bus", and implentment hisi_pci_map_bus as below,
> then we will not need to call hisi_pcie_common_cfg_read().
> 
> void __iomem *hisi_pci_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
> {
> 	struct pci_config_window *cfg = bus->sysdata;
> 	void __iomem *reg_base = cfg->priv;
> 
> 	/* for RC config access*/
> 	if (bus->number == cfg->busr.start)
> 		return reg_base + (where & ~0x3);
> 	else
> 		/* for EP config access */
> 		return pci_ecam_map_bus(bus, devfn, where);
> }
> 
> and hisi_pcie_acpi_rd_conf() need to change as below.
> static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> 				  int size, u32 *val)
> {
> 	struct pci_config_window *cfg = bus->sysdata;
> 
> 	if (hisi_pcie_acpi_valid_config(cfg, bus, PCI_SLOT(devfn)) == 0)
> 		return PCIBIOS_DEVICE_NOT_FOUND;
> 	
> 	/* access RC config space */
> 	if (bus->number == cfg->busr.start)
> 		return pci_generic_config_read32(bus, devfn, where, size, val);
> 	
> 	/* access EP config space */
> 	return pci_generic_config_read(bus, devfn, where, size, val);
> }

Right, this is what I had in mind.


> 2. We need to backward compatible with the old dt way config access as below code,
> so we have to call hisi_pcie_common_cfg_read() when accessing the RC config space.
> For this, we have to call hisi_pcie_common_cfg_read().
> 
> drivers/pci/host/pcie-hisi.c
> static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int where,
> 		int size, u32 *val)
> {
> 	struct hisi_pcie *pcie = to_hisi_pcie(pp);
> 
> 	return hisi_pcie_common_cfg_read(pcie->reg_base, where, size, val);
> }
> 
> static struct pcie_host_ops hisi_pcie_host_ops = {
> 	.rd_own_conf = hisi_pcie_cfg_read,
> 	.wr_own_conf = hisi_pcie_cfg_write,
> 	.link_up = hisi_pcie_link_up,
> };

I think this would be easier if you separate the ACPI code from the
DT code and not try to have a common file used for both.

Sharing the config space accessors really isn't worth it when both
variants are fairly simple to do, but they don't fit in a common
model because one is called from the ACPI quirks and the other
is called from the dw-pcie driver with completely different calling
conventions.

	ARnd
