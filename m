From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] ACPI: add dynamic_debug support
Date: Thu, 22 May 2014 12:47:47 +0200
Message-ID: <1400755667-5377-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:38748 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbaEVKwj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 06:52:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>

Commit 1a699476e258 ("ACPI / hotplug / PCI: Hotplug notifications
from acpi_bus_notify()") added debug messages for a few common
events. These debug messages are unconditionally enabled if
CONFIG_DYNAMIC_DEBUG is defined, contrary to the documented
meaning, making the ACPI system spew lots of unwanted noise on
any kernel with dynamic debugging.

The bug was introduced by commit fbfddae69657 ("ACPI: Add
acpi_handle_<level>() interfaces"), which added the
CONFIG_DYNAMIC_DEBUG dependency without respecting its meaning.

=46ix by adding real support for dynamic_debug.

=46ixes: fbfddae69657 ("ACPI: Add acpi_handle_<level>() interfaces")
Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
Background:  I suddenly got lots of these messages in v3.15-rcX
without having enabled any ACPI debugging AFAIK:

 ACPI: \_SB_.PCI0.HDEF: ACPI_NOTIFY_DEVICE_WAKE event
 ACPI: \_SB_.PCI0.EHC1: ACPI_NOTIFY_DEVICE_WAKE event
 ACPI: \_SB_.PCI0.EHC0: ACPI_NOTIFY_DEVICE_WAKE event
 ACPI: \_SB_.PCI0.IGBE: ACPI_NOTIFY_DEVICE_WAKE event
 ACPI: \_SB_.PCI0.HDEF: ACPI_NOTIFY_DEVICE_WAKE event

The reason turned out to be that I have CONFIG_DYNAMIC_DEBUG
enabled.  Which I must say I have primarily to debug other
stuff, and *not* ACPI.

An alternative way to fix this would of course be just removing
the bogus CONFIG_DYNAMIC_DEBUG dependency. But I guess it's better
to actually support dynamic debugging?


Bj=C3=B8rn


 drivers/acpi/utils.c |   64 ++++++++++++++++++++++++++++++++++++++++--=
--------
 include/linux/acpi.h |   22 +++++++++++++++--
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index bba526148583..07c8c5a5ee95 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/hardirq.h>
 #include <linux/acpi.h>
+#include <linux/dynamic_debug.h>
=20
 #include "internal.h"
=20
@@ -457,6 +458,24 @@ acpi_evaluate_ost(acpi_handle handle, u32 source_e=
vent, u32 status_code,
 EXPORT_SYMBOL(acpi_evaluate_ost);
=20
 /**
+ * acpi_handle_path: Return the object path of handle
+ *
+ * Caller must free the returned buffer
+ */
+static char *acpi_handle_path(acpi_handle handle)
+{
+	struct acpi_buffer buffer =3D {
+		.length =3D ACPI_ALLOCATE_BUFFER,
+		.pointer =3D NULL
+	};
+
+	if (in_interrupt() ||
+	    acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer) !=3D AE_OK)
+		return NULL;
+	return buffer.pointer;
+}
+
+/**
  * acpi_handle_printk: Print message with ACPI prefix and object path
  *
  * This function is called through acpi_handle_<level> macros and prin=
ts
@@ -469,29 +488,50 @@ acpi_handle_printk(const char *level, acpi_handle=
 handle, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
-	struct acpi_buffer buffer =3D {
-		.length =3D ACPI_ALLOCATE_BUFFER,
-		.pointer =3D NULL
-	};
 	const char *path;
=20
 	va_start(args, fmt);
 	vaf.fmt =3D fmt;
 	vaf.va =3D &args;
=20
-	if (in_interrupt() ||
-	    acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer) !=3D AE_OK)
-		path =3D "<n/a>";
-	else
-		path =3D buffer.pointer;
-
-	printk("%sACPI: %s: %pV", level, path, &vaf);
+	path =3D acpi_handle_path(handle);
+	printk("%sACPI: %s: %pV", level, path ? path : "<n/a>" , &vaf);
=20
 	va_end(args);
-	kfree(buffer.pointer);
+	kfree(path);
 }
 EXPORT_SYMBOL(acpi_handle_printk);
=20
+#if defined(CONFIG_DYNAMIC_DEBUG)
+/**
+ * __acpi_handle_debug: pr_debug with ACPI prefix and object path
+ *
+ * This function is called through acpi_handle_debug macro and debug
+ * prints a message with ACPI prefix and object path. This function
+ * acquires the global namespace mutex to obtain an object path.  In
+ * interrupt context, it shows the object path as <n/a>.
+ */
+void
+__acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle,
+		    const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	const char *path;
+
+	va_start(args, fmt);
+	vaf.fmt =3D fmt;
+	vaf.va =3D &args;
+
+	path =3D acpi_handle_path(handle);
+	__dynamic_pr_debug(descriptor, "ACPI: %s: %pV", path ? path : "<n/a>"=
, &vaf);
+
+	va_end(args);
+	kfree(path);
+}
+EXPORT_SYMBOL(__acpi_handle_debug);
+#endif
+
 /**
  * acpi_has_method: Check whether @handle has a method named @name
  * @handle: ACPI device handle
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7a8f2cd66c8b..0e2569031a6f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -37,6 +37,7 @@
=20
 #include <linux/list.h>
 #include <linux/mod_devicetable.h>
+#include <linux/dynamic_debug.h>
=20
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
@@ -589,6 +590,14 @@ static inline __printf(3, 4) void
 acpi_handle_printk(const char *level, void *handle, const char *fmt, .=
=2E.) {}
 #endif	/* !CONFIG_ACPI */
=20
+#if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
+__printf(3, 4)
+void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handl=
e, const char *fmt, ...);
+#else
+#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
+	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
+#endif
+
 /*
  * acpi_handle_<level>: Print message with ACPI prefix and object path
  *
@@ -610,11 +619,19 @@ acpi_handle_printk(const char *level, void *handl=
e, const char *fmt, ...) {}
 #define acpi_handle_info(handle, fmt, ...)				\
 	acpi_handle_printk(KERN_INFO, handle, fmt, ##__VA_ARGS__)
=20
-/* REVISIT: Support CONFIG_DYNAMIC_DEBUG when necessary */
-#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(DEBUG)
 #define acpi_handle_debug(handle, fmt, ...)				\
 	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__)
 #else
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define acpi_handle_debug(handle, fmt, ...)				\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))		\
+		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
+				##__VA_ARGS__);				\
+} while (0)
+#else
 #define acpi_handle_debug(handle, fmt, ...)				\
 ({									\
 	if (0)								\
@@ -622,5 +639,6 @@ acpi_handle_printk(const char *level, void *handle,=
 const char *fmt, ...) {}
 	0;								\
 })
 #endif
+#endif
=20
 #endif	/*_LINUX_ACPI_H*/
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
