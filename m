From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: pci device resume too early?
Date: Wed, 4 Aug 2004 20:47:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408042047.01268.stefandoesinger@gmx.at>
References: <200407281953.39159.stefandoesinger@gmx.at> <200407282118.52624.stefandoesinger@gmx.at> <20040728210602.GA26087@dreamland.darkstar.lan>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k8SEBDjcVMARbsm"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040728210602.GA26087-sTXFmx6KbOnUXq0IF5SVAZ4oGUkBHcCu@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_k8SEBDjcVMARbsm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

> ACPI finish calls acpi_leave_sleep_state() and restore the waking
> vectore. I'm not an ACPI guru but my guess is that what you need is
> in acpi_leave_sleep_state().
>
> If that's the case we may want to split the finish callback (say
> prepare_wake and finish_wake).
I've got a small patch which introduces ->leave function which calls(if acp=
i=20
is used) acpi_leave_sleep_state and acpi_disable_wakeup_device which are=20
needed for me to make device resume work properly.

Hope it's correct and you like it,
Stefan D=F6singer

--Boundary-00=_k8SEBDjcVMARbsm
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="resume-finish-split.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="resume-finish-split.patch"

--- linux-2.6.8-rc2/include/linux/pm.h	2004-08-04 20:36:48.044455680 +0200
+++ include/linux/pm.h	2004-08-04 19:50:07.000000000 +0200
@@ -214,6 +214,7 @@
 	u32	pm_disk_mode;
 	int (*prepare)(u32 state);
 	int (*enter)(u32 state);
+	int (*leave)(u32 state);
 	int (*finish)(u32 state);
 };
 
--- linux-2.6.8-rc2/kernel/power/main.c	2004-08-04 20:36:17.755060368 +0200
+++ kernel/power/main.c	2004-08-04 19:52:26.000000000 +0200
@@ -108,6 +108,8 @@
 
 static void suspend_finish(u32 state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux-2.6.8-rc2/drivers/acpi/sleep/main.c	2004-08-04 20:29:23.863981376 +0200
+++ drivers/acpi/sleep/main.c	2004-08-04 20:33:41.348837728 +0200
@@ -127,7 +127,23 @@
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
+static int acpi_pm_leave(u32 pm_state)
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
@@ -140,9 +156,6 @@
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
-	acpi_leave_sleep_state(acpi_state);
-	acpi_disable_wakeup_device(acpi_state);
-
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
@@ -170,6 +183,7 @@
 static struct pm_ops acpi_pm_ops = {
 	.prepare	= acpi_pm_prepare,
 	.enter		= acpi_pm_enter,
+	.leave		= acpi_pm_leave,
 	.finish		= acpi_pm_finish,
 };
 

--Boundary-00=_k8SEBDjcVMARbsm--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
