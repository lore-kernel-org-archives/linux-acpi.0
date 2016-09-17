From: Dave Lambley <linux@davel.me.uk>
Subject: [PATCH] If _BIX fails, retry with _BIF.
Date: Sat, 17 Sep 2016 23:56:42 +0100
Message-ID: <1474153002-13904-1-git-send-email-linux@davel.me.uk>
References: <1AE640813FDE7649BE1B193DEA596E886A184E5E@SHSMSX101.ccr.corp.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.the-lambleys.org.uk ([212.47.234.164]:39696 "EHLO
        smtp.the-lambleys.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbcIQW47 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Sep 2016 18:56:59 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A184E5E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dave Lambley <linux@davel.me.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

The Lenovo Yoga 300 laptop's firmware advertises that it provides the _BIX
method. Unfortunately (some versions of?) the implementation return
badly-formed data.

[   21.712228] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (0x000000010) is beyond end of object (length 0xD) (20160422/exoparg2-427)
[   21.712244] ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.H_EC.BAT1._BIX] (Node ffff95f8ff0b20f0), AE_AML_PACKAGE_LIMIT (2016042
2/psparse-542)

The _BIF method does succeed.

Signed-off-by: Dave Lambley <linux@davel.me.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
---
 drivers/acpi/battery.c | 68 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ab23479..71ae7e7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -430,39 +430,24 @@ static int acpi_battery_get_status(struct acpi_battery *battery)
 	return 0;
 }
 
-static int acpi_battery_get_info(struct acpi_battery *battery)
+
+int extract_battery_info(const int use_bix,
+			 struct acpi_battery *battery,
+			 const struct acpi_buffer  *buffer)
 {
 	int result = -EFAULT;
-	acpi_status status = 0;
-	char *name = test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags) ?
-			"_BIX" : "_BIF";
-
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	if (!acpi_battery_present(battery))
-		return 0;
-	mutex_lock(&battery->lock);
-	status = acpi_evaluate_object(battery->device->handle, name,
-						NULL, &buffer);
-	mutex_unlock(&battery->lock);
-
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s", name));
-		return -ENODEV;
-	}
-
-	if (battery_bix_broken_package)
-		result = extract_package(battery, buffer.pointer,
+	if (use_bix && battery_bix_broken_package)
+		result = extract_package(battery, buffer->pointer,
 				extended_info_offsets + 1,
 				ARRAY_SIZE(extended_info_offsets) - 1);
-	else if (test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags))
-		result = extract_package(battery, buffer.pointer,
+	else if (use_bix)
+		result = extract_package(battery, buffer->pointer,
 				extended_info_offsets,
 				ARRAY_SIZE(extended_info_offsets));
 	else
-		result = extract_package(battery, buffer.pointer,
+		result = extract_package(battery, buffer->pointer,
 				info_offsets, ARRAY_SIZE(info_offsets));
-	kfree(buffer.pointer);
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		battery->full_charge_capacity = battery->design_capacity;
 	if (test_bit(ACPI_BATTERY_QUIRK_THINKPAD_MAH, &battery->flags) &&
@@ -483,6 +468,41 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	return result;
 }
 
+static int acpi_battery_get_info(struct acpi_battery *battery)
+{
+	acpi_status status = 0;
+	const int xinfo = test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
+	int use_bix;
+
+	if (!acpi_battery_present(battery))
+		return 0;
+
+
+	for (use_bix = xinfo ? 1 : 0; use_bix >= 0; use_bix--) {
+		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+
+		mutex_lock(&battery->lock);
+		status = acpi_evaluate_object(battery->device->handle,
+							use_bix ? "_BIX":"_BIF",
+							NULL, &buffer);
+		mutex_unlock(&battery->lock);
+
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s",
+					use_bix ? "_BIX":"_BIF"));
+		} else {
+			const int result = extract_battery_info(use_bix,
+								battery,
+								&buffer);
+
+			kfree(buffer.pointer);
+			return result;
+		}
+	}
+
+	return -ENODEV;
+}
+
 static int acpi_battery_get_state(struct acpi_battery *battery)
 {
 	int result = 0;
-- 
2.7.4

