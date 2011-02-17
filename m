From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH 2/2] acpi: use __cpuinit for the
	 acpi_processor_set_pdc() call tree
Date: Thu, 17 Feb 2011 16:36:24 +0000
Message-ID: <4D5D5C9802000078000327B1@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org

Once acpi_map_lsapic() in ia64 follows how x86 treats it wrt section
placement, the whole tree from acpi_processor_set_pdc() can become
__cpuinit.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Tony Luck <tony.luck@intel.com>

---
 arch/ia64/kernel/acpi.c       |    9 +++++++--
 drivers/acpi/processor_core.c |    8 ++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

--- 2.6.38-rc5/arch/ia64/kernel/acpi.c
+++ 2.6.38-rc5-acpi-set-pdc-cpuinit/arch/ia64/kernel/acpi.c
@@ -803,7 +803,7 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq
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
@@ -929,6 +929,11 @@ int acpi_map_lsapic(acpi_handle handle, 
 	return (0);
 }
 
+/* wrapper to silence section mismatch warning */
+int __ref acpi_map_lsapic(acpi_handle handle, int *pcpu)
+{
+	return _acpi_map_lsapic(handle, pcpu);
+}
 EXPORT_SYMBOL(acpi_map_lsapic);
 
 int acpi_unmap_lsapic(int cpu)
--- 2.6.38-rc5/drivers/acpi/processor_core.c
+++ 2.6.38-rc5-acpi-set-pdc-cpuinit/drivers/acpi/processor_core.c
@@ -223,7 +223,7 @@ static bool processor_physically_present
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
@@ -278,7 +278,7 @@ static struct acpi_object_list *acpi_pro
  * _PDC is required for a BIOS-OS handshake for most of the newer
  * ACPI processor features.
  */
-static int
+static int __cpuinit
 acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
 	acpi_status status = AE_OK;
@@ -306,7 +306,7 @@ acpi_processor_eval_pdc(acpi_handle hand
 	return status;
 }
 
-void acpi_processor_set_pdc(acpi_handle handle)
+void __cpuinit acpi_processor_set_pdc(acpi_handle handle)
 {
 	struct acpi_object_list *obj_list;
 



