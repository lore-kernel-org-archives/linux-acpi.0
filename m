From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 1/8] ACPI: Use IS_ERR_OR_NULL() instead of non-NULL check in is_acpi_data_node
Date: Fri, 21 Jul 2017 14:39:30 +0300
Message-ID: <1500637177-16095-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500637177-16095-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, erik.veijola-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The is_acpi_data_node() function takes a struct fwnode_handle pointer as
its argument. The validity of the pointer is first checked. Extend the
check to cover error values as is done by similar is_acpi_node() and
is_acpi_device_node() functions.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 68bc6be..7569123 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -414,7 +414,7 @@ static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwno
 
 static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
 {
-	return fwnode && fwnode->type == FWNODE_ACPI_DATA;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_ACPI_DATA;
 }
 
 static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
