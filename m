From: Jerry Snitselaar <jerry.snitselaar@oracle.com>
Subject: [PATCH] acpi_i2c: set MODULE_LICENSE, MODULE_AUTHOR, and  MODULE_DESCRIPTION
Date: Fri, 16 Aug 2013 18:26:35 -0700
Message-ID: <1376702795-25912-1-git-send-email-jerry.snitselaar@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Without MODULE_LICENSE set, I get the following with modprobe:

acpi_i2c: module license 'unspecified' taints kernel.
acpi_i2c: Unknown symbol i2c_new_device (err 0)
acpi_i2c: Unknown symbol acpi_dev_get_resources (err 0)
acpi_i2c: Unknown symbol acpi_dev_resource_interrupt (err 0)
acpi_i2c: Unknown symbol acpi_dev_free_resource_list (err 0)

Signed-off-by: Jerry Snitselaar <jerry.snitselaar@oracle.com>
---
 drivers/acpi/acpi_i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpi_i2c.c b/drivers/acpi/acpi_i2c.c
index 82045e3..2c5c65d 100644
--- a/drivers/acpi/acpi_i2c.c
+++ b/drivers/acpi/acpi_i2c.c
@@ -14,9 +14,14 @@
 #include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/ioport.h>
+#include <linux/module.h>
 
 ACPI_MODULE_NAME("i2c");
 
+MODULE_DESCRIPTION("ACPI I2C enumeration support");
+MODULE_AUTHOR("Mika Westerberg");
+MODULE_LICENSE("GPL");
+
 static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct i2c_board_info *info = data;
-- 
1.8.4.rc3.2.g2c2b664
