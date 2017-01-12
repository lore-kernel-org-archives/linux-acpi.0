From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPI / button: Remove lid_init_state=method mode
Date: Thu, 12 Jan 2017 15:47:40 +0800
Message-ID: <c08881622036234a985acc425af75b351856272e.1484206801.git.lv.zheng@intel.com>
References: <cover.1484206801.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41842 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbdALHro (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Jan 2017 02:47:44 -0500
In-Reply-To: <cover.1484206801.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The mode is buggy, and lid_init__state=open is more useful than this
mode, so this patch makes it deprecated.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/acpi/acpi-lid.txt | 16 ++++------------
 drivers/acpi/button.c           |  9 ---------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
index effe7af..22cb309 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/acpi/acpi-lid.txt
@@ -59,28 +59,20 @@ button driver uses the following 3 modes in order not to trigger issues.
 If the userspace hasn't been prepared to ignore the unreliable "opened"
 events and the unreliable initial state notification, Linux users can use
 the following kernel parameters to handle the possible issues:
-A. button.lid_init_state=method:
-   When this option is specified, the ACPI button driver reports the
-   initial lid state using the returning value of the _LID control method
-   and whether the "opened"/"closed" events are paired fully relies on the
-   firmware implementation.
-   This option can be used to fix some platforms where the returning value
-   of the _LID control method is reliable but the initial lid state
-   notification is missing.
-   This option is the default behavior during the period the userspace
-   isn't ready to handle the buggy AML tables.
-B. button.lid_init_state=open:
+A. button.lid_init_state=open:
    When this option is specified, the ACPI button driver always reports the
    initial lid state as "opened" and whether the "opened"/"closed" events
    are paired fully relies on the firmware implementation.
    This may fix some platforms where the returning value of the _LID
    control method is not reliable and the initial lid state notification is
    missing.
+   This option is the default behavior during the period the userspace
+   isn't ready to handle the buggy AML tables.
 
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
-C. button.lid_init_state=ignore:
+B. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
    ensure that the reliable "closed" notifications can always be delievered
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 6d5a8c1..668137e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -57,7 +57,6 @@
 
 #define ACPI_BUTTON_LID_INIT_IGNORE	0x00
 #define ACPI_BUTTON_LID_INIT_OPEN	0x01
-#define ACPI_BUTTON_LID_INIT_METHOD	0x02
 
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");
@@ -377,9 +376,6 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
 	case ACPI_BUTTON_LID_INIT_OPEN:
 		(void)acpi_lid_notify_state(device, 1);
 		break;
-	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
-		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
 		break;
@@ -563,9 +559,6 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
 	if (!strncmp(val, "open", sizeof("open") - 1)) {
 		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
 		pr_info("Notify initial lid state as open\n");
-	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
-		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
-		pr_info("Notify initial lid state with _LID return value\n");
 	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
 		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
 		pr_info("Do not notify initial lid state\n");
@@ -579,8 +572,6 @@ static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
 		return sprintf(buffer, "open");
-	case ACPI_BUTTON_LID_INIT_METHOD:
-		return sprintf(buffer, "method");
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 		return sprintf(buffer, "ignore");
 	default:
-- 
2.7.4

