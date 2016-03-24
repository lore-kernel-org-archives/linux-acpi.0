From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 3/3] acer-wmi: Use acpi_dev_found()
Date: Thu, 24 Mar 2016 13:15:20 +0100
Message-ID: <7d952954d0be7b63b466b3c1f978ad4b038d2145.1458813034.git.lukas@wunner.de>
References: <cover.1458813034.git.lukas@wunner.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1458813034.git.lukas@wunner.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Use shiny new acpi_dev_found() and remove all the boilerplate
to search for a particular ACPI device. No functional change.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lee, Chun-Yi <jlee@suse.com>
Acked-by: Darren Hart <dvhart@linux.intel.com>
---
 drivers/platform/x86/acer-wmi.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 1062fa4..79d64ea 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -793,15 +793,6 @@ static acpi_status __init AMW0_find_mailled(void)
 	return AE_OK;
 }
 
-static int AMW0_set_cap_acpi_check_device_found __initdata;
-
-static acpi_status __init AMW0_set_cap_acpi_check_device_cb(acpi_handle handle,
-	u32 level, void *context, void **retval)
-{
-	AMW0_set_cap_acpi_check_device_found = 1;
-	return AE_OK;
-}
-
 static const struct acpi_device_id norfkill_ids[] __initconst = {
 	{ "VPC2004", 0},
 	{ "IBM0068", 0},
@@ -816,9 +807,10 @@ static int __init AMW0_set_cap_acpi_check_device(void)
 	const struct acpi_device_id *id;
 
 	for (id = norfkill_ids; id->id[0]; id++)
-		acpi_get_devices(id->id, AMW0_set_cap_acpi_check_device_cb,
-				NULL, NULL);
-	return AMW0_set_cap_acpi_check_device_found;
+		if (acpi_dev_found(id->id))
+			return true;
+
+	return false;
 }
 
 static acpi_status __init AMW0_set_capabilities(void)
-- 
2.8.0.rc3
