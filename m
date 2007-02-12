From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH] sony-laptop: allow complex per-value input/output validation
Date: Mon, 12 Feb 2007 22:01:07 +0100
Message-ID: <20070212210107.GA5577@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:43694 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965404AbXBLVCe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Feb 2007 16:02:34 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

From: Mattia Dongili <malattia@linux.it>

Replace sony_acpi_value.{min,max} with a callback function that allows
more complex reasoning in accepting input and presenting output.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---

Len,
this patch specifically allows consistency between the sony-laptop
specific 'brightness_default' and the backlight subsystem 0-based
'brightness'.
Please apply it tho the test branch before submitting sony-laptop
upstream, thanks. :)

 sony-laptop.c |   81 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index d7b5330..cabbed0 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -58,13 +58,17 @@ static ssize_t sony_acpi_show(struct device *, struct device_attribute *,
 			      char *);
 static ssize_t sony_acpi_store(struct device *, struct device_attribute *,
 			       const char *, size_t);
+static int boolean_validate(const int, const int);
+static int brightness_default_validate(const int, const int);
+
+#define SNC_VALIDATE_IN		0
+#define SNC_VALIDATE_OUT	1
 
 struct sony_acpi_value {
 	char *name;		/* name of the entry */
 	char **acpiget;		/* names of the ACPI get function */
 	char **acpiset;		/* names of the ACPI set function */
-	int min;		/* minimum allowed value or -1 */
-	int max;		/* maximum allowed value or -1 */
+	int (*validate)(const int, const int);	/* input/output validation */
 	int value;		/* current setting */
 	int valid;		/* Has ever been set */
 	int debug;		/* active only in debug mode ? */
@@ -74,13 +78,12 @@ struct sony_acpi_value {
 #define HANDLE_NAMES(_name, _values...) \
 	static char *snc_##_name[] = { _values, NULL }
 
-#define SONY_ACPI_VALUE(_name, _getters, _setters, _min, _max, _debug) \
+#define SONY_ACPI_VALUE(_name, _getters, _setters, _validate, _debug) \
 	{ \
 		.name		= __stringify(_name), \
 		.acpiget	= _getters, \
 		.acpiset	= _setters, \
-		.min		= _min, \
-		.max		= _max, \
+		.validate	= _validate, \
 		.debug		= _debug, \
 		.devattr	= __ATTR(_name, 0, sony_acpi_show, sony_acpi_store), \
 	}
@@ -114,17 +117,18 @@ HANDLE_NAMES(CMI_set, "SCMI");
 
 static struct sony_acpi_value sony_acpi_values[] = {
 	SONY_ACPI_VALUE(brightness_default, snc_brightness_def_get,
-			snc_brightness_def_set, 1, SONY_MAX_BRIGHTNESS, 0),
-	SONY_ACPI_VALUE(fnkey, snc_fnkey_get, NULL, -1, -1, 0),
-	SONY_ACPI_VALUE(cdpower, snc_cdpower_get, snc_cdpower_set, 0, 1, 0),
-	SONY_ACPI_VALUE(audiopower, snc_audiopower_get, snc_audiopower_set, 0,
-			1, 0),
-	SONY_ACPI_VALUE(lanpower, snc_lanpower_get, snc_lanpower_set, 0, 1, 1),
+			snc_brightness_def_set, brightness_default_validate, 0),
+	SONY_ACPI_VALUE(fnkey, snc_fnkey_get, NULL, NULL, 0),
+	SONY_ACPI_VALUE(cdpower, snc_cdpower_get, snc_cdpower_set, boolean_validate, 0),
+	SONY_ACPI_VALUE(audiopower, snc_audiopower_get, snc_audiopower_set,
+			boolean_validate, 0),
+	SONY_ACPI_VALUE(lanpower, snc_lanpower_get, snc_lanpower_set,
+			boolean_validate, 1),
 	/* unknown methods */
-	SONY_ACPI_VALUE(PID, snc_PID_get, NULL, -1, -1, 1),
-	SONY_ACPI_VALUE(CTR, snc_CTR_get, snc_CTR_set, -1, -1, 1),
-	SONY_ACPI_VALUE(PCR, snc_PCR_get, snc_PCR_set, -1, -1, 1),
-	SONY_ACPI_VALUE(CMI, snc_CMI_get, snc_CMI_set, -1, -1, 1),
+	SONY_ACPI_VALUE(PID, snc_PID_get, NULL, NULL, 1),
+	SONY_ACPI_VALUE(CTR, snc_CTR_get, snc_CTR_set, NULL, 1),
+	SONY_ACPI_VALUE(PCR, snc_PCR_get, snc_PCR_set, NULL, 1),
+	SONY_ACPI_VALUE(CMI, snc_CMI_get, snc_CMI_set, NULL, 1),
 	SONY_ACPI_VALUE_NULL
 };
 
@@ -190,6 +194,41 @@ static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
 }
 
 /*
+ * sony_acpi_values input/output validate functions
+ */
+
+/* brightness_default_validate:
+ *
+ * manipulate input output values to keep consistency with the
+ * backlight framework for which brightness values are 0-based.
+ */
+static int brightness_default_validate(const int direction, const int value)
+{
+	switch (direction) {
+		case SNC_VALIDATE_OUT:
+			return value - 1;
+		case SNC_VALIDATE_IN:
+			if (value >= 0 && value < SONY_MAX_BRIGHTNESS)
+				return value + 1;
+	}
+	return -EINVAL;
+}
+
+/* boolean_validate:
+ *
+ * on input validate boolean values 0/1, on output just pass the
+ * received value.
+ */
+static int boolean_validate(const int direction, const int value)
+{
+	if (direction == SNC_VALIDATE_IN) {
+		if (value != 0 && value != 1)
+			return -EINVAL;
+	}
+	return value;
+}
+
+/*
  * Sysfs show/store common to all sony_acpi_values
  */
 static ssize_t sony_acpi_show(struct device *dev, struct device_attribute *attr,
@@ -205,6 +244,9 @@ static ssize_t sony_acpi_show(struct device *dev, struct device_attribute *attr,
 	if (acpi_callgetfunc(sony_acpi_handle, *item->acpiget, &value) < 0)
 		return -EIO;
 
+	if (item->validate)
+		value = item->validate(SNC_VALIDATE_OUT, value);
+
 	return snprintf(buffer, PAGE_SIZE, "%d\n", value);
 }
 
@@ -224,10 +266,11 @@ static ssize_t sony_acpi_store(struct device *dev,
 
 	value = simple_strtoul(buffer, NULL, 10);
 
-	if (item->min != -1 && value < item->min)
-		return -EINVAL;
-	if (item->max != -1 && value > item->max)
-		return -EINVAL;
+	if (item->validate)
+		value = item->validate(SNC_VALIDATE_IN, value);
+
+	if (value < 0)
+		return value;
 
 	if (acpi_callsetfunc(sony_acpi_handle, *item->acpiset, value, NULL) < 0)
 		return -EIO;
