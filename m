From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: sysdev suspend/resume order?
Date: Fri, 13 Aug 2004 13:13:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408131313.03561.stefandoesinger@gmx.at>
References: <B44D37711ED29844BEA67908EAF36F038F7E8A@pdsmsx401.ccr.corp.intel.com>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/IKHB5E2En3gVVl"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F038F7E8A-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_/IKHB5E2En3gVVl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
> My sound card dies after S3 sometimes. Basically, if it dies depends on
> the order of sysdev's resume. If IRQ router resume before PIC (I use a
> tricky method to change order. It's changing the initcall level of the
> sysfs initialization for the device), the sound card die. Otherwise, it
> works. Is it possible that we add some levels for sysdev? I'd like some
> sysdevs resume before other sysdevs. Does this make sense?
Does the attached patch help? I have a similar problem, and calling 
acpi_leave_sleep_state and acpi_disable_wakeup_device before resuming the 
devices solves my problems

Cheers,
Stefan

--Boundary-00=_/IKHB5E2En3gVVl
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
 

--Boundary-00=_/IKHB5E2En3gVVl--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
