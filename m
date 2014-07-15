From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 10/10] ACPI/EC: Add unit test support for EC driver hotplug.
Date: Tue, 15 Jul 2014 11:15:27 +0800
Message-ID: <6d730506322f4d9e3b2840db907b092d56bf95de.1405391679.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1405391678.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1405391678.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds facility to test future EC modification.
All EC commits should enable TEST_HOTPLUG, and try a build/boot test.
Since EC is currently a built-in module, this is the only mean for us to
test the hotplug code.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b98474f..d3b1bd7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -31,6 +31,7 @@
 
 /* Uncomment next line to get verbose printout */
 /* #define DEBUG */
+/* #define TEST_HOTPLUG */
 #define pr_fmt(fmt) "ACPI : EC: " fmt
 
 #include <linux/kernel.h>
@@ -128,6 +129,9 @@ static struct acpi_ec_query_handler *
 acpi_ec_get_query_handler(struct acpi_ec_query_handler *handler);
 static void acpi_ec_put_query_handler(struct acpi_ec_query_handler *handler);
 
+static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
+			       u32 gpe_number, void *data);
+
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
 
@@ -787,6 +791,21 @@ static void acpi_ec_gpe_query(void *ec_cxt)
 	mutex_lock(&ec->mutex);
 	acpi_ec_sync_query(ec, NULL);
 	mutex_unlock(&ec->mutex);
+
+#ifdef TEST_HOTPLUG
+
+	/* Unit testing for driver hotplugging */
+
+	pr_info("Removing EC handlers...\n");
+	acpi_ec_stop(ec);
+	acpi_remove_gpe_handler(NULL, ec->gpe,
+				&acpi_ec_gpe_handler);
+	pr_info("Installing EC handlers...\n");
+	acpi_install_gpe_handler(NULL, ec->gpe,
+				  ACPI_GPE_EDGE_TRIGGERED,
+				  &acpi_ec_gpe_handler, ec);
+	acpi_ec_start(ec);
+#endif
 }
 
 static int ec_check_sci(struct acpi_ec *ec, u8 state)
-- 
1.7.10
