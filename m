Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505480;
	b=xbJWWgGD0eaTl2uyJyaJljmwn7uj0c6sR7bwU7rn1zifrldx7rEAGIacVciIV8NPTfha
	 bj6MEU3QIOBtJDKSxhTy2V3KX4kvhU9a1wSPc4VnPzg6AcJjrQqeaxmc1GkSXaejo/4Qr
	 3Pg2K+3N/eYJrMSPRjD+kiyDCPvZVY8QpmxA9fuYwSKwdTDo3UYTyHmGC9wXEga0XeQG8
	 hvV+a99G1PPWk/Cp368P09CpCNQTur85U6DZM1RfwWxhNS3r/iod4mCGLsHFcOHjjDpQX
	 OaAbk3bLntly1Di7cHNM7ephCAj+cotX3z9TXDVUTyy1ECPChCloTw4N/ebnNMog7Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505480;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V0BDeqW3rj1UgTx/UIet5oUS+7crvU4xcMpxQFKGFDc=;
	b=qQFYbOjWAgWCnjj21lV6JvB4YqAcAbYNXQ3miTAUjjZkl6UNlHQuBqivXgn5EZ/NLY/C
	 a4KeIdYbd+Dhp1f0BiECEtJwi8nyEwgWqXzjf78bgUOn1v8yu9SYLBahKy+wHGvdz7Y8N
	 2kxO9X5LsNUEQUfiTmYY6AL4NRTGkqECy4BPDIYbuga/G+xeEq8QhIQ0ht5WeGUVYvPMn
	 02ZE3RcwwBY0W0cG7nBt0ws7MiywPajIj0xMSZXSYATUDvkspQKFiSY6SAWkRc3o3qcgB
	 3p/0jfXB+u7ic1nXz9d92+7r57rnX7mnU76ZJ8NuUrJtA++tsN+naESvBFKxUJrvktA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ItPRp39b;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D5606A32F;
	Tue, 20 Oct 2026 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 537D5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ItPRp39b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505480; x=1824041480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6E9bPzppJ3iy+b5czdxvnfv7GkDkVybC3Fgea4irwDs=;
  b=ItPRp39bZsVZT6qMt9ds4onTby9oCh5/aHEDWpmLCl3TZc10FNamvZHD
   OTVqSuqpoD3hRNR+kMILsiteFVvZfwl9iwsUtT2bIiSDh0SnilEWSfGV3
   wk1Kxp3u0yG7PCzOOFL5Y85RBUX9qV3x3af2gh4j+2RYEBkxcDczsZdHS
   w22rfy28yRZ8RMnwJSAOuyE76CxG3bCSOkmGaWQm5REHgKXFWzK0s0O3g
   Iv/EwpTWt6/fz64iNOGE5RnP2KzoWvZWYijYvPsdYFRVoJEauYOTybZBt
   GxCfgOLE4pQLxwd7VSsgggoe+SoKqItQAtLkQEx56o5QTY49uhPfwTFUb
   Q==;
X-CSE-ConnectionGUID: 8/2/YSUiTXmio/hZ30turA==
X-CSE-MsgGUID: EtrJanJBTDOOLseod5YM3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222206"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:17 -0700
X-CSE-ConnectionGUID: N2hJmKSFRSS6/D03GEJUdQ==
X-CSE-MsgGUID: 28TZTknQRKOLi0NhXl4eZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887913"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:15 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 03/30] ACPICA: Introduce a new HEST notification type for RISC-V SSE events
Date: Tue, 20 Oct 2026 16:10:24 +0200
Message-Id: <20261020141051.2194123-4-pawel.chmielewski@intel.com>
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

From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Link: https://github.com/acpica/acpica/commit/f73f39352c11
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index d824838cb7af..73ebc089e96d 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1798,7 +1798,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISC-V SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13 /* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.50.1

