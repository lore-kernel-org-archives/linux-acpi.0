From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 2/3] net: qcom/emac: split phy_config to mdio bus create and get phy device
Date: Thu, 8 Nov 2018 15:22:34 +0800
Message-ID: <7964cfa6df086189a87613a93d6184ad596cca55.1541660504.git.dongsheng.wang@hxt-semitech.com>
References: <20181029124044.GB9174@lunn.ch> <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1541660504.git.dongsheng.wang@hxt-semitech.com>
Sender: netdev-owner@vger.kernel.org
To: andrew@lunn.ch, timur@kernel.org
Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, yu.zheng@hxt-semitech.com, f.fainelli@gmail.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch separate emac_mdio_bus_create and emac_get_phydev from
emac_phy_config, and do some codes clean.

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-phy.c | 96 +++++++++++--------
 1 file changed, 56 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-phy.c b/drivers/net/ethernet/qualcomm/emac/emac-phy.c
index 53dbf1e163a8..8289fdda4be7 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-phy.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-phy.c
@@ -96,15 +96,15 @@ static int emac_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
 	return 0;
 }
 
-/* Configure the MDIO bus and connect the external PHY */
-int emac_phy_config(struct platform_device *pdev, struct emac_adapter *adpt)
+static int emac_mdio_bus_create(struct platform_device *pdev,
+				struct emac_adapter *adpt)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mii_bus *mii_bus;
 	int ret;
 
 	/* Create the mii_bus object for talking to the MDIO bus */
-	adpt->mii_bus = mii_bus = devm_mdiobus_alloc(&pdev->dev);
+	mii_bus = devm_mdiobus_alloc(&pdev->dev);
 	if (!mii_bus)
 		return -ENOMEM;
 
@@ -115,50 +115,66 @@ int emac_phy_config(struct platform_device *pdev, struct emac_adapter *adpt)
 	mii_bus->parent = &pdev->dev;
 	mii_bus->priv = adpt;
 
-	if (has_acpi_companion(&pdev->dev)) {
-		u32 phy_addr;
-
-		ret = mdiobus_register(mii_bus);
-		if (ret) {
-			dev_err(&pdev->dev, "could not register mdio bus\n");
-			return ret;
-		}
-		ret = device_property_read_u32(&pdev->dev, "phy-channel",
-					       &phy_addr);
-		if (ret)
-			/* If we can't read a valid phy address, then assume
-			 * that there is only one phy on this mdio bus.
-			 */
-			adpt->phydev = phy_find_first(mii_bus);
-		else
-			adpt->phydev = mdiobus_get_phy(mii_bus, phy_addr);
-
-		/* of_phy_find_device() claims a reference to the phydev,
-		 * so we do that here manually as well. When the driver
-		 * later unloads, it can unilaterally drop the reference
-		 * without worrying about ACPI vs DT.
-		 */
-		if (adpt->phydev)
-			get_device(&adpt->phydev->mdio.dev);
-	} else {
-		struct device_node *phy_np;
-
-		ret = of_mdiobus_register(mii_bus, np);
-		if (ret) {
-			dev_err(&pdev->dev, "could not register mdio bus\n");
-			return ret;
-		}
+	ret = of_mdiobus_register(mii_bus, has_acpi_companion(&pdev->dev) ?
+				  NULL : np);
+	if (ret)
+		dev_err(&pdev->dev, "Could not register mdio bus\n");
+
+	adpt->mii_bus = ret ? NULL : mii_bus;
+	return ret;
+}
+
+static int emac_get_phydev(struct platform_device *pdev,
+			   struct emac_adapter *adpt)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct mii_bus *bus = adpt->mii_bus;
+	struct device_node *phy_np;
+	struct phy_device *phydev;
 
+	u32 phy_addr;
+	int ret;
+
+	if (!has_acpi_companion(&pdev->dev)) {
 		phy_np = of_parse_phandle(np, "phy-handle", 0);
 		adpt->phydev = of_phy_find_device(phy_np);
 		of_node_put(phy_np);
+		return adpt->phydev ? 0 : -ENODEV;
 	}
 
-	if (!adpt->phydev) {
-		dev_err(&pdev->dev, "could not find external phy\n");
-		mdiobus_unregister(mii_bus);
+	ret = device_property_read_u32(&pdev->dev, "phy-channel",
+				       &phy_addr);
+	/* If we can't read a valid phy address, then assume
+	 * that there is only one phy on this mdio bus.
+	 */
+	phydev = ret ? phy_find_first(bus) : mdiobus_get_phy(bus, phy_addr);
+	if (!phydev)
 		return -ENODEV;
-	}
 
+	/* of_phy_find_device() claims a reference to the phydev,
+	 * so we do that here manually as well. When the driver
+	 * later unloads, it can unilaterally drop the reference
+	 * without worrying about ACPI vs DT.
+	 */
+	get_device(&phydev->mdio.dev);
+	adpt->phydev = phydev;
 	return 0;
 }
+
+/* Configure the MDIO bus and connect the external PHY */
+int emac_phy_config(struct platform_device *pdev, struct emac_adapter *adpt)
+{
+	int ret;
+
+	ret = emac_mdio_bus_create(pdev, adpt);
+	if (ret)
+		return ret;
+
+	ret = emac_get_phydev(pdev, adpt);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not find external phy\n");
+		mdiobus_unregister(adpt->mii_bus);
+	}
+
+	return ret;
+}
-- 
2.18.0
