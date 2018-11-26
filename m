From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v3 3/3] of/property: Add of_fwnode_name()
Date: Mon, 26 Nov 2018 14:47:52 +0300
Message-ID: <20181126114752.69597-4-heikki.krogerus@linux.intel.com>
References: <20181126114752.69597-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126114752.69597-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This implements get_name fwnode op for DT.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/of/property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f46828e3b082..253ed0e9d804 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -823,6 +823,13 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
 	of_node_put(to_of_node(fwnode));
 }
 
+static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf,
+			      size_t len)
+{
+	snprintf(buf, len, "%pOFn", to_of_node(fwnode));
+	return 0;
+}
+
 static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	return of_device_is_available(to_of_node(fwnode));
@@ -987,6 +994,7 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
+	.get_name = of_fwnode_get_name,
 	.device_is_available = of_fwnode_device_is_available,
 	.device_get_match_data = of_fwnode_device_get_match_data,
 	.property_present = of_fwnode_property_present,
-- 
2.19.1
