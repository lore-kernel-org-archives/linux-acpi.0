From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 3/4] ACPI / osl: Remove acpi_get_table_with_size()/early_acpi_os_unmap_memory() users
Date: Wed, 14 Dec 2016 15:04:39 +0800
Message-ID: <bae57781dd1ec1ef50d7a4e74ba73dd42dc7d4e2.1481698041.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com> <cover.1481698041.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41545 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753656AbcLNHEp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Dec 2016 02:04:45 -0500
In-Reply-To: <cover.1481698041.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch removes the users of the deprectated APIs:
 acpi_get_table_with_size()
 early_acpi_os_unmap_memory()
The following APIs should be used instead of:
 acpi_get_table()
 acpi_put_table()

The deprecated APIs are invented to be a replacement of acpi_get_table()
during the early stage so that the early mapped pointer will not be stored
in ACPICA core and thus the late stage acpi_get_table() won't return a
wrong pointer. The mapping size is returned just because it is required by
early_acpi_os_unmap_memory() to unmap the pointer during early stage.

But as the mapping size equals to the acpi_table_header.length
(see acpi_tb_init_table_descriptor() and acpi_tb_validate_table()), when
such a convenient result is returned, driver code will start to use it
instead of accessing acpi_table_header to obtain the length.

Thus this patch cleans up the drivers by replacing returned table size with
acpi_table_header.length, and should be a no-op.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/arm64/kernel/acpi.c                 |    7 +++----
 drivers/acpi/nfit/core.c                 |    3 ++-
 drivers/acpi/processor_core.c            |    8 +++-----
 drivers/acpi/spcr.c                      |    8 +++-----
 drivers/acpi/tables.c                    |   17 +++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c |    3 ++-
 drivers/gpu/drm/radeon/radeon_bios.c     |    3 ++-
 drivers/iommu/amd_iommu_init.c           |   10 ++++------
 drivers/iommu/dmar.c                     |    7 ++-----
 drivers/mailbox/pcc.c                    |    5 +----
 10 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 252a6d9..64d9cbd6 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -132,14 +132,13 @@ static int __init acpi_fadt_sanity_check(void)
 	struct acpi_table_header *table;
 	struct acpi_table_fadt *fadt;
 	acpi_status status;
-	acpi_size tbl_size;
 	int ret = 0;
 
 	/*
 	 * FADT is required on arm64; retrieve it to check its presence
 	 * and carry out revision and ACPI HW reduced compliancy tests
 	 */
-	status = acpi_get_table_with_size(ACPI_SIG_FADT, 0, &table, &tbl_size);
+	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
 	if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 
@@ -170,10 +169,10 @@ static int __init acpi_fadt_sanity_check(void)
 
 out:
 	/*
-	 * acpi_get_table_with_size() creates FADT table mapping that
+	 * acpi_get_table() creates FADT table mapping that
 	 * should be released after parsing and before resuming boot
 	 */
-	early_acpi_os_unmap_memory(table, tbl_size);
+	acpi_put_table(table);
 	return ret;
 }
 
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 312c4b4..2f82b8e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2806,12 +2806,13 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_size sz;
 	int rc = 0;
 
-	status = acpi_get_table_with_size(ACPI_SIG_NFIT, 0, &tbl, &sz);
+	status = acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
 	if (ACPI_FAILURE(status)) {
 		/* This is ok, we could have an nvdimm hotplugged later */
 		dev_dbg(dev, "failed to find NFIT at startup\n");
 		return 0;
 	}
+	sz = tbl->length;
 
 	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
 	if (!acpi_desc)
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 5c78ee1..611a558 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -154,18 +154,16 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
 {
 	struct acpi_table_madt *madt = NULL;
-	acpi_size tbl_size;
 	phys_cpuid_t rv;
 
-	acpi_get_table_with_size(ACPI_SIG_MADT, 0,
-				 (struct acpi_table_header **)&madt,
-				 &tbl_size);
+	acpi_get_table(ACPI_SIG_MADT, 0,
+		       (struct acpi_table_header **)&madt);
 	if (!madt)
 		return PHYS_CPUID_INVALID;
 
 	rv = map_madt_entry(madt, 1, acpi_id, true);
 
-	early_acpi_os_unmap_memory(madt, tbl_size);
+	acpi_put_table((struct acpi_table_header *)madt);
 
 	return rv;
 }
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index e8d7bc7..b8019c4 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -33,7 +33,6 @@ int __init parse_spcr(bool earlycon)
 {
 	static char opts[64];
 	struct acpi_table_spcr *table;
-	acpi_size table_size;
 	acpi_status status;
 	char *uart;
 	char *iotype;
@@ -43,9 +42,8 @@ int __init parse_spcr(bool earlycon)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	status = acpi_get_table_with_size(ACPI_SIG_SPCR, 0,
-					  (struct acpi_table_header **)&table,
-					  &table_size);
+	status = acpi_get_table(ACPI_SIG_SPCR, 0,
+				(struct acpi_table_header **)&table);
 
 	if (ACPI_FAILURE(status))
 		return -ENOENT;
@@ -106,6 +104,6 @@ int __init parse_spcr(bool earlycon)
 	err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
 
 done:
-	early_acpi_os_unmap_memory((void __iomem *)table, table_size);
+	acpi_put_table((struct acpi_table_header *)table);
 	return err;
 }
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index cdd56c4..2604189 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -333,7 +333,6 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 			 unsigned int max_entries)
 {
 	struct acpi_table_header *table_header = NULL;
-	acpi_size tbl_size;
 	int count;
 	u32 instance = 0;
 
@@ -346,7 +345,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	if (!strncmp(id, ACPI_SIG_MADT, 4))
 		instance = acpi_apic_instance;
 
-	acpi_get_table_with_size(id, instance, &table_header, &tbl_size);
+	acpi_get_table(id, instance, &table_header);
 	if (!table_header) {
 		pr_warn("%4.4s not present\n", id);
 		return -ENODEV;
@@ -355,7 +354,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	count = acpi_parse_entries_array(id, table_size, table_header,
 			proc, proc_num, max_entries);
 
-	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
+	acpi_put_table(table_header);
 	return count;
 }
 
@@ -397,7 +396,6 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
-	acpi_size tbl_size;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -406,13 +404,13 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		return -EINVAL;
 
 	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table_with_size(id, acpi_apic_instance, &table, &tbl_size);
+		acpi_get_table(id, acpi_apic_instance, &table);
 	else
-		acpi_get_table_with_size(id, 0, &table, &tbl_size);
+		acpi_get_table(id, 0, &table);
 
 	if (table) {
 		handler(table);
-		early_acpi_os_unmap_memory(table, tbl_size);
+		acpi_put_table(table);
 		return 0;
 	} else
 		return -ENODEV;
@@ -426,16 +424,15 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 static void __init check_multiple_madt(void)
 {
 	struct acpi_table_header *table = NULL;
-	acpi_size tbl_size;
 
-	acpi_get_table_with_size(ACPI_SIG_MADT, 2, &table, &tbl_size);
+	acpi_get_table(ACPI_SIG_MADT, 2, &table);
 	if (table) {
 		pr_warn("BIOS bug: multiple APIC/MADT found, using %d\n",
 			acpi_apic_instance);
 		pr_warn("If \"acpi_apic_instance=%d\" works better, "
 			"notify linux-acpi@vger.kernel.org\n",
 			acpi_apic_instance ? 0 : 2);
-		early_acpi_os_unmap_memory(table, tbl_size);
+		acpi_put_table(table);
 
 	} else
 		acpi_apic_instance = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 4f973a9..8ec1967 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -305,8 +305,9 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 	GOP_VBIOS_CONTENT *vbios;
 	VFCT_IMAGE_HEADER *vhdr;
 
-	if (!ACPI_SUCCESS(acpi_get_table_with_size("VFCT", 1, &hdr, &tbl_size)))
+	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
+	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
 		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
 		goto out_unmap;
diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 21b6732..c829cfb 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -603,8 +603,9 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 	GOP_VBIOS_CONTENT *vbios;
 	VFCT_IMAGE_HEADER *vhdr;
 
-	if (!ACPI_SUCCESS(acpi_get_table_with_size("VFCT", 1, &hdr, &tbl_size)))
+	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
+	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
 		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
 		goto out_unmap;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 157e934..eea3d49 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2207,14 +2207,13 @@ static void __init free_dma_resources(void)
 static int __init early_amd_iommu_init(void)
 {
 	struct acpi_table_header *ivrs_base;
-	acpi_size ivrs_size;
 	acpi_status status;
 	int i, remap_cache_sz, ret = 0;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
 
-	status = acpi_get_table_with_size("IVRS", 0, &ivrs_base, &ivrs_size);
+	status = acpi_get_table("IVRS", 0, &ivrs_base);
 	if (status == AE_NOT_FOUND)
 		return -ENODEV;
 	else if (ACPI_FAILURE(status)) {
@@ -2334,7 +2333,7 @@ static int __init early_amd_iommu_init(void)
 
 out:
 	/* Don't leak any ACPI memory */
-	early_acpi_os_unmap_memory((char __iomem *)ivrs_base, ivrs_size);
+	acpi_put_table(ivrs_base);
 	ivrs_base = NULL;
 
 	return ret;
@@ -2358,10 +2357,9 @@ static int amd_iommu_enable_interrupts(void)
 static bool detect_ivrs(void)
 {
 	struct acpi_table_header *ivrs_base;
-	acpi_size ivrs_size;
 	acpi_status status;
 
-	status = acpi_get_table_with_size("IVRS", 0, &ivrs_base, &ivrs_size);
+	status = acpi_get_table("IVRS", 0, &ivrs_base);
 	if (status == AE_NOT_FOUND)
 		return false;
 	else if (ACPI_FAILURE(status)) {
@@ -2370,7 +2368,7 @@ static bool detect_ivrs(void)
 		return false;
 	}
 
-	early_acpi_os_unmap_memory((char __iomem *)ivrs_base, ivrs_size);
+	acpi_put_table(ivrs_base);
 
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8c53748..a88576d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -68,7 +68,6 @@ struct dmar_res_callback {
 LIST_HEAD(dmar_drhd_units);
 
 struct acpi_table_header * __initdata dmar_tbl;
-static acpi_size dmar_tbl_size;
 static int dmar_dev_scope_status = 1;
 static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
 
@@ -543,9 +542,7 @@ static int __init dmar_table_detect(void)
 	acpi_status status = AE_OK;
 
 	/* if we could find DMAR table, then there are DMAR devices */
-	status = acpi_get_table_with_size(ACPI_SIG_DMAR, 0,
-				(struct acpi_table_header **)&dmar_tbl,
-				&dmar_tbl_size);
+	status = acpi_get_table(ACPI_SIG_DMAR, 0, &dmar_tbl);
 
 	if (ACPI_SUCCESS(status) && !dmar_tbl) {
 		pr_warn("Unable to map DMAR\n");
@@ -906,7 +903,7 @@ int __init detect_intel_iommu(void)
 		x86_init.iommu.iommu_init = intel_iommu_init;
 #endif
 
-	early_acpi_os_unmap_memory((void __iomem *)dmar_tbl, dmar_tbl_size);
+	acpi_put_table(dmar_tbl);
 	dmar_tbl = NULL;
 	up_write(&dmar_global_lock);
 
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 1f32688..dd9ecd35 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -447,7 +447,6 @@ static int pcc_parse_subspace_irq(int id,
  */
 static int __init acpi_pcc_probe(void)
 {
-	acpi_size pcct_tbl_header_size;
 	struct acpi_table_header *pcct_tbl;
 	struct acpi_subtable_header *pcct_entry;
 	struct acpi_table_pcct *acpi_pcct_tbl;
@@ -456,9 +455,7 @@ static int __init acpi_pcc_probe(void)
 	acpi_status status = AE_OK;
 
 	/* Search for PCCT */
-	status = acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
-			&pcct_tbl,
-			&pcct_tbl_header_size);
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
 
 	if (ACPI_FAILURE(status) || !pcct_tbl) {
 		pr_warn("PCCT header not found.\n");
-- 
1.7.10

