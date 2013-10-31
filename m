From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/15] ACPICA: Cleanup asmlinkage for ACPICA APIs.
Date: Thu, 31 Oct 2013 09:31:18 +0800
Message-ID: <2e4e092289faff69952c85cdf5f650f1d12fa07e.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:24423 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab3JaBcH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:32:07 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

In order to ensure an asmlinkage function is called by assembly code rather
than calling an ACPICA API that is likely be converted to a stub function
when ACPI_REDUCED_HARDWARE is enabled, this patch cleans up asmlinkage
invocations by introducing an asmlinkage wrapper.

As arch/x86/kernel/acpi/wakeup_xx.S is only compiled when CONFIG_ACPI=y and
there is no users for ACPI_HARDWARE_REDUCED, currently this is in fact not
an issue but a cleanup commit to reduce source code differences between
Linux and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/x86/kernel/acpi/sleep.c     |   10 ++++++++++
 arch/x86/kernel/acpi/sleep.h     |    2 ++
 arch/x86/kernel/acpi/wakeup_32.S |    2 +-
 arch/x86/kernel/acpi/wakeup_64.S |    2 +-
 drivers/acpi/acpica/hwxfsleep.c  |    4 ++--
 include/acpi/acpixf.h            |    4 ++--
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 3312010..f5b142e 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -26,6 +26,16 @@ static char temp_stack[4096];
 #endif
 
 /**
+ * x86_acpi_enter_sleep_state - enter sleep state
+ *
+ * Wrapper of acpi_enter_sleep_state() to be called by assmebly.
+ */
+acpi_status asmlinkage x86_acpi_enter_sleep_state(u8 state)
+{
+	return acpi_enter_sleep_state(state);
+}
+
+/**
  * x86_acpi_suspend_lowlevel - save kernel state
  *
  * Create an identity mapped page table and copy the wakeup routine to
diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
index c9c2c98..65c7b60 100644
--- a/arch/x86/kernel/acpi/sleep.h
+++ b/arch/x86/kernel/acpi/sleep.h
@@ -17,3 +17,5 @@ extern void wakeup_long64(void);
 extern void do_suspend_lowlevel(void);
 
 extern int x86_acpi_suspend_lowlevel(void);
+
+acpi_status asmlinkage x86_acpi_enter_sleep_state(u8 state);
diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index d1daa66..665c6b7 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -73,7 +73,7 @@ ENTRY(do_suspend_lowlevel)
 	call	save_processor_state
 	call	save_registers
 	pushl	$3
-	call	acpi_enter_sleep_state
+	call	x86_acpi_enter_sleep_state
 	addl	$4, %esp
 
 #	In case of S3 failure, we'll emerge here.  Jump
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 8ea5164..ae693b5 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -73,7 +73,7 @@ ENTRY(do_suspend_lowlevel)
 	addq	$8, %rsp
 	movl	$3, %edi
 	xorl	%eax, %eax
-	call	acpi_enter_sleep_state
+	call	x86_acpi_enter_sleep_state
 	/* in case something went wrong, restore the machine status and go on */
 	jmp	resume_point
 
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 4895fca..15dddc1 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -167,7 +167,7 @@ ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
+acpi_status acpi_enter_sleep_state_s4bios(void)
 {
 	u32 in_value;
 	acpi_status status;
@@ -361,7 +361,7 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
+acpi_status acpi_enter_sleep_state(u8 sleep_state)
 {
 	acpi_status status;
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 7def8ca..00725f4 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -510,9 +510,9 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *slp_typ_a, u8 *slp_typ_b);
 
 acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
-acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
+acpi_status acpi_enter_sleep_state(u8 sleep_state);
 
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enter_sleep_state_s4bios(void))
 
 acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
 
-- 
1.7.10

