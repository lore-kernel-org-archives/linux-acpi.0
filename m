From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v2 1/4] ACPI: Add acpi_pr_<level>() interfaces
Date: Fri, 20 Jul 2012 10:54:13 -0600
Message-ID: <1342803256-17514-2-git-send-email-toshi.kani@hp.com>
References: <1342803256-17514-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342803256-17514-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joe@perches.com, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

This patch introduces acpi_pr_<level>(), where <level> is a message
level such as err/warn/info, to support improved logging messages
for ACPI, esp. in hotplug operations.  acpi_pr_<level>() appends
"ACPI" prefix and ACPI object path to the messages.  This improves
diagnostics in hotplug operations since it identifies an object that
caused an issue in a log file.

acpi_pr_<level>() takes acpi_handle as an argument, which is passed
to ACPI hotplug notify handlers from the ACPI CA.  Therefore, it is
always available unlike other kernel objects, such as device.

For example, the statement below
  acpi_pr_err(handle, "Device don't exist, dropping EJECT\n");
logs an error message like this at KERN_ERR.
  ACPI: \_SB_.SCK4.CPU4: Device don't exist, dropping EJECT

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/utils.c    |   34 ++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |   20 ++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 3e87c9c..d4311de 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -454,3 +454,37 @@ acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
 #endif
 }
 EXPORT_SYMBOL(acpi_evaluate_hotplug_ost);
+
+/**
+ * acpi_printk: Print messages with ACPI prefix and object path
+ *
+ * This function is intended to be called through acpi_pr_<level> macros.
+ */
+void
+acpi_printk(const char *level, acpi_handle handle, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	struct acpi_buffer buffer = {
+		.length = ACPI_ALLOCATE_BUFFER,
+		.pointer = NULL
+	};
+	char *path;
+	acpi_status ret;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	ret = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ret == AE_OK)
+		path = buffer.pointer;
+	else
+		path = "<n/a>";
+
+	printk("%sACPI: %s: %pV", level, path, &vaf);
+
+	va_end(args);
+	kfree(buffer.pointer);
+}
+EXPORT_SYMBOL(acpi_printk);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b22b774..2ceeca3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -85,6 +85,26 @@ struct acpi_pld {
 
 acpi_status
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld *pld);
+
+void acpi_printk(const char *level, acpi_handle handle, const char *fmt, ...);
+
+#define acpi_pr_emerg(handle, fmt, ...)				\
+	acpi_printk(KERN_EMERG, handle, fmt, ##__VA_ARGS__)
+#define acpi_pr_alert(handle, fmt, ...)				\
+	acpi_printk(KERN_ALERT, handle, fmt, ##__VA_ARGS__)
+#define acpi_pr_crit(handle, fmt, ...)				\
+	acpi_printk(KERN_CRIT, handle, fmt, ##__VA_ARGS__)
+#define acpi_pr_err(handle, fmt, ...)				\
+	acpi_printk(KERN_ERR, handle, fmt, ##__VA_ARGS__)
+#define acpi_pr_warn(handle, fmt, ...)				\
+	acpi_printk(KERN_WARNING, handle, fmt, ##__VA_ARGS__)
+#define acpi_pr_notice(handle, fmt, ...)			\
+	acpi_printk(KERN_NOTICE, handle, fmt, ##__VA_ARGS__)
+#define acpi_pr_info(handle, fmt, ...)				\
+	acpi_printk(KERN_INFO, handle, fmt, ##__VA_ARGS__)
+#define acpi_pr_debug(handle, fmt, ...)				\
+	acpi_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__)
+
 #ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
-- 
1.7.7.6
