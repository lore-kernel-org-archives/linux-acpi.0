From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: PATCH: Call acpi_leave_sleep_state before resuming devices
Date: Tue, 25 Jan 2005 20:36:30 +0100
Message-ID: <200501252036.32045.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A/p9BLd8g4D8ukn"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_A/p9BLd8g4D8ukn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,
The attached patch introduces 2 new suspend/resume functions, pm_ops->setup=
=20
and pm_ops->leave. These are used to correct the order of suspending/resumi=
ng=20
devices and calling acpi functions.=20

Some notebooks, like my Acer Travelmate 800 and the Samsung P3 notebook hav=
e=20
big resume problems which are solved by calling acpi_leave_sleep_state befo=
re=20
resuming the devices. I fix this by introducing a new function,=20
acpi_pm_leave, which is called before devices are resumed which calls=20
acpi_leave_sleep_state and disables the wakeup devices(yes, this was the=20
resume-finish-split patch). Shaohua also sugested that _PTS should be calle=
d=20
after suspending devices, so I created acpi_pm_setup and moved the content =
of=20
acpi_pm_prepare there.

There are now 5 suspend/resume functions:

prepare: It's called before devices are suspended
setup: Called after device suspend but before finally going to sleep
enter: Last suspend function
leave: Called before devices are beeing resumed
finish: Last function, called after device resume

Acked-by: Pavel Machek

Signed-off-by: Stefan D=F6singer


Stefan

--Boundary-00=_A/p9BLd8g4D8ukn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="suspend.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="suspend.diff"

--- linux-2.6.9/include/linux/pm.h	2005-01-20 14:04:54.248337144 +0100
+++ include/linux/pm.h	2005-01-20 14:03:12.000000000 +0100
@@ -206,9 +206,11 @@
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
-	int (*prepare)(suspend_state_t state);
-	int (*enter)(suspend_state_t state);
-	int (*finish)(suspend_state_t state);
+	int (*prepare)(suspend_state_t state);		/*Called before suspending devices*/
+	int (*setup)(suspend_state_t state);		/*Called after device suspend*/
+	int (*enter)(suspend_state_t state);		/*To Finally enter the sleep state*/
+	int (*leave)(suspend_state_t state);		/*Before device wakeup*/
+	int (*finish)(suspend_state_t state);		/*After device wakeup*/
 };
 
 extern void pm_set_ops(struct pm_ops *);
--- linux-2.6.9/kernel/power/main.c	2005-01-20 14:04:54.463304464 +0100
+++ kernel/power/main.c	2005-01-20 14:10:36.499307088 +0100
@@ -67,6 +67,12 @@
 
 	if ((error = device_suspend(state)))
 		goto Finish;
+
+	if (pm_ops->setup) {
+		if ((error = pm_ops->setup(state)))
+			goto Finish;
+	}
+
 	return 0;
  Finish:
 	if (pm_ops->finish)
@@ -104,6 +110,8 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux-2.6.9/drivers/acpi/sleep/main.c	2005-01-20 14:04:47.382380928 +0100
+++ drivers/acpi/sleep/main.c	2005-01-20 14:12:29.234168784 +0100
@@ -36,7 +36,7 @@
 static int init_8259A_after_S1;
 
 /**
- *	acpi_pm_prepare - Do preliminary suspend work.
+ *	acpi_pm_setup - Do preliminary suspend work.
  *	@pm_state:		suspend state we're entering.
  *
  *	Make sure we support the state. If we do, and we need it, set the
@@ -44,7 +44,7 @@
  *	wakeup code to the waking vector. 
  */
 
-static int acpi_pm_prepare(suspend_state_t pm_state)
+static int acpi_pm_setup(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
@@ -130,7 +130,23 @@
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
+/**
+ *	acpi_pm_leave - Make system ready to resume devices.
+ *	@pm_state:		State we're coming out of.
+ *
+ *	This is called after we wake back up and before device
+ *	resume methods are called.
+ */
 
+static int acpi_pm_leave(suspend_state_t pm_state)
+{
+	u32 acpi_state = acpi_suspend_states[pm_state];
+
+	acpi_leave_sleep_state(acpi_state);
+	acpi_disable_wakeup_device(acpi_state);
+
+	return 0;
+}
 /**
  *	acpi_pm_finish - Finish up suspend sequence.
  *	@pm_state:		State we're coming out of.
@@ -143,9 +159,6 @@
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
-	acpi_leave_sleep_state(acpi_state);
-	acpi_disable_wakeup_device(acpi_state);
-
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
@@ -171,8 +184,10 @@
 }
 
 static struct pm_ops acpi_pm_ops = {
-	.prepare	= acpi_pm_prepare,
+	.prepare	= NULL,
+	.setup		= acpi_pm_setup,
 	.enter		= acpi_pm_enter,
+	.leave		= acpi_pm_leave,
 	.finish		= acpi_pm_finish,
 };
 

--Boundary-00=_A/p9BLd8g4D8ukn--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
