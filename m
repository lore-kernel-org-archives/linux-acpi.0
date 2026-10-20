Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505521;
	b=AS1AM5E3foycg1OX1MKeifvq7YKPBTgB7jz2mTe5nOkEFad76F/tS9hgyKs6BtpUf+VA
	 kwiLWucC3euhGJxMPLXWe2yszIwzAsJjBa0KN7piPesdsysvGlBTX1JVQrMgxrdLS9xU0
	 heuCzW1zJzQd9bokgoxQaToytiG+vkmGICePFd26Acdlv4gV6ngH4D0oDxf5NUou+GYvi
	 N0al0yaqlI0Ro+cQQ2E28elpcgNL20AWjPQx39ITTat8+8NWwhBbpzc4Qh3hkloPatBnP
	 DAIR3S4E/9EVV1WbM/0H0NW7zzDngnayl4OpZIXyhpUwi9LCmj1U7jPkAO/ei2JIFqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505521;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mSrBv1pJ8reH4EiA/g1Vsss520wgj2li1T8OwsdA7yg=;
	b=ZS32k2tpxI2tfsE6MoHFIew2P7Rxz+KSdMQSykg7E51V5PS+DKSwKnN/svZyBzRrImzP
	 /jejN8i902lP629c/+E4cI6Zn1ZDb1P0at1Sxd5qtLMn5xSm0SR0fSzlYOgMFce2+HRMN
	 ZROzfGrK04IYJzIcaaTR6DPs3f17GepF4s8Wzgq0KEDv+1NqCdU4yDkWTKxhr7ExwOupM
	 AHGJLL/sf0SpoLVGHghTR8QWb8B2/kF4EEJRlD7tdyT1x3uq4FAWUvg55imZAy7KmGa5K
	 LWALxif945v/HB9QMJQ5Rn7VMs5bm4O+pguKX2uLV6LTpGQDXYxRRJuZIP5p8gTdv+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R80ZDBPw;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753C606A32A;
	Tue, 20 Oct 2026 14:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5753C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R80ZDBPw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505521; x=1824041521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/TBRlzEU16aRHw++NRVCr925bkMeJ4DWEcaZ6np5Oc=;
  b=R80ZDBPwADxr1VtSwGI1pOoI+2Vo6+Z8UGqQI7g93CIoOQk2JzxYtBml
   9LOIj3UBmSOwk0wILKb8mlPIG8mR4ZB0DA0IPYuWxrXN+GI920A3WYNkt
   vdO0YPBolnnk2KJVDFbRlkXY9cjoPWFmodnTEm3iT6ib8xCY/GheRphMs
   pZz/Ktlfu3j32OtDiHK2bxL3jB3Tmrk1aWIhkA46DRN492q9K1UqaEbjp
   aBFGJE53yIZLvGYO1+GDamPNKUQJAekkNI4x3KX3gzNpFecXtr2SR1j/y
   rys3tv6cJ9S/eumYOf1MVF/PshIHdzjT9aBCkpUpoj9+lVtDXM8AXS7go
   g==;
X-CSE-ConnectionGUID: 7NqKuoyMSTaop8TZIr5/9A==
X-CSE-MsgGUID: WMT1WZofQPSY+TtFfpo1/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222315"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222315"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:59 -0700
X-CSE-ConnectionGUID: H/Tya/QnSnCsVjwxCl7+MQ==
X-CSE-MsgGUID: 8knrX78nScCcIXuwi2zcSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888067"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:56 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 26/30] ACPICA: ACPI 6.5 Add support for the MISC table
Date: Tue, 20 Oct 2026 16:10:47 +0200
Message-Id: <20261020141051.2194123-27-pawel.chmielewski@intel.com>
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

ACPI 6.5 Introduces MISC table and the definition for Miscellaneous GUIDed
Table Entries. This commit adds support for this table, specifically in
compiler, disassembler and template generator.
Refer to section 5.2.33. "Miscellaneous GUIDed Table Entries" of ACPI
6.5 specification for further information.

Link: https://github.com/acpica/acpica/commit/727cd62d95fc
Link: https://github.com/open-acpica/acpica/pull/1199
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/actbl2.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 8666169f98fc..fb706b7a811e 100644
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
@@ -1877,6 +1878,35 @@ struct acpi_table_mchi {
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
2.50.1

