Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195318;
	b=zF2BZzJA6uV3yOsyCF9wnjpUjr1ysDaVejjUFWesUQz9v1ixzHqZ7RYmZrvy4CJQtc0S
	 6I55SYk+H/RrHONd7bXdbssamFZyQQDPFlGqcn9ulpK5/uCMMtLuDadoCLBtW9RZGWxDw
	 PhfrARx5fH74X57KfaLYqxmjhG7p3mazagBO118sHsbwLVOErDZPXA96xkHjihwDNrU/W
	 mL/vfmkdTL0gKwH4FWq+vCkhcI8nOnqNQWgScCfO4ZCxa9sKVOIbU5a83p2OpBxiLC4da
	 nYoy8r6xVst3XXSYFCraW66JSdOcmFxACmz3zItQaKuDOhjEiYmyvmm1IJ/fErR2/cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195318;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kgSWJLv4kDxZkRHPxzXjqLjTOrzur6vRyUHL5kqxuIg=;
	b=K3L//MuXqwPvJwVYfoPMK5NTa+20/iRoqrYIxetHyvACASC1DUi3b6FED53g0DyLs37u
	 P5ksW0Y0jp3sU322cVGXcQMRaavlmB3Bs/y1Z9s1N8vWNXcPZu4nrw75AYAOH8K3SqL2j
	 iZ5c2HsODJmuWi4hLRl7TXJCiQ9LlL/OZmSNwZS0ZkMJLjwjgHqgfwXDGBaJBwT2DpTbQ
	 3HWFEzcfXD0rOgy5FVdDciygOx4TGCfC2LRoAbk6uP2oKVoyqaRoqGCRkH/2C2EOmgMBu
	 Ed9wlrWZJrBTRDUVs3mIMtLiiAyd9h23vgciBZIQgrnJ39s2TkCnQ7D7TLRYNbWDCeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="LeI/P1Mz";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55860A6F75;
	Fri, 20 Nov 2026 17:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B55860A6F75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LeI/P1Mz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195318; x=1826731318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TnrUJ0qQJO++y0gqtSjgrABuyMvnEmme270OYFGBSEw=;
  b=LeI/P1MzCp1rqc16kj23f3CQVtM+jYi+Oo6KfZXFzvjOMF4aW6Re1gUn
   OymRZtARWOPe4zlASIzZUrsIf/2BPZGVsKi8rRmmDYW+bQW/g9XQkQEtN
   yFTr/D2ZVPf3zTw02EQuuM3xP+/kgDNQHFA9/8qD/4SPHSsGoK5F9Bw6M
   OVCIUp30ILYgL1K9NbaSDLXwWiOrf4U3eQ0dKT4aqTg5rrISKH0RLkqt4
   GfmCoYU7lnT2dMpSGyTStiQWc8JrsLRbI2N+Fimxg+8EHOiWEhP6ce3Kp
   NQz7m5R2MSTSI1jrm4TycIT2c76El+GAn7laCBBddDvuxSFjlkpN/TQb3
   w==;
X-CSE-ConnectionGUID: l68cRQXaTOmrSE07odNl5w==
X-CSE-MsgGUID: diC8fiSoSHSzv9G4iMpWZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157574"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:55 -0800
X-CSE-ConnectionGUID: 1Lr35aWORxKdrCWgrQxTdQ==
X-CSE-MsgGUID: 46GAd8aNTIGn/HewCipKCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868272"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:53 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/42] ACPICA: tables: Fix global table read missing mutex
Date: Fri, 20 Nov 2026 18:18:58 +0100
Message-ID: <975f81fd5d85c44c41e289d2a7ce29497d98bdf1.1795194329.git.maciej.wieczor-retman@intel.com>
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

Reading AcpiGbl_RootTableList.Tables[].OwnerId without holding an
appropriate mutex can lead to races if anything modified the table after
the read.

Use a helper specifically dedicated to reading the OwnerId.

Link: https://github.com/acpica/acpica/commit/ef7cf3f3def2
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/tbdata.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 1cf0a46b3539..94ac355daae7 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1059,6 +1059,7 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 {
 	acpi_status status = AE_OK;
 	struct acpi_table_header *table;
+	acpi_owner_id ACPI_UNUSED_VAR owner_id;
 
 	ACPI_FUNCTION_TRACE(tb_unload_table);
 
@@ -1074,8 +1075,8 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 	 * If any matching GPE is currently dispatching, AE_ABORT_METHOD is
 	 * returned and the unload cannot proceed.
 	 */
-	status = acpi_ev_clear_gpe_dispatch_by_owner(
-		acpi_gbl_root_table_list.tables[table_index].owner_id);
+	acpi_tb_get_owner_id(table_index, &owner_id);
+	status = acpi_ev_clear_gpe_dispatch_by_owner(owner_id);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-- 
2.56.0

