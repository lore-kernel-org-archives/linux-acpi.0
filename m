Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195220;
	b=oqz2nSx4Z/5KLQyzjiDiujQugSpLAiI8u8c1HX3aB3miSQYF1S8u6b2+xP6OTJDlKhbX
	 29OV0MTmDlUcu5sjXzmsO1IB3pmwmEG1+RkbFiS8GNEbQCoye7DSQ/10KyRaFpX49zHcq
	 dV5jrC7BMBPTWHYjS/Mu60nqfmaEPwGiecD5H5tH+CL/KYfXIG4FRtUlWUnpcUoAbbMWu
	 qDVVE4V95FgGGVXkMlT/kdZj+rr1yAa9tz9p4wp3xzni4CCPrr7VrRr6+hMEc55BBbDSM
	 XZ/RERwWZinove6cFFuS03+pVezzh2boG6YH4ssJKUf1RzGPmVx/2C0Or6wu+Zv/org==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195220;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Hnxe1Cm4JndOih1erNSVUTLJW3R2JC5LP4xkaz4zsI=;
	b=um+VUryqkU7G7VenYEkRDqJt1x0YYDvjWZf2rT6A6GyW67c0s6TYJjp/XiXLparAA6pL
	 8E72qGJoyaasx65S0POqSn2lDKZ5fORT2Oj2nm3wYLPMztI/icoIFB4ElD0xxVHoU+/cz
	 W88IDOdCFjV6fv2RvvPOdDKefAKFfOwRIVf9fbaNTBPL2CM7rIGnJmh6cCrow9EdzZyXW
	 C7jJ8nbv0klh65997w2bJw9xiyU3grVz3P/xDGaI4pYwIZurMUm+h1xiaLfhV3Li7f4wu
	 fEnRKIdOCehY7VCrs3vByHIAluDmcy8Icc8rWRbLX+FC5yRZqzg4OH0n5IKOeNuyz9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N+3ZJrtL;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CF60A2605;
	Fri, 20 Nov 2026 17:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 807CF60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N+3ZJrtL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195217; x=1826731217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SjrZPn+dG8keIwWn4sRcbdPByHfMsDiGeA74wXYutxw=;
  b=N+3ZJrtLUpqlgWrNbtKWKlZRshjixpahNERyV5BW8ULuEBdMo4hGVkUV
   jOBxP78zFq2DjnoYj8Z1E7OcxWV7548eBq3Q/cRppEAIdHztq2+ndGjcH
   9XK66c6aqR75OCTJ+rW019MCSd5haD98g+/yB1KAjtgFEA15NFR9v+h70
   Q7CTtMTc+BPT6yV4OXrebQ2Rqps5jSxPvhZTK02eO2Q+oiud0OrvXrwRT
   b4Io4GrJmC/yL9jLbmdmFKy5//zTYHhSkJkanZhDHmiI+zbdZGvphVvl0
   4lE/gwe2W8U34euFgbJjOhG6NPUXVsgrdU1YTOZw3A5ijTEhySewBmuhF
   Q==;
X-CSE-ConnectionGUID: 7X09uDTlTsuezZ5m17WyGg==
X-CSE-MsgGUID: 9OegPSbzRpylw7Cq+dAuxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157263"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157263"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:17 -0800
X-CSE-ConnectionGUID: B9yki4SbTT2xfSx6JES7EQ==
X-CSE-MsgGUID: THwZ2CqJTiGzDkwnjrxuzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867833"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:14 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/42] ACPICA: Introduce a new HEST notification type for RISC-V SSE events
Date: Fri, 20 Nov 2026 18:18:24 +0100
Message-ID: <59c5e18dfae7a62a7864040083e21b739fd30bb3.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Link: https://github.com/acpica/acpica/commit/f73f39352c11
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
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
2.56.0

