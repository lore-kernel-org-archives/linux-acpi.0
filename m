From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/2] xen: add acpi_arch_get_root_pointer() for pvh guests
Date: Thu, 25 Jan 2018 11:04:54 +0100
Message-ID: <20180125100454.23203-3-jgross@suse.com>
References: <20180125100454.23203-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180125100454.23203-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: lenb@kernel.org, rafael.j.wysocki@intel.com, mingo@redhat.com, boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add acpi_arch_get_root_pointer() for Xen PVH guests to communicate
the address of the RSDP table given to the kernel via Xen start info.

This makes the kernel boot again in PVH mode after on recent Xen the
RSDP was moved to higher addresses. So up to that change it was pure
luck that the legacy method to locate the RSDP was working when
running as PVH mode.

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pvh.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 436c4f003e17..9a5c3a7fe673 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -16,15 +16,24 @@
 /*
  * PVH variables.
  *
- * xen_pvh and pvh_bootparams need to live in data segment since they
- * are used after startup_{32|64}, which clear .bss, are invoked.
+ * xen_pvh, pvh_bootparams and pvh_start_info need to live in data segment
+ * since they are used after startup_{32|64}, which clear .bss, are invoked.
  */
 bool xen_pvh __attribute__((section(".data"))) = 0;
 struct boot_params pvh_bootparams __attribute__((section(".data")));
+struct hvm_start_info pvh_start_info __attribute__((section(".data")));
 
-struct hvm_start_info pvh_start_info;
 unsigned int pvh_start_info_sz = sizeof(pvh_start_info);
 
+acpi_physical_address acpi_arch_get_root_pointer(void)
+{
+	if (xen_pvh)
+		return pvh_start_info.rsdp_paddr;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_arch_get_root_pointer);
+
 static void __init init_pvh_bootparams(void)
 {
 	struct xen_memory_map memmap;
-- 
2.13.6
