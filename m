From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH resend 2] x86, olpc-xo15-sci: Enable lid close wakeup control through sysfs
Date: Tue, 29 Nov 2011 22:24:47 +0000 (GMT)
Message-ID: <20111129222447.E56959D401E__29112.4403280721$1322605521$gmane$org@zog.reactivated.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, x86@kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
Cc: dilinger@queued.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Like most systems, OLPC's ACPI LID switch wakes up the system when the
lid is opened, but not when it is closed.

Under OLPC's opportunistic suspend model, the lid may be closed while
the system was oportunistically suspended with the screen running.
In this event, we want to wake up to turn the screen off.

Enable control of normal ACPI wakeups through lid close events through
a new sysfs attribute "lid_wake_on_closed". When set, and when
LID wakeups are enabled through ACPI, the system will wake up on both
open and close lid events.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c |   55 ++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

Resending after 6 weeks with no feedback.

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 2b235b7..649230c 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -24,6 +24,50 @@
 #define XO15_SCI_DEVICE_NAME		"OLPC XO-1.5 SCI"
 
 static unsigned long xo15_sci_gpe;
+static bool lid_wake_on_close;
+
+static int set_lid_wake_behavior(bool wake_on_close)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = wake_on_close;
+	status = acpi_evaluate_object(NULL, "\\_SB.PCI0.LID.LIDW", &arg_list,
+				      NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_warning(PFX "failed to set lid behaviour\n");
+		return 1;
+	}
+
+	lid_wake_on_close = wake_on_close;
+	return 0;
+}
+
+static ssize_t lid_wake_on_close_show(struct kobject *s,
+				      struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", lid_wake_on_close);
+}
+
+static ssize_t lid_wake_on_close_store(struct kobject *s,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t n)
+{
+	unsigned int val;
+	if (!sscanf(buf, "%u", &val) == 1)
+		return -EINVAL;
+
+	set_lid_wake_behavior(!!val);
+	return n;
+}
+
+static struct kobj_attribute lid_wake_on_close_attr =
+	__ATTR(lid_wake_on_close, 0644,
+	       lid_wake_on_close_show, lid_wake_on_close_store);
 
 static void battery_status_changed(void)
 {
@@ -91,6 +135,7 @@ static int xo15_sci_add(struct acpi_device *device)
 {
 	unsigned long long tmp;
 	acpi_status status;
+	int r;
 
 	if (!device)
 		return -EINVAL;
@@ -112,6 +157,10 @@ static int xo15_sci_add(struct acpi_device *device)
 
 	dev_info(&device->dev, "Initialized, GPE = 0x%lx\n", xo15_sci_gpe);
 
+	r = sysfs_create_file(&device->dev.kobj, &lid_wake_on_close_attr.attr);
+	if (r)
+		goto err_sysfs;
+
 	/* Flush queue, and enable all SCI events */
 	process_sci_queue();
 	olpc_ec_mask_write(EC_SCI_SRC_ALL);
@@ -123,6 +172,11 @@ static int xo15_sci_add(struct acpi_device *device)
 		device_init_wakeup(&device->dev, true);
 
 	return 0;
+
+err_sysfs:
+	acpi_remove_gpe_handler(NULL, xo15_sci_gpe, xo15_sci_gpe_handler);
+	cancel_work_sync(&sci_work);
+	return r;
 }
 
 static int xo15_sci_remove(struct acpi_device *device, int type)
@@ -130,6 +184,7 @@ static int xo15_sci_remove(struct acpi_device *device, int type)
 	acpi_disable_gpe(NULL, xo15_sci_gpe);
 	acpi_remove_gpe_handler(NULL, xo15_sci_gpe, xo15_sci_gpe_handler);
 	cancel_work_sync(&sci_work);
+	sysfs_remove_file(&device->dev.kobj, &lid_wake_on_close_attr.attr);
 	return 0;
 }
 
-- 
1.7.7.3
