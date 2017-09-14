From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 5/5] device property: Document fwnode_property_get_reference_args better
Date: Thu, 14 Sep 2017 15:29:14 +0300
Message-ID: <20170914122914.14122-6-sakari.ailus@linux.intel.com>
References: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170914122914.14122-1-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Define and document return values for fwnode_property_get_reference_args
which now is aligned with OF and ACPI.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d0b65bbe7e15..2f88b0594770 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -682,6 +682,11 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  * Caller is responsible to call fwnode_handle_put() on the returned
  * args->fwnode pointer.
  *
+ * Returns: %0 on success
+ *	    %-ENOENT when accessing an entry without a reference
+ *	    %-EINVAL on parse error and
+ *	    %-ENODATA when accessing an entry (at @index) that does not exist or
+ *	    the property @prop cannot be found.
  */
 int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
