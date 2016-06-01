From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 3/3] ACPI / button: Add quirks for initial lid state notification
Date: Wed,  1 Jun 2016 18:10:48 +0800
Message-ID: <284674cb8228f4f2b40f940a3c4a666f367d7b6a.1464775699.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Bastien Nocera:" <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Linux userspace (systemd-logind) keeps on rechecking lid state when the
lid state is closed. If it failed to update the lid state to open after
boot/resume, the system suspending right after the boot/resume could be
resulted.
Graphics drivers also uses the lid notifications to implment
MODESET_ON_LID_OPEN option.

Before the situation is improved from the userspace and from the graphics
driver, users can simply configure ACPI button driver to send initial
"open" lid state using button.lid_init_state=open to avoid such kind of
issues. And our ultimate target should be making
button.lid_init_state=ignore the default behavior. This patch implements
the 2 options and keep the old behavior (button.lid_init_state=method).

Link 1: https://lkml.org/2016/3/7/460
Link 2: https://github.com/systemd/systemd/issues/2087
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/acpi/button.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 6e291c1..148f4e5 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -53,6 +53,10 @@
 #define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
 #define ACPI_BUTTON_TYPE_LID		0x05
 
+#define ACPI_BUTTON_LID_INIT_IGNORE	0x00
+#define ACPI_BUTTON_LID_INIT_OPEN	0x01
+#define ACPI_BUTTON_LID_INIT_METHOD	0x02
+
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");
 
@@ -105,6 +109,7 @@ struct acpi_button {
 
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
+static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
@@ -285,6 +290,21 @@ static int acpi_lid_update_state(struct acpi_device *device)
 	return acpi_lid_notify_state(device, state);
 }
 
+static void acpi_lid_initialize_state(struct acpi_device *device)
+{
+	switch (lid_init_state) {
+	case ACPI_BUTTON_LID_INIT_OPEN:
+		(void)acpi_lid_notify_state(device, 1);
+		break;
+	case ACPI_BUTTON_LID_INIT_METHOD:
+		(void)acpi_lid_update_state(device);
+		break;
+	case ACPI_BUTTON_LID_INIT_IGNORE:
+	default:
+		break;
+	}
+}
+
 static void acpi_button_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_button *button = acpi_driver_data(device);
@@ -341,6 +361,8 @@ static int acpi_button_resume(struct device *dev)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	button->suspended = false;
+	if (button->type == ACPI_BUTTON_TYPE_LID)
+		acpi_lid_initialize_state(device);
 	return 0;
 }
 #endif
@@ -421,6 +443,7 @@ static int acpi_button_add(struct acpi_device *device)
 	if (error)
 		goto err_remove_fs;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
+		acpi_lid_initialize_state(device);
 		/*
 		 * This assumes there's only one lid device, or if there are
 		 * more we only care about the last one...
@@ -450,4 +473,42 @@ static int acpi_button_remove(struct acpi_device *device)
 	return 0;
 }
 
+static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
+{
+	int result = 0;
+
+	if (!strncmp(val, "open", sizeof("open") - 1)) {
+		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
+		pr_info("Notify initial lid state as open\n");
+	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
+		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+		pr_info("Notify initial lid state with _LID return value\n");
+	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
+		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
+		pr_info("Do not notify initial lid state\n");
+	} else
+		result = -EINVAL;
+	return result;
+}
+
+static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
+{
+	switch (lid_init_state) {
+	case ACPI_BUTTON_LID_INIT_OPEN:
+		return sprintf(buffer, "open");
+	case ACPI_BUTTON_LID_INIT_METHOD:
+		return sprintf(buffer, "method");
+	case ACPI_BUTTON_LID_INIT_IGNORE:
+		return sprintf(buffer, "ignore");
+	default:
+		return sprintf(buffer, "invalid");
+	}
+	return 0;
+}
+
+module_param_call(lid_init_state,
+		  param_set_lid_init_state, param_get_lid_init_state,
+		  NULL, 0644);
+MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
+
 module_acpi_driver(acpi_button_driver);
-- 
1.7.10
