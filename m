From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI thermal: _TMP and _CRT/_HOT/_PSV/_ACx dependency fix
Date: Tue, 27 Nov 2012 10:01:30 +0800
Message-ID: <1353981690.2157.5.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3498 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932366Ab2K0CBe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2012 21:01:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Matthew Garrett (mjg@redhat.com)" <mjg@redhat.com>, katabami@lavabit.com, "Zhang, Rui" <rui.zhang@intel.com>

>From 391908867c2a500a9068aa9f2a8e74663fff75ac Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 23 Nov 2012 09:25:10 +0800
Subject: [PATCH] ACPI thermal: _TMP and _CRT/_HOT/_PSV/_ACx dependency fix

On some platforms, _TMP and _CRT/_HOT/_PSV/_ACx have dependency.
And there is no way for OS to detect this dependency.

commit 9bcb8118965ab4631a65ee0726e6518f75cda6c5 shows us a problem
that _TMP must be evaluate after _CRT/_HOT/_PSV/_ACx, or esle
firmware will shutdown the system.

But the machins in https://bugzilla.kernel.org/show_bug.cgi?id=43284
shows us that _PSV would return valid value only if _TMP has been
evaluated once.

With this patch, all of the control methods will be evaluated once,
in the order of  _CRT/_HOT/_PSV/_CRT, _TMP, before they are actually used.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: katabami <katabami@lavabit.com>
---
 drivers/acpi/thermal.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 804204d..1cb08db 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -984,6 +984,35 @@ static void acpi_thermal_notify(struct acpi_device *device, u32 event)
 	}
 }
 
+/* On some platforms, the AML code has dependency about
+ * the evaluating order of _TMP and _CRT/_HOT/_PSV/_ACx.
+ * 1. On HP Pavilion G4-1016tx, _TMP must be invoked after
+ *    /_CRT/_HOT/_PSV/_ACx, or else system will be power off.
+ * 2. On HP Compaq 6715b/6715s, the return value of _PSV is 0
+ *    if _TMP has never been evaluated.
+ *
+ * As this dependency is totally transparent to OS, evaluate
+ * all of them once, in the order of _CRT/_HOT/_PSV/_ACx,
+ * _TMP, before they are actually used.
+ */
+static void acpi_thermal_aml_dependency_fix(struct acpi_thermal *tz)
+{
+	unsigned long long value;
+	acpi_status status = AE_OK;
+	int i;
+
+	acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &value);
+	acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &value);
+	acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &value);
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && status != AE_NOT_FOUND; i++ ) {
+		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
+
+		status = acpi_evaluate_integer(tz->device->handle,
+						name, NULL, &value);
+	}
+	acpi_evaluate_integer(tz->device->handle, "_TMP", NULL, &value);
+}
+
 static int acpi_thermal_get_info(struct acpi_thermal *tz)
 {
 	int result = 0;
@@ -992,6 +1021,8 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	if (!tz)
 		return -EINVAL;
 
+	acpi_thermal_aml_dependency_fix(tz);
+
 	/* Get trip points [_CRT, _PSV, etc.] (required) */
 	result = acpi_thermal_get_trip_points(tz);
 	if (result)
-- 
1.7.9.5



