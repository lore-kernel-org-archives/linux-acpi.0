From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 3/3] net: qcom/emac: add phy-handle support for ACPI
Date: Thu, 8 Nov 2018 15:22:56 +0800
Message-ID: <6d3ad2a70c782afa2b4b88fd225c3b0f7cdffcfa.1541660504.git.dongsheng.wang@hxt-semitech.com>
References: <20181029124044.GB9174@lunn.ch> <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Sender: netdev-owner@vger.kernel.org
To: andrew@lunn.ch, timur@kernel.org
Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, yu.zheng@hxt-semitech.com, f.fainelli@gmail.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Use "phy-handle" to point to an internal MDIO device port.

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c | 19 ++---
 drivers/net/ethernet/qualcomm/emac/emac-phy.c | 78 ++++++++++++++-----
 2 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
index 031f6e6ee9c1..74cfe7b95bb3 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -13,6 +13,7 @@
 /* Qualcomm Technologies, Inc. EMAC Ethernet Controller MAC layer support
  */
 
+#include <linux/acpi_mdio.h>
 #include <linux/tcp.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -939,28 +940,28 @@ static void emac_adjust_link(struct net_device *netdev)
 int emac_mac_up(struct emac_adapter *adpt)
 {
 	struct net_device *netdev = adpt->netdev;
-	int ret;
+	struct phy_device *phydev = adpt->phydev;
+	struct fwnode_handle *phy_np = acpi_get_phy_node(phydev);
 
 	emac_mac_rx_tx_ring_reset_all(adpt);
 	emac_mac_config(adpt);
 	emac_mac_rx_descs_refill(adpt, &adpt->rx_q);
 
-	adpt->phydev->irq = PHY_POLL;
-	ret = phy_connect_direct(netdev, adpt->phydev, emac_adjust_link,
-				 PHY_INTERFACE_MODE_SGMII);
-	if (ret) {
+	phydev->irq = PHY_POLL;
+	phydev = acpi_phy_connect(netdev, phy_np, emac_adjust_link,
+				  0, PHY_INTERFACE_MODE_SGMII);
+	if (!phydev) {
 		netdev_err(adpt->netdev, "could not connect phy\n");
-		return ret;
+		return -ENODEV;
 	}
 
-	phy_attached_print(adpt->phydev, NULL);
+	phy_attached_print(phydev, NULL);
 
 	/* enable mac irq */
 	writel((u32)~DIS_INT, adpt->base + EMAC_INT_STATUS);
 	writel(adpt->irq.mask, adpt->base + EMAC_INT_MASK);
 
-	phy_start(adpt->phydev);
-
+	phy_start(phydev);
 	napi_enable(&adpt->rx_q.napi);
 	netif_start_queue(netdev);
 
diff --git a/drivers/net/ethernet/qualcomm/emac/emac-phy.c b/drivers/net/ethernet/qualcomm/emac/emac-phy.c
index 8289fdda4be7..6616014292b0 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-phy.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-phy.c
@@ -17,6 +17,7 @@
 #include <linux/phy.h>
 #include <linux/iopoll.h>
 #include <linux/acpi.h>
+#include <linux/acpi_mdio.h>
 #include "emac.h"
 
 /* EMAC base register offsets */
@@ -96,10 +97,60 @@ static int emac_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
 	return 0;
 }
 
+static struct phy_device *
+emac_acpi_get_phydev_from_phy_handle(struct platform_device *pdev)
+{
+	struct fwnode_reference_args args = {0};
+	struct fwnode_handle *fw_node;
+	struct phy_device *phydev;
+	int ret;
+
+	/* Get PHY Port reference from phy-handle */
+	fw_node = acpi_fwnode_handle(ACPI_COMPANION(&pdev->dev));
+	ret = acpi_node_get_property_reference(fw_node, "phy-handle", 0,
+					       &args);
+	if (ret)
+		return ERR_PTR(-ENODEV);
+
+	if (!is_acpi_data_node(args.fwnode))
+		return ERR_PTR(-ENODEV);
+
+	phydev = acpi_phy_find_device(args.fwnode);
+	return phydev ? phydev : ERR_PTR(-ENODEV);
+}
+
+static struct phy_device *
+emac_acpi_get_phydev(struct platform_device *pdev, struct emac_adapter *adpt)
+{
+	struct phy_device *phydev = NULL;
+	int phy_addr;
+	int ret;
+
+	/* Compatible with "phy-channel" */
+	ret = device_property_read_u32(&pdev->dev, "phy-channel",
+				       &phy_addr);
+	if (!ret)
+		phydev = mdiobus_get_phy(adpt->mii_bus, phy_addr);
+	if (phydev)
+		return phydev;
+
+	/* Get PHY Port reference from phy-handle */
+	phydev = emac_acpi_get_phydev_from_phy_handle(pdev);
+	if (!IS_ERR(phydev))
+		return phydev;
+
+	/* If we can't read a valid phy address from "phy-channel"/"phy-handle",
+	 * then assume that there is only one phy on local mdio bus.
+	 */
+	phydev = phy_find_first(adpt->mii_bus);
+	return phydev ? phydev : ERR_PTR(-ENODEV);
+}
+
 static int emac_mdio_bus_create(struct platform_device *pdev,
 				struct emac_adapter *adpt)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct fwnode_handle *fwnode = pdev->dev.fwnode;
 	struct mii_bus *mii_bus;
 	int ret;
 
@@ -115,8 +166,8 @@ static int emac_mdio_bus_create(struct platform_device *pdev,
 	mii_bus->parent = &pdev->dev;
 	mii_bus->priv = adpt;
 
-	ret = of_mdiobus_register(mii_bus, has_acpi_companion(&pdev->dev) ?
-				  NULL : np);
+	ret = is_of_node(fwnode) ? of_mdiobus_register(mii_bus, np) :
+				   acpi_mdiobus_register(mii_bus, fwnode);
 	if (ret)
 		dev_err(&pdev->dev, "Could not register mdio bus\n");
 
@@ -128,13 +179,9 @@ static int emac_get_phydev(struct platform_device *pdev,
 			   struct emac_adapter *adpt)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct mii_bus *bus = adpt->mii_bus;
 	struct device_node *phy_np;
 	struct phy_device *phydev;
 
-	u32 phy_addr;
-	int ret;
-
 	if (!has_acpi_companion(&pdev->dev)) {
 		phy_np = of_parse_phandle(np, "phy-handle", 0);
 		adpt->phydev = of_phy_find_device(phy_np);
@@ -142,14 +189,9 @@ static int emac_get_phydev(struct platform_device *pdev,
 		return adpt->phydev ? 0 : -ENODEV;
 	}
 
-	ret = device_property_read_u32(&pdev->dev, "phy-channel",
-				       &phy_addr);
-	/* If we can't read a valid phy address, then assume
-	 * that there is only one phy on this mdio bus.
-	 */
-	phydev = ret ? phy_find_first(bus) : mdiobus_get_phy(bus, phy_addr);
-	if (!phydev)
-		return -ENODEV;
+	phydev = emac_acpi_get_phydev(pdev, adpt);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
 
 	/* of_phy_find_device() claims a reference to the phydev,
 	 * so we do that here manually as well. When the driver
@@ -171,10 +213,10 @@ int emac_phy_config(struct platform_device *pdev, struct emac_adapter *adpt)
 		return ret;
 
 	ret = emac_get_phydev(pdev, adpt);
-	if (ret) {
-		dev_err(&pdev->dev, "Could not find external phy\n");
-		mdiobus_unregister(adpt->mii_bus);
-	}
+	if (!ret)
+		return 0;
 
+	dev_err(&pdev->dev, "Could not find external phy\n");
+	mdiobus_unregister(adpt->mii_bus);
 	return ret;
 }
-- 
2.18.0
