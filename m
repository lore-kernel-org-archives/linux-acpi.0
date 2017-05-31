From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v4 4/5] ACPI: button: Fix lid notification locks
Date: Wed, 31 May 2017 17:42:22 +0800
Message-ID: <50e8615b44f9868623d98b755c4c6c24c3e15f5b.1496221776.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-acpi@vger.kernel.org

In acpi_lid_notify_state(), it now contains logic to avoid frequently
replayed events which originally was ensured by using blocking notifier.
On the contrary, using blocking notifier is wrong as it could keep on
returning NOTIFY_DONE, causing events lost.

This patch thus changes lid notification to raw notifier in order not to
have events lost.

Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c | 53 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 13b75e6..a64b3f8 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -112,7 +112,7 @@ struct acpi_button {
 	bool suspended;
 };
 
-static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
+static RAW_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
 
@@ -139,11 +139,16 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 	return lid_state ? 1 : 0;
 }
 
-static int acpi_lid_notify_state(struct acpi_device *device,
+static inline void acpi_lid_notifier_call(struct acpi_device *device,
+					  int state)
+{
+	(void)raw_notifier_call_chain(&acpi_lid_notifier, state, device);
+}
+
+static void acpi_lid_notify_state(struct acpi_device *device,
 				 int state, bool is_bios_event)
 {
 	struct acpi_button *button = acpi_driver_data(device);
-	int ret;
 	ktime_t next_report;
 
 	/*
@@ -161,7 +166,7 @@ static int acpi_lid_notify_state(struct acpi_device *device,
 				ms_to_ktime(lid_report_interval));
 	if (button->last_is_bios && button->last_state == !!state &&
 	    !ktime_after(ktime_get(), next_report))
-		return 0;
+		return;
 
 	/*
 	 * Send the unreliable complement switch event:
@@ -219,18 +224,7 @@ static int acpi_lid_notify_state(struct acpi_device *device,
 	if (state)
 		pm_wakeup_hard_event(&device->dev);
 
-	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
-	if (ret == NOTIFY_DONE)
-		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
-						   device);
-	if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
-		/*
-		 * It is also regarded as success if the notifier_chain
-		 * returns NOTIFY_OK or NOTIFY_DONE.
-		 */
-		ret = 0;
-	}
-	return ret;
+	acpi_lid_notifier_call(device, state);
 }
 
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
@@ -341,13 +335,24 @@ static int acpi_button_remove_fs(struct acpi_device *device)
    -------------------------------------------------------------------------- */
 int acpi_lid_notifier_register(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&acpi_lid_notifier, nb);
+	return raw_notifier_chain_register(&acpi_lid_notifier, nb);
 }
 EXPORT_SYMBOL(acpi_lid_notifier_register);
 
+static inline int __acpi_lid_notifier_unregister(struct notifier_block *nb,
+						 bool sync)
+{
+	int ret;
+
+	ret = raw_notifier_chain_unregister(&acpi_lid_notifier, nb);
+	if (sync)
+		synchronize_rcu();
+	return ret;
+}
+
 int acpi_lid_notifier_unregister(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_unregister(&acpi_lid_notifier, nb);
+	return __acpi_lid_notifier_unregister(nb, false);
 }
 EXPORT_SYMBOL(acpi_lid_notifier_unregister);
 
@@ -360,26 +365,26 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_device *device,
-				 bool is_bios_event)
+static void acpi_lid_update_state(struct acpi_device *device,
+				  bool is_bios_event)
 {
 	int state;
 
 	state = acpi_lid_evaluate_state(device);
 	if (state < 0)
-		return state;
+		return;
 
-	return acpi_lid_notify_state(device, state, is_bios_event);
+	acpi_lid_notify_state(device, state, is_bios_event);
 }
 
 static void acpi_lid_initialize_state(struct acpi_device *device)
 {
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
-		(void)acpi_lid_notify_state(device, 1, false);
+		acpi_lid_notify_state(device, 1, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device, false);
+		acpi_lid_update_state(device, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
-- 
2.7.4
