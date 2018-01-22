From: James Morse <james.morse@arm.com>
Subject: [RFC 5/7] arm64: KVM/mm: Move SEA handling behind a single 'claim' interface.
Date: Mon, 22 Jan 2018 19:29:40 +0000
Message-ID: <20180122192942.30487-6-james.morse@arm.com>
References: <20180122192942.30487-1-james.morse@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbeAVTcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 14:32:17 -0500
In-Reply-To: <20180122192942.30487-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, huangshaoyu@huawei.com, Tyler Baicar <tbaicar@codeaurora.org>, James Morse <james.morse@arm.com>

To split up APEIs in_nmi() path, we need the nmi-like callers to always
be in_nmi(). Add a helper to do the work and claim the notification.

When KVM or the arch code takes an exception that might be a RAS
notification, it asks the APEI firmware-first code whether it wants
to claim the exception. We can then go on to see if (a future)
kernel-first mechanism wants to claim the notification, before
falling through to the existing default behaviour.

The NOTIFY_SEA code was merged before we had multiple, possibly-interacting,
NMI-like notifications and the need to consider kernel-first in the future.
Make the 'claiming' behaviour explicit, and give ourselves somewhere
to hook in kernel-first.

We're restructuring the APEI code to allow multiple NMI-like
notifications, any notification that might interrupt interrupts-masked
code must always be wrapped in nmi_enter()/nmi_exit().

We mask SError over this window to prevent an asynchronous RAS error
arriving and tripping 'nmi_enter()'s BUG_ON(in_nmi()).

Not-signed-off: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/acpi.h      |  2 ++
 arch/arm64/include/asm/daifflags.h |  1 +
 arch/arm64/include/asm/kvm_ras.h   | 14 +++++++++++++-
 arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++++++++++++++
 arch/arm64/mm/fault.c              | 30 ++++++------------------------
 5 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 32f465a80e4e..cf844b8d6ab8 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -94,6 +94,8 @@ void __init acpi_init_cpus(void);
 static inline void acpi_init_cpus(void) { }
 #endif /* CONFIG_ACPI */
 
+bool apei_claim_sea(void);
+
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 bool acpi_parking_protocol_valid(int cpu);
 void __init
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 22e4c83de5a5..cbd753855bf3 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -20,6 +20,7 @@
 
 #define DAIF_PROCCTX		0
 #define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
+#define DAIF_ERRCTX		(PSR_I_BIT | PSR_A_BIT)
 
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
diff --git a/arch/arm64/include/asm/kvm_ras.h b/arch/arm64/include/asm/kvm_ras.h
index 9a54576b759f..7fd38408a602 100644
--- a/arch/arm64/include/asm/kvm_ras.h
+++ b/arch/arm64/include/asm/kvm_ras.h
@@ -4,8 +4,20 @@
 #ifndef __ARM64_KVM_RAS_H__
 #define __ARM64_KVM_RAS_H__
 
+#include <linux/acpi.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 
-int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr);
+static inline int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr)
+{
+	int ret = -ENOENT;
+
+	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA)) {
+		if (apei_claim_sea())
+			ret = 0;
+	}
+
+	return ret;
+}
 
 #endif /* __ARM64_KVM_RAS_H__ */
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 252396a96c78..b2fc9c7a807d 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -33,6 +33,8 @@
 
 #ifdef CONFIG_ACPI_APEI
 # include <linux/efi.h>
+# include <acpi/ghes.h>
+# include <asm/daifflags.h>
 # include <asm/pgtable.h>
 #endif
 
@@ -261,4 +263,32 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
+
+
+/*
+ * Claim Synchronous External Aborts as a firmwre first notification.
+ *
+ * Used by KVM and the arch do_sea handler.
+ */
+bool apei_claim_sea(void)
+{
+	bool ret = false;
+
+	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA)) {
+		unsigned long flags = arch_local_save_flags();
+
+		/*
+		 * APEI expects an NMI-like notification to always be called
+		 * in NMI context.
+		 */
+		local_daif_restore(DAIF_ERRCTX);
+		nmi_enter();
+		if (ghes_notify_sea() == 0)
+			ret = true;
+		nmi_exit();
+		local_daif_restore(flags);
+	}
+
+	return ret;
+}
 #endif
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 39e607515e8f..360b37594649 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -18,6 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
@@ -44,8 +45,6 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
-#include <acpi/ghes.h>
-
 struct fault_info {
 	int	(*fn)(unsigned long addr, unsigned int esr,
 		      struct pt_regs *regs);
@@ -580,19 +579,12 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
 		inf->name, esr, addr);
 
-	/*
-	 * Synchronous aborts may interrupt code which had interrupts masked.
-	 * Before calling out into the wider kernel tell the interested
-	 * subsystems.
-	 */
 	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA)) {
-		if (interrupts_enabled(regs))
-			nmi_enter();
-
-		ret = ghes_notify_sea();
-
-		if (interrupts_enabled(regs))
-			nmi_exit();
+		/*
+		 * Return value ignored as we rely on signal merging.
+		 * Future patches will make this more robust.
+		 */
+	       apei_claim_sea();
 	}
 
 	info.si_signo = SIGBUS;
@@ -674,16 +666,6 @@ static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
-int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr)
-{
-	int ret = -ENOENT;
-
-	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
-		ret = ghes_notify_sea();
-
-	return ret;
-}
-
 asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 					 struct pt_regs *regs)
 {
-- 
2.15.1

