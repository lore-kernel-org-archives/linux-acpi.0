From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Date: Mon,  5 Nov 2018 12:17:26 +0300
Message-ID: <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Instead of always being forced to read the "name" property
in fwnode_name() with of_nodes, implementing the fwnode
operation meant for getting the node name.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/of/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f46828e3b082..ac7b0b6c2d4d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -823,6 +823,11 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
 	of_node_put(to_of_node(fwnode));
 }
 
+static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
+{
+	return to_of_node(fwnode)->name;
+}
+
 static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	return of_device_is_available(to_of_node(fwnode));
@@ -987,6 +992,7 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
+	.name = of_fwnode_name,
 	.device_is_available = of_fwnode_device_is_available,
 	.device_get_match_data = of_fwnode_device_get_match_data,
 	.property_present = of_fwnode_property_present,
-- 
2.19.1
