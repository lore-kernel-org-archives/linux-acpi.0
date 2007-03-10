From: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/20] ACPI: repair nvidia early quirk breakage on x86_64
Date: Fri,  9 Mar 2007 22:49:33 -0500
Message-ID: <11734985901640-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <1173498587849-git-send-email-len.brown@intel.com> <11734985882949-git-send-email-len.brown@intel.com> <11734985891723-git-send-email-len.brown@intel.com> <11734985892382-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965838AbXCJDtw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:52 -0500
In-Reply-To: <11734985892382-git-send-email-len.brown@intel.com>
Message-Id: <d7930085c28d295b573f6862ff863ccbb8a580ce.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

x86_64 nvidia_bugs() broke when we bailed out on not finding the HPET.
However, the quirk works by checking for not finding the HPET...

Delete the nvidia_hpet_detected flag and simply test for
not finding the HPET, which is simple to do now that
acpi_table_parse returns 1 on failure.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/earlyquirk.c |    7 +------
 arch/x86_64/kernel/early-quirks.c  |    9 +--------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/i386/kernel/acpi/earlyquirk.c b/arch/i386/kernel/acpi/earlyquirk.c
index bf86f76..a7d22d9 100644
--- a/arch/i386/kernel/acpi/earlyquirk.c
+++ b/arch/i386/kernel/acpi/earlyquirk.c
@@ -14,11 +14,8 @@
 
 #ifdef CONFIG_ACPI
 
-static int nvidia_hpet_detected __initdata;
-
 static int __init nvidia_hpet_check(struct acpi_table_header *header)
 {
-	nvidia_hpet_detected = 1;
 	return 0;
 }
 #endif
@@ -29,9 +26,7 @@ static int __init check_bridge(int vendor, int device)
 	/* According to Nvidia all timer overrides are bogus unless HPET
 	   is enabled. */
 	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
-		nvidia_hpet_detected = 0;
-		acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check);
-		if (nvidia_hpet_detected == 0) {
+		if (acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check)) {
 			acpi_skip_timer_override = 1;
 			  printk(KERN_INFO "Nvidia board "
                        "detected. Ignoring ACPI "
diff --git a/arch/x86_64/kernel/early-quirks.c b/arch/x86_64/kernel/early-quirks.c
index 8047ea8..dec587b 100644
--- a/arch/x86_64/kernel/early-quirks.c
+++ b/arch/x86_64/kernel/early-quirks.c
@@ -30,11 +30,8 @@ static void via_bugs(void)
 
 #ifdef CONFIG_ACPI
 
-static int nvidia_hpet_detected __initdata;
-
 static int __init nvidia_hpet_check(struct acpi_table_header *header)
 {
-	nvidia_hpet_detected = 1;
 	return 0;
 }
 #endif
@@ -52,11 +49,7 @@ static void nvidia_bugs(void)
 	if (acpi_use_timer_override)
 		return;
 
-	nvidia_hpet_detected = 0;
-	if (acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check))
-		return;
-
-	if (nvidia_hpet_detected == 0) {
+	if (acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check)) {
 		acpi_skip_timer_override = 1;
 		printk(KERN_INFO "Nvidia board "
 		       "detected. Ignoring ACPI "
-- 
1.5.0.3.310.g05ef5
