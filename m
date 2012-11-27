From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI thermal: _TMP and _CRT/_HOT/_PSV/_ACx dependency fix
Date: Tue, 27 Nov 2012 20:55:22 +0100
Message-ID: <13424597.Clh1ApcFoE@vostro.rjw.lan>
References: <1353981690.2157.5.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34535 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755503Ab2K0Tuj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2012 14:50:39 -0500
In-Reply-To: <1353981690.2157.5.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, "Matthew Garrett (mjg@redhat.com)" <mjg@redhat.com>, katabami@lavabit.com

On Tuesday, November 27, 2012 10:01:30 AM Zhang Rui wrote:
> From 391908867c2a500a9068aa9f2a8e74663fff75ac Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Fri, 23 Nov 2012 09:25:10 +0800
> Subject: [PATCH] ACPI thermal: _TMP and _CRT/_HOT/_PSV/_ACx dependency fix
> 
> On some platforms, _TMP and _CRT/_HOT/_PSV/_ACx have dependency.
> And there is no way for OS to detect this dependency.
> 
> commit 9bcb8118965ab4631a65ee0726e6518f75cda6c5 shows us a problem
> that _TMP must be evaluate after _CRT/_HOT/_PSV/_ACx, or esle
> firmware will shutdown the system.
> 
> But the machins in https://bugzilla.kernel.org/show_bug.cgi?id=43284
> shows us that _PSV would return valid value only if _TMP has been
> evaluated once.
> 
> With this patch, all of the control methods will be evaluated once,
> in the order of  _CRT/_HOT/_PSV/_CRT, _TMP, before they are actually used.

I'm going to apply it, but with a few cleanups.  The result is appended, please
double check if it is still correct.

Thanks,
Rafael

---
From: Zhang Rui <rui.zhang@intel.com>
Subject: ACPI / thermal: _TMP and _CRT/_HOT/_PSV/_ACx dependency fix

On some platforms, _TMP and _CRT/_HOT/_PSV/_ACx have dependency.
And there is no way for OS to detect this dependency.

commit 9bcb8118965ab4631a65ee0726e6518f75cda6c5 shows us a problem
that _TMP must be evaluate after _CRT/_HOT/_PSV/_ACx, or else
firmware will shutdown the system.

But the machine in https://bugzilla.kernel.org/show_bug.cgi?id=43284
shows us that _PSV would return valid value only if _TMP has been
evaluated once.

With this patch, all of the control methods will be evaluated once,
in the _CRT/_HOT/_PSV/_CRT/_TMP order, before they are actually used.

[rjw: Added a local variable for the handle and modified the loop
 slightly.]
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: katabami <katabami@lavabit.com>
---
drivers/acpi/thermal.c |   31 +++++++++++++++++++++++++++++++
 drivers/acpi/thermal.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Index: linux/drivers/acpi/thermal.c
===================================================================
--- linux.orig/drivers/acpi/thermal.c
+++ linux/drivers/acpi/thermal.c
@@ -984,6 +984,38 @@ static void acpi_thermal_notify(struct a
 	}
 }
 
+/*
+ * On some platforms, the AML code has dependency about
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
+	acpi_handle handle = tz->device->handle;
+	unsigned long long value;
+	int i;
+
+	acpi_evaluate_integer(handle, "_CRT", NULL, &value);
+	acpi_evaluate_integer(handle, "_HOT", NULL, &value);
+	acpi_evaluate_integer(handle, "_PSV", NULL, &value);
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
+		acpi_status status;
+
+		status = acpi_evaluate_integer(handle, name, NULL, &value);
+		if (status == AE_NOT_FOUND)
+			break;
+	}
+	acpi_evaluate_integer(handle, "_TMP", NULL, &value);
+}
+
 static int acpi_thermal_get_info(struct acpi_thermal *tz)
 {
 	int result = 0;
@@ -992,6 +1024,8 @@ static int acpi_thermal_get_info(struct
 	if (!tz)
 		return -EINVAL;
 
+	acpi_thermal_aml_dependency_fix(tz);
+
 	/* Get trip points [_CRT, _PSV, etc.] (required) */
 	result = acpi_thermal_get_trip_points(tz);
 	if (result)


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
