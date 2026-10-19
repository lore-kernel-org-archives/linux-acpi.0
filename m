Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442413;
	b=Y2Bc1nty4gCeiQAbG56WC7JL38J4y4FmLHWWyCRqBaII2xYGpvAp+BA6JKL+r1sKhsyG
	 u33E6HPFWrW7G/ybOrw3srcRqioykSXsagFfHoiKgHzPcSphX1Ioj8ctVergFpbp0/Hpv
	 sWUaeNzQC//eC4aTaJtC7zHu6eVuV4F5sLpmAPUGcrC7gnoLVu9/oHFET6sqPUuwCuO6g
	 OtbDGvoCZ5qffCc/T+TF/zf5xeNrcxv01aGDidpoCcj0tLzNfywBP1C28zg/cstEle6Pe
	 p3+PyxgWeyFaH9WBanpdChSt16mdz2hPSeFANSHA0ro27X35ElgUGgFfUl70ZYNM6Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442413;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yUyRzbl96uyGBNcSQE2svcLMBol3PtxMZN2IAaqAQz0=;
	b=wzC8kOjCg2TGu6lT1UkuIekj+v5v0OFW/ayNt4Fv/tvU0fqKJpdaaZStz/bqVMFUgjn0
	 gsLhcjmdtxeoQblQ68zz9uq3FRZ9WMYJFu9fxEulllf10SaS6LOG5jHmPyZpnT4ExZM7g
	 S34YUkOgCB/JagCwUn3EHPOlj72t/05odLQ+Ta6XtR9329t+3BmrIsJW/FPF1jMtqB5V1
	 bgtGxat0e0jciNfvVgofaCVBPO3527YWsW1Xvz3zXzoAljkA6Ncoe+zE0vWPl0mq+W7MM
	 S0wYN/quDDHtyY9QxMUkwipkaDhvEa8mgH1kEtOILBXUSSs+PmcF6ZNZFE7vgqSh2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Fe+s1FL/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992360A2602;
	Mon, 19 Oct 2026 20:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3992360A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Fe+s1FL/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883B320E3;
	Mon, 19 Oct 2026 13:40:09 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.53.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E6F03F673;
	Mon, 19 Oct 2026 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792442412; bh=nIKLNWQS7nwrwdNNeYIj2PEjmlHqwm9VrgRdufHn6I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fe+s1FL/qmKzGfkojlSAWDZGvtPY+14uYppKVXBBsfVVyMM1ysbfy8t+5eZTAWgTe
	 Dv1KU766mFe8hMbOHyRp3oxbk5DnZU2pdwDEEKKDDJWA8bqfSDhwMphtv6GL+f6RwP
	 G9IP7bgSIMhIYoLpNpz6o7C8W4nAREbxWnPdLg5Y=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
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
Subject: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2 handlers
Date: Mon, 19 Oct 2026 22:38:44 +0200
Message-ID: <20261019203915.2019037-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019203915.2019037-1-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
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

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c |  49 +++++++++++++++-
 drivers/edac/ghes_edac.c | 118 +++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      |   2 +
 3 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fe10ab0e02f6..c7fb15543b56 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -101,6 +101,7 @@
 #endif
 
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+static ATOMIC_NOTIFIER_HEAD(ghes_report_mem2_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
@@ -551,6 +552,29 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
+static bool ghes_handle_memory_failure2(struct acpi_hest_generic_data *gdata,
+					int sev, bool sync)
+{
+	int flags = -1;
+	int sec_sev = ghes_severity(gdata->error_severity);
+	struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
+		return false;
+
+	/* iff following two events can be handled properly by now */
+	if (sec_sev == GHES_SEV_CORRECTED &&
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
+		flags = MF_SOFT_OFFLINE;
+	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
+		flags = sync ? MF_ACTION_REQUIRED : 0;
+
+	if (flags != -1)
+		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+
+	return false;
+}
+
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				     int sev, bool sync)
 {
@@ -915,7 +939,8 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 		return;
 	}
 
-	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) ||
+	    guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
 		hwerr_log_error_type(HWERR_RECOV_MEMORY);
 		return;
 	}
@@ -952,6 +977,16 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
+			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length < sizeof(*mem_err)) {
+				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
+				continue;
+			}
+
+			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
+			queued = ghes_handle_memory_failure2(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
@@ -1973,3 +2008,15 @@ void ghes_unregister_report_chain(struct notifier_block *nb)
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
index b90150c67f4b..01defc4e3bf1 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -390,6 +390,122 @@ static struct notifier_block ghes_edac_mem_err_nb = {
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
+	e = ghes_edac_init_error(pvt, val);
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
+		if (mem_err->mem_dev_handle <= U16_MAX)
+			dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
+		else
+			pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
+				mem_err->mem_dev_handle);
+		if (dimm) {
+			e->top_layer = dimm->idx;
+			strscpy(e->label, dimm->label);
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
@@ -494,6 +610,7 @@ static int ghes_edac_register(struct device *dev)
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	ghes_register_report_chain(&ghes_edac_mem_err_nb);
+	ghes_register_report_mem2_chain(&ghes_edac_mem_err2_nb);
 
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
@@ -537,6 +654,7 @@ static void ghes_edac_unregister(struct ghes *ghes)
 	if (mci)
 		edac_mc_free(mci);
 
+	ghes_unregister_report_mem2_chain(&ghes_edac_mem_err2_nb);
 	ghes_unregister_report_chain(&ghes_edac_mem_err_nb);
 
 unlock:
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..73d099a4ea7d 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -143,4 +143,6 @@ static inline int ghes_notify_sea(void) { return -ENOENT; }
 struct notifier_block;
 extern void ghes_register_report_chain(struct notifier_block *nb);
 extern void ghes_unregister_report_chain(struct notifier_block *nb);
+extern void ghes_register_report_mem2_chain(struct notifier_block *nb);
+extern void ghes_unregister_report_mem2_chain(struct notifier_block *nb);
 #endif /* GHES_H */
-- 
2.43.0

