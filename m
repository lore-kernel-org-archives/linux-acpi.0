Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195273;
	b=Q5BWdgFXBxqZH/+atcZ5rle0quEw9npRG93mllOKSTJhHVrKZR6TwAAKJqNssWyUjPhI
	 5I5p01AFtbnbgua3buI5MR6uYiB4BoEN5JIXHZnmKCMdwbRAC9ZCk6OkKPrpLc1CByGqP
	 KNygbqLJb/Wu0ZPCJoldaf/ASFLcq4iyw7xsPUCiUlWGJDai8ADXXg4xn9KljmbiCwWXn
	 XlMmE3jsTSc9f2Zlcz2pILV8UW9iBfHC05D2zxcF9ooeZ9WzXCVR+02Ob4vMZGry04yMy
	 Cw+YFV1jm9qT55/91CDkYL7aH+hcMbUbMkExK6YOzorZ6a1C0+mtcCB+EG2Gj+DAPRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195273;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4U/uwHAE/JCkAiNRCy6w0ySpZQBvAQunkij3nCJiKn0=;
	b=b0By87PI5dAlVlmyUQbkIo4pP4B5DUZfqU4do4sriSEP/99O2Z3qJ+uxSsTKTat6qs6A
	 puynjIUSi8I6k16zRXNsZ6XFcv3+nkf1TbVXhkZdU+7wAY5x2rDqMpGW5R9b5eYBuPNgC
	 YdPIOeS0zIhROZkb8yhlr51gARRMCG4yOjiM5nF4uFXd0fGeaZF0+Il1iAmcZNwZ9W96e
	 st+UPOOaOw9unfGo5QgTYV1sB/tXz4F7LxTY8D5b1tJe227nxlHqlkksoHuOqDveHr4Lk
	 5edWVimKVekpLY1vo7ODu/QpiDHw8bDbuJ60k/9ehq2DfmLR/7Id/GtvU+QW29OpmTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IEVoEDpR;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55460A6F77;
	Fri, 20 Nov 2026 17:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F55460A6F77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IEVoEDpR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195272; x=1826731272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zFXoZ8Suc98Mn6omUidyPFbF9/WmIqRHVrDQaUVpDGI=;
  b=IEVoEDpRxgUeUud21EzQn9sYmpYo0JpENKvuilOAuLOVSHY/kOKfs0Wg
   VwdI9NQSGCMnCcs86TJrFWX7nw0bSzuUCBH9BCnfpTI9mPkZl/uXWTfHl
   6JKCGQu9AknEa1Hs85mmZ+HIuiGmNPpV9Dm59/1FFNA0VAupNKN635FRM
   jQ2AJ9+bfcPE9QwbcUz2ouKCm/cxlVmEpfO4l3nMBG2LePYsWf57JK4hj
   e6/7BdjfSsUEWOzJ8tRnhcyLOu8s0D3RRrIgKqn+zv2NIkSxm8HgID4M+
   NUjVIGJRg2tfvW9XPZAO+dNCrSTDwx+O7nDkbuj8PzYTSCaJa/T03VDyt
   Q==;
X-CSE-ConnectionGUID: 3FMCd2XQROq6STTsIWL15g==
X-CSE-MsgGUID: jRfakmEsRLa14JCWAdKDTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157435"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:11 -0800
X-CSE-ConnectionGUID: IDwwc45DSe6aUYl2+hyJSg==
X-CSE-MsgGUID: 1/T3D5jSQFGHf/N0GU49WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868104"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:09 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/42] ACPICA: ACPI 6.5 Add support for the MISC table
Date: Fri, 20 Nov 2026 18:18:43 +0100
Message-ID: <e9cc7ab5219926220c7af1e968548bb033366f00.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

ACPI 6.5 Introduces MISC table and the definition for Miscellaneous GUIDed
Table Entries. This commit adds support for this table, specifically in
compiler, disassembler and template generator.
Refer to section 5.2.33. "Miscellaneous GUIDed Table Entries" of ACPI
6.5 specification for further information.

Link: https://github.com/acpica/acpica/commit/727cd62d95fc
Link: https://github.com/open-acpica/acpica/pull/1199
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/actbl2.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index dbfea7c8bc00..3f6e093133c7 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -38,6 +38,7 @@
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
+#define ACPI_SIG_MISC           "MISC"	/* Miscellaneous GUIDed Table */
 #define ACPI_SIG_MPAM           "MPAM"	/* Memory System Resource Partitioning and Monitoring Table */
 #define ACPI_SIG_MPST           "MPST"	/* Memory Power State Table */
 #define ACPI_SIG_MRRM           "MRRM"	/* Memory Range and Region Mapping table */
@@ -1876,6 +1877,35 @@ struct acpi_table_mchi {
 	u8 pci_function;
 };
 
+/*******************************************************************************
+ *
+ * MISC - Miscellaneous GUIDed Table
+ *
+ * Conforms to section "Miscellaneous GUIDed Table Entries" of ACPI
+ * Specification v6.5
+ *
+ ******************************************************************************/
+
+struct acpi_misc_guid_entry {
+	u8 entry_guid[16];
+	u32 entry_length;
+	u32 revision;
+	char producer_id[ACPI_NAMESEG_SIZE] ACPI_NONSTRING; /* ACPI Vendor ID */
+	u8 data[];
+};
+
+/* Minimum length of a MISC entry (the header fields, without any Data) */
+
+#define ACPI_MISC_MIN_ENTRY_LENGTH 28
+
+struct acpi_table_misc {
+	struct acpi_table_header header; /* Common ACPI table header */
+	/*
+	 * Immediately followed by one or more variable-length entries:
+	 * struct acpi_misc_guid_entry Entries[];
+	 */
+};
+
 /*******************************************************************************
  *
  * MPAM - Memory System Resource Partitioning and Monitoring
-- 
2.56.0

