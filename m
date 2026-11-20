Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195294;
	b=nQGpBpz+7Bkp4lo9jsvV05OysdakppzpG6lpZ1ZzXCDLAvPcc4/lNrjkU+xwNUFShFzP
	 oVKj+o2xhC4gc9dXhEDKPMnCs1flB7GXMAXZy7ZkrT/ERhCsMgZdF5A4fo7HBkk7n6Q32
	 ssOtqsiWRYMiELDDVpTT1mHENTW+nUiFw/I90/5U9MEFuzaqLcCe/VZukfGPXmmb2nF9q
	 sa2DaaFJshFeU2yAU2UllEQCYHvw89fz+k/TeCVreDIJdo1kBarBoJd5pUxbMay5kc2U7
	 BOh3u2DbmNnghwaBONTefvLiwnuqfH+zO4DwTECK39DV/PGJt80b7Dkq4NFX06YfA8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195294;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uh0h/NWGZB0gU+Sbi2kIhBH4+D7ZPc0i9Ti7NLqxMvk=;
	b=WGOX7/OSvMd76wfAn5R6lkysniTs5syXa2sxjXm+opir3sqQCOLT+Q7wut24h1593QvC
	 Egla7x7K2FfpZWggpHiS/WG03KRwhAN+mIVD0TF9HVo+1Eq/cNzQv81ngKknJYVfgjf0r
	 PhqIhA1O3TQrp7Nfta3IYVFES3XOpy3TGQ46Aft2igCkSrrxRUb83wHP46gODvoDAhT9m
	 UoWwJqBbqCrqvZoDVdbde/KkhCH1LinIvP8/cO1qI14s8aLJriduHNfURI9ThxS7LFS5T
	 AJ1T+CcPwCHOTVKcvAcN31B/GT1d+4Cdp0U7EfF0hXPT7DGeHeJ/5Hz72aeL1GMDzFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="bEa/29wb";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34860A381F;
	Fri, 20 Nov 2026 17:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B34860A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bEa/29wb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195284; x=1826731284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wt/0GyyCP/XOuyFnf358qLapGc12smKbmHr+dLhaH+c=;
  b=bEa/29wbYfS8SDcr3CK3TMNnvepV3m91uUZ5rgOmntmIyvKZXFKkK1fy
   X/hecRrB92xS0GzDn8lN5qx9Sbw5wn4lx77TLJq8G61lHky//ibnMtUrJ
   F2RqA53mssCbE44buoDCMaVkDhx78iIm69G3BWBZ9D7jLyKVYJjG1FAT8
   6odqNP8yGLzWZaSqCkUAk9zRdbkgxSxC+Drq3jP95tZ3eW5HUCb1xh/SQ
   0bOosxebYsXqZhvMIgR27nakdvyRqSExcdi3cv6APASmoFLqFBu5HzJmo
   szI1rUmQzj1oLGphO+jveXe4rV0XUG3JIO4YWdIBn7tzXp4X/1d+BgoEg
   g==;
X-CSE-ConnectionGUID: w3Bgv2ZXT/upMwzVQg1buw==
X-CSE-MsgGUID: AGNzxyWzRuOuRxBQvGd+1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157482"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157482"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:24 -0800
X-CSE-ConnectionGUID: HnNbQEwlRCK5akyr6REZAg==
X-CSE-MsgGUID: Mdg61pORTJuETMA7oVNI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868156"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:20 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 26/42] ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1
Date: Fri, 20 Nov 2026 18:18:47 +0100
Message-ID: <28fcfb138c8630dd69e738306a79afb3dae29410.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Andre Przywara <andre.przywara@arm.com>

The latest edition of the "ACPI for MPAM Platform Design Document" (ARM
DEN0065C [1]) re-purposes the current Reserved2 field in the MPAM ACPI
table to hold an offset value for the MPAM Firmware backed interface.
Also the MSC structure gets abstracted a bit, which renames the Reserved
field to type, although it stays at 0, for the time being.

Rename and describe the new fields in the table struct definition.

[1] https://support.arm.com/documentation/den0065/latest

Link: https://github.com/acpica/acpica/commit/4f4a36a99c1d
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/arm64/mpam.c | 6 +++---
 include/acpi/actbl2.h     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index c57bd367922b..671ba501379a 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -331,14 +331,14 @@ static int __init acpi_mpam_parse(void)
 		table_offset += tbl_msc->length;
 
 		/*
-		 * If any of the reserved fields are set, make no attempt to
-		 * parse the MSC structure. This MSC will still be counted by
+		 * If the reserved1 field is set, make no attempt to parse the
+		 * MSC structure. This MSC will still be counted by
 		 * acpi_mpam_count_msc(), meaning the MPAM driver can't probe
 		 * against all MSC, and will never be enabled. There is no way
 		 * to enable it safely, because we cannot determine safe
 		 * system-wide partid and pmg ranges in this situation.
 		 */
-		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
+		if (tbl_msc->reserved1) {
 			pr_err_once("Unrecognised MSC, MPAM not usable\n");
 			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
 			continue;
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9af7c51d1297..8e0d5156e6d6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2004,7 +2004,7 @@ struct acpi_mpam_resource_node {
 struct acpi_mpam_msc_node {
 	u16 length;
 	u8 interface_type;
-	u8 reserved;
+	u8 type;
 	u32 identifier;
 	u64 base_address;
 	u32 mmio_size;
@@ -2014,7 +2014,7 @@ struct acpi_mpam_msc_node {
 	u32 overflow_interrupt_affinity;
 	u32 error_interrupt;
 	u32 error_interrupt_flags;
-	u32 reserved2;
+	u32 mpam_fb_offset;
 	u32 error_interrupt_affinity;
 	u32 max_nrdy_usec;
 	u64 hardware_id_linked_device;
-- 
2.56.0

