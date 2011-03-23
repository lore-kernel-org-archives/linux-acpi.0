From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/42] ACPI: use __cpuinit for the acpi_processor_set_pdc()
 call tree
Date: Wed, 23 Mar 2011 02:42:41 -0400
Message-ID: <af10f941ab7807d8b0bb3c66e679d8a6bbbe7485.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab1CWIHk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:40 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:34 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jan Beulich <JBeulich@novell.com>, Jan Beulich <jbeulich@novell.com>, Len Brown <len.brown@intel.com>

From: Jan Beulich <JBeulich@novell.com>

Once acpi_map_lsapic() in ia64 follows how x86 treats it wrt section
placement, the whole tree from acpi_processor_set_pdc() can become
__cpuinit.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Acked-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/acpi.c       |    9 +++++++--
 drivers/acpi/processor_core.c |    8 ++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 90ebceb..522642d 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -803,7 +803,7 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
  *  ACPI based hotplug CPU support
  */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-static
+static __cpuinit
 int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
@@ -878,7 +878,7 @@ __init void prefill_possible_map(void)
 		set_cpu_possible(i, true);
 }
 
-int acpi_map_lsapic(acpi_handle handle, int *pcpu)
+static int __cpuinit _acpi_map_lsapic(acpi_handle handle, int *pcpu)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
@@ -929,6 +929,11 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 	return (0);
 }
 
+/* wrapper to silence section mismatch warning */
+int __ref acpi_map_lsapic(acpi_handle handle, int *pcpu)
+{
+	return _acpi_map_lsapic(handle, pcpu);
+}
 EXPORT_SYMBOL(acpi_map_lsapic);
 
 int acpi_unmap_lsapic(int cpu)
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index ac77dde..25bf17d 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -223,7 +223,7 @@ static bool __init processor_physically_present(acpi_handle handle)
 	return true;
 }
 
-static void acpi_set_pdc_bits(u32 *buf)
+static void __cpuinit acpi_set_pdc_bits(u32 *buf)
 {
 	buf[0] = ACPI_PDC_REVISION_ID;
 	buf[1] = 1;
@@ -235,7 +235,7 @@ static void acpi_set_pdc_bits(u32 *buf)
 	arch_acpi_set_pdc_bits(buf);
 }
 
-static struct acpi_object_list *acpi_processor_alloc_pdc(void)
+static struct acpi_object_list *__cpuinit acpi_processor_alloc_pdc(void)
 {
 	struct acpi_object_list *obj_list;
 	union acpi_object *obj;
@@ -278,7 +278,7 @@ static struct acpi_object_list *acpi_processor_alloc_pdc(void)
  * _PDC is required for a BIOS-OS handshake for most of the newer
  * ACPI processor features.
  */
-static int
+static int __cpuinit
 acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
 	acpi_status status = AE_OK;
@@ -306,7 +306,7 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 	return status;
 }
 
-void acpi_processor_set_pdc(acpi_handle handle)
+void __cpuinit acpi_processor_set_pdc(acpi_handle handle)
 {
 	struct acpi_object_list *obj_list;
 
-- 
1.7.4.1.343.ga91df

