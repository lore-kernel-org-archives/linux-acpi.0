From: akpm@osdl.org
Subject: [patch 8/8] acpi-cpufreq: remove dead code
Date: Fri, 20 Oct 2006 14:30:30 -0700
Message-ID: <200610202130.k9KLUUfN003257@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:33920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992725AbWJTVbb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 17:31:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, lenb@kernel.org

From: Andrew Morton <akpm@osdl.org>

arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c:396: warning: 'sw_any_bug_dmi_table' defined but not used

Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~acpi-cpufreq-remove-dead-code arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~acpi-cpufreq-remove-dead-code
+++ a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -402,6 +402,7 @@ static int sw_any_bug_found(struct dmi_s
 	return 0;
 }
 
+#ifdef CONFIG_SMP
 static struct dmi_system_id sw_any_bug_dmi_table[] = {
 	{
 		.callback = sw_any_bug_found,
@@ -414,6 +415,7 @@ static struct dmi_system_id sw_any_bug_d
 	},
 	{ }
 };
+#endif
 
 static int
 acpi_cpufreq_cpu_init (
_
