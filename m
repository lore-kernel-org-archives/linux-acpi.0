Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579EA388899;
	Tue, 29 Sep 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668103; cv=none; b=ow6hqPBVBkco6+qiPDObQ6f7OaPb9xCQkOtlpaqIdRCjjtf57MUb0OjkkwjFxJTSUUO8YuxbSzs5ozJD1JCyZF+h+5NOne0oa7HP1E4y9mtgdWqyDFKG/NfKMGk96772RSXU0b2K3oc8oYYptJnT93/SJDyAHM014Rr8j7LQvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668103; c=relaxed/simple;
	bh=vFhISTpXi6uAjuoqrvgRe3vns/Fa3qEIx2JdYjXZe1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWrcVBZ62QmIBxJR7sHxDAh2zBcUWECgTQs0+gPeF1j0LpqArGCqyxe4AO6gYrJt8MEXxSk3bBMOMKOuje0Wz+DM+tVviizIFmPU5FjED+RutxWxVd7J30yheyMQV0n8/6O0ZBGnHJ8YYsGjMnPaEhcnyzQxlBltjRVCrbh21mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F4SCDeRk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F4SCDeRk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6687D1655;
	Tue, 29 Sep 2026 00:48:17 -0700 (PDT)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 533EF3FA1F;
	Tue, 29 Sep 2026 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790668100; bh=vFhISTpXi6uAjuoqrvgRe3vns/Fa3qEIx2JdYjXZe1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4SCDeRkcnaSVbKVE1Ti0Y7W3iba/N5DZbUNkF3yW7kGmFPrgsGYQoGTBbPmvGNra
	 8XrHuoJspjDpJW11zC1URSJy4nK68X3drOkLDSmqbwXgRxDwm3jgu5GIfZyhFtFF0Q
	 nmM0hw8OX9TQzAWuGV0+VQB/67zNraTFuI/m0n2Y=
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
Subject: [RFC PATCH 4/6] cper: add helpers to handle Memory Error Section 2
Date: Tue, 29 Sep 2026 09:46:03 +0200
Message-ID: <20260929074659.2587216-5-pierre.gondois@arm.com>
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

Add helpers to parse Memory Error Section 2 CPER records.
Memory Error Section (1)/2 can be parsed indistinctly into a
cper_mem_err_compact struct.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/efi/cper.c | 141 ++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |   4 +
 2 files changed, 145 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 6285b67e8fcd9..cfcd01e3f47bf 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -370,6 +370,28 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 }
 EXPORT_SYMBOL_GPL(cper_dimm_err_location);

+static void cper_mem_err_old_pack(const struct cper_sec_mem_err_old *mem,
+				  struct cper_mem_err_compact *cmem)
+{
+	memset(cmem, 0, sizeof(*cmem));
+	cmem->validation_bits = mem->validation_bits;
+	cmem->node = mem->node;
+	cmem->card = mem->card;
+	cmem->module = mem->module;
+	cmem->bank = mem->bank;
+	cmem->device = mem->device;
+	cmem->row = mem->row;
+	cmem->column = mem->column;
+	cmem->bit_pos = mem->bit_pos;
+	cmem->requestor_id = mem->requestor_id;
+	cmem->responder_id = mem->responder_id;
+	cmem->target_id = mem->target_id;
+	cmem->error_status = mem->error_status;
+	cmem->physical_addr = mem->physical_addr;
+	cmem->physical_addr_mask = mem->physical_addr_mask;
+	cmem->error_type = mem->error_type;
+}
+
 void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 		       struct cper_mem_err_compact *cmem)
 {
@@ -399,6 +421,125 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_pack);

+static void cper_mem_err2_pack(const struct cper_sec_mem_err2 *mem,
+			       struct cper_mem_err_compact *cmem)
+{
+	u64 valid = mem->validation_bits;
+
+	memset(cmem, 0, sizeof(*cmem));
+	/*
+	 * Memory Error Section 2 uses different validation bit assignments
+	 * from the legacy section starting at bit 10.  Translate them to the
+	 * assignments used by struct cper_mem_err_compact and its consumers.
+	 */
+	cmem->validation_bits = valid & GENMASK_ULL(9, 0);
+	if (valid & BIT_ULL(10))
+		cmem->validation_bits |= CPER_MEM_VALID_RANK_NUMBER;
+	if (valid & BIT_ULL(11))
+		cmem->validation_bits |= CPER_MEM_VALID_BIT_POSITION;
+	if (valid & BIT_ULL(12))
+		cmem->validation_bits |= CPER_MEM_VALID_CHIP_ID;
+	if (valid & BIT_ULL(13))
+		cmem->validation_bits |= CPER_MEM_VALID_ERROR_TYPE;
+	if (valid & BIT_ULL(14))
+		cmem->validation_bits |= CPER_MEM_VALID_STATUS;
+	if (valid & BIT_ULL(15))
+		cmem->validation_bits |= CPER_MEM_VALID_REQUESTOR_ID;
+	if (valid & BIT_ULL(16))
+		cmem->validation_bits |= CPER_MEM_VALID_RESPONDER_ID;
+	if (valid & BIT_ULL(17))
+		cmem->validation_bits |= CPER_MEM_VALID_TARGET_ID;
+	if (valid & BIT_ULL(18))
+		cmem->validation_bits |= CPER_MEM_VALID_CARD_HANDLE;
+	if (valid & BIT_ULL(19))
+		cmem->validation_bits |= CPER_MEM_VALID_MODULE_HANDLE;
+	if (valid & BIT_ULL(20))
+		cmem->validation_bits |= CPER_MEM_VALID_BANK_GROUP;
+	if (valid & BIT_ULL(21))
+		cmem->validation_bits |= CPER_MEM_VALID_BANK_ADDRESS;
+	cmem->node = mem->node;
+	cmem->card = mem->card;
+	cmem->module = mem->module;
+	cmem->bank = mem->bank;
+	cmem->device = mem->device;
+	cmem->row = mem->row;
+	cmem->column = mem->column;
+	cmem->bit_pos = mem->bit_pos;
+	cmem->requestor_id = mem->requestor_id;
+	cmem->responder_id = mem->responder_id;
+	cmem->target_id = mem->target_id;
+	cmem->rank = mem->rank;
+	cmem->mem_array_handle = mem->mem_array_handle;
+	cmem->mem_dev_handle = mem->mem_dev_handle;
+	cmem->error_status = mem->error_status;
+	cmem->physical_addr = mem->physical_addr;
+	cmem->physical_addr_mask = mem->physical_addr_mask;
+	cmem->chip_id = mem->chip_id;
+	cmem->status = mem->status;
+	cmem->error_type = mem->error_type;
+	cmem->is_section2 = 1;
+
+	if ((cmem->validation_bits & CPER_MEM_VALID_CARD_HANDLE) &&
+	    cmem->mem_array_handle > U16_MAX) {
+		pr_warn(FW_WARN "Memory Error Section 2 card handle 0x%x exceeds SMBIOS range\n",
+			cmem->mem_array_handle);
+		cmem->mem_array_handle = 0;
+		cmem->validation_bits &= ~CPER_MEM_VALID_CARD_HANDLE;
+	}
+
+	if ((cmem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) &&
+	    cmem->mem_dev_handle > U16_MAX) {
+		pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
+			cmem->mem_dev_handle);
+		cmem->mem_dev_handle = 0;
+		cmem->validation_bits &= ~CPER_MEM_VALID_MODULE_HANDLE;
+	}
+}
+
+bool cper_sec_is_platform_mem(const guid_t *sec_type)
+{
+	return guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) ||
+	       guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2);
+}
+EXPORT_SYMBOL_GPL(cper_sec_is_platform_mem);
+
+int cper_mem_err_parse(const guid_t *sec_type, const void *mem, size_t len,
+		       struct cper_mem_err_compact *cmem)
+{
+	memset(cmem, 0, sizeof(*cmem));
+
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
+		const struct cper_sec_mem_err2 *mem2 = mem;
+
+		if (len < sizeof(*mem2))
+			return -EINVAL;
+
+		cper_mem_err2_pack(mem2, cmem);
+		return 0;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+		const struct cper_sec_mem_err_old *old = mem;
+
+		if (len < sizeof(*old))
+			return -EINVAL;
+
+		if (len < sizeof(struct cper_sec_mem_err)) {
+			u64 old_valid_mask = CPER_MEM_VALID_RANK_NUMBER - 1;
+
+			cper_mem_err_old_pack(old, cmem);
+			cmem->validation_bits &= old_valid_mask;
+			return 0;
+		}
+
+		cper_mem_err_pack(mem, cmem);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(cper_mem_err_parse);
+
 const char *cper_mem_err_unpack(struct trace_seq *p,
 				struct cper_mem_err_compact *cmem)
 {
diff --git a/include/linux/cper.h b/include/linux/cper.h
index b5e2a0d115ca2..ac236043ce859 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -265,6 +265,7 @@ enum {
 #define CPER_MEM_VALID_BANK_GROUP		0x80000
 #define CPER_MEM_VALID_BANK_ADDRESS		0x100000
 #define CPER_MEM_VALID_CHIP_ID			0x200000
+#define CPER_MEM_VALID_STATUS			0x400000

 #define CPER_MEM_EXT_ROW_MASK			0x3
 #define CPER_MEM_EXT_ROW_SHIFT			16
@@ -628,6 +629,9 @@ int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
 		     const char * const strs[], unsigned int strs_size);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
 		       struct cper_mem_err_compact *);
+bool cper_sec_is_platform_mem(const guid_t *sec_type);
+int cper_mem_err_parse(const guid_t *sec_type, const void *mem, size_t len,
+		       struct cper_mem_err_compact *cmem);
 const char *cper_mem_err_unpack(struct trace_seq *,
 				struct cper_mem_err_compact *);
 void cper_print_proc_arm(const char *pfx,
--
2.43.0
