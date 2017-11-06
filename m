From: James Morse <james.morse@arm.com>
Subject: [PATCH 4/4] ACPI / APEI: Remove arch_apei_flush_tlb_one()
Date: Mon,  6 Nov 2017 18:44:27 +0000
Message-ID: <20171106184427.31905-5-james.morse@arm.com>
References: <20171106184427.31905-1-james.morse@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171106184427.31905-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, x86@kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Tyler Baicar <tbaicar@codeaurora.org>, Qiang Zheng <zhengqiang10@huawei.com>, Toshi Kani <toshi.kani@hpe.com>, torvalds@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

Nothing calls arch_apei_flush_tlb_one() anymore, instead relying on
__set_pte_vaddr() to do the invalidation when called from clear_fixmap()
Remove arch_apei_flush_tlb_one().

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/acpi/apei.c | 5 -----
 include/acpi/apei.h         | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index ea3046e0b0cf..bb8d300fecbd 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -52,8 +52,3 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	apei_mce_report_mem_error(sev, mem_err);
 #endif
 }
-
-void arch_apei_flush_tlb_one(unsigned long addr)
-{
-	__flush_tlb_one(addr);
-}
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index c46694abea28..82c451698c98 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -50,7 +50,6 @@ int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
-void arch_apei_flush_tlb_one(unsigned long addr);
 
 #endif
 #endif
-- 
2.15.0.rc2
