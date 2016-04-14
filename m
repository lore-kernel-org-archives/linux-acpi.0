From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 05/16] x86, ACPI: move ACPI_FADT_NO_CMOS_RTC check to ACPI boot code
Date: Wed, 13 Apr 2016 17:17:47 -0700
Message-ID: <1460593067-495-1-git-send-email-mcgrof@kernel.org>
References: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38352 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcDNAR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 20:17:58 -0400
In-Reply-To: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, jgross@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, mbizon@freebox.fr, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

This moves the ACPI specific check into the ACPI boot code,
it also takes advantage of the x86_platform.legacy.rtc which
is checked for already on the RTC initialization code. This
lets us remove the nasty #ifdefery and consolidate the checks
to use only one toggle to disable the RTC init code.

The works as RTC is initialized by device_initcall(add_rtc_cmos),
this will run late in boot on start_kernel() during rest_init(),
acpi_parse_fadt() gets called earlier during setup_arch().

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/kernel/acpi/boot.c | 4 ++++
 arch/x86/kernel/rtc.c       | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8c2f1ef6ca23..8c9c2bdba092 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -913,6 +913,10 @@ late_initcall(hpet_insert_resource);
 
 static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
+	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_CMOS_RTC) {
+		pr_debug("ACPI: not registering RTC platform device\n");
+		x86_platform.legacy.rtc = 0;
+	}
 
 #ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 62c48da3889d..ff4f4180fefd 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -189,14 +189,6 @@ static __init int add_rtc_cmos(void)
 	if (of_have_populated_dt())
 		return 0;
 
-#ifdef CONFIG_ACPI
-	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_CMOS_RTC) {
-		/* This warning can likely go away again in a year or two. */
-		pr_info("ACPI: not registering RTC platform device\n");
-		return -ENODEV;
-	}
-#endif
-
 	if (!x86_platform.legacy.rtc)
 		return -ENODEV;
 
-- 
2.7.2

