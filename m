Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195232;
	b=LEpaiTYAJ++ACTdmK7o0SQyc/9yX5O43hzq8fK2GUreirlKfXflLloFBR4UX+L7CfEjL
	 vUUd/fPDyzh5DVPrwBNXhWhcOGAZXUH+eJetIse0TeVzbyyaL2/UpRTutm+I7QcI6k1Wi
	 yilPMviukghRPxYSN1r9171sQh0Si+PmOQOBhNn7WIGemDHdyHTzDEMY1ckzd9VtGhcGl
	 zwu6JxU1GRy0sfxz8CP+onZon3jBQ8G11MnUzAilio/XvAY2hqNbeNRGbQ/fKSLIYTFZ8
	 auxgaaJuq7nlzVhS/BZA4g7e2UFQF2V6DtGzK3nAtB9YvSvEIeXRKlD/CzKGgHkSuFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tC0y5OPQI+lgwvTV+5FizcoEFO9EStGTpf/MJaL1HrY=;
	b=mj+Sao63J7F7UAGisqgLVi3BLbCpiZU5Og13yWIzrq4MssPwzmGfh3TYu47Icf5kq0Br
	 bY63CQP0xHEIU0yIbG57g8y+5nScUfSVkZnTm1tP7Py213ZNX5mZt/2/eUPwc4tETatMn
	 AMsL5u5lJQ9XT2/Z9cCB6S3/+xpFlYYe9LESWkqvH+tT/INljjZB+lA+1VM6Az06Zvfp7
	 knOsRrnJNz+mdeJuaz1WAwSEZGC8F3nZ2beheNFTxh5LzoK3dwGbfqEocceGcbZA3F0xn
	 Barqq3pZWhHLhb2SpAzI95oHgwA19vcuhzAZTMkc6buvFRaKF8sCvlvnm9YqhQNsTjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=If1YAY0o;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB260A3807;
	Fri, 20 Nov 2026 17:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBB260A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=If1YAY0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195226; x=1826731226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXDw8y1OPfs5v27YAVnr+SYY4fb37hufK8wKV9W4ylM=;
  b=If1YAY0o1gqJtdjZn5oa+IKnhte1MERmm0y1qxpM4weCPpfo4WuDUhtC
   1pdkW+fqCJdHA4b1N84sP6AEoFS56nf3kdoEGXRQgSp2GT0mMhm6+suw/
   z1NMJwC4Jld1InzT34/Pk9U8fQAUbU3OYV6v69w3LR7pEmEYXilNjvLf6
   ZkIfkeIaX8ua1jzyyuwYg/mu2jEyrI764LK7NZVM8dx6oT5i3+48lrtIl
   g3f7kWKdTZbANLaN/WYDonLbZlsFnXwc03xzoE7mf4pmOeXh8vXGjt1eb
   atmT0gyMg7KAGSQrXzTAK0rVSEFuhvK0POc8gT9Meey98j8C30cMOPakE
   g==;
X-CSE-ConnectionGUID: bj9V7xb8Rj+NTb+kJklPoQ==
X-CSE-MsgGUID: gg4BySy0T46rrL6zjlp5AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157301"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:26 -0800
X-CSE-ConnectionGUID: vbnLXLy8Q+mVHcHGr9p37g==
X-CSE-MsgGUID: bPR38W2KS5Ke8YWGIdkzxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867865"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:23 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/42] ACPICA: CEDT: RDPAS: Fix incorrect field positions for RDPAS
Date: Fri, 20 Nov 2026 18:18:27 +0100
Message-ID: <24493c0a326677bef5c42fc8ed0f09397b13ddbc.1795194329.git.maciej.wieczor-retman@intel.com>
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

The 'Address' and 'Protocol' fields for RDPAS are reversed.
Correct them by swapping the positions.

Link: https://github.com/acpica/acpica/commit/041416c33eab
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
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
2.56.0

