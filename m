From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: [RFC PATCH][SeaBIOS] Add _PXM to CPU objects for NUMA hot-plug
Date: Fri, 25 Oct 2013 11:32:10 +0200
Message-ID: <1382693530-31137-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:58864 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab3JYJcV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2013 05:32:21 -0400
Received: by mail-ee0-f47.google.com with SMTP id e49so1767639eek.20
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2013 02:32:20 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: seabios@seabios.org, linux-acpi@vger.kernel.org
Cc: kevin@koconnor.net, wency@cn.fujitsu.com, rjw@sisk.pl, thilo.fromm@profitbricks.com, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>

This patch adds a _PXM object to seabios CPU objects. The _PXM value is derived
from CPU SRAT entries, so build_ssdt needs to be called after build_srat for
this to work.

The motivation for this patch is a CPU hot-unplug/hot-plug bug observed when
using seabios and a 3.11 linux guest kernel on a multi-NUMA node qemu/kvm VM.
The linux guest kernel parses the SRAT CPU entries at boot time and stores them
in the array __apicid_to_node. When a CPU is hot-removed, the linux guest kernel
resets the removed CPU's __apicid_to_node entry to NO_NUMA_NODE (kernel commit
c4c60524). When the removed cpu is hot-added again, the linux kernel looks up
the hot-added cpu object's _PXM  value instead of somehow re-using the SRAT
entry info (acpi_map_cpu2node calls acpi_get_node which calls acpi_get_pxm). If
the _PXM value is not found, the CPU is assumed to be on node 0, and it is
hot-plugged in the wrong NUMA node.

Which is the preferred OSPM way of looking up a CPU's proximity info at hotplug
time? Is it the CPU object's _PXM value, or the already-parsed CPU SRAT entry?
Or maybe both ways are valid?

This issue may require a kernel fix alternatively or additionally to the seabios
fix: The kernel can save the originally parsed SRAT entry info somewhere before
it resets it at hot-remove time, and use that info on hot-plug time if the _PXM
value is missing for the hot-plugged CPU BIOS object. This way CPU hot-plug
works well against a BIOS with no CPU _PXM info.

Any comments / thoughts are welcome.
---
 src/fw/acpi.c        |    8 +++++++-
 src/fw/ssdt-proc.dsl |    2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/fw/acpi.c b/src/fw/acpi.c
index 8de24c9..85c04fd 100644
--- a/src/fw/acpi.c
+++ b/src/fw/acpi.c
@@ -23,6 +23,7 @@
 #include "src/fw/acpi-dsdt.hex"
 
 u32 acpi_pm1a_cnt VARFSEG;
+struct srat_processor_affinity *cpu;
 
 static void
 build_header(struct acpi_table_header *h, u32 sig, int len, u8 rev)
@@ -244,6 +245,7 @@ encodeLen(u8 *ssdt_ptr, int length, int bytes)
 #define PROC_OFFSET_CPUHEX (*ssdt_proc_name - *ssdt_proc_start + 2)
 #define PROC_OFFSET_CPUID1 (*ssdt_proc_name - *ssdt_proc_start + 4)
 #define PROC_OFFSET_CPUID2 (*ssdt_proc_id - *ssdt_proc_start)
+#define PROC_OFFSET_CPUPXM (*ssdt_proc_pxm - *ssdt_proc_start)
 #define PROC_SIZEOF (*ssdt_proc_end - *ssdt_proc_start)
 #define PROC_AML (ssdp_proc_aml + *ssdt_proc_start)
 
@@ -372,6 +374,7 @@ build_ssdt(void)
     *(ssdt_ptr++) = '_';
 
     // build Processor object for each processor
+    struct srat_processor_affinity *core = cpu;
     int i;
     for (i=0; i<acpi_cpus; i++) {
         memcpy(ssdt_ptr, PROC_AML, PROC_SIZEOF);
@@ -379,7 +382,9 @@ build_ssdt(void)
         ssdt_ptr[PROC_OFFSET_CPUHEX+1] = getHex(i);
         ssdt_ptr[PROC_OFFSET_CPUID1] = i;
         ssdt_ptr[PROC_OFFSET_CPUID2] = i;
+        ssdt_ptr[PROC_OFFSET_CPUPXM] = core->proximity_lo;
         ssdt_ptr += PROC_SIZEOF;
+        core++;
     }
 
     // build "Method(NTFY, 2) {If (LEqual(Arg0, 0x00)) {Notify(CP00, Arg1)} ...}"
@@ -497,6 +502,7 @@ build_srat(void)
     int i;
     u64 curnode;
 
+    cpu = core;
     for (i = 0; i < max_cpu; ++i) {
         core->type = SRAT_PROCESSOR;
         core->length = sizeof(*core);
@@ -620,10 +626,10 @@ acpi_setup(void)
 
     struct fadt_descriptor_rev1 *fadt = build_fadt(pci);
     ACPI_INIT_TABLE(fadt);
-    ACPI_INIT_TABLE(build_ssdt());
     ACPI_INIT_TABLE(build_madt());
     ACPI_INIT_TABLE(build_hpet());
     ACPI_INIT_TABLE(build_srat());
+    ACPI_INIT_TABLE(build_ssdt());
     if (pci->device == PCI_DEVICE_ID_INTEL_ICH9_LPC)
         ACPI_INIT_TABLE(build_mcfg_q35());
 
diff --git a/src/fw/ssdt-proc.dsl b/src/fw/ssdt-proc.dsl
index 407d61e..373cdd7 100644
--- a/src/fw/ssdt-proc.dsl
+++ b/src/fw/ssdt-proc.dsl
@@ -32,6 +32,8 @@ DefinitionBlock ("ssdt-proc.aml", "SSDT", 0x01, "BXPC", "BXSSDT", 0x1)
  * also updating the C code.
  */
         Name(_HID, "ACPI0007")
+        ACPI_EXTRACT_NAME_BYTE_CONST ssdt_proc_pxm
+        Name(_PXM, 0xBB)
         External(CPMA, MethodObj)
         External(CPST, MethodObj)
         External(CPEJ, MethodObj)
-- 
1.7.10.4

