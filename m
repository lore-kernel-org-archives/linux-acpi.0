Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195332;
	b=xr7Ly2r6f7OB+MbPN+tohTHVFMbCWoyJmdyglKvaxotVuWvJ+IMZuPhUKEFy4te0G9Mt
	 92P//5RYc6OpioBEB1EjraQLXQCxPehl0bM4X1JtGghk/rfpf5nOCGxsqP1X8JVZGprNK
	 D7ttMdbtdhNezSrKuy38qe9gBVzLAgAZ55s7yQWM4r7V22mNUgY5o3oaSjKJDCklgbicf
	 4MCKuo5iSE0RfShdwupz+X4bbx2xfsi4BsiolQpRsoaTR3p7qFIS2gpky1xSZdqI6EzMW
	 XOu426Jfbipk4ObIGMlmWv3PjhKooyIn9IS0QgrigPoM+BhQlckd+AxxiOXTUJsUkFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195332;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PUUb0sVha9mz+Q5P2aB5wJO+l3MzTX7urtq3WM77HY4=;
	b=zna85RocSI5U6Tu8FBeDQkOsGmbXH2CIXm9RqvvBFU8QWegydGxAk3xVD/5xtMSAUBjl
	 b+fSM5wl0vS4iq2SSrHbEk2zZmQnw/ksud3BL97nJLhvUXV/LHtfLe/FvWLBA4tymvDbD
	 6Yht86k5TR1NsiZ3bRybt6Kt+59PewlRY0unzsQ19nHsww2t79tQZnn4bO7UGlpabr8iN
	 1PZsBLhrS25umbsBJFi+Qik8Tm199NrppioFub2i3rXHK9aSeoEI+ZoEGHqsrZwoTGZ8d
	 Mk+VecW74lt5R4ctfkL8UrwSUoatb55BUiHccBjuWA0wELuXqXT/CixbKwfGHDhSWKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZRxj78q2;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D56606A756;
	Fri, 20 Nov 2026 17:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D56606A756
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZRxj78q2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195332; x=1826731332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMhaDCLJsFJHsJoXjlaoBAIT9Wuj3F6Exo4WcsaYWMQ=;
  b=ZRxj78q2nzvEBRlpRsW/M2w4PckLYdtcpM+3xS99AkzUJVIVKdsk+pee
   H9PDu/DSmbcyqupwmhCZy+gySWht9JuQUkHy4S8/YWv3tFBrQbjj/vXeE
   kyaOjhBijDXUlgCgt6OnGXLiyvhlo536Tg4ieba3C5FDU/s8H8uCDh9tc
   cYuzTPAp8KSzJmG9E1Pizw+nquUJ11UQhl70nX6pXGdKM8db1c32BGUAh
   Ir7NDL2CbW7nBxsTtXiPS0VPXo+iFl4zMlJIdqll8+lRvZO+foqOSeTWK
   EVe05oXKlBWv+3xDU0iBsVQBvPJ5Gttg1omRT40JoZGHv8B2qAc/RmzqD
   Q==;
X-CSE-ConnectionGUID: 1LLM6u14SHCoIliw3Cj60w==
X-CSE-MsgGUID: jlZ8PEQcQf+4ooQwvKjneQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157634"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157634"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:11 -0800
X-CSE-ConnectionGUID: SAzC80goRoO+buGWsGRGxg==
X-CSE-MsgGUID: 63Zk4WsRSNixERqOnr3xEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868306"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:08 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: linux-acpi@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 42/42] ACPICA: acpica: Fix typo in the IOVT_IOMMU table definitions
Date: Fri, 20 Nov 2026 18:19:03 +0100
Message-ID: <e20e813ff50db584712f86edd2bb8c672ad755e3.1795194329.git.maciej.wieczor-retman@intel.com>
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

Change MAGAGE to MANAGE in ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT.

Link: https://github.com/acpica/acpica/commit/dee9a9e3c797
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/loongarch/iovt.c | 6 +++---
 include/acpi/actbl2.h         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 1e97669eaeea..e891170d9b8b 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -42,7 +42,7 @@ static void __init iovt_enable_acs(struct acpi_iovt_iommu *iommu)
 
 	/* IOMMU V1 only supports PCI device management */
 	if ((iommu->header.type == ACPI_IOVT_IOMMU_V1) ||
-	    (iommu->flags & (ACPI_IOVT_IOMMU_PCI_DEVICE | ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT))) {
+	    (iommu->flags & (ACPI_IOVT_IOMMU_PCI_DEVICE | ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT))) {
 		pci_request_acs();
 		acs_enabled = true;
 	}
@@ -151,7 +151,7 @@ static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
 	}
 
 	/* All devices in the segment are managed by this IOMMU */
-	if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT)
+	if (np->flag & ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT)
 		goto skip;
 
 	if (iovt_validate_entries(iommu) < 0) {
@@ -280,7 +280,7 @@ static int iovt_pci_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 		if (dev_id == np->devid)
 			return -EINVAL;
 
-		if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT)
+		if (np->flag & ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT)
 			goto found;
 
 		list_for_each_entry(entry, &np->ep_list, list) {
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 1dafb2a71368..fe767fcf5726 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -928,7 +928,7 @@ struct acpi_iovt_iommu {
 /* Masks for Flags field above */
 #define ACPI_IOVT_IOMMU_PCI_DEVICE		(1<<0)
 #define ACPI_IOVT_IOMMU_PXM_VALID		(1<<1)
-#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT	(1<<2)
+#define ACPI_IOVT_IOMMU_MANAGE_BY_SEGMENT	(1<<2)
 #define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT		(1<<3)
 #define ACPI_IOVT_IOMMU_MSI_INT_BYPASS		(1<<4)
 
-- 
2.56.0

