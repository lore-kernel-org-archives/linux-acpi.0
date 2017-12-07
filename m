From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V7 5/7] ACPI: properties: Implement get_match_data() callback
Date: Thu,  7 Dec 2017 16:10:29 -0500
Message-ID: <1512681031-11343-6-git-send-email-okaya@codeaurora.org>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, sakari.ailus@linux.intel.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Now that we have a get_match_data() callback as part of the firmware node,
implement the ACPI specific piece for it.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e26ea20..466d150 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1271,9 +1271,17 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static void *
+acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
+				  const struct device *dev)
+{
+	return acpi_get_match_data(dev);
+}
+
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
 		.device_is_available = acpi_fwnode_device_is_available, \
+		.device_get_match_data = acpi_fwnode_device_get_match_data, \
 		.property_present = acpi_fwnode_property_present,	\
 		.property_read_int_array =				\
 			acpi_fwnode_property_read_int_array,		\
-- 
1.9.1
