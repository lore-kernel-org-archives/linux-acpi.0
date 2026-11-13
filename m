Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576456;
	b=wfTP715w8f5ReqevPQOvYw4SdTrjKIjnHGVS9v6ZyZI6f6zBoPreXAiU8k7MaPVAmAI+
	 2GXVxd0EKP/jyMGyxFe0HAVCaSc/+l1CeEjFaM9+gG1/eESDOdp3NYmIShcJtf45vNcBU
	 NONdX//B/BFw2Gd8OpNdr3arJFVoq6ZtJbCXUzoj1Djsd6kZUUQWkUi62cKn6e4nUV5cw
	 LiOSuAcwnvathywTeo9zkyRkRj/c2dWaQEoSmM9L74ORJogMrWa5pTmSHEo5gs2gB4dEI
	 2DeH6CZaRwfC9+beD1PrIJShK2IywN2wgg+RTL1pvht5htOrb0NSBBlAiP/h4J9cMyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576456;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z9ljZj57dKAhY+i7oqd/TyfFuLV5Irwzsb4Zp433lHc=;
	b=fz3cEdCXGzSLF7Q0bpMo9S0ls4dqLQeW2SskMQLcnJ5XTNwxc0wMP49OxjqCk4qCI5Qk
	 1bGUkCWFBW6PBah+r15G33OCgVC5Dtrgg6iBbW+zp9pEpirqf5Z6orsRK/gqF363Rz5nl
	 yw1ulZ4NyXDiDQtFolh8xGYy6+0CVrzL2UgAi5y/Xaue9yZCThds5lt2aAi+VS0QdyIi4
	 1jyulgXwacFbFpDsILj4eP6YGd2ILBgtoC1Re8eQb6HIRIFoPrdlnhSpzXkrnREU8nXC9
	 C4EAvL7t7rZznzLwXGEngoBUVCae2Hd3dHED3FNtJ2ojOwH0WgvTPLUNlBpWwWjWFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AjCbzdCy;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6335606CAB2;
	Fri, 13 Nov 2026 13:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6335606CAB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AjCbzdCy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CDBC1595;
	Fri, 13 Nov 2026 05:27:32 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 390323F85F;
	Fri, 13 Nov 2026 05:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576455; bh=v+wTm6ZUNalZK7gqhzsQLHsfZeeSE6PqJdjlr8irWLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjCbzdCybFAmqx3LQgwndPHvtuRCPrlvsD7J7abc4q4Kcp/q44j0AkypguzbajeFx
	 4nKJWoTqkw2eGjD3i5cRRnpmn8EBloydazbyJKQE/b3MTjapACwUAHvuRqQKCEXmQH
	 Su4XWUFTdIdmV2d/sCYsA/jL+6Nn6M1yZvMxuxg8=
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 08/12] ACPI: extlog: add Memory Error Section 2 trace event
Date: Fri, 13 Nov 2026 14:24:50 +0100
Message-ID: <20261113132600.3355836-9-pierre.gondois@arm.com>
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
index bf5f7b1a9aea..5565177be328 100644
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
+							(u8)gdata->error_severity);
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
index fdb785fa4613..ce759ee1cf4c 100644
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
+		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
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

