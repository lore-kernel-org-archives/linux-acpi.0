Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442428;
	b=Hc41nLw0N5yruAOz9D+6gx5hz4IwXtDNpKHnhCEE72hta3KK8NJ5BpOU66Z+DIGDxbZL
	 lz35NJAu701oMnESytYy7+7RYHFz2sa1IuZumda/qrUxsVnTeU0rgTsGryWPxLpmfCLfh
	 eNLJQHRApmZKJt5rD7inCF4XFHvR3+Y9usRZCqaRZHEEylHUJTelFjfAbfQHfiKMR7uFl
	 pBdPB27pQ6BNSnblZbMWzVY4cg2vswM5iFoHqbUMSmpSMUGybCz6j7zlZnxe6xWezzCAU
	 tLYdx9/ssd/FlBcXiYTkQkICmY+X8nrwOq+yDeANwptWbVnP6TX3NKUz0sAvP1w5dMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442428;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2/7A38RNtD7RQ/YyFo6ODsiOAHnMtbezT9OG2lOi13g=;
	b=uSjVfvOwQGIdOG5/kkNtdbDoRSzdyU0+VdKcPlRVIQY2y6njOK00yi8cDzOCyV5mljyA
	 rZt+CaQhlPHBNwzTEkMU+pHUKrVER477LusgKbH4WrRhWMixueBDxrz41CDrGlVDLO2J+
	 1xuTyQqsXnqn5wqc7Zo5ikyyUvaeYKDKY4HKYEGVvlnGhc6XD00m2etczEspubtQqkyhK
	 dlCe8PZt103KFw+rurPcKIvirBK3qB8wteWUZSBPawFVY2SFJWvrNNNGd9VbXVuEEmS/w
	 0u4m4D7MxfJ6FI3OzUh2cNAkIZp0M9HHgo/6ez7cXo4Ue7XchWpLXceRl6/3liu1oaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R9RL4vxr;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355B606A31C;
	Mon, 19 Oct 2026 20:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4355B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R9RL4vxr
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C1720E3;
	Mon, 19 Oct 2026 13:40:18 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.53.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 244DE3F673;
	Mon, 19 Oct 2026 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792442421; bh=mZdsZZ0eMnFYwFad0DranBP838NOpNxdeiDGOK0U3Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9RL4vxrXA/kXCqTFAOPXOCh/FTqLTtZp8lxKbhtF6PiMlu3pfNy3OM6DNSfq4Nd1
	 aGjqqL1irL5mcb6WJZeC4U8CXreAj8ylH2tnF/l24uUBmyvQu8IzdCQDfHY/yYjixW
	 33OT3QU241AQhslqOlqYFUEmPmH8imvqQb/2pj1g=
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
Subject: [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event
Date: Mon, 19 Oct 2026 22:38:45 +0200
Message-ID: <20261019203915.2019037-7-pierre.gondois@arm.com>
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

Add a separate handling for Memory Error Section 2 trace events.
The fields of the record are individually printed so userspace
can discover the layout more dynamically if a new field is added.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c |   6 +++
 drivers/ras/ras.c          |   1 +
 include/ras/ras_event.h    | 102 +++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 7ad3b36013cc..9e4d16e06244 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -231,6 +231,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
+			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length >= sizeof(*mem))
+				trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text,
+						      	(u8)gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err =
 				acpi_hest_get_payload(gdata);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 03df3db62334..c6b14202a5e9 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -111,6 +111,7 @@ subsys_initcall(ras_init);
 
 #if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
 EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem2_event);
 #endif
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(non_standard_event);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index fdb785fa4613..0c0dbe068dc8 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -74,6 +74,108 @@ TRACE_EVENT(extlog_mem_event,
 		  &__entry->fru_id,
 		  __get_str(fru_text))
 );
+
+/*
+ * Memory Error Section 2 exposes each field separately so userspace can
+ * discover its layout. Validation bits use the UEFI Section 2 assignments.
+ */
+TRACE_EVENT(extlog_mem2_event,
+	TP_PROTO(const struct cper_sec_mem_err2 *mem,
+		 u32 err_seq,
+		 const guid_t *fru_id,
+		 const char *fru_text,
+		 u8 sev),
+
+	TP_ARGS(mem, err_seq, fru_id, fru_text, sev),
+
+	TP_STRUCT__entry(
+		__field(u32, err_seq)
+		__field(u8, sev)
+		__field_struct(guid_t, fru_id)
+		__string(fru_text, fru_text)
+		__field(u64, validation_bits)
+		__field(u64, error_status)
+		__field(u64, physical_addr)
+		__field(u64, physical_addr_mask)
+		__field(u16, node)
+		__field(u16, card)
+		__field(u16, module)
+		__field(u16, bank)
+		__field(u32, device)
+		__field(u32, row)
+		__field(u32, column)
+		__field(u32, rank)
+		__field(u32, bit_pos)
+		__field(u8, chip_id)
+		__field(u8, error_type)
+		__field(u8, status)
+		__field(u64, requestor_id)
+		__field(u64, responder_id)
+		__field(u64, target_id)
+		__field(u32, mem_array_handle)
+		__field(u32, mem_dev_handle)
+	),
+
+	TP_fast_assign(
+		__entry->err_seq = err_seq;
+		__entry->sev = sev;
+		__entry->fru_id = *fru_id;
+		__assign_str(fru_text);
+		__entry->validation_bits = mem->validation_bits;
+		__entry->error_status = mem->error_status;
+		__entry->physical_addr = mem->physical_addr;
+		__entry->physical_addr_mask = mem->physical_addr_mask;
+		__entry->node = mem->node;
+		__entry->card = mem->card;
+		__entry->module = mem->module;
+		__entry->bank = mem->bank;
+		__entry->device = mem->device;
+		__entry->row = mem->row;
+		__entry->column = mem->column;
+		__entry->rank = mem->rank;
+		__entry->bit_pos = mem->bit_pos;
+		__entry->chip_id = mem->chip_id;
+		__entry->error_type = mem->error_type;
+		__entry->status = mem->status;
+		__entry->requestor_id = mem->requestor_id;
+		__entry->responder_id = mem->responder_id;
+		__entry->target_id = mem->target_id;
+		__entry->mem_array_handle = mem->mem_array_handle;
+		__entry->mem_dev_handle = mem->mem_dev_handle;
+	),
+
+	TP_printk("{%u} %s error: validation_bits: 0x%llx "
+		  "error_status: 0x%llx physical_addr: 0x%llx "
+		  "physical_addr_mask: 0x%llx node: %u card: %u "
+		  "module: %u bank: %u device: %u row: %u column: %u "
+		  "rank: %u bit_pos: %u chip_id: %u error_type: %u "
+		  "status: 0x%x requestor_id: 0x%llx responder_id: 0x%llx "
+		  "target_id: 0x%llx mem_array_handle: 0x%x "
+		  "mem_dev_handle: 0x%x FRU: %pUl %.20s",
+		  __entry->err_seq, cper_severity_str(__entry->sev),
+		  __entry->validation_bits,
+		  __entry->error_status,
+		  __entry->physical_addr,
+		  __entry->physical_addr_mask,
+		  __entry->node,
+		  __entry->card,
+		  __entry->module,
+		  __entry->bank,
+		  __entry->device,
+		  __entry->row,
+		  __entry->column,
+		  __entry->rank,
+		  __entry->bit_pos,
+		  __entry->chip_id,
+		  __entry->error_type,
+		  __entry->status,
+		  __entry->requestor_id,
+		  __entry->responder_id,
+		  __entry->target_id,
+		  __entry->mem_array_handle,
+		  __entry->mem_dev_handle,
+		  &__entry->fru_id, __get_str(fru_text))
+);
 #endif
 
 /*
-- 
2.43.0

