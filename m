Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576467;
	b=kysuJXgtPphtKqEmDQendFnznxEAoanwoIXCC8GyERvj+7stAJZbPpCfDpfKLuJm8TvI
	 6HxlWViXq2o+FIQmpWMeIXeApSmswwsMCUXezpp1Qj6Auj7FGFUlHa0JBPIrhkfhsvReE
	 3t2KfdoeCAw5W7s0kESC8B5v5Ua+fStufaorvEB2lwNp0TZZUFDbCfJN7CNx1DBiVeY7y
	 sFVk6wdDKHsZNODr+zQSinARf/pU4DjhaN76qXU11mlr2MATg9Zf/0QMo0WrRBZy6N9Hr
	 JChuZcws/8DIScpl9DIS5tg1mLgajzz6TINwcKQJ7+t+U6QcMqgTyR6eTpllVyfWGkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576467;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J4NubqrM6nzzchObresGL1cXHe1JRNdDiotHUUSc+V8=;
	b=KjGFCqXqCGrsUjUyuTjPS60E1McbAc2wXLkUVjDGwygLYwbwf31bfu5bOh74H6OPbk6I
	 ewHKABXH0WD6vDA+vTpDO65eOE6SNj71GKhzGU1NiKb3ktnhFJTscKEHKsCB93lBqYXZ5
	 J0wx34X67mzr+7alGrrb5jgslSwXOoeAHTantyh6m4QGnFeFDaD1qyvLJasnwIS8y3gZ5
	 Dekm+SNOyPLTSlXi1VaE6wbl7/BhwFlFtyw3Sc0OuzPiUxigwpaREaVrQsLlqKi6we/Pk
	 RDzcECxE130WFzZTlD6BbFod4BwGkg1YC61egZP3wcaDj4x+b2sJiEypL2LBot5wIlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="oLQefZ/9";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EA606B540;
	Fri, 13 Nov 2026 13:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18EA606B540
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oLQefZ/9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4349D1650;
	Fri, 13 Nov 2026 05:27:42 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BF823F85F;
	Fri, 13 Nov 2026 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576465; bh=SC8j2qYgiQ7K+xU7rysDMm0EtcEp7qJZLDeKfYZxITA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLQefZ/9t+gsyuZWN3xhwAqLAwmI6Hj/uu4SuGO5N8/gA7foXIZHNj0QBHUpkb1ib
	 3MODptfp9esW/JvNoUodXZQRKKYe0gpYhcA/xy+tFlt1MHyau0SXPmNynPiqbpXfVi
	 yV0gQ55lA3Sec40synyDwBxyfED4jkZcsq6viYxA=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
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
Subject: [PATCH v4 09/12] efi/cper: Pass buffer length to DIMM location helpers
Date: Fri, 13 Nov 2026 14:24:51 +0100
Message-ID: <20261113132600.3355836-10-pierre.gondois@arm.com>
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

Add a length parameter to:
- cper_dimm_err_location()
- cper_dimm_err2_location()
to prevent potential buffer overflows/truncated messages.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/edac/ghes_edac.c    | 15 ++++++++++-----
 drivers/firmware/efi/cper.c | 20 +++++++++-----------
 include/linux/cper.h        |  4 ++--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 1a963e554ff8..075328d1bb7d 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -308,6 +308,7 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
 	struct ghes_pvt *pvt;
+	size_t len;
 	char *p;
 
 	/*
@@ -352,21 +353,23 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 		e->grain = ~mem_err->physical_addr_mask + 1;
 
 	/* Memory error location, mapped on e->location */
-	p = e->location;
 	cper_mem_err_pack(mem_err, &cmem);
+
+	len = sizeof(e->location);
+	p = e->location;
 	p += cper_mem_err_location(&cmem, p);
 
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		struct dimm_info *dimm;
 
-		p += cper_dimm_err_location(&cmem, p);
+		p += cper_dimm_err_location(&cmem, p, len - (p - e->location));
 		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
 		if (dimm) {
 			e->top_layer = dimm->idx;
 			strscpy(e->label, dimm->label);
 		}
 	}
-	if (p > e->location)
+	if (p > e->location && p[-1] == ' ')
 		*(p - 1) = '\0';
 
 	if (!*e->label)
@@ -422,6 +425,7 @@ static int ghes_edac_report_mem_error2(struct notifier_block *nb,
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
 	struct ghes_pvt *pvt;
+	size_t len;
 	char *p;
 
 	/*
@@ -466,13 +470,14 @@ static int ghes_edac_report_mem_error2(struct notifier_block *nb,
 		e->grain = ~mem_err->physical_addr_mask + 1;
 
 	/* Memory error location, mapped on e->location */
+	len = sizeof(e->location);
 	p = e->location;
 	p += cper_mem_err2_location(mem_err, p);
 
 	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
 		struct dimm_info *dimm = NULL;
 
-		p += cper_dimm_err2_location(mem_err, p);
+		p += cper_dimm_err2_location(mem_err, p, len - (p - e->location));
 		if (mem_err->mem_dev_handle <= U16_MAX) {
 			dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
 			if (dimm) {
@@ -481,7 +486,7 @@ static int ghes_edac_report_mem_error2(struct notifier_block *nb,
 			}
 		}
 	}
-	if (p > e->location)
+	if (p > e->location && p[-1] == ' ')
 		*(p - 1) = '\0';
 
 	if (!*e->label)
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index d8587141f8b2..0c38ff65ee0b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -353,15 +353,14 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_location);
 
-int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg, size_t len)
 {
-	u32 len, n;
+	u32 n;
 	const char *bank = NULL, *device = NULL;
 
-	if (!msg || !(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
+	if (!msg || !len || !(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
 		return 0;
 
-	len = CPER_REC_LEN;
 	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
 	if (bank && device)
 		n = scnprintf(msg, len, "DIMM location: %s %s ", bank, device);
@@ -422,7 +421,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
 
 	if (cper_mem_err_location(cmem, rcd_decode_str))
 		trace_seq_printf(p, "%s", rcd_decode_str);
-	if (cper_dimm_err_location(cmem, rcd_decode_str))
+	if (cper_dimm_err_location(cmem, rcd_decode_str, sizeof(rcd_decode_str)))
 		trace_seq_printf(p, "%s", rcd_decode_str);
 	trace_seq_putc(p, '\0');
 
@@ -459,7 +458,7 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 		printk("%s""error_type: %d, %s\n", pfx, etype,
 		       cper_mem_err_type_str(etype));
 	}
-	if (cper_dimm_err_location(&cmem, rcd_decode_str))
+	if (cper_dimm_err_location(&cmem, rcd_decode_str, sizeof(rcd_decode_str)))
 		printk("%s%s\n", pfx, rcd_decode_str);
 }
 
@@ -514,12 +513,12 @@ int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err2_location);
 
-int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
+int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg, size_t len)
 {
-	u32 len, n;
+	u32 n;
 	const char *bank = NULL, *device = NULL;
 
-	if (!msg || !(mem->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE))
+	if (!msg || !len || !(mem->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE))
 		return 0;
 
 	/* SMBIOS handles are 16 bits; never truncate a Section 2 handle. */
@@ -529,7 +528,6 @@ int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
 		pr_warn_ratelimited(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
 			mem->mem_dev_handle);
 
-	len = CPER_REC_LEN;
 	if (bank && device)
 		n = scnprintf(msg, len, "DIMM location: %s %s ", bank, device);
 	else
@@ -560,7 +558,7 @@ static void cper_print_mem2(const char *pfx, const struct cper_sec_mem_err2 *mem
 		       cper_mem_err_type_str(mem->error_type));
 	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
 		printk("%sstatus: 0x%02x\n", pfx, mem->status);
-	if (cper_dimm_err2_location(mem, rcd_decode_str))
+	if (cper_dimm_err2_location(mem, rcd_decode_str, sizeof(rcd_decode_str)))
 		printk("%s%s\n", pfx, rcd_decode_str);
 }
 
diff --git a/include/linux/cper.h b/include/linux/cper.h
index afbfb4e77f29..4338c216b1dc 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -655,10 +655,10 @@ void cper_print_proc_arm(const char *pfx,
 void cper_print_proc_ia(const char *pfx,
 			const struct cper_sec_proc_ia *proc);
 int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
-int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
+int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg, size_t len);
 
 int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg);
-int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg);
+int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg, size_t len);
 
 struct acpi_hest_generic_status;
 void cper_estatus_print(const char *pfx,
-- 
2.43.0

