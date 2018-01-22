From: James Morse <james.morse@arm.com>
Subject: [RFC 4/7] KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
Date: Mon, 22 Jan 2018 19:29:39 +0000
Message-ID: <20180122192942.30487-5-james.morse@arm.com>
References: <20180122192942.30487-1-james.morse@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34342 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbeAVTcQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 14:32:16 -0500
In-Reply-To: <20180122192942.30487-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, huangshaoyu@huawei.com, Tyler Baicar <tbaicar@codeaurora.org>, James Morse <james.morse@arm.com>

To split up APEIs in_nmi() path, we need any nmi-like callers to always
be in_nmi(). KVM shouldn't have to know about this, pull the RAS plumbing
out into a header file.

Currently guest synchronous external aborts are claimed as RAS
notifications by handle_guest_sea(), which is hidden in the arch codes
mm/fault.c. 32bit gets a dummy declaration in system_misc.h.

There is going to be more of this in the future if/when we support
the SError-based firmware-first notification mechanism and/or
kernel-first notifications for both synchronous external abort and
SError. Each of these will come with some Kconfig symbols and a
handful of header files.

Create a header file for all this.

This patch gives handle_guest_sea() a 'kvm_' prefix, and moves the
declarations to kvm_ras.h as preparation for a future patch that moves
the ACPI-specific RAS code out of mm/fault.c.

Not-signed-off: James Morse <james.morse@arm.com>
---
 arch/arm/include/asm/kvm_ras.h       | 14 ++++++++++++++
 arch/arm/include/asm/system_misc.h   |  5 -----
 arch/arm64/include/asm/kvm_ras.h     | 11 +++++++++++
 arch/arm64/include/asm/system_misc.h |  2 --
 arch/arm64/mm/fault.c                |  2 +-
 virt/kvm/arm/mmu.c                   |  4 ++--
 6 files changed, 28 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_ras.h
 create mode 100644 arch/arm64/include/asm/kvm_ras.h

diff --git a/arch/arm/include/asm/kvm_ras.h b/arch/arm/include/asm/kvm_ras.h
new file mode 100644
index 000000000000..9e6cf0aab657
--- /dev/null
+++ b/arch/arm/include/asm/kvm_ras.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2017 - Arm Ltd
+
+#ifndef __ARM_KVM_RAS_H__
+#define __ARM_KVM_RAS_H__
+
+#include <linux/types.h>
+
+static inline int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr)
+{
+	return -1;
+}
+
+#endif /* __ARM_KVM_RAS_H__ */
diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 78f6db114faf..51e5ab50b35f 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -23,11 +23,6 @@ extern void (*arm_pm_idle)(void);
 
 extern unsigned int user_debug;
 
-static inline int handle_guest_sea(phys_addr_t addr, unsigned int esr)
-{
-	return -1;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_ARM_SYSTEM_MISC_H */
diff --git a/arch/arm64/include/asm/kvm_ras.h b/arch/arm64/include/asm/kvm_ras.h
new file mode 100644
index 000000000000..9a54576b759f
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_ras.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2017 - Arm Ltd
+
+#ifndef __ARM64_KVM_RAS_H__
+#define __ARM64_KVM_RAS_H__
+
+#include <linux/types.h>
+
+int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr);
+
+#endif /* __ARM64_KVM_RAS_H__ */
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 07aa8e3c5630..d0beefeb6d25 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -56,8 +56,6 @@ extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 	__show_ratelimited;						\
 })
 
-int handle_guest_sea(phys_addr_t addr, unsigned int esr);
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_SYSTEM_MISC_H */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0e671ddf4855..39e607515e8f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -674,7 +674,7 @@ static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
-int handle_guest_sea(phys_addr_t addr, unsigned int esr)
+int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr)
 {
 	int ret = -ENOENT;
 
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 876caf531d32..6bd3b082b23a 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -27,10 +27,10 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_mmio.h>
+#include <asm/kvm_ras.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/virt.h>
-#include <asm/system_misc.h>
 
 #include "trace.h"
 
@@ -1487,7 +1487,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * For RAS the host kernel may handle this abort.
 		 * There is no need to pass the error into the guest.
 		 */
-		if (!handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
+		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
 			return 1;
 
 		if (unlikely(!is_iabt)) {
-- 
2.15.1

