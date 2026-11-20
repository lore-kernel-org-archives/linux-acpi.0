Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195234;
	b=A0yEZnSrKUujJoLvcLvxnblk5xZqa3WwtjrhjgID8JCx2mVERsNX1HeJy2Zrly2hUoEy
	 71Fljfu2Z/9M+KdtyFajjbkvCzQCDtDJg1zUHzepYqghPA84RFnKJUutC5ce//VRqk8yP
	 nt6vp/Lv7d2AtIX1jJ60zL9nJAc5U5iWGCcd/kaO9U/9JS7lrFT1cFL8VbuT0WcIreboo
	 7UxJHG/OQFyIAww+zKRVBoDhKYwJkx5VsEHDEQR2Nos/wf1vnDMDX+q17d+G8yeVYoSfo
	 A+imx3pj77hxzSvLzaujqnsnn6dPvvvPDMwBK8rYjLrIkxBGQSv1CrRHOysx6jQz4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195234;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Q5P/onJTcUW81xkdYnrJMMsfvaW1X71Cpq5f5F6Drg=;
	b=ZXVdfXCcPXWIvb8bpRVSl8Sfx/O3tseNX7W2BG0BENhbosfb/g4CEAAYrGK96I0yoQE0
	 xv4cBAwPfHKuV92Nrk+er0GjHctth20QYFGe1vFP3/Trmd8vFCxj3jU/OhwbLweCU1mHv
	 th8kg5HOKmTi/Q6hDgd1kFNNDYsBoPqWILSUB+p12iDgKctj7AgaA/sXjL67B4xiTDA0u
	 jq5/PC4KX1F0ibTqoWbIbb0GLOTx4f/8+3WRoRrzLJWmBEYsHEzM2Mvcjqs2GbG/HL+sY
	 8dSZVnau7EujGH+PUEarii0UoM0I3feuM4jWhcP8cDGw5VbAHFzXuyHMki9fUg+V5cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CcnlMBfm;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03660A2634;
	Fri, 20 Nov 2026 17:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C03660A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CcnlMBfm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195224; x=1826731224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7z9Bas6WEyT7Cowz8cSJBJ4gbIfztcmfm6g/6W7XHTo=;
  b=CcnlMBfmuBnaAJDqjLUx+vqrEytcXDVGaw0s6TSZQqCXTR9b/Lukl08i
   FrZrMggdMeDfQ1QCGr9dRUlmFxGhfBX3uFGukGPSiX7I48Al8rwBpRm6E
   OMBupi02RZ4MRl8JFIvtGZR1oG+HfFitRnzoGUpMsR8YLLyxgfLrKBh8S
   V5LHxW5ipMvex+7xt4Fpq/8uRGeoI61e2IxRbY7lXa/duTrg62RnEXmcm
   lez4bn1E7mZWEgBiTZIUWqNJxiPrjJs08U3rN6ry3xZp2/qG6pTrMXmfa
   89CrvDF/HxR2TA7wJHAey/kg2AzT6RDeu+8pjyIxaKVGsgPKRS/9H6D8s
   A==;
X-CSE-ConnectionGUID: m2X2fg95Rzeqo4F62E5GyQ==
X-CSE-MsgGUID: FcHX9JaDRT6cNFGSul2otA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157291"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157291"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:23 -0800
X-CSE-ConnectionGUID: XWaC8FlMRa6GEX/ZZxkAXg==
X-CSE-MsgGUID: wPOGs+GTSg+P78z9P8k3Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867855"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:20 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/42] ACPICA: CEDT: RDPAS: Add missing reserved field in RDPAS structure
Date: Fri, 20 Nov 2026 18:18:26 +0100
Message-ID: <fa4dcd0bbc16ff6e9d7470c38d68f968bfb91004.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

Add the missing 3 reserved bytes at the end of the RDPAS structure.

Link: https://github.com/acpica/acpica/commit/88d82d3ae53e
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/actbl1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 73ebc089e96d..5b4207af046a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -590,6 +590,7 @@ struct acpi_cedt_rdpas {
 	u16 bdf;
 	u8 protocol;
 	u64 address;
+	u8 reserved[3];
 };
 
 /* Masks for bdf field above */
-- 
2.56.0

