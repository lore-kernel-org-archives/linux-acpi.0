From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: PATCH: Call acpi_leave_sleep_state before resuming devices
Date: Thu, 30 Dec 2004 22:39:18 +0100
Message-ID: <200412302239.20109.stefandoesinger@gmx.at>
References: <41BFC3AD.5030001@gmx.net> <200412261543.58340.stefandoesinger@gmx.at> <20041226194039.GC1739@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IWH1B5u+O7uc5PG"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041226194039.GC1739-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_IWH1B5u+O7uc5PG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Here's again the resume-finish-split patch, this time CC-ed to Len.

This patch splits up acpi_pm_leave. It introduces acpi_pm_leave which calls=
=20
acpi_leave_sleep_state and acpi_disable_wakeup_device before resuming the=20
devices. This improves S3 resume on an Acer Travelmate 800 and on the Samsu=
ng=20
P3 notebook.

Some archive references:
http://sourceforge.net/mailarchive/message.php?msg_id=3D9091506
http://sourceforge.net/mailarchive/message.php?msg_id=3D10315947

The background is that any write access to the pci config registers of some=
=20
devices(sound card, usb 2.0 controler, and modem) cause a system lockup if=
=20
they are called before acpi_leave_sleep_state and acpi_disable_wakeup_devic=
e=20
were called. This is on an Acer Travelmate 803 Notebook, and it seems to be=
=20
the same on other systems.

I sent the patch to the list, but it seems that nobody noticed it and I for=
got=20
to send it again. Here is an updated patch against 2.6.10. I can't promise=
=20
that it doesn't break other systems. Someone should make sure that=20
pm_ops->leave is set to NULL for apm. I haven't found this in the apm code=
=20
yet.

Cheers,
Stefan D=F6singer

--Boundary-00=_IWH1B5u+O7uc5PG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="resume-finish-split.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="resume-finish-split.patch"

--- linux-2.6.10/include/linux/pm.h	2004-12-26 15:25:39.639998872 +0100
+++ include/linux/pm.h	2004-12-26 15:27:10.885127504 +0100
@@ -208,6 +208,7 @@
 	suspend_disk_method_t pm_disk_mode;
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
+	int (*leave)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 };
 
--- linux-2.6.10/kernel/power/main.c	2004-12-26 15:25:54.377758392 +0100
+++ kernel/power/main.c	2004-12-26 15:26:31.472119192 +0100
@@ -104,6 +104,8 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux-2.6.10/drivers/acpi/sleep/main.c	2004-12-26 15:25:20.314936728 +0100
+++ drivers/acpi/sleep/main.c	2004-12-26 15:28:49.253173288 +0100
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
+
+static int acpi_pm_leave(suspend_state_t pm_state)
+{
+	u32 acpi_state = acpi_suspend_states[pm_state];
 
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
 
@@ -173,6 +186,7 @@
 static struct pm_ops acpi_pm_ops = {
 	.prepare	= acpi_pm_prepare,
 	.enter		= acpi_pm_enter,
+	.leave		= acpi_pm_leave,
 	.finish		= acpi_pm_finish,
 };
 

--Boundary-00=_IWH1B5u+O7uc5PG--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
