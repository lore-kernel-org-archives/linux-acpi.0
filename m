Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5E30E0DC;
	Wed, 15 Apr 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218214; cv=none; b=QzxR81h64u26WYk3eOCGef4uj2cc/XUQHdnWShc1ov1qFxBn+KD53xGoSOq0/MNzbHG8KGq0HxasEnqd8rmU40H6SalBGCx+7THFW5lGxG/j72yG9PTe+RqPo7WA/oRmiPIwbptuuYAow50erWeQZG5PXZl3FSy0m/y8ajM5Zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218214; c=relaxed/simple;
	bh=T0+s0E0tWZCrb0PJGYB8J4W5kypAHxHmL1V4nejdY4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrKJGPd1VAXjedf3Tde8p7uvGTgZB3rQJgv1wiRpAnoEAK+4LI538bMRxIphVK1jL/Pz02+1UCTlHfypH9kSSKocbQn3CnquaEjEiQtEjmVSIgOIsg7paIkAdepRMUUT+9wmpnSiazDlj/HPrcDHDc++QD9ulJPPHFfbTN2YZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCVJdSbO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCVJdSbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A48EC2BCC9;
	Wed, 15 Apr 2026 01:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218214;
	bh=T0+s0E0tWZCrb0PJGYB8J4W5kypAHxHmL1V4nejdY4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MCVJdSbOSwjEm3SSXBb38boGpn0F+zueoAU4548Em/7noj7MEolMlop4JnZhYfWeF
	 7BxK7xIJnN08BHqOUi5RXJvhDDAWqVDzTC/K/Q2i59v32p3W7SkB6CNyMtD7f2h4wa
	 L7rW/d5tAR1pArGluxez7fZNUVU7YPwaIcFTYMs8jkjOklDr2+SmamTagygP0J7TDG
	 uGSpqHs3QAi0pbANQTfsj6MY0uBjzf+9bCCzSH/esTziPWvvGKx8yCDMzN5MIWzs7Q
	 fynKJeKe7ykZdqjmBJDq6w/nvCmCl3pGxR3yEx2dGjvvOppOp5rkYqJTBuAHnCYlV/
	 piFdvsrxOSXnA==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Apr 2026 18:53:57 -0700
Subject: [PATCH RFC v3 03/11] RISC-V: Add support for srmcfg CSR from
 Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-3-b3b2e7e9847a@kernel.org>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8345; i=fustini@kernel.org;
 h=from:subject:message-id; bh=T0+s0E0tWZCrb0PJGYB8J4W5kypAHxHmL1V4nejdY4Q=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5A0Z6vRpr2XXpce3nbgjuQeu93esXvZEi6s+VTVw
 Ll5lnpYSEcpC4MYF4OsmCLLpg95F5Z4hX5dMP/FNpg5rEwgQxi4OAVgImI6jAzdHMp6XTnn7vee
 vHheJ86JIVm1VPll2PT1Enl733DeFdnC8N+rYuaCN6bHJ//4vPCRdsn2rxu6Ny1k7LX6Wao0a/2
 R6mpmAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
The CSR contains two fields:

  - Resource Control ID (RCID) for resource allocation
  - Monitoring Counter ID (MCID) for tracking resource usage

Requests from a hart to shared resources are tagged with these IDs,
allowing resource usage to be associated with the running task.

Add a srmcfg field to thread_struct with the same format as the CSR so
the scheduler can set the RCID and MCID for each task on context switch.
A per-cpu cpu_srmcfg variable mirrors the CSR state to avoid redundant
writes, as L1D-hot memory access is faster than a CSR read and avoids
traps under virtualization.

Add a per-cpu cpu_srmcfg_default variable to store the default srmcfg
for each CPU, as set by resctrl CPU group assignment. On context switch,
if the next task belongs to the default resource group (srmcfg == 0),
the CPU's default value is used instead. This implements resctrl
resource allocation rule 2: default-group tasks on a CPU assigned to a
specific group receive that group's allocations.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                        |  8 ++++++
 arch/riscv/Kconfig                 | 17 +++++++++++++
 arch/riscv/include/asm/csr.h       |  6 +++++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 52 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 +++
 arch/riscv/kernel/Makefile         |  2 ++
 arch/riscv/kernel/qos/Makefile     |  2 ++
 arch/riscv/kernel/qos/qos.c        |  8 ++++++
 9 files changed, 101 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..b17f885411ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22778,6 +22778,14 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V QOS RESCTRL SUPPORT
+M:	Drew Fustini <fustini@kernel.org>
+R:	yunhui cui <cuiyunhui@bytedance.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	arch/riscv/include/asm/qos.h
+F:	arch/riscv/kernel/qos/
+
 RISC-V RPMI AND MPXY DRIVERS
 M:	Rahul Pathak <rahul@summations.net>
 M:	Anup Patel <anup@brainfault.org>
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5..92d2265a0c61 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -595,6 +595,23 @@ config RISCV_ISA_SVNAPOT
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SSQOSID
+	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
+	default n
+	help
+	  Adds support for the Ssqosid ISA extension (Supervisor-mode
+	  Quality of Service ID).
+
+	  Ssqosid defines the srmcfg CSR which allows the system to tag the
+	  running process with an RCID (Resource Control ID) and MCID
+	  (Monitoring Counter ID). The RCID is used to determine resource
+	  allocation. The MCID is used to track resource usage in event
+	  counters.
+
+	  For example, a cache controller may use the RCID to apply a
+	  cache partitioning scheme and use the MCID to track how much
+	  cache a process, or a group of processes, is using.
+
 config RISCV_ISA_SVPBMT
 	bool "Svpbmt extension support for supervisor mode page-based memory types"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 31b8988f4488..dc13835bd661 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -84,6 +84,11 @@
 #define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif
 
+/* SRMCFG fields */
+#define SRMCFG_RCID_MASK	_AC(0x00000FFF, UL)
+#define SRMCFG_MCID_MASK	_AC(0x00000FFF, UL)
+#define SRMCFG_MCID_SHIFT	16
+
 /* Exception cause high bit - is an interrupt if set */
 #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
 
@@ -328,6 +333,7 @@
 #define CSR_STVAL		0x143
 #define CSR_SIP			0x144
 #define CSR_SATP		0x180
+#define CSR_SRMCFG		0x181
 
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 4c3dd94d0f63..feaee2502593 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -123,6 +123,9 @@ struct thread_struct {
 	/* A forced icache flush is not needed if migrating to the previous cpu. */
 	unsigned int prev_cpu;
 #endif
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+	u32 srmcfg;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
new file mode 100644
index 000000000000..aa96bb5a153c
--- /dev/null
+++ b/arch/riscv/include/asm/qos.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_QOS_H
+#define _ASM_RISCV_QOS_H
+
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+
+#include <linux/sched.h>
+
+#include <asm/csr.h>
+#include <asm/hwcap.h>
+
+/* cached value of srmcfg csr for each cpu */
+DECLARE_PER_CPU(u32, cpu_srmcfg);
+
+/* default srmcfg value for each cpu, set via resctrl cpu assignment */
+DECLARE_PER_CPU(u32, cpu_srmcfg_default);
+
+static inline void __switch_to_srmcfg(struct task_struct *next)
+{
+	u32 thread_srmcfg;
+
+	thread_srmcfg = READ_ONCE(next->thread.srmcfg);
+
+	/*
+	 * Tasks in the default resource group have closid=0 and rmid=0,
+	 * so thread.srmcfg is 0.  For these tasks, use this CPU's default
+	 * srmcfg instead.  This implements resctrl rule 2: a default-group
+	 * task running on a CPU assigned to a specific group uses that
+	 * group's allocations.
+	 */
+	if (thread_srmcfg == 0)
+		thread_srmcfg = __this_cpu_read(cpu_srmcfg_default);
+
+	if (thread_srmcfg != __this_cpu_read(cpu_srmcfg)) {
+		__this_cpu_write(cpu_srmcfg, thread_srmcfg);
+		csr_write(CSR_SRMCFG, thread_srmcfg);
+	}
+}
+
+static __always_inline bool has_srmcfg(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID);
+}
+
+#else /* ! CONFIG_RISCV_ISA_SSQOSID  */
+
+struct task_struct;
+static __always_inline bool has_srmcfg(void) { return false; }
+static inline void __switch_to_srmcfg(struct task_struct *next) { }
+
+#endif /* CONFIG_RISCV_ISA_SSQOSID */
+#endif /* _ASM_RISCV_QOS_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920..1c7ea53ec012 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/qos.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -119,6 +120,8 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector() || has_xtheadvector())		\
 		__switch_to_vector(__prev, __next);	\
+	if (has_srmcfg())				\
+		__switch_to_srmcfg(__next);		\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
 	__switch_to_envcfg(__next);			\
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index cabb99cadfb6..82157aae6401 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -128,3 +128,5 @@ obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
 
 obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
 obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
+
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos/
diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makefile
new file mode 100644
index 000000000000..9f996263a86d
--- /dev/null
+++ b/arch/riscv/kernel/qos/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o
diff --git a/arch/riscv/kernel/qos/qos.c b/arch/riscv/kernel/qos/qos.c
new file mode 100644
index 000000000000..a3c2b910e2e0
--- /dev/null
+++ b/arch/riscv/kernel/qos/qos.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <asm/qos.h>
+
+/* cached value of srmcfg csr for each cpu */
+DEFINE_PER_CPU(u32, cpu_srmcfg);
+
+/* default srmcfg value for each cpu, set via resctrl cpu assignment */
+DEFINE_PER_CPU(u32, cpu_srmcfg_default);

-- 
2.43.0

