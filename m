From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/6]ACPI based Physical CPU hotplug
Date: Wed, 8 Sep 2004 18:35:54 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908183554.A7384@unix-os.sc.intel.com>
References: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <44BDAFB888F59F408FAE3CC35AB47041B17999@orsmsx409>; from anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Wed, Sep 08, 2004 at 06:10:50PM -0700
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: LHNS list <lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



---
Name:acpi_hotplug_arch.patch
Status: Tested on 2.6.9-rc1-mm2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Depends:	
Version: applies on 2.6.9-rc1-mm2	
Description: 
This patch provides the architecture specifice support for mapping lsapic to cpu array.
Currently this supports just IA64. Support for IA32 and x86_64 is in progress
---

 linux-2.6.9-rc1-mm2-askeshav/arch/i386/kernel/acpi/boot.c |   22 ++
 linux-2.6.9-rc1-mm2-askeshav/arch/ia64/kernel/acpi.c      |  129 +++++++++++++-
 linux-2.6.9-rc1-mm2-askeshav/include/linux/acpi.h         |    6 
 3 files changed, 155 insertions(+), 2 deletions(-)

diff -puN include/linux/acpi.h~acpi_hotplug_arch include/linux/acpi.h
--- linux-2.6.9-rc1-mm2/include/linux/acpi.h~acpi_hotplug_arch	2004-09-08 16:42:19.810469466 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/include/linux/acpi.h	2004-09-08 16:42:19.907149152 -0700
@@ -396,6 +396,12 @@ void acpi_numa_processor_affinity_init (
 void acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
 void acpi_numa_arch_fixup(void);
 
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+/* Arch dependent functions for cpu hotplug support */
+int acpi_map_lsapic(acpi_handle handle, int *pcpu);
+int acpi_unmap_lsapic(int cpu);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 extern int acpi_mp_config;
 
 extern u32 pci_mmcfg_base_addr;
diff -puN arch/ia64/kernel/acpi.c~acpi_hotplug_arch arch/ia64/kernel/acpi.c
--- linux-2.6.9-rc1-mm2/arch/ia64/kernel/acpi.c~acpi_hotplug_arch	2004-09-08 16:42:19.816328841 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/arch/ia64/kernel/acpi.c	2004-09-08 16:42:19.909102277 -0700
@@ -354,11 +354,11 @@ acpi_parse_madt (unsigned long phys_addr
 #define PXM_FLAG_LEN ((MAX_PXM_DOMAINS + 1)/32)
 
 static int __initdata srat_num_cpus;			/* number of cpus */
-static u32 __initdata pxm_flag[PXM_FLAG_LEN];
+static u32 __devinitdata pxm_flag[PXM_FLAG_LEN];
 #define pxm_bit_set(bit)	(set_bit(bit,(void *)pxm_flag))
 #define pxm_bit_test(bit)	(test_bit(bit,(void *)pxm_flag))
 /* maps to convert between proximity domain and logical node ID */
-int __initdata pxm_to_nid_map[MAX_PXM_DOMAINS];
+int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
 int __initdata nid_to_pxm_map[MAX_NUMNODES];
 static struct acpi_table_slit __initdata *slit_table;
 
@@ -650,4 +650,129 @@ acpi_gsi_to_irq (u32 gsi, unsigned int *
 	return 0;
 }
 
+
+
+/*
+ *  ACPI based hotplug support for CPU
+ */
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+static
+int
+acpi_map_cpu2node(acpi_handle handle, int cpu, long physid)
+{
+#ifdef CONFIG_ACPI_NUMA
+	int 			pxm_id = 0;
+	union acpi_object 	*obj;
+	struct acpi_buffer 	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_PXM", NULL, &buffer)))
+		goto pxm_id_0;
+
+	if ((!buffer.length) || (!buffer.pointer))
+		goto pxm_id_0;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		acpi_os_free(buffer.pointer);
+		goto pxm_id_0;
+	}
+
+	pxm_id = obj->integer.value;
+
+pxm_id_0:
+	/*
+	 * Assuming that the container driver would have set the proximity
+	 * domain and would have initialized pxm_to_nid_map[pxm_id] && pxm_flag
+	 */
+
+	/* Return Error if proximity domain is not set */
+	if (!pxm_bit_test(pxm_id))
+		return -EINVAL;
+
+	node_cpuid[cpu].phys_id =  physid;
+	node_cpuid[cpu].nid = pxm_to_nid_map[pxm_id];
+
+#endif
+	return(0);
+}
+
+
+int
+acpi_map_lsapic(acpi_handle handle, int *pcpu)
+{
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	struct acpi_table_lsapic *lsapic;
+	cpumask_t tmp_map;
+	long physid;
+	int cpu;
+ 
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
+		return -EINVAL;
+
+	if (!buffer.length ||  !buffer.pointer)
+		return -EINVAL;
+ 
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*lsapic)) {
+		acpi_os_free(buffer.pointer);
+		return -EINVAL;
+	}
+
+	lsapic = (struct acpi_table_lsapic *)obj->buffer.pointer;
+
+	if ((lsapic->header.type != ACPI_MADT_LSAPIC) ||
+	    (!lsapic->flags.enabled)) {
+		acpi_os_free(buffer.pointer);
+		return -EINVAL;
+	}
+
+	physid = ((lsapic->id <<8) | (lsapic->eid));
+
+	acpi_os_free(buffer.pointer);
+	buffer.length = ACPI_ALLOCATE_BUFFER;
+	buffer.pointer = NULL;
+
+	cpus_complement(tmp_map, cpu_present_map);
+	cpu = first_cpu(tmp_map);
+	if(cpu >= NR_CPUS)
+		return -EINVAL;
+
+	if (ACPI_FAILURE(acpi_map_cpu2node(handle, cpu, physid)))
+	return -ENODEV;
+
+ 	cpu_set(cpu, cpu_present_map);
+	ia64_cpu_to_sapicid[cpu] = physid;
+	ia64_acpiid_to_sapicid[lsapic->acpi_id] = ia64_cpu_to_sapicid[cpu];
+
+	*pcpu = cpu;
+	return(0);
+}
+EXPORT_SYMBOL(acpi_map_lsapic);
+
+
+int
+acpi_unmap_lsapic(int cpu)
+{
+	int i;
+
+	for (i=0; i<MAX_SAPICS; i++) {
+ 		if (ia64_acpiid_to_sapicid[i] == ia64_cpu_to_sapicid[cpu]) {
+ 			ia64_acpiid_to_sapicid[i] = -1;
+ 			break;
+ 		}
+ 	}
+ 	ia64_cpu_to_sapicid[cpu] = -1;
+	cpu_clear(cpu,cpu_present_map);
+
+#ifdef CONFIG_ACPI_NUMA
+	/* NUMA specific cleanup's */
+#endif
+
+	return(0);
+}
+EXPORT_SYMBOL(acpi_unmap_lsapic);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+ 
 #endif /* CONFIG_ACPI */
diff -puN arch/i386/kernel/acpi/boot.c~acpi_hotplug_arch arch/i386/kernel/acpi/boot.c
--- linux-2.6.9-rc1-mm2/arch/i386/kernel/acpi/boot.c~acpi_hotplug_arch	2004-09-08 16:42:19.822188215 -0700
+++ linux-2.6.9-rc1-mm2-askeshav/arch/i386/kernel/acpi/boot.c	2004-09-08 16:42:19.910078839 -0700
@@ -475,6 +475,28 @@ unsigned int acpi_register_gsi(u32 gsi, 
 }
 EXPORT_SYMBOL(acpi_register_gsi);
 
+/*
+ *  ACPI based hotplug support for CPU
+ */
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+int
+acpi_map_lsapic(acpi_handle handle, int *pcpu)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_map_lsapic);
+
+
+int
+acpi_unmap_lsapic(int cpu)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_unmap_lsapic);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 static unsigned long __init
 acpi_scan_rsdp (
 	unsigned long		start,
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
