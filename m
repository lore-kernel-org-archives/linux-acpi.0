From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Samsung P35 and S3 suspend
Date: Wed, 22 Dec 2004 16:35:58 +0100
Message-ID: <41C9945E.9080101@gmx.net>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>	<41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03>	<41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net>	<41C1CFA2.20304@gmx.net> <41C8D689.3020502@gmx.net> <m2zn067edh.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050807010104020706000509"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2zn067edh.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050807010104020706000509
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Johan Vromans schrieb:
> Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org> writes:
> 
> 
>>- pci-resume-2.6.10.patch and resume-finish-split-2.6.10.patch
>>  are applied
> 
> 
> Excuse my ignorance, but where can I get these patches?

>From my local harddisk ;-)
Actually, you only need resume-finish-split-2.6.10.patch, the other
patch did not have any effect in my testing. Patch attached.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------050807010104020706000509
Content-Type: text/plain;
 name="resume-finish-split-2.6.10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resume-finish-split-2.6.10.patch"

--- linux-2.6.8-rc2/include/linux/pm.h	2004-08-04 20:36:48.044455680 +0200
+++ include/linux/pm.h	2004-08-04 19:50:07.000000000 +0200
@@ -208,6 +208,7 @@
 	suspend_disk_method_t pm_disk_mode;
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
+	int (*leave)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 };
 
--- linux-2.6.8-rc2/kernel/power/main.c	2004-08-04 20:36:17.755060368 +0200
+++ kernel/power/main.c	2004-08-04 19:52:26.000000000 +0200
@@ -104,6 +104,8 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux-2.6.8-rc2/drivers/acpi/sleep/main.c	2004-08-04 20:29:23.863981376 +0200
+++ drivers/acpi/sleep/main.c	2004-08-04 20:33:41.348837728 +0200
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
 

--------------050807010104020706000509--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
