From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/5] Revert "ACPI / button: Remove lid_init_state=method mode"
Date: Tue,  9 May 2017 15:02:22 +0800
Message-ID: <1279adcdd56501f97ce02c6289d1c5ae9cc583aa.1494311429.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2895 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdEIHCa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 May 2017 03:02:30 -0400
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org

This reverts commit ecb10b694b72ca5ea51b3c90a71ff2a11963425a.

The only expected ACPI control method lid device's usage model is
1. Listen to the lid notification,
2. Evaluate _LID after being notified by BIOS,
3. Suspend the system (if users configure to do so) after seeing "close".
It's not ensured that BIOS will notify OS after boot/resume, and
it's not ensured that BIOS will always generate "open" event upon
opening the lid.

But there are 2 wrong usage models:
1. When the lid device is responsible for suspend/resume the system,
   userspace requires to see "open" event to be paired with "close" after
   the system is resumed, or it will suspend the system again.
2. When an external monitor connects to the laptop attached docks,
   userspace requires to see "close" event after the system is resumed so
   that it can determine whether the internal display should remain dark
   and the external display should be lit on.

After we made default kernel behavior to be suitable for usage model 1,
users of usage model 2 start to report regressions for such behavior
change.

Reversion of button.lid_init_state=method doesn't actually reverts to old
default behavior as doing so can enter a regression loop, but facilitates
users to work the reported regressions around with
button.lid_init_state=method.

Fixes: ecb10b694b72 ("ACPI / button: Remove lid_init_state=method mode")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=195455
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1430259
Tested-by: Steffen Weber <steffen.weber@gmail.com>
Tested-by: Julian Wiedmann <julian.wiedmann@jwi.name>
Reported-by: Joachim Frieben <jfrieben@hotmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
 drivers/acpi/button.c           |  9 +++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
index 22cb309..effe7af 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/acpi/acpi-lid.txt
@@ -59,20 +59,28 @@ button driver uses the following 3 modes in order not to trigger issues.
 If the userspace hasn't been prepared to ignore the unreliable "opened"
 events and the unreliable initial state notification, Linux users can use
 the following kernel parameters to handle the possible issues:
-A. button.lid_init_state=open:
+A. button.lid_init_state=method:
+   When this option is specified, the ACPI button driver reports the
+   initial lid state using the returning value of the _LID control method
+   and whether the "opened"/"closed" events are paired fully relies on the
+   firmware implementation.
+   This option can be used to fix some platforms where the returning value
+   of the _LID control method is reliable but the initial lid state
+   notification is missing.
+   This option is the default behavior during the period the userspace
+   isn't ready to handle the buggy AML tables.
+B. button.lid_init_state=open:
    When this option is specified, the ACPI button driver always reports the
    initial lid state as "opened" and whether the "opened"/"closed" events
    are paired fully relies on the firmware implementation.
    This may fix some platforms where the returning value of the _LID
    control method is not reliable and the initial lid state notification is
    missing.
-   This option is the default behavior during the period the userspace
-   isn't ready to handle the buggy AML tables.
 
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
-B. button.lid_init_state=ignore:
+C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
    ensure that the reliable "closed" notifications can always be delievered
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 668137e..6d5a8c1 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -57,6 +57,7 @@
 
 #define ACPI_BUTTON_LID_INIT_IGNORE	0x00
 #define ACPI_BUTTON_LID_INIT_OPEN	0x01
+#define ACPI_BUTTON_LID_INIT_METHOD	0x02
 
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");
@@ -376,6 +377,9 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
 	case ACPI_BUTTON_LID_INIT_OPEN:
 		(void)acpi_lid_notify_state(device, 1);
 		break;
+	case ACPI_BUTTON_LID_INIT_METHOD:
+		(void)acpi_lid_update_state(device);
+		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
 		break;
@@ -559,6 +563,9 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
 	if (!strncmp(val, "open", sizeof("open") - 1)) {
 		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
 		pr_info("Notify initial lid state as open\n");
+	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
+		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+		pr_info("Notify initial lid state with _LID return value\n");
 	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
 		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
 		pr_info("Do not notify initial lid state\n");
@@ -572,6 +579,8 @@ static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
 		return sprintf(buffer, "open");
+	case ACPI_BUTTON_LID_INIT_METHOD:
+		return sprintf(buffer, "method");
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 		return sprintf(buffer, "ignore");
 	default:
-- 
2.7.4

