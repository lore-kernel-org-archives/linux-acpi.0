From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Date: Thu,  8 Nov 2018 19:51:55 +0300
Message-ID: <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This implements get_name fwnode op for DT.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/of/property.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f46828e3b082..9bc8fe136fa3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
 	of_node_put(to_of_node(fwnode));
 }
 
+static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
+{
+	const char *name = kbasename(to_of_node(fwnode)->full_name);
+	size_t len = strchrnul(name, '@') - name;
+
+	snprintf(buf, len + 1, "%s", name);
+
+	return 0;
+}
+
 static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	return of_device_is_available(to_of_node(fwnode));
@@ -987,6 +997,7 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
+	.get_name = of_fwnode_get_name,
 	.device_is_available = of_fwnode_device_is_available,
 	.device_get_match_data = of_fwnode_device_get_match_data,
 	.property_present = of_fwnode_property_present,
-- 
2.19.1
