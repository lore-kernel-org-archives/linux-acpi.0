From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Mon,  6 Jan 2014 22:50:37 +0800
Message-ID: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, l@dorileo.org, dmitry.torokhov@gmail.com, "3.8+" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

The aml method _BIX of NEC LZ750/LS returns a broken package which
skip the first member "Revision" according ACPI 5.0 spec Table 10-234.

This patch is to add a quirk for this machine to skip member "Revision"
during parsing _BIX returned package.

Reported-and-tested-by: Francisco Castro <fcr@adinet.com.uy>
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=67351
Cc: 3.8+ <stable@vger.kernel.org>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Change since v1:
	Remove battery_bix_package_quirk() function and set
battery_bix_broken_package flag according the returned value
of dmi_check_system().

 drivers/acpi/battery.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e90ef8b..d21cc1a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -61,6 +61,7 @@ MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
+static int battery_bix_broken_package;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -415,7 +416,12 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s", name));
 		return -ENODEV;
 	}
-	if (test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags))
+
+	if (battery_bix_broken_package)
+		result = extract_package(battery, buffer.pointer,
+				extended_info_offsets + 1,
+				ARRAY_SIZE(extended_info_offsets) - 1);
+	else if (test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags))
 		result = extract_package(battery, buffer.pointer,
 				extended_info_offsets,
 				ARRAY_SIZE(extended_info_offsets));
@@ -753,6 +759,17 @@ static int battery_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static struct dmi_system_id bat_dmi_table[] = {
+	{
+	.ident = "NEC LZ750/LS",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "PC-LZ750LS"),
+		},
+	},
+	{},
+};
+
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -845,6 +862,9 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 {
 	if (acpi_disabled)
 		return;
+
+	if (dmi_check_system(bat_dmi_table))
+		battery_bix_broken_package = 1;
 	acpi_bus_register_driver(&acpi_battery_driver);
 }
 
-- 
1.8.2.1
