Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576476;
	b=qrjBXcIizwOkidYeCnur8ge9NED9sz3jHBUf5x4C79t3H1E+nLUHNCowSlBJ3egobvQq
	 OyOW0d82ZglCKM4ddOq0yqFS0c/K1HAxC4Z247LGaKNlQxyXIl8C1UrLGFJaDLiwO6I8J
	 qzylt5wnfk3JIu72Qph0WyHlpFiSDXu2a6Mx3lSMfAaeGErAZsTzgZUE4US+wv7596Bpw
	 I5hb6ABZ5aAaWXim1jFoON82AU8bVlMGHznI7EjtvA7JypHyxmqr8lbeziR3lyOwa1Oh2
	 JLSmXxOsU1bSk6jd7grUOJjvWNqtDFjn5D4bEtpRr3FjH4Mo9ZSdBN4xo7mHW4KH3fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576476;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vXiMqLho4RNuv/eY0F44Zfecir/DdxWAqcWY0anw/Ns=;
	b=RhgDt0iK/3X4fbv90LRWUTUgIz7Q06DpVmTGdwXq83LKWUjlY68tHFFzavf9VMGt8M8/
	 xKCEsttM9hb0Rmv+fxYAkDorEWPIfbskrCgwn7rAMEwF5U+epPN2i8r2otHfTkxo2WWYO
	 e/fruNvs46Ji7uoDAzo6XPHAvjKl9Ii7WAjqGMiLDZozlrJ4Gl6S0Nfd8d76r4sqc/BEK
	 BooUBlGo6FMvMhVKQTdN84iNxJwz+URLG4pLetrtLpvS7u3T5NgJkJBeKRPSDw4bdaF61
	 GvJUR+IW8M1JKTM3x+x87SrF52ltUqBT/qZwsjrpVykYoF82SOz2U98D2VWbMZu/1qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m1e2eVX2;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246B606B545;
	Fri, 13 Nov 2026 13:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E246B606B545
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m1e2eVX2
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64C9E169C;
	Fri, 13 Nov 2026 05:27:52 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31A143F85F;
	Fri, 13 Nov 2026 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576475; bh=M4YTbBeqX3PYCmq0Sod5RHrB7myumFEVylMcW6NPVcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1e2eVX2YumSflQ3b9OqjsVQUC06POJTiZNFA/giqJB3MMsJPu82aDjYWA0/sXEda
	 rBf5TelAd/SMz6/DkuijEdgTATqFhCJN+Q++7TJtXqAEBTtNzk8P0yEw1X2eAVWtFC
	 U/YUFfsAI6QNQXPHzOBLYp8snma3Pu+B+YXtKOZc=
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
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 10/12] efi/cper: Pass buffer length to memory location helpers
Date: Fri, 13 Nov 2026 14:24:52 +0100
Message-ID: <20261113132600.3355836-11-pierre.gondois@arm.com>
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
- cper_mem_err_location()
- cper_mem_err2_location()
to prevent potential buffer overflows/truncated messages.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/edac/ghes_edac.c    |  4 ++--
 drivers/firmware/efi/cper.c | 20 +++++++++-----------
 include/linux/cper.h        |  4 ++--
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 075328d1bb7d..f0ca61bddee6 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -357,7 +357,7 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 
 	len = sizeof(e->location);
 	p = e->location;
-	p += cper_mem_err_location(&cmem, p);
+	p += cper_mem_err_location(&cmem, p, len);
 
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
 		struct dimm_info *dimm;
@@ -472,7 +472,7 @@ static int ghes_edac_report_mem_error2(struct notifier_block *nb,
 	/* Memory error location, mapped on e->location */
 	len = sizeof(e->location);
 	p = e->location;
-	p += cper_mem_err2_location(mem_err, p);
+	p += cper_mem_err2_location(mem_err, p, len);
 
 	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
 		struct dimm_info *dimm = NULL;
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 0c38ff65ee0b..89ebd3cc6123 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -298,15 +298,14 @@ const char *cper_mem_err_status_str(u64 status)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_status_str);
 
-int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
+int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg, size_t len)
 {
-	u32 len, n;
+	u32 n;
 
-	if (!msg)
+	if (!msg || !len)
 		return 0;
 
 	n = 0;
-	len = CPER_REC_LEN;
 	if (mem->validation_bits & CPER_MEM_VALID_NODE)
 		n += scnprintf(msg + n, len - n, "node:%d ", mem->node);
 	if (mem->validation_bits & CPER_MEM_VALID_CARD)
@@ -419,7 +418,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
 	const char *ret = trace_seq_buffer_ptr(p);
 	char rcd_decode_str[CPER_REC_LEN];
 
-	if (cper_mem_err_location(cmem, rcd_decode_str))
+	if (cper_mem_err_location(cmem, rcd_decode_str, sizeof(rcd_decode_str)))
 		trace_seq_printf(p, "%s", rcd_decode_str);
 	if (cper_dimm_err_location(cmem, rcd_decode_str, sizeof(rcd_decode_str)))
 		trace_seq_printf(p, "%s", rcd_decode_str);
@@ -451,7 +450,7 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 		printk("%s""physical_address_mask: 0x%016llx\n",
 		       pfx, mem->physical_addr_mask);
 	cper_mem_err_pack(mem, &cmem);
-	if (cper_mem_err_location(&cmem, rcd_decode_str))
+	if (cper_mem_err_location(&cmem, rcd_decode_str, sizeof(rcd_decode_str)))
 		printk("%s%s\n", pfx, rcd_decode_str);
 	if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE) {
 		u8 etype = mem->error_type;
@@ -462,15 +461,14 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 		printk("%s%s\n", pfx, rcd_decode_str);
 }
 
-int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
+int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg, size_t len)
 {
-	u32 len, n;
+	u32 n;
 
-	if (!msg)
+	if (!msg || !len)
 		return 0;
 
 	n = 0;
-	len = CPER_REC_LEN;
 	if (mem->validation_bits & CPER_MEM2_VALID_NODE)
 		n += scnprintf(msg + n, len - n, "node:%d ", mem->node);
 	if (mem->validation_bits & CPER_MEM2_VALID_CARD)
@@ -551,7 +549,7 @@ static void cper_print_mem2(const char *pfx, const struct cper_sec_mem_err2 *mem
 	if (mem->validation_bits & CPER_MEM2_VALID_PA_MASK)
 		printk("%sphysical_address_mask: 0x%016llx\n", pfx,
 		       mem->physical_addr_mask);
-	if (cper_mem_err2_location(mem, rcd_decode_str))
+	if (cper_mem_err2_location(mem, rcd_decode_str, sizeof(rcd_decode_str)))
 		printk("%s%s\n", pfx, rcd_decode_str);
 	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_TYPE)
 		printk("%serror_type: %u, %s\n", pfx, mem->error_type,
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4338c216b1dc..db69995a43bf 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -654,10 +654,10 @@ void cper_print_proc_arm(const char *pfx,
 			 u32 length);
 void cper_print_proc_ia(const char *pfx,
 			const struct cper_sec_proc_ia *proc);
-int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
+int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg, size_t len);
 int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg, size_t len);
 
-int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg);
+int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg, size_t len);
 int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg, size_t len);
 
 struct acpi_hest_generic_status;
-- 
2.43.0

