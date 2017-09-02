From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] platform/x86: intel_cht_int33fe: Work around BIOS bug on some devices
Date: Sat,  2 Sep 2017 18:20:40 +0200
Message-ID: <20170902162040.18565-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752697AbdIBQUp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 2 Sep 2017 12:20:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

At least one BIOS enumerates the max17047 both through the INT33FE ACPI
device (it is right there in the resources table) as well as through a
separate MAX17047 device.

This commit checks for the max17047 already being enumerated through
a separate MAX17047 ACPI device and if so it uses the i2c-client
instantiated for this and attaches the device-props for the max17047 to
that i2c-client.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Check acpi_companion HID instead of dev_name
---
 drivers/platform/x86/intel_cht_int33fe.c | 71 +++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index da706e2c4232..a9cbc4b8ca63 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -34,6 +34,42 @@ struct cht_int33fe_data {
 	struct i2c_client *pi3usb30532;
 };
 
+/*
+ * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
+ * the max17047 both through the INT33FE ACPI device (it is right there
+ * in the resources table) as well as through a separate MAX17047 device.
+ *
+ * These helpers are used to work around this by checking if an i2c-client
+ * for the max17047 has already been registered.
+ */
+int cht_int33fe_check_for_max17047(struct device *dev, void *data)
+{
+	struct acpi_device *companion = ACPI_COMPANION(dev);
+	struct i2c_client **max17047 = data;
+	const char *hid;
+
+	if (!companion)
+		return 0;
+
+	hid = acpi_device_hid(companion);
+
+	/* The MAX17047 ACPI node doesn't have an UID, so we don't check that */
+	if (strcmp(hid, "MAX17047") == 0) {
+		*max17047 = to_i2c_client(dev);
+		return 1;
+	}
+
+	return 0;
+}
+
+struct i2c_client *cht_int33fe_find_max17047(void)
+{
+	struct i2c_client *max17047 = NULL;
+
+	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
+	return max17047;
+}
+
 static const char * const max17047_suppliers[] = { "bq24190-charger" };
 
 static const struct property_entry max17047_props[] = {
@@ -46,9 +82,10 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
+	struct i2c_client *max17047;
 	unsigned long long ptyp;
 	acpi_status status;
-	int fusb302_irq;
+	int ret, fusb302_irq;
 
 	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
 	if (ACPI_FAILURE(status)) {
@@ -75,13 +112,25 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	memset(&board_info, 0, sizeof(board_info));
-	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
-	board_info.properties = max17047_props;
-
-	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
-	if (!data->max17047)
-		return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
+	max17047 = cht_int33fe_find_max17047();
+	if (max17047) {
+		/* Pre-existing i2c-client for the max17047, add device-props */
+		ret = device_add_properties(&max17047->dev, max17047_props);
+		if (ret)
+			return ret;
+		/* And re-probe to get the new device-props applied. */
+		ret = device_reprobe(&max17047->dev);
+		if (ret)
+			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
+	} else {
+		memset(&board_info, 0, sizeof(board_info));
+		strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
+		board_info.properties = max17047_props;
+		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
+		if (!data->max17047)
+			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
+	}
 
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "fusb302", I2C_NAME_SIZE);
@@ -106,7 +155,8 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	i2c_unregister_device(data->fusb302);
 
 out_unregister_max17047:
-	i2c_unregister_device(data->max17047);
+	if (data->max17047)
+		i2c_unregister_device(data->max17047);
 
 	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 }
@@ -117,7 +167,8 @@ static int cht_int33fe_remove(struct i2c_client *i2c)
 
 	i2c_unregister_device(data->pi3usb30532);
 	i2c_unregister_device(data->fusb302);
-	i2c_unregister_device(data->max17047);
+	if (data->max17047)
+		i2c_unregister_device(data->max17047);
 
 	return 0;
 }
-- 
2.13.4

