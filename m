From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 1/3] acpi: Add acpi mdio support code
Date: Thu, 8 Nov 2018 15:22:16 +0800
Message-ID: <2bf82b60c52bd3fc38b733e38fd991c9d31af6b9.1541660504.git.dongsheng.wang@hxt-semitech.com>
References: <20181029124044.GB9174@lunn.ch> <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Sender: netdev-owner@vger.kernel.org
To: andrew@lunn.ch, timur@kernel.org
Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, yu.zheng@hxt-semitech.com, f.fainelli@gmail.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add support for parsing the ACPI data node for PHY devices on an MDIO bus.
The current implementation depend on mdio bus scan.
With _DSD device properties we can finally do this:

    Device (MDIO) {
        Name (_DSD, Package () {
            ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
            Package () { Package () { "ethernet-phy@0", PHY0 }, }
        })
        Name (PHY0, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () { Package () { "reg", 0x0 }, }
        })
    }

    Device (MACO) {
        Name (_DSD, Package () {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () { Package () { "phy-handle", \_SB.MDIO, "ethernet-phy@0" }, }
        })
    }

Documentations:
    The DT "phy-handle" binding that we reuse for ACPI is documented in
    Documentation/devicetree/bindings/phy/phy-bindings.txt

    Documentation/acpi/dsd/data-node-references.txt
    Documentation/acpi/dsd/graph.txt

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
 drivers/acpi/Kconfig       |   6 ++
 drivers/acpi/Makefile      |   1 +
 drivers/acpi/acpi_mdio.c   | 167 +++++++++++++++++++++++++++++++++++++
 drivers/net/phy/mdio_bus.c |   3 +
 include/linux/acpi_mdio.h  |  82 ++++++++++++++++++
 5 files changed, 259 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9705fc986da9..0fefa3410ce9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -252,6 +252,12 @@ config ACPI_PROCESSOR_IDLE
 config ACPI_MCFG
 	bool
 
+config ACPI_MDIO
+	def_tristate PHYLIB
+	depends on PHYLIB
+	help
+	  ACPI MDIO bus (Ethernet PHY) accessors
+
 config ACPI_CPPC_LIB
 	bool
 	depends on ACPI_PROCESSOR
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 6d59aa109a91..ec7461a064fc 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -41,6 +41,7 @@ acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
+acpi-$(CONFIG_ACPI_MDIO)	+= acpi_mdio.o
 acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
diff --git a/drivers/acpi/acpi_mdio.c b/drivers/acpi/acpi_mdio.c
new file mode 100644
index 000000000000..293bf9a63197
--- /dev/null
+++ b/drivers/acpi/acpi_mdio.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Lots of code in this file is copy from drivers/of/of_mdio.c
+// Copyright (c) 2018 Huaxintong Semiconductor Technology Co., Ltd.
+
+#include <linux/acpi.h>
+#include <linux/acpi_mdio.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/err.h>
+#include <linux/phy.h>
+#include <linux/phy_fixed.h>
+
+/* Helper function for acpi_phy_find_device */
+static int phy_match(struct device *dev, void *fwnode)
+{
+	return dev->fwnode == fwnode;
+}
+
+/**
+ * acpi_phy_find_device - Give a PHY fwnode, find the phy_device
+ * @fwnode: Pointer to the phy's acpi data node
+ *
+ * If successful, returns a pointer to the phy_device with the embedded
+ * struct device refcount incremented by one, or NULL on failure.
+ */
+struct phy_device *acpi_phy_find_device(struct fwnode_handle *fwnode)
+{
+	struct device *d;
+	struct mdio_device *mdiodev;
+
+	if (!fwnode)
+		return NULL;
+
+	d = bus_find_device(&mdio_bus_type, NULL, fwnode, phy_match);
+	if (d) {
+		mdiodev = to_mdio_device(d);
+		if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY)
+			return to_phy_device(d);
+		put_device(d);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(acpi_phy_find_device);
+
+static int do_acpi_mdiodev_match(struct fwnode_handle *fwnode,
+				 struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct fwnode_handle *child_node;
+	int addr;
+	int ret;
+
+	fwnode_for_each_child_node(fwnode, child_node) {
+		do {
+			addr = acpi_mdio_parse_addr(dev, child_node);
+			if (addr < 0)
+				break;
+
+			if (mdiodev->addr != addr)
+				break;
+
+			dev->fwnode = child_node;
+			return 0;
+		} while (0);
+
+		/* Walk hierarchical extension data nodes */
+		ret = do_acpi_mdiodev_match(child_node, mdiodev);
+		if (!ret)
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
+/* Walk the list of subnodes of a mdio bus and look for a node that
+ * matches the mdio device's address with its 'reg' property. If
+ * found, set the fwnode pointer for the mdio device.
+ */
+void acpi_mdiobus_link_mdiodev(struct mii_bus *bus,
+			       struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+
+	if (dev->fwnode || !bus->dev.fwnode)
+		return;
+
+	if (!has_acpi_companion(&bus->dev))
+		return;
+
+	do_acpi_mdiodev_match(bus->dev.fwnode, mdiodev);
+}
+
+/**
+ * acpi_phy_connect - Connect to the phy
+ * @dev: pointer to net_device claiming the phy
+ * @fwnode: Pointer to ACPI data node for the PHY
+ * @hndlr: Link state callback for the network device
+ * @flags: flags to pass to the PHY
+ * @iface: PHY data interface type
+ *
+ * If successful, returns a pointer to the phy_device with the embedded
+ * struct device refcount incremented by one, or NULL on failure. The
+ * refcount must be dropped by calling phy_disconnect() or phy_detach().
+ */
+struct phy_device *acpi_phy_connect(struct net_device *dev,
+				    struct fwnode_handle *fwnode,
+				    void (*hndlr)(struct net_device *),
+				    u32 flags,
+				    phy_interface_t iface)
+{
+	struct phy_device *phy = acpi_phy_find_device(fwnode);
+	int ret;
+
+	if (!phy)
+		return NULL;
+
+	phy->dev_flags = flags;
+
+	ret = phy_connect_direct(dev, phy, hndlr, iface);
+
+	/* refcount is held by phy_connect_direct() on success */
+	put_device(&phy->mdio.dev);
+
+	return ret ? NULL : phy;
+}
+EXPORT_SYMBOL(acpi_phy_connect);
+
+static int acpi_mdio_node_verify(struct fwnode_handle *fwnode)
+{
+	return is_acpi_device_node(fwnode) ? 0 : -ENODEV;
+}
+
+static int fwnode_mdiobus_verify_node(struct fwnode_handle *fwnode)
+{
+	if (!is_acpi_node(fwnode))
+		return -ENODEV;
+	return acpi_mdio_node_verify(fwnode);
+}
+
+/**
+ * acpi_mdiobus_register - Register mii_bus and create PHYs
+ * @mdio: pointer to mii_bus structure
+ * @fwnode: pointer to fw_node of MDIO bus.
+ *
+ * This function registers the mii_bus structure and scan the phy_devices
+ * for each child node of @fwnode.
+ */
+int acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode)
+{
+	int ret;
+
+	if (!fwnode)
+		return mdiobus_register(mdio);
+
+	ret = fwnode_mdiobus_verify_node(fwnode);
+	if (ret)
+		return ret;
+
+	/* Scan PHYs on MDIO bus */
+	mdio->phy_mask = 0;
+	mdio->dev.fwnode = fwnode;
+
+	/* Register the MDIO bus */
+	return mdiobus_register(mdio);
+}
+EXPORT_SYMBOL(acpi_mdiobus_register);
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 2e59a8419b17..d7bca2145d0f 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi_mdio.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -516,6 +517,8 @@ struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr)
 	 * in the bus node, and set the of_node pointer in this case.
 	 */
 	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
+	/* Link the phy device with ACPI phy fwnode. */
+	acpi_mdiobus_link_mdiodev(bus, &phydev->mdio);
 
 	err = phy_device_register(phydev);
 	if (err) {
diff --git a/include/linux/acpi_mdio.h b/include/linux/acpi_mdio.h
new file mode 100644
index 000000000000..1a4a30258ebc
--- /dev/null
+++ b/include/linux/acpi_mdio.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+// Copyright (c) 2018 Huaxintong Semiconductor Technology Co., Ltd.
+
+#ifndef __LINUX_ACPI_MDIO_H
+#define __LINUX_ACPI_MDIO_H
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/phy.h>
+#include <linux/property.h>
+
+#if IS_ENABLED(CONFIG_ACPI_MDIO)
+static inline int acpi_mdio_parse_addr(struct device *dev,
+				       const struct fwnode_handle *fwnode)
+{
+	u32 addr;
+
+	if (!is_acpi_data_node(fwnode))
+		return -ENODEV;
+
+	if (!fwnode_property_present(fwnode, "reg"))
+		return -ENODEV;
+
+	if (fwnode_property_read_u32(fwnode, "reg", &addr)) {
+		dev_err(dev, "Invalid PHY address\n");
+		return -ENODEV;
+	}
+
+	/* A PHY must have a reg property in the range [0-31] */
+	if (addr >= PHY_MAX_ADDR) {
+		dev_err(dev, "PHY address %i is too large\n", addr);
+		return -EINVAL;
+	}
+
+	return addr;
+}
+
+struct phy_device *acpi_phy_find_device(struct fwnode_handle *fwnode);
+struct phy_device *acpi_phy_connect(struct net_device *dev,
+				    struct fwnode_handle *fwnode,
+				    void (*hndlr)(struct net_device *),
+				    u32 flags, phy_interface_t iface);
+int acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode);
+void acpi_mdiobus_link_mdiodev(struct mii_bus *bus,
+			       struct mdio_device *mdiodev);
+#else
+static inline int acpi_mdio_parse_addr(struct device *dev,
+				       const struct fwnode_handle *fwnode)
+{
+	return -EINVAL;
+}
+
+static inline struct phy_device *
+acpi_phy_find_device(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
+static inline struct phy_device *
+acpi_phy_connect(struct net_device *dev, struct fwnode_handle *fwnode,
+		 void (*hndlr)(struct net_device *), u32 flags,
+		 phy_interface_t iface)
+{
+	return NULL;
+}
+
+static inline int acpi_mdiobus_register(struct mii_bus *mdio,
+					struct fwnode_handle *fwnode)
+{
+	return -ENODEV;
+}
+
+static inline void
+acpi_mdiobus_link_mdiodev(struct mii_bus *bus, struct mdio_device *mdiodev) { }
+#endif
+
+static inline struct fwnode_handle *acpi_get_phy_node(struct phy_device *phydev)
+{
+	return !phydev ? NULL : phydev->mdio.dev.fwnode;
+}
+
+#endif /* __LINUX_ACPI_MDIO_H */
-- 
2.18.0
