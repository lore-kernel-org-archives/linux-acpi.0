From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH V10 2/6] arm: arm64: Add routine to determine cpuid of other cpus
Date: Wed,  9 Nov 2016 17:39:49 -0600
Message-ID: <1478734793-6341-3-git-send-email-jeremy.linton@arm.com>
References: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754539AbcKIXjz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Nov 2016 18:39:55 -0500
In-Reply-To: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-acpi@vger.kernel.org, msalter@redhat.com

It is helpful if we can read the cpuid/midr of other CPUs
in the system independent of arm/arm64.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm/include/asm/cputype.h   | 2 ++
 arch/arm64/include/asm/cputype.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 522b5fe..31fb273 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -235,6 +235,8 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
 #define cpu_is_sa1100() (read_cpuid_part() == ARM_CPU_PART_SA1100)
 #define cpu_is_sa1110() (read_cpuid_part() == ARM_CPU_PART_SA1110)
 
+#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->cpuid
+
 /*
  * Intel's XScale3 core supports some v6 features (supersections, L2)
  * but advertises itself as v5 as it does not support the v6 ISA.  For
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 26a68dd..a6d26e1 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -124,6 +124,9 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
 {
 	return read_cpuid(CTR_EL0);
 }
+
+#define read_specific_cpuid(cpu_num) per_cpu_ptr(&cpu_data, cpu_num)->reg_midr
+
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
2.5.5

