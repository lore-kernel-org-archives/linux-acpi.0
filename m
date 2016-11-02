From: Dave Lambley <linux@davel.me.uk>
Subject: [PATCH v2] If _BIX fails, retry with _BIF.
Date: Wed,  2 Nov 2016 18:37:27 +0000
Message-ID: <1478111847-14653-2-git-send-email-linux@davel.me.uk>
References: <1474153002-13904-1-git-send-email-linux@davel.me.uk>
 <1478111847-14653-1-git-send-email-linux@davel.me.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.the-lambleys.org.uk ([212.47.234.164]:46830 "EHLO
        smtp.the-lambleys.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756244AbcKBSqI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Nov 2016 14:46:08 -0400
In-Reply-To: <1478111847-14653-1-git-send-email-linux@davel.me.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dave Lambley <linux@davel.me.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

The Lenovo Yoga 300 laptop's firmware advertises that it provides the _BIX
the method to retrieve battery information. Unfortunately (some versions
of?) the implementation return with an error.

[   21.712228] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (0x000000010) is beyond end of object (length 0xD) (20160422/exoparg2-427)
[   21.712244] ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.H_EC.BAT1._BIX] (Node ffff95f8ff0b20f0), AE_AML_PACKAGE_LIMIT (2016042
2/psparse-542)

The _BIF method does succeed and returns convincing data. We detect _BIX
failing and automatically retry with _BIF.

Signed-off-by: Dave Lambley <linux@davel.me.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/battery.c | 72 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 93ecae5..ad5a62c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -430,39 +430,24 @@ static int acpi_battery_get_status(struct acpi_battery *battery)
 	return 0;
 }
 
-static int acpi_battery_get_info(struct acpi_battery *battery)
+
+int extract_battery_info(const int use_bix,
+			 struct acpi_battery *battery,
+			 const struct acpi_buffer *buffer)
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
@@ -483,6 +468,45 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	return result;
 }
 
+static int acpi_battery_get_info(struct acpi_battery *battery)
+{
+	const int xinfo = test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
+	int use_bix;
+	int result = -ENODEV;
+
+	if (!acpi_battery_present(battery))
+		return 0;
+
+
+	for (use_bix = xinfo ? 1 : 0; use_bix >= 0; use_bix--) {
+		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+		acpi_status status = AE_ERROR;
+
+		mutex_lock(&battery->lock);
+		status = acpi_evaluate_object(battery->device->handle,
+					      use_bix ? "_BIX":"_BIF",
+					      NULL, &buffer);
+		mutex_unlock(&battery->lock);
+
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s",
+					use_bix ? "_BIX":"_BIF"));
+		} else {
+			result = extract_battery_info(use_bix,
+						      battery,
+						      &buffer);
+
+			kfree(buffer.pointer);
+			break;
+		}
+	}
+
+	if (!result && !use_bix && xinfo)
+		pr_warn(FW_BUG "The _BIX method is broken, using _BIF.\n");
+
+	return result;
+}
+
 static int acpi_battery_get_state(struct acpi_battery *battery)
 {
 	int result = 0;
-- 
2.7.4

