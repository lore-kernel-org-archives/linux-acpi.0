From: Richard Knutsson <ricknu-0@student.ltu.se>
Subject: [PATCH] sonypi: Fix initialization warning
Date: Sun, 05 Aug 2007 21:05:20 +0200
Message-ID: <46B61F70.90005@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760661AbXHETGZ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Collins <bcollins@ubuntu.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
Got this from the compiler (gcc (GCC) 4.1.2 20070626 (Red Hat 4.1.2-13)):
drivers/char/sonypi.c:1153: warning: initialization from incompatible pointer type


diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 73037a4..2dcd519 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1147,10 +1147,15 @@ static int sonypi_acpi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static const struct acpi_device_id sonypi_acpi_driver_ids[] = {
+        {ACPI_PROCESSOR_HID, 0},
+        {"", 0},
+};
+
 static struct acpi_driver sonypi_acpi_driver = {
 	.name           = "sonypi",
 	.class          = "hkey",
-	.ids            = "SNY6001",
+	.ids            = sonypi_acpi_driver_ids,
 	.ops            = {
 		           .add = sonypi_acpi_add,
 			   .remove = sonypi_acpi_remove,
