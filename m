From: fu.wei@linaro.org
Subject: [PATCH v3] acpi, apei, arm64: APEI initial support for aarch64.
Date: Fri,  4 Dec 2015 01:15:03 +0800
Message-ID: <1449162903-11203-1-git-send-email-fu.wei@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbbLCRP0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2015 12:15:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, jon.zhixiong.zhang@gmail.com, tomasz.nowicki@linaro.org, tn@semihalf.com, rjw@rjwysocki.net, lenb@kernel.org, jarkko.nikula@linux.intel.com
Cc: graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, jcm@redhat.com, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, msalter@redhat.com, Marc.Zyngier@arm.com, grant.likely@linaro.org, rrichter@cavium.com, lorenzo.pieralisi@arm.com, rruigrok@codeaurora.org, harba@qti.qualcomm.com, Fu Wei <fu.wei@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This commit provides APEI arch-specific bits for aarch64

The reason for wrapping "acpi_disable_cmcff" by 
"#if defined(__i386__) || defined(__x86_64__)" in hest.c is:
according to ACPI spec CMC(Corrected Machine Check) is only for IA-32
Architecture.

Changelog:
v3: Remove "acpi_disable_cmcff" from arm64 code,
    and wrap it in hest.c by "#if defined(__i386__) || defined(__x86_64__)"

v2: https://lkml.org/lkml/2015/12/2/432
    Rebase to latest kernel version(4.4-rc3).
    Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c

v1: https://lkml.org/lkml/2015/8/14/199
    Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
    Delete arch/arm64/kernel/apei.c.
    Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 arch/arm64/Kconfig            | 1 +
 arch/arm64/include/asm/acpi.h | 1 +
 arch/arm64/kernel/acpi.c      | 6 ++++++
 drivers/acpi/apei/hest.c      | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 871f217..58c8992 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select HAVE_ACPI_APEI if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index caafd63..7207f8e 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -94,6 +94,7 @@ static inline const char *acpi_get_enable_method(int cpu)
 
 #ifdef	CONFIG_ACPI_APEI
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
+void arch_apei_flush_tlb_one(unsigned long addr);
 #endif
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2..7a742e7 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -32,6 +32,7 @@
 #ifdef CONFIG_ACPI_APEI
 # include <linux/efi.h>
 # include <asm/pgtable.h>
+# include <asm/tlbflush.h>
 #endif
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
@@ -233,4 +234,9 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
+
+void arch_apei_flush_tlb_one(unsigned long addr)
+{
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
 #endif
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20b3fcf..4ead747 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -232,8 +232,10 @@ void __init acpi_hest_init(void)
 		goto err;
 	}
 
+#if defined(__i386__) || defined(__x86_64__)
 	if (!acpi_disable_cmcff)
 		apei_hest_parse(hest_parse_cmc, NULL);
+#endif
 
 	if (!ghes_disable) {
 		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
-- 
2.5.0

