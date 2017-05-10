From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
Date: Wed, 10 May 2017 18:12:39 +0200
Message-ID: <20170510161240.13229-2-benjamin.tissoires@redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>
Cc: Jiri Eischmann <jeischma@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This reverts commit ecb10b694b72ca5ea51b3c90a71ff2a11963425a.

Even if the method can be buggy some times, it's still a need
when you boot a laptop with a lid closed and an external monitor
connected (typical situation when using a docking station)

Note: this option has been removed without being deprecated, which
is terrible in term of distribution handling. The new default "open"
is plain wrong and we don't even have the chance to keep the current
default option because it's not there anymore.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
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
2.9.3
