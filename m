From: Len Brown <len.brown@intel.com>
Subject: [PATCH 44/77] ACPI: thinkpad-acpi: enable more hotkeys
Date: Sun, 22 Jul 2007 05:14:29 -0400
Message-ID: <11850957482671-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53139 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763260AbXGVJPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:54 -0400
In-Reply-To: <11850957471828-git-send-email-len.brown@intel.com>
Message-Id: <ae92bd17ff703b3703562148c73b4d6833e6a326.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Revise ACPI HKEY functionality to better interface with the firmware, and
enable up to 32 regular hotkeys, instead of just 16 of them.  Ouch.

This takes care of most keys one used to have to do CMOS NVRAM polling on,
and should drop the need for tpb, thinkpad-keys, and other such 5Hz NVRAM
polling power vampires on most modern ThinkPads ;-)

And, just to add insult to injury, this was sort of working since forever
through the procfs interface, but nobody noticed or tried an echo
0xffffffff > /proc/acpi/ibm/hotkey and told me it would generate weird
events. ARGH!

Thanks to Richard Hughes for kicking off the work that ended up with this
discovery, and to Matthew Garret for calling my attention to the fact that
newer ThinkPads were indeed generating ACPI GPEs when such hot keys were
pressed.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   41 ++++++++++++++++----------------------
 drivers/misc/thinkpad_acpi.c    |   38 ++++++++++++++++++++---------------
 drivers/misc/thinkpad_acpi.h    |    6 ++--
 3 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index b90d9a7..2f30db0 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -153,29 +153,22 @@ addition, the lid microswitch and some docking station buttons may
 also generate such events.
 
 The bit mask allows some control over which hot keys generate ACPI
-events. Not all bits in the mask can be modified. Not all bits that
-can be modified do anything. Not all hot keys can be individually
-controlled by the mask. Most recent ThinkPad models honor the
-following bits (assuming the hot keys feature has been enabled):
-
-	key	bit	behavior when set	behavior when unset
-
-	Fn-F3			always generates ACPI event
-	Fn-F4			always generates ACPI event
-	Fn-F5	0010	generate ACPI event	enable/disable Bluetooth
-	Fn-F7	0040	generate ACPI event	switch LCD and external display
-	Fn-F8	0080	generate ACPI event	expand screen or none
-	Fn-F9	0100	generate ACPI event	none
-	Fn-F12			always generates ACPI event
-
-Some models do not support all of the above. For example, the T30 does
-not support Fn-F5 and Fn-F9. Other models do not support the mask at
-all. On those models, hot keys cannot be controlled individually.
+events. Not all bits in the mask can be modified. Not all bits that can
+be modified do anything. Not all hot keys can be individually controlled
+by the mask. Some models do not support the mask at all. On those
+models, hot keys cannot be controlled individually.
 
 Note that enabling ACPI events for some keys prevents their default
-behavior. For example, if events for Fn-F5 are enabled, that key will
-no longer enable/disable Bluetooth by itself. This can still be done
-from an acpid handler for the ibm/hotkey event.
+behavior. For example, if events for Fn-F5 are enabled, that key will no
+longer enable/disable Bluetooth by itself. This can still be done from
+an acpid handler for the ibm/hotkey event.
+
+On some models, even enabling/disabling the entire hot key feature may
+change the way some keys behave (e.g. in a T43, Fn+F4 will generate an
+button/sleep ACPI event if hot keys are disabled, and it will ignore its
+mask when hot keys are enabled, so the key always does something.  On a
+X40, Fn+F4 respects its mask status, but generates the button/sleep ACPI
+event if masked off).
 
 Note also that not all Fn key combinations are supported through
 ACPI. For example, on the X40, the brightness, volume and "Access IBM"
@@ -189,9 +182,9 @@ The following commands can be written to the /proc/acpi/ibm/hotkey file:
 
 	echo enable > /proc/acpi/ibm/hotkey -- enable the hot keys feature
 	echo disable > /proc/acpi/ibm/hotkey -- disable the hot keys feature
-	echo 0xffff > /proc/acpi/ibm/hotkey -- enable all possible hot keys
-	echo 0x0000 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
-	... any other 4-hex-digit mask ...
+	echo 0xffffffff > /proc/acpi/ibm/hotkey -- enable all hot keys
+	echo 0 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
+	... any other 8-hex-digit mask ...
 	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
 
 sysfs notes:
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9f10b46..450b1e5 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -727,7 +727,7 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
  */
 
 static int hotkey_orig_status;
-static int hotkey_orig_mask;
+static u32 hotkey_orig_mask;
 
 static struct attribute_set *hotkey_dev_attributes;
 
@@ -736,7 +736,8 @@ static ssize_t hotkey_enable_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	int res, status, mask;
+	int res, status;
+	u32 mask;
 
 	res = hotkey_get(&status, &mask);
 	if (res)
@@ -750,7 +751,8 @@ static ssize_t hotkey_enable_store(struct device *dev,
 			    const char *buf, size_t count)
 {
 	unsigned long t;
-	int res, status, mask;
+	int res, status;
+	u32 mask;
 
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
@@ -771,13 +773,14 @@ static ssize_t hotkey_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	int res, status, mask;
+	int res, status;
+	u32 mask;
 
 	res = hotkey_get(&status, &mask);
 	if (res)
 		return res;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", mask);
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", mask);
 }
 
 static ssize_t hotkey_mask_store(struct device *dev,
@@ -785,9 +788,10 @@ static ssize_t hotkey_mask_store(struct device *dev,
 			    const char *buf, size_t count)
 {
 	unsigned long t;
-	int res, status, mask;
+	int res, status;
+	u32 mask;
 
-	if (parse_strtoul(buf, 0xffff, &t))
+	if (parse_strtoul(buf, 0xffffffffUL, &t))
 		return -EINVAL;
 
 	res = hotkey_get(&status, &mask);
@@ -817,7 +821,7 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n", hotkey_orig_mask);
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_orig_mask);
 }
 
 static struct device_attribute dev_attr_hotkey_bios_mask =
@@ -902,10 +906,10 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	int hkey;
 
-	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d"))
+	if (event == 0x80 && acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
 		acpi_bus_generate_event(ibm->acpi->device, event, hkey);
-	else {
-		printk(IBM_ERR "unknown hotkey event %d\n", event);
+	} else {
+		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
 		acpi_bus_generate_event(ibm->acpi->device, event, 0);
 	}
 }
@@ -913,7 +917,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 /*
  * Call with hotkey_mutex held
  */
-static int hotkey_get(int *status, int *mask)
+static int hotkey_get(int *status, u32 *mask)
 {
 	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
 		return -EIO;
@@ -928,7 +932,7 @@ static int hotkey_get(int *status, int *mask)
 /*
  * Call with hotkey_mutex held
  */
-static int hotkey_set(int status, int mask)
+static int hotkey_set(int status, u32 mask)
 {
 	int i;
 
@@ -949,7 +953,8 @@ static int hotkey_set(int status, int mask)
 /* procfs -------------------------------------------------------------- */
 static int hotkey_read(char *p)
 {
-	int res, status, mask;
+	int res, status;
+	u32 mask;
 	int len = 0;
 
 	if (!tp_features.hotkey) {
@@ -967,7 +972,7 @@ static int hotkey_read(char *p)
 
 	len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 0));
 	if (tp_features.hotkey_mask) {
-		len += sprintf(p + len, "mask:\t\t0x%04x\n", mask);
+		len += sprintf(p + len, "mask:\t\t0x%08x\n", mask);
 		len += sprintf(p + len,
 			       "commands:\tenable, disable, reset, <mask>\n");
 	} else {
@@ -980,7 +985,8 @@ static int hotkey_read(char *p)
 
 static int hotkey_write(char *buf)
 {
-	int res, status, mask;
+	int res, status;
+	u32 mask;
 	char *cmd;
 	int do_cmd = 0;
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 72d62f2..e1a64f0 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -415,14 +415,14 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc);
  */
 
 static int hotkey_orig_status;
-static int hotkey_orig_mask;
+static u32 hotkey_orig_mask;
 
 static struct mutex hotkey_mutex;
 
 static int hotkey_init(struct ibm_init_struct *iibm);
 static void hotkey_exit(void);
-static int hotkey_get(int *status, int *mask);
-static int hotkey_set(int status, int mask);
+static int hotkey_get(int *status, u32 *mask);
+static int hotkey_set(int status, u32 mask);
 static void hotkey_notify(struct ibm_struct *ibm, u32 event);
 static int hotkey_read(char *p);
 static int hotkey_write(char *buf);
-- 
1.5.3.rc2.22.g69a9b
