From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Good news: video can be revived after S3 on Samsung P30 (Radeon 9200)
Date: Fri, 26 Nov 2004 12:11:19 +0100
Message-ID: <200411261211.20116.stefandoesinger@gmx.at>
References: <1101458866.15323.4.camel@mhcln03>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X9wpBBt9NBBzWOV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101458866.15323.4.camel@mhcln03>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_X9wpBBt9NBBzWOV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Interesting thing!
> - XFree86 4.3+  (didn't test Xorg, but may work)
> - dummydriver [1]
Can you try the attached kernel patch instead of my dummydriver? It fixes a 
problem with my soundcard which I originally worked around with dummydriver.

Stefan

--Boundary-00=_X9wpBBt9NBBzWOV
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
 

--Boundary-00=_X9wpBBt9NBBzWOV--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
