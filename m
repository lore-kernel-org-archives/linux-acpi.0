Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195268;
	b=TliWcQH5AOv5na/mmSXK2bMnqCXYdLhV5BLl121RWgubLEI4H2b0HdbvV3chIith51PM
	 xhmqYPpcclUzAIaqnmdOIUnZ8/gecBQPiohiYvjqJaZx5rKJ5R/gp6r44AJqZIh1LqtxJ
	 HDy3MIFJX54JQsfaV958QFISDOCipABCLwrU2ocFl/QICPBbWmBhH5ouP/XDooJfImgbR
	 kNTh6Mcv3qszL6MHl/FFE8aTxwN+bz0jStBePJNE0Zo7rRfsrZXgzbzEwuEMceR1g60UT
	 HhWJ/mM+F/pq6Gfc+XhBsLOhz38t3r2oSlzyskG+NvkmYIKFb6sq4dZs8HmMbMBLZ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195268;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X5t8KSN+BPwewSOUqLYXJa+3yiZf9HW9mxXEcML004g=;
	b=YRlUB1BR2hmHy8JXX8warXSIGV+T/RYyCuw0XB21HjkTgMgvgzWwEy1Y9QBN6eZbN1Bl
	 Q/WLC96GMdFW30imeB8d/qW0ivHTfkzvZ0AxHaXFLqWT8FIy9horcauW9fo6fQnq7WWSF
	 jCvS9DbkJlv9Kg7JL1BLIeQEJ5UMiR/5hkcW4PVfT57vQpTgLglKqvozJtm6Mdo/gR5me
	 Mpr6OBKjHKLhGNoIPE0l2tAsHyE+ez5CRm70xxiJpfu7+huZvfHE2TwEZnb+4RGDUdRpr
	 D501IkodKNNauS26quwOH0kQjOs6CJY3eJbpiXMijLHGyccxErRz9mVrKE0g0rT3plA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="H/W/Xp/t";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308B60A5BCC;
	Fri, 20 Nov 2026 17:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4308B60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H/W/Xp/t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195266; x=1826731266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NMeYiLSx7ZE5DNWL3ziK2d2TldZQDmeLoanT6gIxdeE=;
  b=H/W/Xp/tri34zHCfrJE6NF2BEYMew8EnXY121QzwBUipEciNpc+g/OHr
   JAoPv5ypPN7M+rLsV7SR+LZO14NT+cjhdUt4S6b+cHWhRL96tXddi1uvD
   OuKPrT1Hh3LG1ouLjWL2fz3nXDDHQ21XpLtcKgPxodp6isx//MfTgENdx
   xL8ptmqhthWpDXROYG17n0BPNqrGLTAF1Ge9EduZGxPHcw0Msz49EBNOf
   8/j/ckpZH8vOaTo90vh3Iftw4/YBJkVgc/OZR0e92K7KjqkvxeKt64HEV
   /Fda0EFs06UuxCz+kVtqiPeGgwbO6+c/Twi1gZ5dQdT2qpnDnJWs5V2eP
   w==;
X-CSE-ConnectionGUID: 7WVBUemJTha6em4qm3IL8w==
X-CSE-MsgGUID: YOVdUJsWTJ+LYB3nOYrnBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157423"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157423"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:06 -0800
X-CSE-ConnectionGUID: 08HTqaASQOOaVqc9MdVi8Q==
X-CSE-MsgGUID: SRMsZbDnTTyeBZ4F5zfWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868066"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:03 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/42] ACPICA: add UBRT (UnifiedBus Root Table) definitions
Date: Fri, 20 Nov 2026 18:18:41 +0100
Message-ID: <75d98747303ca235cfcbb374c259492493132969.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Hanjun Guo <guohanjun@huawei.com>

Add UBRT table structure definitions as specified in
"UnifiedBus Root Table (UBRT) Specification Revision 1.0" [1].

UBRT table signature was reserved and published in links to ACPI-related
documents: https://uefi.org/acpi.

The UBRT provides the OS with fundamental configuration and architectural
information necessary to initialize and manage the UB device.

This includes:
- UBRT main table structure (ACPI_TABLE_UBRT)
- UBC (UnifiedBus Bus Controller) information sub-table
- UMMU (UnifiedBus Memory Management Unit) information sub-table
- UB Reserved Memory information sub-table

[1]: https://www.unifiedbus.com/en/docs/UB-Root-Table-Spec-1.0-en

Link: https://github.com/acpica/acpica/commit/8565698cefd9
Link: https://github.com/open-acpica/acpica/pull/1211
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/actbl2.h | 153 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 76e4a5bc79b4..dbfea7c8bc00 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -61,6 +61,7 @@
 #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
 #define ACPI_SIG_SWFT           "SWFT"	/* SoundWire File Table */
 #define ACPI_SIG_TDEL           "TDEL"	/* TD Event Log Table */
+#define ACPI_SIG_UBRT           "UBRT"	/* UnifiedBus Root Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
@@ -3708,6 +3709,158 @@ struct acpi_table_tdel {
 	u64 log_area_start_address;
 };
 
+/*******************************************************************************
+ *
+ * UBRT - UnifiedBus Root Table
+ *        Revision 1
+ *
+ * Conforms to "UnifiedBus Root Table (UBRT) Specification"
+ * Revision 1.0, Release Date 2026-03-05
+ *
+ ******************************************************************************/
+
+struct acpi_table_ubrt {
+	struct acpi_table_header header; /* Common ACPI table header */
+	u32 count; /* Number of sub-tables */
+};
+
+/* UBRT sub-table entry (16 bytes) */
+
+struct acpi_ubrt_subtable {
+	u8 type; /* Sub-table type (0=UBC, 1=UMMU, 2=reserved_mem) */
+	u8 reserved[7]; /* Reserved, must be zero */
+	u64 pointer; /* Physical address of the sub-table */
+};
+
+/* Values for Type field above */
+
+#define ACPI_UBRT_TYPE_UBC 0 /* UBC information sub-table */
+#define ACPI_UBRT_TYPE_UMMU 1 /* UMMU information sub-table */
+#define ACPI_UBRT_TYPE_RESERVED_MEM \
+	2 /* UB reserved memory information sub-table */
+
+/*
+ * UBRT Sub-tables, correspond to Type in struct acpi_ubrt_subtable.
+ * These are accessed via the physical Pointer field - not contiguous with UBRT.
+ */
+
+/* Common header for all UBRT sub-tables */
+
+struct acpi_ubrt_header {
+	char name[16]; /* Table name, null-terminated */
+	u32 total_size; /* Total size including header */
+	u8 version; /* Version number */
+	u8 reserved[3]; /* Reserved, must be zero */
+	u32 remaining_size; /* Remaining size of the sub-table */
+	u32 checksum; /* Entire table must sum to zero */
+};
+
+/* Type 0: UBC Information Table */
+
+struct acpi_ubrt_ubc {
+	struct acpi_ubrt_header header; /* Common sub-table header */
+	u32 local_cna_start; /* Start CNA available for local UBPU */
+	u32 local_cna_end; /* End CNA available for local UBPU (included) */
+	u32 local_eid_start; /* Start EID available for local UBPU */
+	u32 local_eid_end; /* End EID available for local UBPU (included) */
+	u8 feature_sets; /* Features enabled for the UBC */
+	u8 reserved[3]; /* Reserved, must be zero */
+	u16 cluster_mode; /* System operating mode */
+	u16 ubc_count; /* Number of UBC structures */
+};
+
+/* Values for feature_sets field above */
+
+#define ACPI_UBRT_UBC_FEAT_MMIO_TOKEN (1 << 0) /* Bit 0: MMIO token value */
+#define ACPI_UBRT_UBC_FEAT_MCTP_UB (1 << 1) /* Bit 1: MCTP over UB */
+
+/* Values for cluster_mode field above */
+
+#define ACPI_UBRT_CLUSTER_MODE_STANDALONE 0
+#define ACPI_UBRT_CLUSTER_MODE_SUPERPOD 1
+
+/* UBC Structure entry (one per ubc_count) */
+
+struct acpi_ubrt_ubc_entry {
+	u32 interrupt_id_start; /* Start interrupt ID */
+	u32 interrupt_id_end; /* End interrupt ID (included) */
+	u64 hpa_base; /* Base address of available HPA */
+	u64 hpa_size; /* Size of available HPA */
+	u8 memory_size_limit; /* Maximum address bit width */
+	u8 dma_cca; /* DMA and cache coherent attribute */
+	u16 ummu_mapping; /* Mapping between UBC and UMMU */
+	u16 proximity_domain; /* NUMA domain sequence number */
+	u16 reserved; /* Reserved, must be zero */
+	u64 msg_queue_base; /* MSG queue register base address */
+	u64 msg_queue_size; /* MSG queue register size */
+	u16 msg_queue_depth; /* MSG queue depth */
+	u16 msg_queue_interrupt; /* MSG queue interrupt ID */
+	u8 msg_queue_interrupt_attr; /* MSG queue interrupt attribute */
+	u8 reserved1[59]; /* Reserved, must be zero */
+	u8 guid[16]; /* UBC GUID */
+	u8 vendor_info[256]; /* Vendor-defined information */
+};
+
+/* Values for dma_cca field above */
+
+#define ACPI_UBRT_UBC_DMA_ONLY 0
+#define ACPI_UBRT_UBC_DMA_CCA 1
+
+/* Values for msg_queue_interrupt_attr field above */
+
+#define ACPI_UBRT_UBC_MSG_INT_LEVEL (0 << 0) /* Bit 0: level-triggered */
+#define ACPI_UBRT_UBC_MSG_INT_EDGE (1 << 0) /* Bit 0: edge-triggered */
+#define ACPI_UBRT_UBC_MSG_INT_HIGH \
+	(0 << 1) /* Bit 1: high level (rising edge) */
+#define ACPI_UBRT_UBC_MSG_INT_LOW (1 << 1) /* Bit 1: low level (falling edge) */
+
+/* Type 1: UMMU Information Table */
+
+struct acpi_ubrt_ummu {
+	struct acpi_ubrt_header header; /* Common sub-table header */
+	u16 ummu_count; /* Number of UMMU structures */
+	u8 reserved[6]; /* Reserved, must be zero */
+};
+
+/* UMMU Structure entry (one per ummu_count) */
+
+struct acpi_ubrt_ummu_entry {
+	u64 base_address; /* Base address of UMMU register */
+	u64 size; /* Size of UMMU register */
+	u32 reserved; /* Reserved, must be zero */
+	u16 proximity_domain; /* NUMA domain sequence number */
+	u16 reserved1; /* Reserved, must be zero */
+	u64 pmu_base_address; /* PMU register base address */
+	u64 pmu_size; /* PMU register size */
+	u32 reserved2; /* Reserved, must be zero */
+	u32 min_token_id; /* Minimum token_ID */
+	u32 max_token_id; /* Maximum token_ID */
+	u8 reserved3[26]; /* Reserved, must be zero */
+	u16 vendor_id; /* Vendor ID */
+	u8 vendor_info[80]; /* Vendor-defined information */
+};
+
+/* Type 2: UB Reserved Memory Information Table */
+
+struct acpi_ubrt_reserved_mem {
+	struct acpi_ubrt_header header; /* Common sub-table header */
+	u16 memory_ranges_count; /* Number of memory ranges */
+	u8 reserved[6]; /* Reserved, must be zero */
+};
+
+/* Memory Range entry (one per memory_ranges_count) */
+
+struct acpi_ubrt_mem_range {
+	u8 flags; /* Memory segment flags */
+	u8 reserved[7]; /* Reserved, must be zero */
+	u64 memory_base; /* Base address of allocated UB memory (64KB aligned) */
+	u64 memory_size; /* Size of allocated UB memory (64KB aligned) */
+};
+
+/* Values for Flags field above */
+
+#define ACPI_UBRT_MEM_FLAG_1_1_MAPPING (1 << 0) /* Bit 0: 1:1 mapped mode */
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
2.56.0

