From: "Yankejian (Hackim Yim)" <yankejian@huawei.com>
Subject: Re: [PATCH] ACPI: Add phylib support code for mdio
Date: Tue, 12 Jan 2016 20:12:18 +0800
Message-ID: <5694EDA2.9080502@huawei.com>
References: <1449107683-69717-1-git-send-email-yankejian@huawei.com>
 <20151203104724.GB11655@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:5299 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbcALMNQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2016 07:13:16 -0500
In-Reply-To: <20151203104724.GB11655@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: rjw@rjwysocki.net, lenb@kernel.org, davem@davemloft.net, liguozhu@huawei.com, yisen.zhuang@huawei.com, huangdaode@hisilicon.com, lipeng321@huawei.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com

Hi Graeme,
I some how missed to reply this. Sorry for this!

HNS needs to configure PHYs dynamically parameter. So HNS try to call
Linux PHY driver to help access to PHYs. If PHYs access will be implemented in BIOS,
it seems that HNS needs repeatedly communication with BIOS.
And we have read other ethernet drivers with PHYs as well, like
1) APM X-Gene Ethernet Driver, and
2) AMD 10Gb Ethernet driver, and
3) Intel IXGBE.
Both AMD and Intel try to implement PHYs access routines itself. The drivers
needs to implement PHY access routines includes the popular PHYs.
APM X-Gene Ethernet Driver needs Linux PHY driver help to access PHYs. It
implements the new routines help to access Linux PHY driver, then access PHYs.
As the drivers shows, each MDIO controller connects one PHY. Sometimes, one MDIO
may control several PHYs, like HNS.

Firstly, let's go over the HNS hardware topology as below. The MDIO controller may
control several PHYs, and each PHY connects to a MAC device.
                       cpu                       
                        |                        
                        |                        
     ------------------------------------------- 
    |                   |                       |
    |                   |                       |
    |                  dsaf                     |
    |                   |                       |
    |      ---------------------------          |
    |     |         |         |       |         |
    |     |         |         |       |         |
    |    MAC       MAC       MAC     MAC        |
    |     |         |         |       |         |
     ---- |-------- |-------- |       | --------|
         ||        ||        ||       ||         
         PHY       PHY       PHY     PHY         

As we know, Linux Mido bus can be registered by multi phy devices. Then net device
can find mdio bus through phy node information. So

 MDIO_BUS0    NET-DEVECE0    NET-DEVICE1   ...   NET-DEVICEn    MDIO_BUS1
    |                 |               |             |                |
    |                 |               |             |                |
    |                 |               |             |                |
    |                 |               |             |    ------------
     -----------------|------------   |             |   |
                  |   |            |  |             |   |
              PHY-DEVICE0    PHY-DEVICE1   ...   PHY-DEVICEn


If we push this patch successfully, the other SOC with the same topology can use this
common routines directly.
Thanks again.



On 2015/12/3 18:47, Graeme Gregory wrote:
> On Thu, Dec 03, 2015 at 09:54:43AM +0800, yankejian wrote:
>> Add support for getting the PHY devices on an MDIO bus by ACPI.
>> Currently many of the ethernet drivers are open coding a solution
>> for reading data out of ACPI to find the correct PHY device.
>> This patch implements a set of common routines are similar to of_mdio.c
>>
> The general conclusion for the ACPI on ARM64 discussion so far has been that
> things like PHYs should be setup by the firmware before the kernel takes
> control.
>
> I am unsure that this doing it the same way as DT with a different
> description language is the way to go.
>
> Graeme
>
>> Signed-off-by: yankejian <yankejian@huawei.com>
>> ---
>>  drivers/acpi/Makefile     |   3 +
>>  drivers/acpi/acpi_mdio.c  | 263 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi_mdio.h |  68 ++++++++++++
>>  3 files changed, 334 insertions(+)
>>  create mode 100644 drivers/acpi/acpi_mdio.c
>>  create mode 100644 include/linux/acpi_mdio.h
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 675eaf3..832e7d6 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -35,6 +35,7 @@ acpi-y				+= bus.o glue.o
>>  acpi-y				+= scan.o
>>  acpi-y				+= resource.o
>>  acpi-y				+= acpi_processor.o
>> +acpi-y				+= acpi_mdio.o
>>  acpi-y				+= processor_core.o
>>  acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
>>  acpi-y				+= ec.o
>> @@ -65,6 +66,7 @@ obj-$(CONFIG_ACPI_BUTTON)	+= button.o
>>  obj-$(CONFIG_ACPI_FAN)		+= fan.o
>>  obj-$(CONFIG_ACPI_VIDEO)	+= video.o
>>  obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
>> +obj-$(CONFIG_PCI_MMCONFIG)	+= mcfg.o
>>  obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
>>  obj-y				+= container.o
>>  obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
>> @@ -79,6 +81,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>>  obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>> +obj-$(CONFIG_IORT_TABLE) 	+= iort.o
>>  
>>  # processor has its own "processor." module_param namespace
>>  processor-y			:= processor_driver.o
>> diff --git a/drivers/acpi/acpi_mdio.c b/drivers/acpi/acpi_mdio.c
>> new file mode 100644
>> index 0000000..3a5871d
>> --- /dev/null
>> +++ b/drivers/acpi/acpi_mdio.c
>> @@ -0,0 +1,263 @@
>> +/*
>> + * Copyright (c) 2015 Hisilicon Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/acpi_mdio.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/phy.h>
>> +#include <linux/phy_fixed.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock_types.h>
>> +
>> +static
>> +int acpi_mdiobus_register_phy(struct mii_bus *mdio, struct fwnode_handle *child,
>> +			      u32 addr)
>> +{
>> +	struct phy_device *phy;
>> +	const char *phy_type;
>> +	bool is_c45;
>> +	int rc;
>> +
>> +	rc = fwnode_property_read_string(child, "ethernet-phy", &phy_type);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (!strncmp(phy_type, "ethernet-phy-ieee802.3-c45",
>> +		     sizeof("ethernet-phy-ieee802.3-c45")))
>> +		is_c45 = 1;
>> +	else if (!strncmp(phy_type, "ethernet-phy-ieee802.3-c22",
>> +			  sizeof("ethernet-phy-ieee802.3-c22")))
>> +		is_c45 = 0;
>> +	else
>> +		return -ENODATA;
>> +
>> +	phy = get_phy_device(mdio, addr, is_c45);
>> +	if (!phy || IS_ERR(phy))
>> +		return 1;
>> +
>> +	/* Associate the fw node with the device structure so it
>> +	 * can be looked up later
>> +	 */
>> +	phy->dev.fwnode = child;
>> +
>> +	if (mdio->irq)
>> +		phy->irq = mdio->irq[addr];
>> +
>> +	if (fwnode_property_read_bool(child, "broken-turn-around"))
>> +		mdio->phy_ignore_ta_mask |= 1 << addr;
>> +
>> +	/* All data is now stored in the phy struct;
>> +	 * register it
>> +	 */
>> +	rc = phy_device_register(phy);
>> +	if (rc) {
>> +		phy_device_free(phy);
>> +		return 1;
>> +	}
>> +
>> +	dev_dbg(&mdio->dev, "registered phy at address %i\n", addr);
>> +
>> +	return 0;
>> +}
>> +
>> +int acpi_mdio_parse_addr(struct device *dev, struct fwnode_handle *fwnode)
>> +{
>> +	u32 addr;
>> +	int ret;
>> +
>> +	ret = fwnode_property_read_u32(fwnode, "phy-addr", &addr);
>> +	if (ret < 0) {
>> +		dev_err(dev, "has invalid PHY address ret:%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (addr >= PHY_MAX_ADDR) {
>> +		dev_err(dev, "PHY address %i is too large\n", addr);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return addr;
>> +}
>> +EXPORT_SYMBOL(acpi_mdio_parse_addr);
>> +
>> +/**
>> + * acpi_mdiobus_register - Register mii_bus and create PHYs
>> + * @mdio: pointer to mii_bus structure
>> + * @fwnode: pointer to framework node of MDIO bus.
>> + *
>> + * This function registers the mii_bus structure and registers a phy_device
>> + * for each child node of mdio device.
>> + */
>> +int acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode)
>> +{
>> +	struct fwnode_handle *child;
>> +	struct acpi_device *adev;
>> +	bool scanphys = false;
>> +	int addr, rc, i;
>> +
>> +	/* Mask out all PHYs from auto probing.  Instead the PHYs listed in
>> +	 * the framework node are populated after the bus has been registered
>> +	 */
>> +	mdio->phy_mask = ~0;
>> +
>> +	/* Clear all the IRQ properties */
>> +	if (mdio->irq)
>> +		for (i = 0; i < PHY_MAX_ADDR; i++)
>> +			mdio->irq[i] = PHY_POLL;
>> +
>> +	mdio->dev.fwnode = fwnode;
>> +
>> +	/* Register the MDIO bus */
>> +	rc = mdiobus_register(mdio);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Loop over the child nodes and register a phy_device for each one */
>> +	device_for_each_child_node(&mdio->dev, child) {
>> +		adev = to_acpi_device_node(child);
>> +		if (!adev)
>> +			continue;
>> +
>> +		addr = acpi_mdio_parse_addr(&adev->dev, child);
>> +		if (addr < 0) {
>> +			scanphys = true;
>> +			continue;
>> +		}
>> +
>> +		rc = acpi_mdiobus_register_phy(mdio, child, addr);
>> +		dev_dbg(&mdio->dev, "acpi reg phy rc:%#x addr:%#x\n", rc, addr);
>> +		if (rc)
>> +			continue;
>> +	}
>> +
>> +	if (!scanphys)
>> +		return 0;
>> +
>> +	/* auto scan for PHYs with empty reg property */
>> +	device_for_each_child_node(&mdio->dev, child) {
>> +		/* Skip PHYs with reg property set */
>> +		if (!fwnode_property_present(child, "reg"))
>> +			continue;
>> +
>> +		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
>> +			/* skip already registered PHYs */
>> +			if (mdio->phy_map[addr])
>> +				continue;
>> +
>> +			/* be noisy to encourage people to set reg property */
>> +			dev_info(&mdio->dev, "scan phy %s at address %i\n",
>> +				 acpi_dev_name(to_acpi_device_node(child)),
>> +				 addr);
>> +
>> +			rc = acpi_mdiobus_register_phy(mdio, child, addr);
>> +			if (rc)
>> +				continue;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(acpi_mdiobus_register);
>> +
>> +/* Helper function for acpi_phy_find_device */
>> +static int acpi_phy_match(struct device *dev, void *phy_fwnode)
>> +{
>> +	return dev->fwnode == phy_fwnode;
>> +}
>> +
>> +/**
>> + * acpi_phy_find_device - Give a PHY node, find the phy_device
>> + * @phy_fwnode: Pointer to the phy's framework node
>> + *
>> + * If successful, returns a pointer to the phy_device with the embedded
>> + * struct device refcount incremented by one, or NULL on failure.
>> + */
>> +struct phy_device *acpi_phy_find_device(struct fwnode_handle *phy_fwnode)
>> +{
>> +	struct device *d;
>> +
>> +	if (!phy_fwnode)
>> +		return NULL;
>> +
>> +	d = bus_find_device(&mdio_bus_type, NULL, phy_fwnode, acpi_phy_match);
>> +
>> +	return d ? to_phy_device(d) : NULL;
>> +}
>> +EXPORT_SYMBOL(acpi_phy_find_device);
>> +
>> +/**
>> + * acpi_phy_attach - Attach to a PHY without starting the state machine
>> + * @dev: pointer to net_device claiming the phy
>> + * @phy_fwnode: framework Node pointer for the PHY
>> + * @flags: flags to pass to the PHY
>> + * @iface: PHY data interface type
>> + *
>> + * If successful, returns a pointer to the phy_device with the embedded
>> + * struct device refcount incremented by one, or NULL on failure. The
>> + * refcount must be dropped by calling phy_disconnect() or phy_detach().
>> + */
>> +struct phy_device *acpi_phy_attach(struct net_device *dev,
>> +				   struct fwnode_handle *phy_fwnode, u32 flags,
>> +				   phy_interface_t iface)
>> +{
>> +	struct phy_device *phy = acpi_phy_find_device(phy_fwnode);
>> +	int ret;
>> +
>> +	if (!phy)
>> +		return NULL;
>> +
>> +	ret = phy_attach_direct(dev, phy, flags, iface);
>> +
>> +	/* refcount is held by phy_attach_direct() on success */
>> +	put_device(&phy->dev);
>> +
>> +	return ret ? NULL : phy;
>> +}
>> +EXPORT_SYMBOL(acpi_phy_attach);
>> +
>> +/**
>> + * acpi_phy_connect - Connect to the phy described
>> + * @dev: pointer to net_device claiming the phy
>> + * @phy_fwnode: Pointer to framework node for the PHY
>> + * @hndlr: Link state callback for the network device
>> + * @iface: PHY data interface type
>> + *
>> + * If successful, returns a pointer to the phy_device with the embedded
>> + * struct device refcount incremented by one, or NULL on failure. The
>> + * refcount must be dropped by calling phy_disconnect() or phy_detach().
>> + */
>> +struct phy_device *acpi_phy_connect(struct net_device *dev,
>> +				    struct fwnode_handle *phy_fwnode,
>> +				    void (*hndlr)(struct net_device *),
>> +				    u32 flags,
>> +				    phy_interface_t iface)
>> +{
>> +	struct phy_device *phy = acpi_phy_find_device(phy_fwnode);
>> +	int ret;
>> +
>> +	if (!phy)
>> +		return NULL;
>> +
>> +	phy->dev_flags = flags;
>> +
>> +	ret = phy_connect_direct(dev, phy, hndlr, iface);
>> +
>> +	/* refcount is held by phy_connect_direct() on success */
>> +	put_device(&phy->dev);
>> +
>> +	return ret ? NULL : phy;
>> +}
>> +EXPORT_SYMBOL(acpi_phy_connect);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
>> diff --git a/include/linux/acpi_mdio.h b/include/linux/acpi_mdio.h
>> new file mode 100644
>> index 0000000..82b5be5
>> --- /dev/null
>> +++ b/include/linux/acpi_mdio.h
>> @@ -0,0 +1,68 @@
>> +/*
>> + * Copyright (c) 2015 Hisilicon Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#ifndef __LINUX_ACPI_MDIO_H
>> +#define __LINUX_ACPI_MDIO_H
>> +
>> +#include <linux/phy.h>
>> +
>> +#ifdef CONFIG_ACPI
>> +
>> +int acpi_mdio_parse_addr(struct device *dev, struct fwnode_handle *fwnode);
>> +int acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode);
>> +struct phy_device *acpi_phy_find_device(struct fwnode_handle *phy_fwnode);
>> +struct phy_device *acpi_phy_attach(struct net_device *dev,
>> +				   struct fwnode_handle *phy_fwnode, u32 flags,
>> +				   phy_interface_t iface);
>> +struct phy_device *acpi_phy_connect(struct net_device *dev,
>> +				    struct fwnode_handle *phy_fwnode,
>> +				    void (*hndlr)(struct net_device *),
>> +				    u32 flags,
>> +				    phy_interface_t iface);
>> +
>> +#else
>> +static inline int acpi_mdio_parse_addr(struct device *dev,
>> +				       struct fwnode_handle *fwnode)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline int acpi_mdiobus_register(struct mii_bus *mdio,
>> +					struct fwnode_handle *fwnode)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline
>> +struct phy_device *acpi_phy_find_device(struct fwnode_handle *phy_fwnode)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline
>> +struct phy_device *acpi_phy_attach(struct net_device *dev,
>> +				   struct fwnode_handle *phy_fwnode, u32 flags,
>> +				   phy_interface_t iface)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline
>> +struct phy_device *acpi_phy_connect(struct net_device *dev,
>> +				    struct fwnode_handle *phy_fwnode,
>> +				    void (*hndlr)(struct net_device *),
>> +				    u32 flags,
>> +				    phy_interface_t iface)
>> +{
>> +	return NULL;
>> +}
>> +
>> +#endif
>> +
>> +#endif /* __LINUX_ACPI_MDIO_H */
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> .
>


