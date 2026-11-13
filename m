Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576446;
	b=HXMLdfd5z/eRK+VasCDP0pF/PUlKlM5w8xgnTk1kMYv0d5equcPys5S2sMjSlTaXcKi4
	 OmWaFF0HFn0UZrAfAvPUsqm0raXDMUX5S10lh7XI1LzcWXAV2v00gKAP6++qF66qm2vlv
	 2xBUuestgAYar7Lc8DWwBFp9JHDrsvgxhON19CxWr6Ctb0eTSzUfB0NKFjAkX6oPMv9ta
	 cyX/ODQ2+WyZj7Fnu+GajqycO+vLo5ttuOb19++TdpniEzDyrSNyq1YhIlvxP8A09NRCY
	 fFhfLHwxyiIEdZRq4s0PaIK1/TNER+erMIvNH0Q9ooI+2M5rB6+6BysesytSbXcPENw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nbmt5CQwND8GIaONTHLvCR1pB2KXdJdMEq7yuXtyM04=;
	b=kjul2O9CIryjJiRv/oU5/SgT/i9g3kAf/SQukeLV0hUQ1jMx7YhX3DxQRvo4fjeGcXtC
	 c5boOAFoLQk3twObYWRBNCPZW7vs1Qql5O4tAaVz8fjoJdLcJwG/x+X+Sn8mauezJBeod
	 5Ivte4Gfjr19qVUSwox+bEXaRgzIhHA8kNHtzTAc9Wq7d3ABCl3ioN4I2YlmfOz2TocZw
	 3oX6X8enQrzc5WB0521WFU8Y+VJX+Q4/xKUapSyaH+NqKJvt12fQFei0fV6G2QMpt2pjK
	 auXohSPB1+ptvEwVDOkCb2s1p4vZ2Sw6nqz/x4tsY1VLyslCuZxR83VDD/em2m8h3CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NkOuoaLK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A89606ABBC;
	Fri, 13 Nov 2026 13:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A89606ABBC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NkOuoaLK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FA3E1576;
	Fri, 13 Nov 2026 05:27:22 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1161B3F85F;
	Fri, 13 Nov 2026 05:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576445; bh=Z4DXyZSW7RvIweBvhgNaqggon5LdlcRAVZhHqGZ9f4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkOuoaLK+UV/0Fz1jz+AaW4FmjAYEplX1yM2YLUhj2IJijClmVA/0R4uU482YbIQl
	 B/0ZUAynO9vKjkDBWYfECi8dHRZS4jGkq/UpN/5nmEBn4mqp4YoqF2aRpoH9wKflTa
	 qF12y2Db04CUapwaYjize7XRuPrwaSi/1eG4G3aY=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 07/12] ACPI: APEI: add separate Memory Error Section 2 handlers
Date: Fri, 13 Nov 2026 14:24:49 +0100
Message-ID: <20261113132600.3355836-8-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113132600.3355836-1-pierre.gondois@arm.com>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated GHES and EDAC callbacks for Memory Error Section 2
records. Use a separate GHES notifier chain so existing consumers
continue to receive legacy memory error sections.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c |  37 ++++++++++++-
 drivers/edac/ghes_edac.c | 117 +++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      |   2 +
 3 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d6bbee466b48..07306af5a54b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -101,6 +101,7 @@
 #endif
 
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+static ATOMIC_NOTIFIER_HEAD(ghes_report_mem2_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
@@ -558,6 +559,17 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return ghes_handle_memory_failure_common(gdata, sev, sync, mem_err->physical_addr);
 }
 
+static bool ghes_handle_memory_failure2(struct acpi_hest_generic_data *gdata,
+					int sev, bool sync)
+{
+	struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
+		return false;
+
+	return ghes_handle_memory_failure_common(gdata, sev, sync, mem_err->physical_addr);
+}
+
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				     int sev, bool sync)
 {
@@ -930,7 +942,8 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 		return;
 	}
 
-	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) ||
+	    guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
 		hwerr_log_error_type(HWERR_RECOV_MEMORY);
 		return;
 	}
@@ -1008,6 +1021,16 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued |= ghes_handle_memory_failure(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
+			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length < sizeof(*mem_err)) {
+				pr_warn_ratelimited(FW_WARN GHES_PFX "Memory Error Section 2 length is too small\n");
+				continue;
+			}
+
+			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
+			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
@@ -2033,3 +2056,15 @@ void ghes_unregister_report_chain(struct notifier_block *nb)
 	atomic_notifier_chain_unregister(&ghes_report_chain, nb);
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_report_chain);
+
+void ghes_register_report_mem2_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_register(&ghes_report_mem2_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_register_report_mem2_chain);
+
+void ghes_unregister_report_mem2_chain(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&ghes_report_mem2_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_report_mem2_chain);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index f1cf4d640d68..1a963e554ff8 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -388,6 +388,121 @@ static struct notifier_block ghes_edac_mem_err_nb = {
 	.priority	= 0,
 };
 
+static int print_mem_error2_other_detail(const struct cper_sec_mem_err2 *mem, char *msg,
+					 const char *location, unsigned int len)
+{
+	u32 n;
+
+	if (!msg)
+		return 0;
+
+	n = 0;
+	len -= 1;
+
+	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);
+
+	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_STATUS) {
+		n += scnprintf(msg + n, len - n, "status(0x%016llx): ", mem->error_status);
+		n += scnprintf(msg + n, len - n, "%s ",
+			       cper_mem_err_status_str(mem->error_status));
+	}
+	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
+		n += scnprintf(msg + n, len - n, "section_status:0x%02x ",
+			       mem->status);
+
+	msg[n] = '\0';
+
+	return n;
+}
+
+static int ghes_edac_report_mem_error2(struct notifier_block *nb,
+				       unsigned long val, void *data)
+{
+	struct cper_sec_mem_err2 *mem_err = data;
+	struct edac_raw_error_desc *e;
+	struct mem_ctl_info *mci;
+	struct ghes_pvt *pvt;
+	char *p;
+
+	/*
+	 * We can do the locking below because GHES defers error processing
+	 * from NMI to IRQ context. Whenever that changes, we'd at least
+	 * know.
+	 */
+	if (WARN_ON_ONCE(in_nmi()))
+		return NOTIFY_OK;
+
+	guard(spinlock_irqsave)(&ghes_lock);
+
+	pvt = ghes_pvt;
+	if (!pvt)
+		return NOTIFY_OK;
+
+	mci = pvt->mci;
+	e = &mci->error_desc;
+	ghes_edac_init_error_desc(e, val, pvt->msg, pvt->other_detail);
+
+	edac_dbg(1, "error validation_bits: 0x%08llx\n",
+		 (long long)mem_err->validation_bits);
+
+	/* Error type, mapped on e->msg */
+	if (mem_err->validation_bits & CPER_MEM2_VALID_ERROR_TYPE) {
+		u8 etype = mem_err->error_type;
+
+		p = pvt->msg;
+		p += snprintf(p, sizeof(pvt->msg), "%s", cper_mem_err_type_str(etype));
+	} else {
+		strscpy(pvt->msg, "unknown error");
+	}
+
+	/* Error address */
+	if (mem_err->validation_bits & CPER_MEM2_VALID_PA) {
+		e->page_frame_number = PHYS_PFN(mem_err->physical_addr);
+		e->offset_in_page = offset_in_page(mem_err->physical_addr);
+	}
+
+	/* Error grain */
+	if (mem_err->validation_bits & CPER_MEM2_VALID_PA_MASK)
+		e->grain = ~mem_err->physical_addr_mask + 1;
+
+	/* Memory error location, mapped on e->location */
+	p = e->location;
+	p += cper_mem_err2_location(mem_err, p);
+
+	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
+		struct dimm_info *dimm = NULL;
+
+		p += cper_dimm_err2_location(mem_err, p);
+		if (mem_err->mem_dev_handle <= U16_MAX) {
+			dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+			if (dimm) {
+				e->top_layer = dimm->idx;
+				strscpy(e->label, dimm->label);
+			}
+		}
+	}
+	if (p > e->location)
+		*(p - 1) = '\0';
+
+	if (!*e->label)
+		strscpy(e->label, "unknown memory");
+
+	/* All other fields are mapped on e->other_detail */
+	p = pvt->other_detail;
+	p += print_mem_error2_other_detail(mem_err, p, e->location, OTHER_DETAIL_LEN);
+	if (p > pvt->other_detail)
+		*(p - 1) = '\0';
+
+	edac_raw_mc_handle_error(e);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ghes_edac_mem_err2_nb = {
+	.notifier_call	= ghes_edac_report_mem_error2,
+	.priority	= 0,
+};
+
 static int ghes_edac_register(struct device *dev)
 {
 	bool fake = false;
@@ -492,6 +607,7 @@ static int ghes_edac_register(struct device *dev)
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	ghes_register_report_chain(&ghes_edac_mem_err_nb);
+	ghes_register_report_mem2_chain(&ghes_edac_mem_err2_nb);
 
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
@@ -535,6 +651,7 @@ static void ghes_edac_unregister(struct ghes *ghes)
 	if (mci)
 		edac_mc_free(mci);
 
+	ghes_unregister_report_mem2_chain(&ghes_edac_mem_err2_nb);
 	ghes_unregister_report_chain(&ghes_edac_mem_err_nb);
 
 unlock:
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 7acf209061ea..3fdb7ea59f9c 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -147,4 +147,6 @@ static inline int ghes_notify_sea(void) { return -ENOENT; }
 struct notifier_block;
 extern void ghes_register_report_chain(struct notifier_block *nb);
 extern void ghes_unregister_report_chain(struct notifier_block *nb);
+extern void ghes_register_report_mem2_chain(struct notifier_block *nb);
+extern void ghes_unregister_report_mem2_chain(struct notifier_block *nb);
 #endif /* GHES_H */
-- 
2.43.0

