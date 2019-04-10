From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 09/12] platform/x86: intel_cht_int33fe: Provide software nodes for the devices
Date: Wed, 10 Apr 2019 18:25:02 +0300
Message-ID: <20190410152505.87041-10-heikki.krogerus@linux.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Software nodes provide two features that we will need later.
1) Software nodes can have references to other software nodes.
2) Software nodes can exist before a device entry is created.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 124 +++++++++++++++++------
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 657b8d61554c..a9abc77fffa7 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -21,18 +21,28 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define EXPECTED_PTYPE		4
 
+enum {
+	INT33FE_NODE_FUSB302,
+	INT33FE_NODE_MAX17047,
+	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_MAX,
+};
+
 struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
 	struct device_connection connections[4];
+
+	struct fwnode_handle *node[INT33FE_NODE_MAX];
 };
 
 /*
@@ -63,14 +73,6 @@ static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
 	return 1;
 }
 
-static struct i2c_client *cht_int33fe_find_max17047(void)
-{
-	struct i2c_client *max17047 = NULL;
-
-	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
-	return max17047;
-}
-
 static const char * const max17047_suppliers[] = { "bq24190-charger" };
 
 static const struct property_entry max17047_props[] = {
@@ -78,6 +80,36 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+static int
+cht_int33fe_find_max17047(struct device *dev, struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode = data->node[INT33FE_NODE_MAX17047];
+	struct i2c_client *max17047 = NULL;
+	struct i2c_board_info board_info;
+	int ret;
+
+	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
+	if (max17047) {
+		/* Pre-existing i2c-client for the max17047, add device-props */
+		max17047->dev.fwnode->secondary = fwnode;
+		/* And re-probe to get the new device-props applied. */
+		ret = device_reprobe(&max17047->dev);
+		if (ret)
+			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
+		return 0;
+	}
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
+	board_info.dev_name = "max17047";
+	board_info.fwnode = fwnode;
+	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
+	if (IS_ERR(data->max17047))
+		return PTR_ERR(data->max17047);
+
+	return 0;
+}
+
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
 	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
@@ -86,12 +118,50 @@ static const struct property_entry fusb302_props[] = {
 	{ }
 };
 
+static const struct property_entry *props[] = {
+	[INT33FE_NODE_FUSB302]		= fusb302_props,
+	[INT33FE_NODE_MAX17047]		= max17047_props,
+	[INT33FE_NODE_PI3USB30532]	= NULL,
+};
+
+static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
+{
+	int i;
+
+	for (i = 0; i < INT33FE_NODE_MAX; i++) {
+		fwnode_remove_software_node(data->node[i]);
+		data->node[i] = NULL;
+	}
+}
+
+static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		fwnode = fwnode_create_software_node(props[i], NULL);
+		if (IS_ERR(fwnode)) {
+			ret = PTR_ERR(fwnode);
+			goto err_remove_nodes;
+		}
+		data->node[i] = fwnode;
+	}
+
+	return 0;
+
+err_remove_nodes:
+	cht_int33fe_remove_nodes(data);
+
+	return ret;
+}
+
 static int cht_int33fe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
-	struct i2c_client *max17047;
 	struct regulator *regulator;
 	unsigned long long ptyp;
 	acpi_status status;
@@ -151,26 +221,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
-	max17047 = cht_int33fe_find_max17047();
-	if (max17047) {
-		/* Pre-existing i2c-client for the max17047, add device-props */
-		ret = device_add_properties(&max17047->dev, max17047_props);
-		if (ret)
-			return ret;
-		/* And re-probe to get the new device-props applied. */
-		ret = device_reprobe(&max17047->dev);
-		if (ret)
-			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
-	} else {
-		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
-		board_info.dev_name = "max17047";
-		board_info.properties = max17047_props;
-		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
-		if (IS_ERR(data->max17047))
-			return PTR_ERR(data->max17047);
-	}
+	ret = cht_int33fe_add_nodes(data);
+	if (ret)
+		return ret;
+
+	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
+	ret = cht_int33fe_find_max17047(dev, data);
+	if (ret)
+		goto out_remove_nodes;
 
 	data->connections[0].endpoint[0] = "port0";
 	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
@@ -187,7 +245,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
-	board_info.properties = fusb302_props;
+	board_info.fwnode = data->node[INT33FE_NODE_FUSB302];
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
@@ -198,6 +256,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	memset(&board_info, 0, sizeof(board_info));
 	board_info.dev_name = "pi3usb30532";
+	board_info.fwnode = data->node[INT33FE_NODE_PI3USB30532];
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
@@ -214,9 +273,11 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	i2c_unregister_device(data->fusb302);
 
 out_unregister_max17047:
+	device_connections_remove(data->connections);
 	i2c_unregister_device(data->max17047);
 
-	device_connections_remove(data->connections);
+out_remove_nodes:
+	cht_int33fe_remove_nodes(data);
 
 	return ret;
 }
@@ -230,6 +291,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	cht_int33fe_remove_nodes(data);
 
 	return 0;
 }
-- 
2.20.1
