From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC 4/4]An experimental implementation for IDE bus
Date: Mon, 08 Nov 2004 12:11:47 +0800
Message-ID: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-8INMQSGffGGf3EYOjTVV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-8INMQSGffGGf3EYOjTVV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
A sample patch to bind IDE devices. I'm not familar with IDE driver, so
the patch possibly is completely wrong, though it can show correct ACPI
path in my laptop. This test case just shows the framework works, please
don't apply it.

Thanks,
Shaohua
---

 2.6-root/drivers/ide/ide.c |   43
+++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+)

diff -puN drivers/ide/ide.c~ide-bind-acpi drivers/ide/ide.c
--- 2.6/drivers/ide/ide.c~ide-bind-acpi	2004-11-08 11:09:12.625009440
+0800
+++ 2.6-root/drivers/ide/ide.c	2004-11-08 11:10:04.477126720 +0800
@@ -2412,10 +2412,53 @@ EXPORT_SYMBOL(ide_fops);
 
 EXPORT_SYMBOL(ide_lock);
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+int generic_ide_platform_bind(struct device *dev)
+{
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+	int i;
+
+	/* Seems dev->parent->parent is the PCI IDE controller */
+        if (dev->parent && dev->parent->parent)
+                parent_handle = dev->parent->parent->handle;
+
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -1;
+	}
+	/* Please ref to ACPI spec for syntax of _ADR */
+	sscanf(dev->bus_id, "%d", &i);
+	address = i;
+	dev->handle = acpi_get_child(parent_handle, address);
+
+#if 1
+       {/* For debug */
+               char            name[80] = {'?','\0'};
+               struct acpi_buffer      buffer = {sizeof(name), name};
+
+               printk("IDE device %d:", i);
+               if (dev->handle) {
+                       acpi_get_name(dev->handle, ACPI_FULL_PATHNAME,
&buffer);
+                       printk("%s", name);
+               }
+               printk("\n");
+       }
+#endif
+	return 0;
+}
+#else
+int generic_ide_platform_bind(struct device *dev)
+{
+	return 0;
+}
+#endif
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
+	.platform_bind	= generic_ide_platform_bind,
 };
 
 /*
_


--=-8INMQSGffGGf3EYOjTVV
Content-Disposition: attachment; filename=p00004_ide-bind-acpi.patch
Content-Type: text/x-patch; name=p00004_ide-bind-acpi.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


A sample patch to bind IDE devices. I'm not familar with IDE driver, so the
patch possibly is completely wrong, though it can show correct ACPI path in
my laptop. This test case just shows the framework works, please don't apply.

---

 2.6-root/drivers/ide/ide.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+)

diff -puN drivers/ide/ide.c~ide-bind-acpi drivers/ide/ide.c
--- 2.6/drivers/ide/ide.c~ide-bind-acpi	2004-11-08 11:09:12.625009440 +0800
+++ 2.6-root/drivers/ide/ide.c	2004-11-08 11:10:04.477126720 +0800
@@ -2412,10 +2412,53 @@ EXPORT_SYMBOL(ide_fops);
 
 EXPORT_SYMBOL(ide_lock);
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+int generic_ide_platform_bind(struct device *dev)
+{
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+	int i;
+
+	/* Seems dev->parent->parent is the PCI IDE controller */
+        if (dev->parent && dev->parent->parent)
+                parent_handle = dev->parent->parent->handle;
+
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -1;
+	}
+	/* Please ref to ACPI spec for syntax of _ADR */
+	sscanf(dev->bus_id, "%d", &i);
+	address = i;
+	dev->handle = acpi_get_child(parent_handle, address);
+
+#if 1
+       {/* For debug */
+               char            name[80] = {'?','\0'};
+               struct acpi_buffer      buffer = {sizeof(name), name};
+
+               printk("IDE device %d:", i);
+               if (dev->handle) {
+                       acpi_get_name(dev->handle, ACPI_FULL_PATHNAME, &buffer);
+                       printk("%s", name);
+               }
+               printk("\n");
+       }
+#endif
+	return 0;
+}
+#else
+int generic_ide_platform_bind(struct device *dev)
+{
+	return 0;
+}
+#endif
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
+	.platform_bind	= generic_ide_platform_bind,
 };
 
 /*
_

--=-8INMQSGffGGf3EYOjTVV--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
