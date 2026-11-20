Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195323;
	b=tHF8O51nscjf/rhwGKXeJoY/fUOaS0MBVEeTcj2kNCCSWsjHSXsmChBoDDnTrXZEovvf
	 Uae+9X1hT0ryScTzdGrgomnLL98Qpa5RNi6VJ0Mx5hkPXRqNKOxwVqwl0uXE4T4DV6sy0
	 4KBUqLI8ww6fXrOL/mogBSbcoKdUD1wP9mMVE4a6Hag6e0TnXY4zcY23GVOIfGQeKXBM3
	 FVJxBds5rHUTro1ZSOGEir1w6hJTL1N58Np2Y2p+7CC9pSImG3mqZI6ZZbvmWFa1uRkre
	 U6/SuRqBE6JBWLWj9g3HQgr6ATm75n2NjpeCuceJ9xt0FzobfXmhMCcrzmiNI6R4A4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195323;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0LKEXFrrcZbW1+QLpKx26etI8mlbufN440M5sguwo+w=;
	b=0U3l1V1qDIHfnC6A+sNjakZcHA4nq6ro7dkJLQ3pFLr8ZaF0E0EDGPF5q6Lo9yemL6ly
	 j9ko7D15Z/adzNL42Aj6CXAP+1OYWBbZHrU1TwCXPGKEl3V6xx8tHW9T5/Yszuzlu39Kj
	 5FaM5jyq8XsXehKmzpoMBxCddoYIidCRkzI1KRF8NML/+Iuf7fVpHd6NSLwRPAWJs4g2F
	 ZRPKhQfxBF6kSs+n1j6PxiCOs/Nsh/TXHv1i4iFc+ZKqud6Fo7IX4DX8NEBBZqKbeYjPm
	 36qjuQ+4Oorugz6x67m/2tniwfslk8IRcwq9BGISwb8xC9AFRfrODNxKGK3xmkpRl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jemN50dd;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9C606A74D;
	Fri, 20 Nov 2026 17:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F9C606A74D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jemN50dd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195322; x=1826731322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+dMsLN5Kt4kDicrj1HTOeOb8hIYjWrACVK+Yeit25w=;
  b=jemN50ddr4lLOw85mxqkML3FlO85ct37nfyabNTnLx9J8VJfbAxOTr3K
   V5ZTdkuKHGO2nhmeGxplBetukgTCipUQ/Hkgyd+BKlfAQB61TwvrDFuNj
   5oaTu/vyg+fUP0TeXpXqB3k6Eh3pbxRod9KOoXcC2MAkewvNRcV8Ilu7B
   NB+MHFTcrQzHZ8mHsaB0NGDxHUGWx55jLSz3/GTEXXyl/kgoufevW2e5K
   gMZtoPOLuc9cypgnZsYsp4y4yAFuP0AqRnku24qkkmH5JMdc6RjB9DGdV
   UDjUAtTCnIyl4/YGk95BgiTZotsG6jcgZCVkNTCquT3nU3koaQHn5yXTB
   g==;
X-CSE-ConnectionGUID: HHqHv1JkSaKtqwJAueCXGA==
X-CSE-MsgGUID: Ta/AiJ5yRXqlsufwz/zSVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157595"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:02 -0800
X-CSE-ConnectionGUID: uSpSYkXmTLuuLmbG3SA/hA==
X-CSE-MsgGUID: X3+1Fwh5TXON5OvU+ODs/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868289"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:59 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>,
	Kyle Pelton <kyle.d.pelton@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	Erik Kaneda <erik.kaneda@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/42] ACPICA: dispatcher: Fix zero size non-NULL PCC buffer pointer
Date: Fri, 20 Nov 2026 18:19:00 +0100
Message-ID: <2747c1067c076700bb55a4e9f76a30905ce400ed.1795194329.git.maciej.wieczor-retman@intel.com>
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

Zero sized PCC buffers still get allocated, so they pass the null checks
and can cause writes to unallocated memory.

Skip the allocation if the region length is zero or the
AOPOBJ_DATA_VALID flag is not set as otherwise the disassembler will
emit warnings on every PCC Field().

Link: https://github.com/acpica/acpica/commit/0f58983617c2
Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 5d0dfe4ff8e8..d091453eea93 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -530,6 +530,18 @@ acpi_ds_create_field(union acpi_parse_object *op,
 	if (info.region_node->object->region.space_id ==
 	    ACPI_ADR_SPACE_PLATFORM_COMM &&
 	    !region_node->object->field.internal_pcc_buffer) {
+		/*
+	   * If AOPOBJ_DATA_VALID flag is not set the region operands is not
+	   * evaluated (e.g. disassembler), nothing to allocate.
+	   * Also avoid a zero-size allocation which may yield a non-NULL pointer
+	   */
+
+		if (!(info.region_node->object->common.flags &
+		      AOPOBJ_DATA_VALID) ||
+		    (!info.region_node->object->region.length)) {
+			return_ACPI_STATUS(AE_OK);
+		}
+
 		region_node->object->field.internal_pcc_buffer =
 		    ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
 					 length);
-- 
2.56.0

