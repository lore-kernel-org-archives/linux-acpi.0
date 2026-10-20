Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505505;
	b=W0kDpUdeFhyI6/e4yTF92hxKZtYvDyI1Nzk2NJHkT7CWFaVBiAPNGQNdeo0bLld9nO75
	 0KbfOlWsvPQtfPNE06tMw4XnkKqa3G/0HYa7fTlDyGqmDBCiNf2VLzdWMIaaMHQGmp5wQ
	 sXIgkxRcckAi3DcCLgCIPN2u/bcnA7tE1C6249+CbpEldLEqcgHj+11TDglPh6obcgAn7
	 Yw3ISP39dp1A7edFnolN0YFUw5JSYl7ZxyJfjvHBZc0SkDpjKLk6Xe5d5LN+TL+2gsBbW
	 A2PItO7fhCXmq5MTlmTLBCNtS93Rg546EeemCTT0lr31J/AWGfz3hW0GvLoJXkrsCzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505505;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TZY9caKXcqsaBuEoFOnS5/c+6IHqGxVaFNV1zoy0ywo=;
	b=ErDVNx5b2YswxKpMlo1HOEITiYm7v39uADuSSVoW1hSRAeXQ0CAMylWU2jPUyr/Mr0hH
	 8omYOppeLohtDkJRZr85neMh4w5Q0Ox1flQxWwTaJDie5SlKdr3h7ZoRUY7Ch5aue/v1r
	 mp5u/tdY9rWLwqkIKzA/GFuR3yfln3ItR+yi4p9Er3nYFqyQh5apI3orjobqe/XVU0vjF
	 CmWrGtXq1jiQWO24YPwPHp0xyVuw7XJaIXTEu7d7GnJxn3aRLga3z9FxURHzD5V454Wq9
	 tvB3BIsWUqz9/XRc4i9IFKaTeom+D2tbP2a/ybUrMAwv6v6D/pCYGJMYfvQR95Z81bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cS9kEuL8;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214C60A3823;
	Tue, 20 Oct 2026 14:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2214C60A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cS9kEuL8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505504; x=1824041504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKgMAdmjgsYVamwCMOcXhqNjaTprDeujz4xLsPho/GM=;
  b=cS9kEuL8xU1nbkyexZoZiNVUmPMGmGdUr1m+kh/60VqBdAiIhCDRqyT5
   t3Bny+2b81/IUsSL5vxNlBaQjSHNq2D3+IafRbgPayL1coj+labK02S4A
   pk63Ok4IYxkCX6ufvPtNmsD2RmZ63IQKh7SlIXxvBqGwfN7FkjW8DO/2u
   Qw/yQA2Xzz6jd9Kr7LHq9b0Cy0CD1ciX3MMzCnX8qzalSIkxnO+QMUTwB
   ib7Vz9Io9k5r10d9SCyNRh5XbbAloT2chKKjeGSL/gXHf/43LjUt1uvI9
   N5pMNT479oO/cOKmYVkMqFzmLuR7BHH9g8zi8Y7KkSqlVzFI6nbN1uVIP
   w==;
X-CSE-ConnectionGUID: /Slzo6XfSqOhrmp5icWPtg==
X-CSE-MsgGUID: 848lgIgqQcOfbYqZqvzMGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222270"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222270"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:43 -0700
X-CSE-ConnectionGUID: fEt9UmA7R/m2QXIPYXRbIA==
X-CSE-MsgGUID: cqB21BkSS6e9ghw4w1v8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887989"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:41 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Xianglai Li <lixianglai@loongson.cn>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 17/30] ACPICA: actbl2: Add bit constants of the Flags field in the IOVT IOMMU structure
Date: Tue, 20 Oct 2026 16:10:38 +0200
Message-Id: <20261020141051.2194123-18-pawel.chmielewski@intel.com>
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

From: Xianglai Li <lixianglai@loongson.cn>

According to the IOVT specification,
define macros for each bit of the Flags field in the IOVT IOMMU structure:

Bit 0: PCI device flag.
	1: The IOMMU is a PCI device.
	0: The IOMMU is a platform device.

Bit 1: Proximity domain valid.
Bit 2: Whether the devices managed by the IOMMU can be classified by
the PCI segment.
	1: All devices under the root PCI bridge can be managed.
	0: Manageable devices are placed in the device entry list.

Bit3: Hardware capability support.
Bit4: MSI interrupt address bypass supported.
Bit5-31: Reserved, must be zero.

The bit constants are used in a linux kernel driver outside of the
ACPICA code.

Link: https://github.com/acpica/acpica/commit/352f750e4cc0
Link: https://lore.kernel.org/all/20260717063713.3638059-3-maobibo@loongson.cn/
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/actbl2.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index baef525367b5..acbd46243736 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -919,6 +919,14 @@ struct acpi_iovt_iommu {
 	u32 device_entry_offset;
 };
 
+/* Masks for Flags field above */
+
+#define ACPI_IOVT_IOMMU_PCI_DEVICE (1 << 0)
+#define ACPI_IOVT_IOMMU_PXM_VALID (1 << 1)
+#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT (1 << 2)
+#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT (1 << 3)
+#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS (1 << 4)
+
 struct acpi_iovt_device_entry {
 	u8 type;
 	u8 length;
-- 
2.50.1

