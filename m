From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: RE: PATCH: Call acpi_leave_sleep_state before resuming devices
Date: Sat, 15 Jan 2005 10:53:22 +0100
Message-ID: <200501151053.24075.stefandoesinger@gmx.at>
References: <16A54BF5D6E14E4D916CE26C9AD30575F054DA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UgO6BrMGIT8wRIQ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575F054DA-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_UgO6BrMGIT8wRIQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

> ACPI spec also said _PTS (in 'acpi_enter_sleep_state_prep') should be
> called after all devices are suspend (ACPI sepc 3.0 P401), could you
> please also change the order of device suspend and
> 'acpi_enter_sleep_state_prep'?

Sorry for the delay, but I was quite busy this week. Here is the updated patch 
which also causes pm_ops->prepare to be called after device suspend.
Is this correct or should I create another new function? What does the spec 
say?

Stefan

--Boundary-00=_UgO6BrMGIT8wRIQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch.diff"

--- linux/drivers/acpi/sleep/main.c	2005-01-15 10:28:32.224204848 +0100
+++ drivers/acpi/sleep/main.c	2004-12-27 13:11:03.000000000 +0100
@@ -130,7 +130,22 @@
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
+	
+	return 0;
+}
 /**
  *	acpi_pm_finish - Finish up suspend sequence.
  *	@pm_state:		State we're coming out of.
@@ -142,8 +157,7 @@
 static int acpi_pm_finish(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
-
-	acpi_leave_sleep_state(acpi_state);
+	
 	acpi_disable_wakeup_device(acpi_state);
 
 	/* reset firmware waking vector */
@@ -173,6 +187,7 @@
 static struct pm_ops acpi_pm_ops = {
 	.prepare	= acpi_pm_prepare,
 	.enter		= acpi_pm_enter,
+	.leave		= acpi_pm_leave,
 	.finish		= acpi_pm_finish,
 };
 
--- linux/kernel/power/main.c	2005-01-15 10:28:40.151999640 +0100
+++ kernel/power/main.c	2005-01-15 10:25:55.118088608 +0100
@@ -60,13 +60,14 @@
 		goto Thaw;
 	}
 
+	if ((error = device_suspend(state)))
+		goto Finish;
+	
 	if (pm_ops->prepare) {
 		if ((error = pm_ops->prepare(state)))
-			goto Thaw;
+			goto Finish;
 	}
-
-	if ((error = device_suspend(state)))
-		goto Finish;
+	
 	return 0;
  Finish:
 	if (pm_ops->finish)
@@ -104,6 +105,8 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux/include/linux/pm.h	2005-01-15 10:28:39.937032320 +0100
+++ include/linux/pm.h	2004-12-26 15:27:10.000000000 +0100
@@ -208,6 +208,7 @@
 	suspend_disk_method_t pm_disk_mode;
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
+	int (*leave)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 };
 

--Boundary-00=_UgO6BrMGIT8wRIQ--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
