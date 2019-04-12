From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v3 12/13] platform/x86: intel_cht_int33fe: Link with external dependencies using fwnodes
Date: Fri, 12 Apr 2019 16:41:21 +0300
Message-ID: <20190412134122.82903-13-heikki.krogerus@linux.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Supplying also external devices - the DisplayPort connector
and the USB role switch - software fwnodes. After this the
driver has access to all the components tied to the USB
Type-C connector and can start creating software node
references to actually associate them with the USB Type-C
connector device.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 93 ++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index eff5990322ff..7711667a3454 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -32,6 +33,8 @@ enum {
 	INT33FE_NODE_FUSB302,
 	INT33FE_NODE_MAX17047,
 	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_DISPLAYPORT,
+	INT33FE_NODE_ROLE_SWITCH,
 	INT33FE_NODE_USB_CONNECTOR,
 	INT33FE_NODE_MAX,
 };
@@ -43,6 +46,7 @@ struct cht_int33fe_data {
 	/* Contain a list-head must be per device */
 	struct device_connection connections[4];
 
+	struct fwnode_handle *dp;
 	struct fwnode_handle *node[INT33FE_NODE_MAX];
 };
 
@@ -143,8 +147,71 @@ static const struct property_entry *props[] = {
 	[INT33FE_NODE_FUSB302]		= fusb302_props,
 	[INT33FE_NODE_MAX17047]		= max17047_props,
 	[INT33FE_NODE_PI3USB30532]	= NULL,
+	[INT33FE_NODE_DISPLAYPORT]	= NULL,
+	[INT33FE_NODE_ROLE_SWITCH]	= NULL,
 };
 
+static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct device *p;
+
+	/* First let's find xHCI PCI device */
+	pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
+	if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
+		return -ENODEV;
+
+	/* Then the child platform device */
+	p = device_find_child_by_name(&pdev->dev, "intel_xhci_usb_sw");
+	pci_dev_put(pdev);
+	if (!p)
+		return -EPROBE_DEFER;
+
+	/* Finally the mux device */
+	dev = device_find_child_by_name(p, "intel_xhci_usb_sw-role-switch");
+	put_device(p);
+	if (!dev)
+		return -EPROBE_DEFER;
+
+	/* If there already is a node for the mux, using that one. */
+	if (dev->fwnode) {
+		fwnode_handle_get(dev->fwnode);
+		fwnode_remove_software_node(fwnode);
+		data->node[INT33FE_NODE_ROLE_SWITCH] = dev->fwnode;
+	} else {
+		/* The node can be tied to the lifetime of the device. */
+		dev->fwnode = fwnode_handle_get(dev->fwnode);
+	}
+
+	put_device(dev);
+
+	return 0;
+}
+
+static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
+	struct pci_dev *pdev;
+
+	/* First let's find the GPU PCI device */
+	pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
+	if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
+		return -ENODEV;
+
+	/* Then the DP child device node */
+	data->dp = device_get_named_child_node(&pdev->dev, "DD02");
+	pci_dev_put(pdev);
+	if (!data->dp)
+		return -ENODEV;
+
+	fwnode->secondary = ERR_PTR(-ENODEV);
+	data->dp->secondary = fwnode;
+
+	return 0;
+}
+
 static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 {
 	int i;
@@ -153,6 +220,12 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 		fwnode_remove_software_node(data->node[i]);
 		data->node[i] = NULL;
 	}
+
+	if (data->dp) {
+		data->dp->secondary = NULL;
+		fwnode_handle_put(data->dp);
+		data->dp = NULL;
+	}
 }
 
 static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
@@ -179,6 +252,26 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 	}
 	data->node[INT33FE_NODE_USB_CONNECTOR] = fwnode;
 
+	/* The devices that are not created in this driver need extra steps. */
+
+	/*
+	 * There is no ACPI device node for the USB role mux, so we need to find
+	 * the mux device and assign our node directly to it. That means we
+	 * depend on the mux driver. This function will return -PROBE_DEFER
+	 * until the mux device is registered.
+	 */
+	ret = cht_int33fe_setup_mux(data);
+	if (ret)
+		goto err_remove_nodes;
+
+	/*
+	 * The DP connector does have ACPI device node. In this case we can just
+	 * find that ACPI node and assing our node as the secondary node to it.
+	 */
+	ret = cht_int33fe_setup_dp(data);
+	if (ret)
+		goto err_remove_nodes;
+
 	return 0;
 
 err_remove_nodes:
-- 
2.20.1
