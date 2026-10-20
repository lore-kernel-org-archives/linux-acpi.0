Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505485;
	b=sq6itA4uo0x4xtgPJUvano52aLhgRmb1gx79PyQkIneHtNCmL7X1Fyt0Jj8KoesfW3Yg
	 ynVRlL2sHqQWB532xRAPTs70vQ88iaBA48ItBDjWkX2MncjX/oRcVvOquSinEuPL8+0kR
	 ujuQUnUKR6J1CfCLX8ORdK39DDdGqlYiqwQio6oeWJlUXkiuSWILqMjMBql7XWciuN0Il
	 2LCS+5ekaPTJWXw4gVZXm7TdafglrX8GOCX9nQakj/s1Y3eaaWaVOHn+4/Bk+BPHO2TzM
	 6FpkpBjhtPGZELYt8YB9S4D85RmVr5WVHOeiUqYaNdte3vxwa5Z8XRbQCS5U43LQpGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505485;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LAHcx8B2gd/TFPqnkf8k2njwEubiIKnvnEGWZw45sH4=;
	b=pYm+Ejxk0WoKCeAL7vLgAWdvcjHAjXNdcaCd1xkEsOS2E0mZAfm3rL984fYJL6DJKkid
	 lTWo0pz0FHFyfNAz2hCz2OkcMqQJWtm30pO24vb5aROseWh3FA9cbxgUWeFi7gT/EJDaP
	 Mzzitx/1n0+PE3NibAvYA1o80w2N8JrNCL8GWcVRZA/IWAi4Uv7nxc8Iv9lOVSs0NYJHX
	 DieYdK+Ei1ZTiim53EJ49j7XhyV9k59SWsBkgd780CYMntfIqZOtbqbfjn9aIYuUpY3E6
	 ggyjv8PwG4vggSMBgse02fRZmuG8ACN4IzHnMGw/drV7+pQySutjSweRWGen8DLmVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hZf8TRHZ;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334660A2601;
	Tue, 20 Oct 2026 14:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A334660A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hZf8TRHZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505485; x=1824041485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uHRWlhpYIWlN5XBTXjwWZdhZsVT1Jz9yP8oACoC8Z30=;
  b=hZf8TRHZmYa7a/dsQJQn4tfcmbaHw6fbbb4zrrtYW9C9T+gAlqAfxBOC
   wcu9iClbY7mGPNjr9bWYVPQ6gGbZrLcCkDe6/z4/KLhP0JP06Q4IB7TTt
   f3COdotTOuHPcZ/64XEoofADmSSF9v6hLbd7vjmxwclRNk3z3b1UzyW56
   Js7/DL1SgOw0OYaF6/kUmv2m0ZzXX5ulgdPeRmVmccR1QMLZDsZebKgBH
   GimFQUqVtNgIW9j0KG1QQdi7C4AJUIq11JJFf4LOWfIhChAoWY8cgmZFY
   11pVw23DIjoPpSRbPZlOJuNABgAw9MxqdfVRdvaPbm9Ahb56qlLWZTAUm
   g==;
X-CSE-ConnectionGUID: qiHkxt0NTHSKROHoj6FgaQ==
X-CSE-MsgGUID: g58WqKnFQGue9+jPNqst7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222217"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222217"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:25 -0700
X-CSE-ConnectionGUID: ovgsMM/eRkOQlO4MaarmRA==
X-CSE-MsgGUID: UscZxrmuT3KWJJSGyI/Eow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887924"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:21 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 06/30] ACPICA: CEDT: RDPAS: Fix incorrect field positions for RDPAS
Date: Tue, 20 Oct 2026 16:10:27 +0200
Message-Id: <20261020141051.2194123-7-pawel.chmielewski@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

The 'Address' and 'Protocol' fields for RDPAS are reversed.
Correct them by swapping the positions.

Link: https://github.com/acpica/acpica/commit/041416c33eab
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/actbl1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 5b4207af046a..3fa9cd46271f 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -588,8 +588,8 @@ struct acpi_cedt_rdpas {
 	struct acpi_cedt_header header;
 	u16 segment;
 	u16 bdf;
-	u8 protocol;
 	u64 address;
+	u8 protocol;
 	u8 reserved[3];
 };
 
-- 
2.50.1

