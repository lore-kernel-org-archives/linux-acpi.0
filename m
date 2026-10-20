Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505476;
	b=UhuZN9jrQYixvOO5c/7zM2xBO/PpJZzGwe9OtIOb67wz10pTHcd8wp0CEePZB1wBMjHV
	 ev7DZrKHW/uo3CC9WBg4ArXH5zrnUihiy6yVyLDEDVvLTkHJ0bPn+sQbiSwOQoZ1AWIfa
	 0qWkuKNNkVvF9nmQTn06PbHOvK7GSO993TtK9saobv5OamuCSzf37dk9QLaB7M6Lcqikh
	 8N6AEMTKpFj0vq/ZLZsdEliPcIYY//Uo2S/bkThA64DEnIK60fEfvYEdFiqXVvFVrddMt
	 m+G2j23edZ42tZh1ksFLzOmUuqf2DKHHa0xQ42w8M8gRyUtHuvnWlxKL02QoKlxsUyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505476;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uBsAb5BnMUnD6wOAjfRZOVmejsztuoFKnt541dB/Lyc=;
	b=fFJzteSZ8EvLO8ZD3cAFkwJjUWix0pwIuSgqAFftSCZx/Rk+1XCkYJ1Wy3olIrFboFtb
	 RexTLLsRjs32V0gbzqsMVO9emegCgu1KVG++xtsion5iwjIYUtq/9tBL/ZHQVwM/G3e37
	 SYfgCXNNTyYDvoOtBSZPCJrlZUzDIacHN87xCuqY3QCA+P8Jw7OROtkx3uPZMQ5HHAez6
	 JhLBzEqeGhGlRncfS/7UBZxHGkC81AyRWPD+YqdUd5ewtqmLBsa7YTPKG35S27eOJX5Ak
	 4CUiXq1AhcAZNzdjTiG3bRf+HMj5YEGkXHGwyXW2+nxXlydB0EC6Staruso6uUt3vaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IZDISWkM;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816A606A322;
	Tue, 20 Oct 2026 14:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7816A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IZDISWkM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505476; x=1824041476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yG2jsvCCAXfzlRD+elhLBT9cKhqYYDT/w+CLx65dcc=;
  b=IZDISWkMj3rY3L4U8bHLo2a/dO8vXpTc6oiO5VTVxYvR2yOHBoexp62l
   B2UFsA0IzaIP1ZU3EMbJePAmNzUxdfqcb2QktKYZarBHSE6MYTmsXJPqy
   fEP8BkRDR/RtEHxbGJvSBV0KZKHltZw/hN6fiT45+a2MC9TgDp0y1ku11
   VM63HZ0M95Z6T0jL6JW3pOc+LeLWFKm+Vg9xu/S4iCfz1Q7E13JuDECGD
   QYPQqm3MbVtdEkdYJ+CMTj/ElyRH/XCwciUyxHAPkVRcgVoAv7nXQFkTp
   F3vVah+nnA9TRNfi0V98EdAllgaCYI12ukUtWyjNrPy0A8Hn70sKQTaqN
   w==;
X-CSE-ConnectionGUID: NN7M8RZ9T26e8B6/KH02xw==
X-CSE-MsgGUID: ZqexKa7EQR67kcK49kPmSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222202"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222202"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:15 -0700
X-CSE-ConnectionGUID: quxL8tzeTdGhlwViMPcosQ==
X-CSE-MsgGUID: MtXnvVDfQ9GyFvbBzK1ZDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887910"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:13 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 02/30] ACPICA: components: Fix typo: "numer" -> "number"
Date: Tue, 20 Oct 2026 16:10:23 +0200
Message-Id: <20261020141051.2194123-3-pawel.chmielewski@intel.com>
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

From: Colin Ian King <colin.i.king@gmail.com>

There is a typo in a comment. Fix it.

Link: https://github.com/acpica/acpica/commit/5c8d1e7129f0
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/extrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index 4a6c7fb147d7..27a8e81e4157 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -152,7 +152,7 @@ acpi_ex_trace_point(acpi_trace_event_type type,
  * FUNCTION:    acpi_ex_trace_args
  *
  * PARAMETERS:  params            - AML method arguments
- *              count             - numer of method arguments
+ *              count             - number of method arguments
  *
  * RETURN:      None
  *
-- 
2.50.1

