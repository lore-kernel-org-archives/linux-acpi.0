Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505521;
	b=w4w9tp/ALs917TKMjSbKpA44ze/uhrsYM4OhLh6VmspJwAUWU8CWoyC9BD5/3OyXOkbS
	 qMUja9o5POAG/MGhP/OjDHNewU6I73XbEWGC/l0WMIlH1c0Z6kR5h1Q/S+mJgvc4WJ5G9
	 XylnzWrC74q0lsevbHkywTPtf1Hr0SeIvYOa8Ceta5fo5J3PKE0RqrspkbqcJPwubhkn8
	 VxDeIwYsTVD6sVNsg+V01hzAQc4xI3EEbCK1ly9u/81gAEouoWNO0PGX19h/p1Arlbira
	 MxV3TcYAS3oxnoryc++9zbt6JmpR/EkkG8zpGqGgQKOsi6kZAfdzcP9QmElbHI978TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505521;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XFMHtZmmQyN94256/7heALzwsLrllpOuPJEABO5hJcE=;
	b=N27lHZTvlN5ec5pklQRKuP7obA8CIv3qJEVa0ewhBf3VGg3WGwyoxhYK2eYiBey2LnmY
	 pchcPLe5XZWppAZHoKfSRAYoNJHrWtFToyx+cz2d9ySG1W5CBLjPONx8bmjT7g+tlJfqw
	 pa8wpoJA69LUl/+CC397gbuxF9H1Gk3S+izC1X4lXSzuWrfeDJeW68MDSitfY0NB5VN+P
	 agEDdixe0cmrSQl2XTg6t4sLHAaL1bgnB3CB7jAut4rGNsN4Z3y2x8e8+PQy+kEFj1zkF
	 8j/tqafmss7T0cyYNUoAhXqVwUMmw60XfaQrgMJ2a2beAP7AQZOKOLdo65I6WBsCoLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y9JQOZ3w;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378560A2604;
	Tue, 20 Oct 2026 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F378560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y9JQOZ3w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505521; x=1824041521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DcgrkQi54Cex3RRy2kGNeKR/LslD4lle2CDfJ4Esy3I=;
  b=Y9JQOZ3whEESobZQt8UY5P5dOZ+rCHL99waP3hV6MAHU6i9ex+yur3ou
   LLGYHgvQihean2SIhrE0EFvF3U/BS42ehihi2Mrbdwbi/WFiRsqYSHtyE
   m4FclJls4607Z8kw5XdM0HNA9ojtHhUocT+QZpPVGh1RJJinzdNMmJyhz
   HNTXGgUEtJoLSvgD2QjxnOYwX5D+2p6HFOff1w5sCUXNSW0/B7hPzQfeS
   sM4sn18q6CLqe4MbTDOB/yGKtzue7EdA/yZ2P07brXR19smgBIzs1zboS
   kes+K5KTA2XeCeI3GX1qc+Vzbowv9kdfUTPAUWlIvlIlZUf7RU7ZidP4u
   w==;
X-CSE-ConnectionGUID: gI3udrAwQA+68R5q3l4oVg==
X-CSE-MsgGUID: ZAnwIwZeShe74HO4Iuk3Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222312"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222312"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:58 -0700
X-CSE-ConnectionGUID: G+ScFgA/Sn+L9og7X6dUkw==
X-CSE-MsgGUID: fZWnVY9aSJWwwNB+rFsPcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888046"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:53 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 24/30] ACPICA: add UBRT (UnifiedBus Root Table) definitions
Date: Tue, 20 Oct 2026 16:10:45 +0200
Message-Id: <20261020141051.2194123-25-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
References: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
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
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/actbl2.h | 153 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index acbd46243736..8666169f98fc 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -61,6 +61,7 @@
 #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
 #define ACPI_SIG_SWFT           "SWFT"	/* SoundWire File Table */
 #define ACPI_SIG_TDEL           "TDEL"	/* TD Event Log Table */
+#define ACPI_SIG_UBRT           "UBRT"	/* UnifiedBus Root Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
@@ -3709,6 +3710,158 @@ struct acpi_table_tdel {
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
2.50.1

