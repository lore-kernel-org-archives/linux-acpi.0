Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCD3A4F33;
	Tue, 29 Sep 2026 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668116; cv=none; b=L1MtYLqOjID2FyPXeXa2aWGb2oxsdaY/taAnMBGwSmZJEWFeJU6W0wlfrGBoePJ0WpSiV+d4OyfnqJA2KveUqiOPduRE5VDzlAQQd42uM9iPS4M36pb3VAEyDzbEBa/+gv4FCqMEjjUjNnspt2WZBelE7WUGSALDprM0JrIdTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668116; c=relaxed/simple;
	bh=ZWwzNe7f+uqIX+H7OyeffBhU5yAhmeDeY/svSjV9ZMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NS5cz9vbOqL2LiSC54wfqCltMr9qrwJb6RHjxrfZGDQHBRoz/X/A9ZdLLknyPYa73Mi/sfsRHddTW9/rhPsMfQzpOFML7c0LgbZULsltnoPcrrzmsEbj7wDXqcf0StPE80oL2sOLRsdUE73MOfMKfAHkItTjOCoclm9TTBvtdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vqoeygdh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vqoeygdh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE18C1684;
	Tue, 29 Sep 2026 00:48:29 -0700 (PDT)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0240B3F85F;
	Tue, 29 Sep 2026 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790668113; bh=ZWwzNe7f+uqIX+H7OyeffBhU5yAhmeDeY/svSjV9ZMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vqoeygdhzs1Lr6Y1Xs9B4dHri39YFPXDYOfAuxTgqtJMoEIxXgSidOX63YWf26WC6
	 huqN337JBYtNT0yYgcD1Q0v7EkpCwawVuXCO4WeHVigl5laoeeKtzIeotl43st+IwB
	 n3nyBJhrPS6rcArBFpVFZ19LgR5oL4EEHAs0VCqo=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Kees Cook <kees@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH 5/6] x86/mce/apei: switch cper_sec_mem_err struct users to compact CPER records
Date: Tue, 29 Sep 2026 09:46:04 +0200
Message-ID: <20260929074659.2587216-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074659.2587216-1-pierre.gondois@arm.com>
References: <20260929074659.2587216-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the GHES, EDAC and x86 APEI memory error paths to consume
struct cper_mem_err_compact instead of raw legacy CPER memory error
sections.

This switches the users over to the common parsed representation,
allowing them to handle both legacy platform memory sections and
Memory Error Section 2 without duplicating format-specific logic.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/x86/include/asm/mce.h     |  4 +--
 arch/x86/kernel/acpi/apei.c    |  2 +-
 arch/x86/kernel/cpu/mce/apei.c |  2 +-
 drivers/acpi/acpi_extlog.c     |  9 +++---
 drivers/acpi/apei/apei-base.c  |  2 +-
 drivers/acpi/apei/ghes.c       | 20 ++++++++-----
 drivers/edac/ghes_edac.c       | 26 ++++++++---------
 drivers/firmware/efi/cper.c    | 52 +++++++++++++++++++---------------
 include/acpi/apei.h            |  2 +-
 include/ras/ras_event.h        |  4 +--
 10 files changed, 68 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index e575b702063d0..76cff0d9d0308 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -330,9 +330,9 @@ extern void (*deferred_error_int_vector)(void);
  * Used by APEI to report memory error via /dev/mcelog
  */

-struct cper_sec_mem_err;
+struct cper_mem_err_compact;
 extern void apei_mce_report_mem_error(int corrected,
-				      struct cper_sec_mem_err *mem_err);
+				      struct cper_mem_err_compact *mem_err);

 /*
  * Enumerate new IP types and HWID values in AMD processors which support
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index e21419e686eb3..7b914204b6ab4 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -39,7 +39,7 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
 	return 1;
 }

-void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
+void arch_apei_report_mem_error(int sev, struct cper_mem_err_compact *mem_err)
 {
 #ifdef CONFIG_X86_MCE
 	apei_mce_report_mem_error(sev, mem_err);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0a89947e47bc8..a46bc1325c951 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -26,7 +26,7 @@

 #include "internal.h"

-void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
+void apei_mce_report_mem_error(int severity, struct cper_mem_err_compact *mem_err)
 {
 	struct mce_hw_err err;
 	struct mce *m;
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 699534b6a732d..6f1f1b8ecf924 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -181,7 +181,7 @@ extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 }

 static void
-extlog_mem_err_event(struct cper_sec_mem_err *mem, u32 err_seq,
+extlog_mem_err_event(struct cper_mem_err_compact *mem, u32 err_seq,
 		     const guid_t *fru_id, const char *fru_text, u8 sev)
 {
 #if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
@@ -234,10 +234,11 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		else
 			fru_text = "";
 		sec_type = (guid_t *)gdata->section_type;
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
+		if (cper_sec_is_platform_mem(sec_type)) {
+			struct cper_mem_err_compact mem;

-			if (gdata->error_data_length >= sizeof(*mem))
+			if (!cper_mem_err_parse(sec_type, acpi_hest_get_payload(gdata),
+						gdata->error_data_length, &mem))
 				extlog_mem_err_event(&mem, err_seq, fru_id,
 						     fru_text,
 						     (u8)gdata->error_severity);
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 7a06d30bd40e9..c2b731054f329 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -768,7 +768,7 @@ int __weak arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr,
 EXPORT_SYMBOL_GPL(arch_apei_enable_cmcff);

 void __weak arch_apei_report_mem_error(int sev,
-				       struct cper_sec_mem_err *mem_err)
+				       struct cper_mem_err_compact *mem_err)
 {
 }
 EXPORT_SYMBOL_GPL(arch_apei_report_mem_error);
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fe10ab0e02f68..b0368e55856ef 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -529,11 +529,11 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }

 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				       struct cper_mem_err_compact *mem_err,
 				       int sev, bool sync)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);

 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return false;
@@ -915,7 +915,7 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 		return;
 	}

-	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+	if (cper_sec_is_platform_mem(sec_type)) {
 		hwerr_log_error_type(HWERR_RECOV_MEMORY);
 		return;
 	}
@@ -945,13 +945,19 @@ static void ghes_do_proc(struct ghes *ghes,
 			fru_text = gdata->fru_text;

 		ghes_log_hwerr(sev, sec_type);
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+		if (cper_sec_is_platform_mem(sec_type)) {
+			struct cper_mem_err_compact mem_err;

-			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
+			if (cper_mem_err_parse(sec_type, acpi_hest_get_payload(gdata),
+					       gdata->error_data_length, &mem_err)) {
+				pr_warn(FW_WARN "memory error section length is too small\n");
+				continue;
+			}

-			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
+			atomic_notifier_call_chain(&ghes_report_chain, sev, &mem_err);
+
+			arch_apei_report_mem_error(sev, &mem_err);
+			queued = ghes_handle_memory_failure(gdata, &mem_err, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d80c88818691c..ae4c92463e305 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -242,7 +242,7 @@ static void ghes_scan_system(void)
 	system_scanned = true;
 }

-static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char *msg,
+static int print_mem_error_other_detail(struct cper_mem_err_compact *mem, char *msg,
 					const char *location, unsigned int len)
 {
 	u32 n;
@@ -255,13 +255,15 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char

 	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);

-	if (!(mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS))
-		goto out;
-
-	n += scnprintf(msg + n, len - n, "status(0x%016llx): ", mem->error_status);
-	n += scnprintf(msg + n, len - n, "%s ", cper_mem_err_status_str(mem->error_status));
+	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
+		n += scnprintf(msg + n, len - n, "status(0x%016llx): ", mem->error_status);
+		n += scnprintf(msg + n, len - n, "%s ",
+			       cper_mem_err_status_str(mem->error_status));
+	}
+	if (mem->validation_bits & CPER_MEM_VALID_STATUS)
+		n += scnprintf(msg + n, len - n, "section_status:0x%02x ",
+			       mem->status);

-out:
 	msg[n] = '\0';

 	return n;
@@ -270,8 +272,7 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char
 static int ghes_edac_report_mem_error(struct notifier_block *nb,
 				      unsigned long val, void *data)
 {
-	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
-	struct cper_mem_err_compact cmem;
+	struct cper_mem_err_compact *mem_err = data;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
 	unsigned long sev = val;
@@ -348,14 +349,13 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,

 	/* Memory error location, mapped on e->location */
 	p = e->location;
-	cper_mem_err_pack(mem_err, &cmem);
-	p += cper_mem_err_location(&cmem, p);
+	p += cper_mem_err_location(mem_err, p);

 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		struct dimm_info *dimm;

-		p += cper_dimm_err_location(&cmem, p);
-		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+		p += cper_dimm_err_location(mem_err, p);
+		dimm = find_dimm_by_handle(mci, (u16)mem_err->mem_dev_handle);
 		if (dimm) {
 			e->top_layer = dimm->idx;
 			strscpy(e->label, dimm->label);
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index cfcd01e3f47bf..e0ba2ca498e75 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -555,36 +555,41 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
 	return ret;
 }

-static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
-	int len)
+static void cper_print_mem(const char *pfx, const guid_t *sec_type,
+			   const void *mem, int len)
 {
 	struct cper_mem_err_compact cmem;
 	char rcd_decode_str[CPER_REC_LEN];

 	/* Don't trust UEFI 2.1/2.2 structure with bad validation bits */
-	if (len == sizeof(struct cper_sec_mem_err_old) &&
-	    (mem->validation_bits & ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) &&
+	    len == sizeof(struct cper_sec_mem_err_old) &&
+	    (((const struct cper_sec_mem_err_old *)mem)->validation_bits &
+	     ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
 		pr_err(FW_WARN "valid bits set for fields beyond structure\n");
 		return;
 	}
-	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
+
+	if (cper_mem_err_parse(sec_type, mem, len, &cmem))
+		return;
+
+	if (cmem.validation_bits & CPER_MEM_VALID_ERROR_STATUS)
 		printk("%s error_status: %s (0x%016llx)\n",
-		       pfx, cper_mem_err_status_str(mem->error_status),
-		       mem->error_status);
-	if (mem->validation_bits & CPER_MEM_VALID_PA)
+		       pfx, cper_mem_err_status_str(cmem.error_status),
+		       cmem.error_status);
+	if (cmem.validation_bits & CPER_MEM_VALID_PA)
 		printk("%s""physical_address: 0x%016llx\n",
-		       pfx, mem->physical_addr);
-	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
+		       pfx, cmem.physical_addr);
+	if (cmem.validation_bits & CPER_MEM_VALID_PA_MASK)
 		printk("%s""physical_address_mask: 0x%016llx\n",
-		       pfx, mem->physical_addr_mask);
-	cper_mem_err_pack(mem, &cmem);
+		       pfx, cmem.physical_addr_mask);
 	if (cper_mem_err_location(&cmem, rcd_decode_str))
 		printk("%s%s\n", pfx, rcd_decode_str);
-	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
-		u8 etype = mem->error_type;
-		printk("%s""error_type: %d, %s\n", pfx, etype,
-		       cper_mem_err_type_str(etype));
-	}
+	if (cmem.validation_bits & CPER_MEM_VALID_ERROR_TYPE)
+		printk("%s""error_type: %d, %s\n", pfx, cmem.error_type,
+		       cper_mem_err_type_str(cmem.error_type));
+	if (cmem.validation_bits & CPER_MEM_VALID_STATUS)
+		printk("%s""status: 0x%02x\n", pfx, cmem.status);
 	if (cper_dimm_err_location(&cmem, rcd_decode_str))
 		printk("%s%s\n", pfx, rcd_decode_str);
 }
@@ -784,13 +789,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_proc_generic(newpfx, proc_err);
 		else
 			goto err_section_too_small;
-	} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-		struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
+	} else if (cper_sec_is_platform_mem(sec_type)) {
 		printk("%s""section_type: memory error\n", newpfx);
-		if (gdata->error_data_length >=
-		    sizeof(struct cper_sec_mem_err_old))
-			cper_print_mem(newpfx, mem_err,
+		if ((guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) &&
+		     gdata->error_data_length >= sizeof(struct cper_sec_mem_err_old)) ||
+		    (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2) &&
+		     gdata->error_data_length >= sizeof(struct cper_sec_mem_err2)))
+			cper_print_mem(newpfx, sec_type,
+				       acpi_hest_get_payload(gdata),
 				       gdata->error_data_length);
 		else
 			goto err_section_too_small;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524f..5aabf92bd867d 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -51,7 +51,7 @@ ssize_t erst_read_record(u64 record_id, struct cper_record_header *record,
 int erst_clear(u64 record_id);

 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
-void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+void arch_apei_report_mem_error(int sev, struct cper_mem_err_compact *mem_err);

 #endif
 #endif
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index fdb785fa4613a..921089912fbfb 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -24,7 +24,7 @@

 #if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
 TRACE_EVENT(extlog_mem_event,
-	TP_PROTO(struct cper_sec_mem_err *mem,
+	TP_PROTO(struct cper_mem_err_compact *mem,
 		 u32 err_seq,
 		 const guid_t *fru_id,
 		 const char *fru_text,
@@ -61,7 +61,7 @@ TRACE_EVENT(extlog_mem_event,
 			__entry->pa_mask_lsb = ~0;
 		__entry->fru_id = *fru_id;
 		__assign_str(fru_text);
-		cper_mem_err_pack(mem, &__entry->data);
+		__entry->data = *mem;
 	),

 	TP_printk("{%d} %s error: %s physical addr: %016llx (mask lsb: %x) %sFRU: %pUl %.20s",
--
2.43.0
