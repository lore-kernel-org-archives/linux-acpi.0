From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v4 2/4] ACPI: property: Add acpi_fwnode_name()
Date: Tue, 27 Nov 2018 17:28:53 +0300
Message-ID: <20181127142855.73899-3-heikki.krogerus@linux.intel.com>
References: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This implements the get_name fwnode op for ACPI.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8c7c4583b52d..c24cf02e9214 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1219,6 +1219,33 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *__fwnode)
 	return acpi_graph_get_child_prop_value(fwnode, "endpoint", endpoint_nr);
 }
 
+static int
+acpi_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
+{
+	struct acpi_buffer buffer;
+	acpi_status status;
+
+	if (is_acpi_data_node(fwnode)) {
+		if (len < strlen(to_acpi_data_node(fwnode)->name) + 1)
+			return -EOVERFLOW;
+		sprintf(buf, "%s", to_acpi_data_node(fwnode)->name);
+		return 0;
+	}
+
+	if (len < ACPI_NAME_SIZE + 1)
+		return -EOVERFLOW;
+
+	buffer.length = ACPI_NAME_SIZE + 1;
+	buffer.pointer = buf;
+
+	status = acpi_get_name(to_acpi_device_node(fwnode)->handle,
+			       ACPI_SINGLE_NAME, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENXIO;
+
+	return 0;
+}
+
 static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	if (!is_acpi_device_node(fwnode))
@@ -1310,6 +1337,7 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
+		.get_name = acpi_fwnode_get_name,			\
 		.device_is_available = acpi_fwnode_device_is_available, \
 		.device_get_match_data = acpi_fwnode_device_get_match_data, \
 		.property_present = acpi_fwnode_property_present,	\
-- 
2.19.2
