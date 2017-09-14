From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 4/5] ACPI: align acpi_fwnode_get_reference_args with OF counterpart
Date: Thu, 14 Sep 2017 15:29:13 +0300
Message-ID: <20170914122914.14122-5-sakari.ailus@linux.intel.com>
References: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170914122914.14122-1-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

acpi_fwnode_get_reference_args currently returns -EINVAL if a property
isn't found. -EINVAL is returned on parse error as well, and a
non-existent property is, for a list of references with arguments, usually
effectively the same as a property without entries.

Thus use -ENODATA to signal this as well. -EINVAL is still used to tell
about parse errors.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index c1c216163de3..c6c777341023 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1211,6 +1211,9 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 	unsigned int i;
 	int ret;
 
+	if (acpi_node_prop_get(fwnode, prop, NULL))
+		return -ENODATA;
+
 	ret = __acpi_node_get_property_reference(fwnode, prop, index,
 						 args_count, &acpi_args);
 	if (ret < 0)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
