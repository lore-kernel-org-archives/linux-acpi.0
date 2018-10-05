From: James Morse <james.morse@arm.com>
Subject: [RFC PATCH 1/2] ACPI / processor: Add helper to convert acpi_id to a
 phys_cpuid
Date: Fri,  5 Oct 2018 16:02:34 +0100
Message-ID: <20181005150235.13846-2-james.morse@arm.com>
References: <20181005150235.13846-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181005150235.13846-1-james.morse@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: Vijaya Kumar K <vkilari@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Jeremy Linton <jeremy.linton@arm.com>, Tomasz Nowicki <Tomasz.Nowicki@cavium.com>, James Morse <james.morse@arm.com>, Richard Ruigrok <rruigrok@qti.qualcomm.com>, Hanjun Guo <guohanjun@huawei.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

The PPTT parsing code only has access to an acpi_id, we need a hardware
property, preferably the corresponding phys_cpuid_t.

acpi_get_cpuid() requires us to have the acpi_handle, which would imply
we already have the acpi_device or acpi_processor structure. This call
is useful when the CPU may not have been mapped, e.g. when walking the
namespace.

The PPTT is parsed after CPUs have been discovered and mapped, add a
helper to walk the possible CPUs and test whether the acpi_processor
matches our acpi_id.

Signed-off-by: James Morse <james.morse@arm.com>

---
I'm not entirely sure what 'mapping processors' is about, so may have the
wrong end of the stick here.
---
 drivers/acpi/processor_core.c | 16 ++++++++++++++++
 include/acpi/processor.h      |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 8c0a54d50d0e..333547bf7845 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -9,7 +9,9 @@
  *	Yinghai Lu <yinghai@kernel.org>
  *	Jiang Liu <jiang.liu@intel.com>
  */
+#include <linux/percpu.h>
 #include <linux/export.h>
+#include <linux/cpumask.h>
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
@@ -263,6 +265,20 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 
+phys_cpuid_t acpi_id_to_phys_cpuid(u32 acpi_id)
+{
+	int cpu;
+	struct acpi_processor *pr;
+
+	for_each_possible_cpu(cpu) {
+		pr = per_cpu(processors, cpu);
+		if (pr && pr->acpi_id == acpi_id)
+			return pr->phys_id;
+	}
+
+	return PHYS_CPUID_INVALID;
+}
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
 			 u64 *phys_addr, int *ioapic_id)
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 1194a4c78d55..9235b41a9d52 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -333,6 +333,7 @@ phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
 phys_cpuid_t acpi_map_madt_entry(u32 acpi_id);
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
+phys_cpuid_t acpi_id_to_phys_cpuid(u32 acpi_id);
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
-- 
2.18.0
