From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Resend PATCH V3 1/8] ACPI: Add stubs for (un)register_acpi_bus_type
Date: Fri, 11 May 2012 16:08:25 +0800
Message-ID: <1336723712-7686-2-git-send-email-tianyu.lan@intel.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336723712-7686-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

It's unreasonable to have CONFIG_ACPI for these in drivers, so add some
stub functions.

Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/glue.c     |    2 ++
 include/acpi/acpi_bus.h |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 29a4a5c..1564e09 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -69,6 +69,7 @@ static struct acpi_bus_type *acpi_get_bus_type(struct bus_type *type)
 	up_read(&bus_type_sem);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(register_acpi_bus_type);
 
 static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 {
@@ -85,6 +86,7 @@ static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 	up_read(&bus_type_sem);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
 
 /* Get device's handler per its address under its parent */
 struct acpi_find_child {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f1c8ca6..c909984 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -407,6 +407,11 @@ static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 }
 #endif
 
+#else	/* CONFIG_ACPI */
+
+static int register_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
+static int unregister_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
