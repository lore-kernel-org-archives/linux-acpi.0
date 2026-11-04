Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790322;
	b=l37kwtxgXD3Gs+ORPB+VSI1RZQ62gf9z1Wj83hisbpydFCE3ReHHm3AJL1rLWFMpYxAN
	 tbv4/AmcFn1d2S2F5sbY3xjIgxgKD93B5bJN8lNW47LXedRMmQzDH2Tj7a4dKYnlJSlia
	 emgOCybMgf1EGMKYZ1cImlLTiM3ye6Qxwzv2kRmSVDAy//5WPnrcjGeSnC1qBp1ouW7BQ
	 oY9dOahHsXv54oxvMZrQUWi91QyoGooeWPH2Zz7RKKqc0mMu6GMlxb/7TZ7l3EVSqVS52
	 oEL4digmoYW9oKk3mfREGzl+EpIfpT/4Y93umwj0WaxEYPfMNYAETl67r3+Sw2G2Sqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790322;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n2CVVez4EHqUSTFlzZyWHRieB1i699ErjEhVYhhbzJk=;
	b=ezjuaLsNiHcfHzPzLFIqBLh1MUlgEOepAZ+qQVmAx/ANroB1mRYcqzk06GL7IpOA7qcp
	 ybkrsnfz7VkM7bo+2MxDde20FH+F+63bEk93sRiMq0wAQVgLyq3KNqkDifXsj/sUdSpe1
	 zyfPAmftoz+BRzcxkYjkMIJBIyJepEymhjbBDHUhoWtaS7mfgzeyXgzPsvfsUnETDrqe8
	 hZixDTlf+0eoxU5PutQQDcSM1l8EcObtCYacV4oLhw3amvcBU8/SdDEkwxHUF6+V1aKX/
	 TGzcuLkboChP4MWILOBqUPDZYp4c0cvrwNlc83+FhgtEADBThzDs2S7w3OtNQl09Hww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="mqtCh0/y";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B1606A326;
	Wed,  4 Nov 2026 11:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 092B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mqtCh0/y
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ED0722EE;
	Wed,  4 Nov 2026 03:05:18 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.64.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A038A3F632;
	Wed,  4 Nov 2026 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793790321; bh=z4/JtwoKnS2YEULGo8xS6qGVXvyr5xk8ArsItYnndwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqtCh0/yUx4ZVFEZgya7OmVgO/lh3YnsX/sirn5RMgHbVtj62AnQEqyp/vzNFeSZs
	 7SH/P6S/9LPaohDOhGeNdYXu/X/3hytISYo6T+luvDtBT4v6KMcUtAwWU432ORG81s
	 ratFg0cyl8UnCTKtLbNJ7wceDNN5K4Lh4T/kihIM=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 6/7] ACPI: APEI: add separate Memory Error Section 2 handlers
Date: Wed,  4 Nov 2026 12:03:14 +0100
Message-ID: <20261104110355.1437249-7-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104110355.1437249-1-pierre.gondois@arm.com>
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
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
 drivers/acpi/apei/ghes.c |  37 +++++++++++-
 drivers/edac/ghes_edac.c | 119 +++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      |   2 +
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d6bbee466b48..ae1990429e12 100644
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
+				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
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
index f1cf4d640d68..dfa8276884f6 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -388,6 +388,123 @@ static struct notifier_block ghes_edac_mem_err_nb = {
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
@@ -492,6 +609,7 @@ static int ghes_edac_register(struct device *dev)
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	ghes_register_report_chain(&ghes_edac_mem_err_nb);
+	ghes_register_report_mem2_chain(&ghes_edac_mem_err2_nb);
 
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
@@ -535,6 +653,7 @@ static void ghes_edac_unregister(struct ghes *ghes)
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

