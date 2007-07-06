From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 04/16] ACPI: thinkpad-acpi: enable more
	hotkeys
Date: Thu,  5 Jul 2007 23:42:16 -0300
Message-ID: <1183689748659-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11836897482509-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

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

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
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
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
