From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/33] ACPI throttling: Use this_cpu_has and simplify code
Date: Sun, 26 Dec 2010 17:43:53 -0500
Message-ID: <630c6a2603a844b3771f007224e22db8cc16a038.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51680 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0LZW6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:50 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:50 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Christoph Lameter <cl@linux.com>, Len Brown <len.brown@intel.com>

From: Christoph Lameter <cl@linux.com>

With the this_cpu_xx we no longer need to pass an acpi
structure to the msr management code. Simplifies code and improves
performance.

Signed-off-by: Christoph Lameter <cl@linux.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |   32 ++++++++++----------------------
 1 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index ff36327..2e773d9 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -662,20 +662,14 @@ static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 }
 
 #ifdef CONFIG_X86
-static int acpi_throttling_rdmsr(struct acpi_processor *pr,
-					u64 *value)
+static int acpi_throttling_rdmsr(u64 *value)
 {
-	struct cpuinfo_x86 *c;
 	u64 msr_high, msr_low;
-	unsigned int cpu;
 	u64 msr = 0;
 	int ret = -1;
 
-	cpu = pr->id;
-	c = &cpu_data(cpu);
-
-	if ((c->x86_vendor != X86_VENDOR_INTEL) ||
-		!cpu_has(c, X86_FEATURE_ACPI)) {
+	if ((this_cpu_read(cpu_info.x86_vendor) != X86_VENDOR_INTEL) ||
+		!this_cpu_has(X86_FEATURE_ACPI)) {
 		printk(KERN_ERR PREFIX
 			"HARDWARE addr space,NOT supported yet\n");
 	} else {
@@ -690,18 +684,13 @@ static int acpi_throttling_rdmsr(struct acpi_processor *pr,
 	return ret;
 }
 
-static int acpi_throttling_wrmsr(struct acpi_processor *pr, u64 value)
+static int acpi_throttling_wrmsr(u64 value)
 {
-	struct cpuinfo_x86 *c;
-	unsigned int cpu;
 	int ret = -1;
 	u64 msr;
 
-	cpu = pr->id;
-	c = &cpu_data(cpu);
-
-	if ((c->x86_vendor != X86_VENDOR_INTEL) ||
-		!cpu_has(c, X86_FEATURE_ACPI)) {
+	if ((this_cpu_read(cpu_info.x86_vendor) != X86_VENDOR_INTEL) ||
+		!this_cpu_has(X86_FEATURE_ACPI)) {
 		printk(KERN_ERR PREFIX
 			"HARDWARE addr space,NOT supported yet\n");
 	} else {
@@ -713,15 +702,14 @@ static int acpi_throttling_wrmsr(struct acpi_processor *pr, u64 value)
 	return ret;
 }
 #else
-static int acpi_throttling_rdmsr(struct acpi_processor *pr,
-				u64 *value)
+static int acpi_throttling_rdmsr(u64 *value)
 {
 	printk(KERN_ERR PREFIX
 		"HARDWARE addr space,NOT supported yet\n");
 	return -1;
 }
 
-static int acpi_throttling_wrmsr(struct acpi_processor *pr, u64 value)
+static int acpi_throttling_wrmsr(u64 value)
 {
 	printk(KERN_ERR PREFIX
 		"HARDWARE addr space,NOT supported yet\n");
@@ -753,7 +741,7 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		ret = acpi_throttling_rdmsr(pr, value);
+		ret = acpi_throttling_rdmsr(value);
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
@@ -786,7 +774,7 @@ static int acpi_write_throttling_state(struct acpi_processor *pr,
 		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		ret = acpi_throttling_wrmsr(pr, value);
+		ret = acpi_throttling_wrmsr(value);
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
-- 
1.7.3.3.557.gb5c17

