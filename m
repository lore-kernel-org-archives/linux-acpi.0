From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/41] sony-laptop: allow complex per-value input/output validation
Date: Tue, 13 Feb 2007 00:49:42 -0500
Message-ID: <11713458293698-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org> <11713458233765-git-send-email-lenb@kernel.org> <11713458242872-git-send-email-lenb@kernel.org> <11713458251648-git-send-email-lenb@kernel.org> <11713458262743-git-send-email-lenb@kernel.org> <11713458271675-
 git-send-email-lenb@kernel.org> <11713458271642-git-send-email-lenb@kernel.org> <11713458283253-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:19853 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751102AbXBMFub (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:31 -0500
In-Reply-To: <11713458283253-git-send-email-lenb@kernel.org>
Message-Id: <2136aff6886eebac074811cecb59f5c60642e70a.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Replace sony_acpi_value.{min,max} with a callback function that allows
more complex reasoning in accepting input and presenting output.

This allows consistency between the sony-laptop specific 'brightness_default'
and the backlight subsystem 0-based 'brightness'.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |   81 +++++++++++++++++++++++++++++++++----------
 1 files changed, 62 insertions(+), 19 deletions(-)

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
-- 
1.5.0.rc4.345.gb4d2
