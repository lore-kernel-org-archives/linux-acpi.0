Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD03845C4;
	Fri,  8 May 2026 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228445; cv=none; b=dvrn+p8CUxlHWxvRPmFiaHNw3uOjjhOO1SjKHckeEvzRjvhAK0ORcAYjhCVuLabiUx7cdXjbAhCBdgH5Uc6mICVbksuDkJlJOhB42o5g0iGYB7CrwrAiLtdLpFFcWE/d+2eSXg68UCwR/rynPK2kLQVOYqn3duyBDA1HdZfA4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228445; c=relaxed/simple;
	bh=DdTUDZpQZBodq+Jsf2rbL/+2JWxAwch78X6dd8N6dhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJURNn7LUhqtonqsx44BMBqe38Jrbe0gWIXrlCczuax+Lq/xzdz7q66Jw3v/CYe0KR8VX0FvgOE/waNDnrfWFSkpV4uD8RiPmDdqCg4e4owbelxtrR4a9EO7mzPxgc/JHl/rRK2VAJGTuyN+frpJLxdMoua5w3IKF9TsIfR04k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lWUtowmF; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lWUtowmF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778228435; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hjnsD0ELdUzIO/JJbHc3X7gLpHKxXYAa5gL1Sp3NwVg=;
	b=lWUtowmFSs7r/qfg38HLWSkNKhqcuj1BSUKnVhjj849HJbpCg296iYnkYLsqPRppjhrDqhGDU1ZaVcgoqwMusOGVwUh47JPCFsRUPyNo9QtvFYM0t5SbRfgu/yXrf9ucgPvC7r5ZB7v1csR85EtJ1adGzqff9/9bshfDHorNCXU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X2Wljyz_1778228432;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X2Wljyz_1778228432 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 16:20:34 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	lenb@kernel.org,
	saket.dumbre@intel.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 3/3] riscv: collect hardware error information via APEI on HEE
Date: Fri,  8 May 2026 16:20:20 +0800
Message-ID: <20260508082020.3368109-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260508082020.3368109-1-tianruidong@linux.alibaba.com>
References: <20260508082020.3368109-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V already dispatches Hardware Error Exceptions through
do_trap_hardware_error(), but the trap handler currently has no way to
learn *what* went wrong: the user sees the offending task killed, or
the kernel panic, with no diagnostic about the underlying hardware
fault. No error record is logged, and the subsequent memory_failure()
handling has no input.

There are two principal ways to obtain that information on HEE:

  1. Have firmware parse the platform error registers and hand the
     kernel a CPER record through APEI / GHES.
  2. Have the kernel read the error registers directly.

Option (2) is not yet viable on RISC-V: the architecture does not
define a unified, mandatory layout for hardware error status
registers across implementations, so there is nothing stable for
common code to read. This patch therefore only implements option (1):
collect hardware error information on HEE through the existing APEI /
GHES path, mirroring how arm64 treats SEA.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/riscv/include/asm/acpi.h |  2 ++
 arch/riscv/kernel/acpi.c      | 54 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c     | 35 +++++++++++++++++++++--
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index aa889093f531..e4d18421063e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -87,6 +87,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
+int apei_claim_hee(struct pt_regs *regs);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -104,6 +105,7 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
 					   u32 *cbom_size, u32 *cboz_size,
 					   u32 *cbop_size) { }
 
+static inline int apei_claim_hee(struct pt_regs *regs) { return -ENOENT; }
 #endif /* CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 068e0b404b6f..77ad1e18a092 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -21,6 +21,9 @@
 #include <linux/of_fdt.h>
 #include <linux/pci.h>
 #include <linux/serial_core.h>
+#include <linux/irq_work.h>
+#include <linux/nmi.h>
+#include <acpi/ghes.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -353,3 +356,54 @@ int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
+
+/*
+ * Claim Hardware Error Exception as a firmware first notification.
+ *
+ * Used by RISC-V exception handler for hardware error processing.
+ */
+int apei_claim_hee(struct pt_regs *regs)
+{
+	int err = -ENOENT;
+	unsigned long flags;
+	bool return_to_irqs_enabled;
+	bool need_nmi_ctx = !in_nmi();
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
+		return err;
+
+	local_irq_save(flags);
+
+	/*
+	 * Determine whether the interrupted context had IRQs enabled.
+	 * This decides if we can run irq_work immediately after.
+	 */
+	return_to_irqs_enabled = false;
+	if (regs)
+		return_to_irqs_enabled = !regs_irqs_disabled(regs);
+
+	if (need_nmi_ctx)
+		nmi_enter();
+	err = ghes_notify_hee();
+	if (need_nmi_ctx)
+		nmi_exit();
+
+	/*
+	 * APEI NMI-like notifications are deferred to irq_work. Unless
+	 * we interrupted irqs-masked code, we can do that now.
+	 */
+	if (!err) {
+		if (return_to_irqs_enabled) {
+			__irq_enter();
+			irq_work_run();
+			__irq_exit();
+		} else {
+			pr_warn_ratelimited("APEI work queued but not completed");
+			err = -EINPROGRESS;
+		}
+	}
+
+	local_irq_restore(flags);
+	return err;
+}
+EXPORT_SYMBOL(apei_claim_hee);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c62c771a656..5ee0ac8b0745 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/entry-common.h>
+#include <linux/acpi.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -161,8 +162,6 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 
 DO_ERROR_INFO(do_trap_unknown,
 	SIGILL, ILL_ILLTRP, "unknown exception");
-DO_ERROR_INFO(do_trap_hardware_error,
-	SIGBUS, BUS_MCEERR_AR, "hardware error");
 DO_ERROR_INFO(do_trap_insn_misaligned,
 	SIGBUS, BUS_ADRALN, "instruction address misaligned");
 DO_ERROR_INFO(do_trap_insn_fault,
@@ -484,3 +483,35 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 		wait_for_interrupt();
 }
 #endif
+
+static int claim_hardware_error(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_ACPI_APEI_HEE))
+		return apei_claim_hee(regs);
+	return -ENOENT;
+}
+
+asmlinkage __visible __trap_section void do_trap_hardware_error(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+		local_irq_enable();
+
+		if (claim_hardware_error(regs))
+			do_trap_error(regs, SIGBUS, BUS_MCEERR_AR,
+				      regs->badaddr,
+				      "Hardware Error Exception");
+
+		local_irq_disable();
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		irqentry_state_t state = irqentry_nmi_enter(regs);
+
+		claim_hardware_error(regs);
+
+		if (!fixup_exception(regs))
+			die(regs, "Hardware Error Exception");
+
+		irqentry_nmi_exit(regs, state);
+	}
+}
-- 
2.51.2.612.gdc70283dfc

