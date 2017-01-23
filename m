From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v14 1/6] arm: arm64: Add routine to determine cpuid of other
 cpus
Date: Mon, 23 Jan 2017 16:32:40 -0600
Message-ID: <1485210765-9422-2-git-send-email-jeremy.linton@arm.com>
References: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, msalter@redhat.com, bamvor.zhangjian@linaro.org
List-Id: linux-acpi@vger.kernel.org

It is helpful if we can read the cpuid/midr of other CPUs
in the system independent of arm/arm64.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm/include/asm/cputype.h   | 4 ++++
 arch/arm/kernel/setup.c          | 2 +-
 arch/arm64/include/asm/cputype.h | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index b62eaeb..a3b6c8b 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -238,6 +238,10 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
 #define cpu_is_sa1100() (read_cpuid_part() == ARM_CPU_PART_SA1100)
 #define cpu_is_sa1110() (read_cpuid_part() == ARM_CPU_PART_SA1110)
 
+#define read_specific_cpuid(cpu_num) (is_smp() ? \
+				      per_cpu_ptr(&cpu_data, cpu_num)->cpuid \
+				      : read_cpuid_id())
+
 /*
  * Intel's XScale3 core supports some v6 features (supersections, L2)
  * but advertises itself as v5 as it does not support the v6 ISA.  For
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 34e3f3c..d443c97 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1217,7 +1217,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
+		cpuid = read_specific_cpuid(i);
 		seq_printf(m, "model name\t: %s rev %d (%s)\n",
 			   cpu_name, cpuid & 15, elf_platform);
 
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
2.7.4
