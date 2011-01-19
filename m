From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH, resend] x86: unify "numa=" command line option
	 handling
Date: Wed, 19 Jan 2011 08:57:21 +0000
Message-ID: <4D36B581020000780002D0FF@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com
Cc: Tejun Heo <tj@kernel.org>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

In order to be able to suppress the use of SRAT tables that 32-bit
Linux can't deal with (in one case known to lead to a non-bootable
system, unless disabling ACPI altogether), move the "numa=" option
handling to common code.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Tejun Heo <tj@kernel.org>

---
 arch/x86/include/asm/numa_32.h |    2 ++
 arch/x86/include/asm/numa_64.h |    1 +
 arch/x86/mm/numa.c             |   22 ++++++++++++++++++++++
 arch/x86/mm/numa_64.c          |   24 +++++-------------------
 arch/x86/mm/srat_32.c          |    1 -
 5 files changed, 30 insertions(+), 20 deletions(-)

--- 2.6.38-rc1/arch/x86/include/asm/numa_32.h
+++ 2.6.38-rc1-x86-numa-option/arch/x86/include/asm/numa_32.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_NUMA_32_H
 #define _ASM_X86_NUMA_32_H
 
+extern int numa_off;
+
 extern int pxm_to_nid(int pxm);
 extern void numa_remove_cpu(int cpu);
 
--- 2.6.38-rc1/arch/x86/include/asm/numa_64.h
+++ 2.6.38-rc1-x86-numa-option/arch/x86/include/asm/numa_64.h
@@ -40,6 +40,7 @@ extern void __cpuinit numa_remove_cpu(in
 #ifdef CONFIG_NUMA_EMU
 #define FAKE_NODE_MIN_SIZE	((u64)32 << 20)
 #define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
+void numa_emu_cmdline(char *);
 #endif /* CONFIG_NUMA_EMU */
 #else
 static inline void init_cpu_to_node(void)		{ }
--- 2.6.38-rc1/arch/x86/mm/numa.c
+++ 2.6.38-rc1-x86-numa-option/arch/x86/mm/numa.c
@@ -2,6 +2,28 @@
 #include <linux/topology.h>
 #include <linux/module.h>
 #include <linux/bootmem.h>
+#include <asm/numa.h>
+#include <asm/acpi.h>
+
+int __initdata numa_off;
+
+static __init int numa_setup(char *opt)
+{
+	if (!opt)
+		return -EINVAL;
+	if (!strncmp(opt, "off", 3))
+		numa_off = 1;
+#ifdef CONFIG_NUMA_EMU
+	if (!strncmp(opt, "fake=", 5))
+		numa_emu_cmdline(opt + 5);
+#endif
+#ifdef CONFIG_ACPI_NUMA
+	if (!strncmp(opt, "noacpi", 6))
+		acpi_numa = -1;
+#endif
+	return 0;
+}
+early_param("numa", numa_setup);
 
 /*
  * Which logical CPUs are on which nodes
--- 2.6.38-rc1/arch/x86/mm/numa_64.c
+++ 2.6.38-rc1-x86-numa-option/arch/x86/mm/numa_64.c
@@ -30,7 +30,6 @@ s16 apicid_to_node[MAX_LOCAL_APIC] __cpu
 	[0 ... MAX_LOCAL_APIC-1] = NUMA_NO_NODE
 };
 
-int numa_off __initdata;
 static unsigned long __initdata nodemap_addr;
 static unsigned long __initdata nodemap_size;
 
@@ -263,6 +262,11 @@ static struct bootnode nodes[MAX_NUMNODE
 static struct bootnode physnodes[MAX_NUMNODES] __cpuinitdata;
 static char *cmdline __initdata;
 
+void __init numa_emu_cmdline(char *str)
+{
+	cmdline = str;
+}
+
 static int __init setup_physnodes(unsigned long start, unsigned long end,
 					int acpi, int amd)
 {
@@ -670,24 +674,6 @@ unsigned long __init numa_free_all_bootm
 	return pages;
 }
 
-static __init int numa_setup(char *opt)
-{
-	if (!opt)
-		return -EINVAL;
-	if (!strncmp(opt, "off", 3))
-		numa_off = 1;
-#ifdef CONFIG_NUMA_EMU
-	if (!strncmp(opt, "fake=", 5))
-		cmdline = opt + 5;
-#endif
-#ifdef CONFIG_ACPI_NUMA
-	if (!strncmp(opt, "noacpi", 6))
-		acpi_numa = -1;
-#endif
-	return 0;
-}
-early_param("numa", numa_setup);
-
 #ifdef CONFIG_NUMA
 
 static __init int find_near_online_node(int node)
--- 2.6.38-rc1/arch/x86/mm/srat_32.c
+++ 2.6.38-rc1-x86-numa-option/arch/x86/mm/srat_32.c
@@ -59,7 +59,6 @@ static struct node_memory_chunk_s __init
 static int __initdata num_memory_chunks; /* total number of memory chunks */
 static u8 __initdata apicid_to_pxm[MAX_APICID];
 
-int numa_off __initdata;
 int acpi_numa __initdata;
 
 static __init void bad_srat(void)



