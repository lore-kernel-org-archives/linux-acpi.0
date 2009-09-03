From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: introduce kernel parameter
	acpi_sleep=s3_sci_enable
Date: Thu, 03 Sep 2009 14:28:23 +0800
Message-ID: <1251959303.3483.296.camel@rzhang-dt>
References: <1251702975.3483.140.camel@rzhang-dt>
	 <200908311501.00842.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11630 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbZICGam (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Sep 2009 02:30:42 -0400
In-Reply-To: <200908311501.00842.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2009-08-31 at 21:01 +0800, Rafael J. Wysocki wrote:
> On Monday 31 August 2009, Zhang Rui wrote:
> > 
> > Introduce kernel parameter acpi_sleep=s3_sci_enable
> 
> I'm not against that, but I'd rather call the option s3_set_sci_en.
> 
okay, patch refreshed.

> > some laptop requires SCI_EN being set directly on resume,
> > or else they hung somewhere in the resume code path.
> > 
> > We already have a blacklist for these lattops but we still need
> > this option, especially when debugging some suspend/resume problems.
> 
> Do we know of any that are not blacklisted?
> 
sorry, I mean we have a whitelist.

refreshed patch attached belowed.


Introduce kernel parameter acpi_sleep=s3_sci_enable

some laptop requires SCI_EN being set directly on resume,
or else they hung somewhere in the resume code path.

We already have a blacklist for these lattops but we still need
this option, especially when debugging some suspend/resume problems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/kernel-parameters.txt |    3 ++-
 arch/x86/kernel/acpi/sleep.c        |    4 ++++
 drivers/acpi/sleep.c                |    6 ++++++
 include/linux/acpi.h                |    3 +++
 4 files changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -182,6 +182,12 @@ static void acpi_pm_end(void)
  */
 static bool set_sci_en_on_resume;
 
+void __init acpi_set_sci_en_on_resume(void)
+{
+	set_sci_en_on_resume = true;
+	return 0;
+}
+
 extern void do_suspend_lowlevel(void);
 
 static u32 acpi_suspend_states[] = {
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -162,6 +162,10 @@ static int __init acpi_sleep_setup(char 
 #endif
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+#ifdef CONFIG_SUSPEND
+		if (strncmp(str, "s3_set_sci_en", 13) == 0)
+			acpi_set_sci_en_on_resume();
+#endif /* CONFIG_SUSPEND */
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -251,6 +251,9 @@ int acpi_check_mem_region(resource_size_
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
 void __init acpi_s4_no_nvs(void);
+#ifdef CONFIG_SUSPEND
+void __init acpi_set_sci_en_on_resume(void);
+#endif /* CONFIG_SUSPEND*/
 #endif /* CONFIG_PM_SLEEP */
 
 #define OSC_QUERY_TYPE			0
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -240,7 +240,7 @@ and is between 256 and 4096 characters. 
 
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
-				  old_ordering, s4_nonvs }
+				  old_ordering, s4_nonvs, s3_set_sci_en }
 			See Documentation/power/video.txt for information on
 			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
@@ -253,6 +253,7 @@ and is between 256 and 4096 characters. 
 			of _PTS is used by default).
 			s4_nonvs prevents the kernel from saving/restoring the
 			ACPI NVS memory during hibernation.
+			s3_set_sci_en sets SCI_EN directly on resume.
 
 	acpi_use_timer_override [HW,ACPI]
 			Use timer override. For some broken Nvidia NF5 boards


