Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792421861;
	b=fbBaSA4hWZ2zyIIPGEFU59zYDxUJ+zgkeC3ZZGJOiOFkMiso7OaBNjlnNogT+8TUywDp
	 9kJXdDhEm+cVunAO/XUqZ90L7i+piosiyVShYxnFauH6mQolSBRVW55j2bMoE1xsdM8a/
	 +WCwH+zFum9R7SEPKRrYrbHN5O08mX1Zlxqh2C/3rg5ffqfg1Dp75gnhwlxhgmfMLNmA8
	 ARLUmIaPVbuJjantD8MUQJfZtHq4PLKKnRh5Cxdjz6g6e845zaqtiwKr9j12jQmtJHPJ+
	 82CLztwnmTA11QZHsshNXas7R+CbAQpejocWSR5aHFmDPcOoh1YXaESlshveXfcXnCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421861;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jb1csYS041OQkRUmll6dd69CLnrWmFEl4dVYrmHtRAU=;
	b=qS8WGsZHJgNZ2Isnxg/lP4AxJVdGsCAoblID7kYMKtCVYhHuwNcRIccf2aReiwctFZsB
	 9sO+pgTbz1UhSnZZ3oQ9OkiNJSaLc7jzgM6U8lp3xO2f++tTGAqDMXw0AJCoJpE2qx40U
	 y6Vr7Pxk6ujjZT2fJxbJ0wCUTztj5q7zf1qPiB0qu1vUtXCgSkWM27OaKHhzDQAvUW3zz
	 w1OUC9i6TD/S+7brJNFHK3ZYYCSzu7jGmWUM90Hzm8Vvi+8Nr212ESm0EUn9zWWyU40bG
	 eLyqfZ+902tcsEZjBf+25Cahb1iRgBwslrtgAjaEpX7N8FByq0QpLeiZv665OX5xVsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gKgqD6z5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6160740BA;
	Mon, 19 Oct 2026 14:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA6160740BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gKgqD6z5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D434E1EA6;
	Mon, 19 Oct 2026 07:57:29 -0700 (PDT)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 239C93F673;
	Mon, 19 Oct 2026 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421853; bh=rFQ3QLuKff7vtlNW+Ur6AcpokK+E1Tl4p+PypJsyh/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKgqD6z5TyPQLzUtRIFI01FrJpTwkRcyF+muszFRAoPszG94P+njdbUoMt9YNeckJ
	 OFKy6SWNcoYvVHsuuyWT3yoqSutdQqsTJ1HEjbqr3kjyx6ELSG1AnQpHPTBZGRoAVg
	 PnDsG4BkJan0/3EQZ20xOSQyBiOun5+QFpm+ZclU=
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
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 4/6] cper: add helpers to handle Memory Error Section 2
Date: Mon, 19 Oct 2026 16:56:11 +0200
Message-ID: <20261019145643.1877246-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019145643.1877246-1-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
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
diretly rely on struct cper_sec_mem_err2.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/efi/cper.c | 108 ++++++++++++++++++++++++++++++++++++
 include/linux/cper.h        |   3 +
 2 files changed, 111 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..5c9b832b67a1 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -445,6 +445,106 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
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
+	len = CPER_REC_LEN;
+	/* SMBIOS handles are 16 bits; never truncate a Section 2 handle. */
+	if (mem->mem_dev_handle <= U16_MAX)
+		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
+	else
+		pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
+			mem->mem_dev_handle);
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
@@ -650,6 +750,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
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

