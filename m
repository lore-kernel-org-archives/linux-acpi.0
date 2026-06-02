Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46C378803;
	Tue,  2 Jun 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384591; cv=none; b=Z8l4PxSPNl4fvvPzSCynw2Mm34MKGEQK3gglGioO8twbjOKN5TaFbQmpGN/eSh/mpEmmXBCNrLBAeaAC7xwziAPGJiFZUoLM7FOphydSoVP3RmkHIMtwetfJTAcXWETa70gX0fo8EMa0bj08kChwFN+6WQuCixZzNfy3v8foqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384591; c=relaxed/simple;
	bh=dwOtUaaZ1T28ZHMpxfRgsLXLHFh404qL2muulpCIriU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWH7VU+/7wcIdl++896KyCaiVszF+v4RUPBbsIXfQ7151U0hRSoZ9mrcV5DPzGWKki0ri/QaXnPb2bkqtaBo1+rdTLjwv61Pgwc6zJqOCgQVQg5ykZiQOKfBgbY+EoXKAwi7g1FGCwJwzTh6vZpxf4dzEjByLBfqYISVN8Cq23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ejTna3FH; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ejTna3FH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384580; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m8PYl6vt/JGLK/5rXbDBL7ylKeOz6sqUbxtL6VST4yk=;
	b=ejTna3FHsIne9z7Da7wJFICwGYJcS0wZJ053H8Tus8UXsdGhsKU0s0zOgYOKmb1/QmxgKlrtvmDObCRh8ZpPp3uP0M50IUx753hhbzCpVYy/0mZGRACR0kDxErphTgzSwS1IBRSa1ZJDLwsJ5WHl8HjCJals9uzfJT3/NTmiHxw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2hf_1780384577;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2hf_1780384577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:19 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v7 16/16] trace, ras: add ARM RAS extension trace event
Date: Tue,  2 Jun 2026 15:15:39 +0800
Message-ID: <20260602071540.3711528-17-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trace event for hardware errors reported by the ARMv8
RAS extension registers. userspace app can monitor this
trace event and decode error information.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/arm64/ras-core.c |  5 +++
 drivers/ras/ras.c            |  3 ++
 include/ras/ras_event.h      | 79 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index 82e8bb10870f..3f4e7866bb75 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -11,6 +11,7 @@
 #include <linux/panic.h>
 #include <linux/platform_device.h>
 #include <linux/ras.h>
+#include <ras/ras_event.h>
 
 #include "ras.h"
 
@@ -181,6 +182,10 @@ static void ras_do_proc(struct ras_record *record, struct ras_ext_regs *regs)
 		}
 	}
 
+	trace_arm_ras_ext_event(record->node->type, record->index, regs,
+				record->node->specific_data, record->node->specific_data_size,
+				record->vendor_data, record->vendor_data_size);
+
 	atomic_notifier_call_chain(&ras_decoder_chain, 0, record);
 
 	if (status & ERR_STATUS_CE)
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 03df3db62334..c8858b745021 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -115,6 +115,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(non_standard_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(arm_event);
+#ifdef CONFIG_ARM64_RAS_EXTN
+EXPORT_TRACEPOINT_SYMBOL_GPL(arm_ras_ext_event);
+#endif
 
 static int __init parse_ras_param(char *str)
 {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index fdb785fa4613..346c868f3cf7 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -381,6 +381,85 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 #endif /* CONFIG_PCIEAER */
+
+/*
+ * ARM RAS Extension Events Report
+ *
+ * This event is generated when an error reported by the ARM RAS extension
+ * hardware is detected.
+ */
+
+#ifdef CONFIG_ARM64_RAS_EXTN
+#include <asm/ras.h>
+TRACE_EVENT(arm_ras_ext_event,
+
+	TP_PROTO(const u8 type,
+		 const u32 index,
+		 struct ras_ext_regs *regs,
+		 const u8 *specific_data,
+		 const u32 specific_data_size,
+		 const u8 *vendor_data,
+		 const u32 vendor_data_size),
+
+	TP_ARGS(type, index, regs, specific_data, specific_data_size,
+		vendor_data, vendor_data_size),
+
+	TP_STRUCT__entry(
+		__field(u8,  type)
+		__field(u32, index)
+		__field(u64, err_fr)
+		__field(u64, err_ctlr)
+		__field(u64, err_status)
+		__field(u64, err_addr)
+		__field(u64, err_misc0)
+		__field(u64, err_misc1)
+		__field(u64, err_misc2)
+		__field(u64, err_misc3)
+		__field(u32, specific_data_size)
+		__dynamic_array(u8, specific_data, specific_data_size)
+		__field(u32, vendor_data_size)
+		__dynamic_array(u8, vendor_data, vendor_data_size)
+	),
+
+	TP_fast_assign(
+		__entry->type = type;
+		__entry->index = index;
+		__entry->err_fr = regs->err_fr;
+		__entry->err_ctlr = regs->err_ctlr;
+		__entry->err_status = regs->err_status;
+		__entry->err_addr = regs->err_addr;
+		__entry->err_misc0 = regs->err_misc[0];
+		__entry->err_misc1 = regs->err_misc[1];
+		__entry->err_misc2 = regs->err_misc[2];
+		__entry->err_misc3 = regs->err_misc[3];
+		__entry->specific_data_size = specific_data_size;
+		memcpy(__get_dynamic_array(specific_data), specific_data, specific_data_size);
+		__entry->vendor_data_size = vendor_data_size;
+		memcpy(__get_dynamic_array(vendor_data), vendor_data, vendor_data_size);
+	),
+
+	TP_printk("type: %d; index: %d; "
+		  "ERR_FR: %llx; ERR_CTLR: %llx; ERR_STATUS: %llx; "
+		  "ERR_ADDR: %llx; ERR_MISC0: %llx; ERR_MISC1: %llx; "
+		  "ERR_MISC2: %llx; ERR_MISC3: %llx; "
+		  "specific data len:%d; specific data:%s; "
+		  "vendor data len:%d; vendor data:%s",
+		  __entry->type,
+		  __entry->index,
+		  __entry->err_fr,
+		  __entry->err_ctlr,
+		  __entry->err_status,
+		  __entry->err_addr,
+		  __entry->err_misc0,
+		  __entry->err_misc1,
+		  __entry->err_misc2,
+		  __entry->err_misc3,
+		  __entry->specific_data_size,
+		  __print_hex(__get_dynamic_array(specific_data), __entry->specific_data_size),
+		  __entry->vendor_data_size,
+		  __print_hex(__get_dynamic_array(vendor_data), __entry->vendor_data_size))
+);
+#endif /* CONFIG_ARM64_RAS_EXTN */
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */
-- 
2.51.2.612.gdc70283dfc

