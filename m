Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442396;
	b=rDhzwpWvdERFN9mNEdfbrO1lAfKDoxHkIAKuezI6NC0m7TeY0uDqfqKSo4pE0hOvwxp4
	 7gRwuPWuSD8IR70C6BN3ZsHipaNPfq7qTyX1UqCyVTmgeqpsuvK/OJf8Hn4rZUGlnotnS
	 h2MndrhR9u/jQoJcFOhAzQro64OaZE4ZULpAZvD4yyirj7BifPFORhonv86B4/NK3kzij
	 EUYkVp8pTizg71+vjXA+1wdxajVSSsylxYfuYHIhY6edRDZNHx8yaBpPTira4nthGm1TP
	 q3vFFHsrW7biZJKzt7LPzaQ8i0/9wMd67eM6SlyRU7DsnOSFLO8rdX1erGbS3s8C2Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442396;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=egoRfyoWrlONoOnFPOLU8y0T0MnbnX2vgl819dIM/aQ=;
	b=FZZA62KKVQK5h98JUvjq2enxhqQVpotp4RFf3F9Hj9JQVLhq+2hvf5OyU9TLMnvgP0a9
	 c9KUQ1ZTZF7HtZgTUtapb+zwc4owTRXg+JolXKAnzd6Lp4o0F0IEsaksD9L6EIIBxzlrO
	 X00ZYJD0hYOa4JcEhZ/q3rpgpWVQE2tNhBnGZvWakIDOpM4Wi2Z+qVNjYl6fhe25sTmEq
	 n+peURSgbItQh87a+wfJfxFmXNzo4kdE13hhpyKO+XHYPvgHmvwsW7967O3K+PFfieMzZ
	 dRqE0GKUv6/As7osm/dyevWHQnOUWEzN1Q8ctT9AziWMy/N8GPf3sF+ZsUSBklJcLdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sa80KvAt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6064606A32E;
	Mon, 19 Oct 2026 20:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6064606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sa80KvAt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD2D620E3;
	Mon, 19 Oct 2026 13:39:51 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.53.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE1E33F673;
	Mon, 19 Oct 2026 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792442395; bh=wZOhSVu13d1TLJt3gTH6vhmBF1Riw/IxQaHTxqFMLdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa80KvAtfaTF0BGhe/kEZEFj7bWV+9B2hZQAwjVL5IzqI/k9GnSmovkxjvAEaOZuB
	 d3u7MLZ9yrgr36+CkZ91rS0R+dA5KbqT3/GE48BJHQPCFWEewrVjvLNmK8GFsPC90V
	 6RUXMFt9aXBtvK5AXQOgjMzMBZXhuhTPmukI36gA=
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
Subject: [PATCH v2 3/6] cper: add helpers to handle Memory Error Section 2
Date: Mon, 19 Oct 2026 22:38:42 +0200
Message-ID: <20261019203915.2019037-4-pierre.gondois@arm.com>
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

Add separate location and printing helpers for Memory Error
Section 2:
- cper_mem_err2_location()
- cper_dimm_err2_location()
- cper_print_mem2()

Similar functions/logic exists for Memory Error Section (1),
but require a compact version of the record. To avoid relying
and propagating a non-standard record format, the new functions
directly rely on struct cper_sec_mem_err2.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/efi/cper.c | 109 ++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |   3 +
 2 files changed, 112 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..42e324d5707c 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -445,6 +445,107 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 		printk("%s%s\n", pfx, rcd_decode_str);
 }
 
+int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
+{
+	u32 len, n;
+
+	if (!msg)
+		return 0;
+
+	n = 0;
+	len = CPER_REC_LEN;
+	if (mem->validation_bits & CPER_MEM2_VALID_NODE)
+		n += scnprintf(msg + n, len - n, "node:%d ", mem->node);
+	if (mem->validation_bits & CPER_MEM2_VALID_CARD)
+		n += scnprintf(msg + n, len - n, "card:%d ", mem->card);
+	if (mem->validation_bits & CPER_MEM2_VALID_MODULE)
+		n += scnprintf(msg + n, len - n, "module:%d ", mem->module);
+	if (mem->validation_bits & CPER_MEM2_VALID_RANK_NUMBER)
+		n += scnprintf(msg + n, len - n, "rank:%u ", mem->rank);
+	if (mem->validation_bits & CPER_MEM2_VALID_BANK)
+		n += scnprintf(msg + n, len - n, "bank:%d ", mem->bank);
+	if (mem->validation_bits & CPER_MEM2_VALID_BANK_GROUP)
+		n += scnprintf(msg + n, len - n, "bank_group:%d ",
+			       mem->bank >> CPER_MEM_BANK_GROUP_SHIFT);
+	if (mem->validation_bits & CPER_MEM2_VALID_BANK_ADDRESS)
+		n += scnprintf(msg + n, len - n, "bank_address:%d ",
+			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);
+	if (mem->validation_bits & CPER_MEM2_VALID_DEVICE)
+		n += scnprintf(msg + n, len - n, "device:%u ", mem->device);
+	if (mem->validation_bits & CPER_MEM2_VALID_ROW)
+		n += scnprintf(msg + n, len - n, "row:%u ", mem->row);
+	if (mem->validation_bits & CPER_MEM2_VALID_COLUMN)
+		n += scnprintf(msg + n, len - n, "column:%u ", mem->column);
+	if (mem->validation_bits & CPER_MEM2_VALID_BIT_POSITION)
+		n += scnprintf(msg + n, len - n, "bit_position:%u ",
+			       mem->bit_pos);
+	if (mem->validation_bits & CPER_MEM2_VALID_REQUESTOR_ID)
+		n += scnprintf(msg + n, len - n, "requestor_id:0x%016llx ",
+			       mem->requestor_id);
+	if (mem->validation_bits & CPER_MEM2_VALID_RESPONDER_ID)
+		n += scnprintf(msg + n, len - n, "responder_id:0x%016llx ",
+			       mem->responder_id);
+	if (mem->validation_bits & CPER_MEM2_VALID_TARGET_ID)
+		n += scnprintf(msg + n, len - n, "target_id:0x%016llx ",
+			       mem->target_id);
+	if (mem->validation_bits & CPER_MEM2_VALID_CHIP_ID)
+		n += scnprintf(msg + n, len - n, "chip_id:%d ",
+			       mem->chip_id);
+
+	return n;
+}
+EXPORT_SYMBOL_GPL(cper_mem_err2_location);
+
+int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
+{
+	u32 len, n;
+	const char *bank = NULL, *device = NULL;
+
+	if (!msg || !(mem->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE))
+		return 0;
+
+	/* SMBIOS handles are 16 bits; never truncate a Section 2 handle. */
+	if (mem->mem_dev_handle <= U16_MAX)
+		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
+	else
+		pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
+			mem->mem_dev_handle);
+
+	len = CPER_REC_LEN;
+	if (bank && device)
+		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
+	else
+		n = snprintf(msg, len,
+			     "DIMM location: not present. DMI handle: 0x%.8x ",
+			     mem->mem_dev_handle);
+
+	return n;
+}
+EXPORT_SYMBOL_GPL(cper_dimm_err2_location);
+
+static void cper_print_mem2(const char *pfx, const struct cper_sec_mem_err2 *mem)
+{
+	char rcd_decode_str[CPER_REC_LEN];
+
+	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_STATUS)
+		printk("%serror_status: %s (0x%016llx)\n", pfx,
+		       cper_mem_err_status_str(mem->error_status), mem->error_status);
+	if (mem->validation_bits & CPER_MEM2_VALID_PA)
+		printk("%sphysical_address: 0x%016llx\n", pfx, mem->physical_addr);
+	if (mem->validation_bits & CPER_MEM2_VALID_PA_MASK)
+		printk("%sphysical_address_mask: 0x%016llx\n", pfx,
+		       mem->physical_addr_mask);
+	if (cper_mem_err2_location(mem, rcd_decode_str))
+		printk("%s%s\n", pfx, rcd_decode_str);
+	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_TYPE)
+		printk("%serror_type: %u, %s\n", pfx, mem->error_type,
+		       cper_mem_err_type_str(mem->error_type));
+	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
+		printk("%sstatus: 0x%02x\n", pfx, mem->status);
+	if (cper_dimm_err2_location(mem, rcd_decode_str))
+		printk("%s%s\n", pfx, rcd_decode_str);
+}
+
 static const char * const pcie_port_type_strs[] = {
 	"PCIe end point",
 	"legacy PCI end point",
@@ -650,6 +751,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 				       gdata->error_data_length);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
+		struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: memory error 2\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*mem_err))
+			cper_print_mem2(newpfx, mem_err);
+		else
+			goto err_section_too_small;
 	} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 		struct cper_sec_pcie *pcie = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cper.h b/include/linux/cper.h
index ed355b240685..a466cba4fd61 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -656,6 +656,9 @@ void cper_print_proc_ia(const char *pfx,
 int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
 int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
 
+int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg);
+int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg);
+
 struct acpi_hest_generic_status;
 void cper_estatus_print(const char *pfx,
 			const struct acpi_hest_generic_status *estatus);
-- 
2.43.0

