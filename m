From: Len Brown <len.brown@intel.com>
Subject: [PATCH 013/105] asus-laptop: use acpi_evaluate_integer instead of read_acpi_int
Date: Sun, 29 Apr 2007 00:50:13 -0400
Message-ID: <11778223161614-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbXD2Ev6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:58 -0400
In-Reply-To: <11778223152006-git-send-email-len.brown@intel.com>
Message-Id: <9a8168500674b1062afe438d34d0c8216d38dc31.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Use acpi_evaluate_integer() instead of read_acpi_int()

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   68 ++++++++++++++++++++++----------------------
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 4b23212..dcab778 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -245,32 +245,19 @@ static int write_acpi_int(acpi_handle handle, const char *method, int val,
 	return (status == AE_OK);
 }
 
-static int read_acpi_int(acpi_handle handle, const char *method, int *val,
-			 struct acpi_object_list *params)
-{
-	struct acpi_buffer output;
-	union acpi_object out_obj;
-	acpi_status status;
-
-	output.length = sizeof(out_obj);
-	output.pointer = &out_obj;
-
-	status = acpi_evaluate_object(handle, (char *)method, params, &output);
-	*val = out_obj.integer.value;
-	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
-}
-
 static int read_wireless_status(int mask)
 {
-	int status;
+	ulong status;
+	acpi_status rv = AE_OK;
 
 	if (!wireless_status_handle)
 		return (hotk->status & mask) ? 1 : 0;
 
-	if (read_acpi_int(wireless_status_handle, NULL, &status, NULL)) {
-		return (status & mask) ? 1 : 0;
-	} else
+	rv = acpi_evaluate_integer(wireless_status_handle, NULL, NULL, &status);
+	if (ACPI_FAILURE(rv))
 		printk(ASUS_WARNING "Error reading Wireless status\n");
+	else
+		return (status & mask) ? 1 : 0;
 
 	return (hotk->status & mask) ? 1 : 0;
 }
@@ -354,9 +341,11 @@ static void lcd_blank(int blank)
 
 static int read_brightness(struct backlight_device *bd)
 {
-	int value;
+	ulong value;
+	acpi_status rv = AE_OK;
 
-	if (!read_acpi_int(brightness_get_handle, NULL, &value, NULL))
+	rv = acpi_evaluate_integer(brightness_get_handle, NULL, NULL, &value);
+	if (ACPI_FAILURE(rv))
 		printk(ASUS_WARNING "Error reading brightness\n");
 
 	return value;
@@ -403,8 +392,10 @@ static ssize_t show_infos(struct device *dev,
 			  struct device_attribute *attr, char *page)
 {
 	int len = 0;
-	int temp;
+	ulong temp;
 	char buf[16];		//enough for all info
+	acpi_status rv = AE_OK;
+
 	/*
 	 * We use the easy way, we don't care of off and count, so we don't set eof
 	 * to 1
@@ -418,9 +409,10 @@ static ssize_t show_infos(struct device *dev,
 	 * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI card.
 	 * The significance of others is yet to be found.
 	 */
-	if (read_acpi_int(hotk->handle, "SFUN", &temp, NULL))
-		len +=
-		    sprintf(page + len, "SFUN value         : 0x%04x\n", temp);
+	rv = acpi_evaluate_integer(hotk->handle, "SFUN", NULL, &temp);
+	if (!ACPI_FAILURE(rv))
+		len += sprintf(page + len, "SFUN value         : 0x%04x\n",
+			       (uint) temp);
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
 	 * battery low and 0x04 for battery critical, its readings tend to be
@@ -428,9 +420,10 @@ static ssize_t show_infos(struct device *dev,
 	 * Note: since not all the laptops provide this method, errors are
 	 * silently ignored.
 	 */
-	if (read_acpi_int(hotk->handle, "ASYM", &temp, NULL))
-		len +=
-		    sprintf(page + len, "ASYM value         : 0x%04x\n", temp);
+	rv = acpi_evaluate_integer(hotk->handle, "ASYM", NULL, &temp);
+	if (!ACPI_FAILURE(rv))
+		len += sprintf(page + len, "ASYM value         : 0x%04x\n",
+			       (uint) temp);
 	if (asus_info) {
 		snprintf(buf, 16, "%d", asus_info->length);
 		len += sprintf(page + len, "DSDT length        : %s\n", buf);
@@ -547,12 +540,15 @@ static void set_display(int value)
 
 static int read_display(void)
 {
-	int value = 0;
+	ulong value = 0;
+	acpi_status rv = AE_OK;
 
 	/* In most of the case, we know how to set the display, but sometime
 	   we can't read it */
 	if (display_get_handle) {
-		if (!read_acpi_int(display_get_handle, NULL, &value, NULL))
+		rv = acpi_evaluate_integer(display_get_handle, NULL,
+					   NULL, &value);
+		if (ACPI_FAILURE(rv))
 			printk(ASUS_WARNING "Error reading display status\n");
 	}
 
@@ -771,7 +767,7 @@ static int asus_hotk_get_info(void)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
-	int bsts_result, hwrs_result;
+	ulong bsts_result, hwrs_result;
 	char *string = NULL;
 	acpi_status status;
 
@@ -794,11 +790,13 @@ static int asus_hotk_get_info(void)
 	}
 
 	/* This needs to be called for some laptops to init properly */
-	if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result, NULL))
+	status =
+	    acpi_evaluate_integer(hotk->handle, "BSTS", NULL, &bsts_result);
+	if (ACPI_FAILURE(status))
 		printk(ASUS_WARNING "Error calling BSTS\n");
 	else if (bsts_result)
 		printk(ASUS_NOTICE "BSTS called, 0x%02x returned\n",
-		       bsts_result);
+		       (uint) bsts_result);
 
 	/*
 	 * Try to match the object returned by INIT to the specific model.
@@ -840,7 +838,9 @@ static int asus_hotk_get_info(void)
 	 * The significance of others is yet to be found.
 	 * If we don't find the method, we assume the device are present.
 	 */
-	if (!read_acpi_int(hotk->handle, "HRWS", &hwrs_result, NULL))
+	status =
+	    acpi_evaluate_integer(hotk->handle, "HRWS", NULL, &hwrs_result);
+	if (ACPI_FAILURE(status))
 		hwrs_result = WL_HWRS | BT_HWRS;
 
 	if (hwrs_result & WL_HWRS)
-- 
1.5.2.rc0.34.gda94
