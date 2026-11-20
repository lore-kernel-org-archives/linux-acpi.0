Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195266;
	b=SdHwuD9dmW75AnHMdKKca/7uRvUVoTCXog8LN75DJAL+ujcaExiCZxKqCQHsMbEKSAsu
	 tFRkY2wVmhuWbR46PyqDNq1/xlMrc+aEAgMtdOjGSlC/Yu+vyF1ZvYW/ygLPJPKAaXRR2
	 SeY+ysj2u9LhB5XTq1A6peEd1XngihEbPpSFJDJ1U90Si4yzggckDKfWgOX4+nTWoYfo6
	 7GjLulZ1se/f2RPCLUm/tJxsxZzAoqIHyagi1yplTJwgY4jQPDD+kauWXeWGP4aoTpzkP
	 T5Cs1T89Mp8+hFxqbgrnXgidJRZIe/yv7H0tWudPJ/SQMpz61rz3SPwfmuPJv66onog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195266;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIIaj3sqQnfJteZE12ujJn6H9pQzWDcexXx/Al57YXc=;
	b=KyO2nFsWLx3mXy2S7vSSJdkJp9Cmavm/Tb3LDVGGjF8zoLAQGOIoeor+pzlkgjQauWHH
	 w2MFe1x5oXhUTXEASJS67wSa3JY4HpN9WemKPmw6h19THxHlv/0AGz2Ix7OfU/b+K5T/c
	 Oevu9iECS5TzoPlmmdTXwSzBCN972yRIY9MIWyAwtJC6zEl+bDCgLnRVpWJT0BgY0zuC0
	 kD59JQHsSyokN4vTggLAmud73FH+V9EzpKy6f+lAALiK6Pn6RCTabLBR7xh5MCZhTf3NP
	 1ucaZEn9ZXj9HgZ2O0Bi6L/rsuFnDBmLjmvBNw1d7fZAWQ49EyAIlNjB0KgFh19KUzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDuKoIwS;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5CC60A5BE6;
	Fri, 20 Nov 2026 17:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D5CC60A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lDuKoIwS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195263; x=1826731263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VHgojWTTgqHUg9gLX8EIQcohgFrnGm+WjLPweoAYLVU=;
  b=lDuKoIwSEuW05Z/DJQ0jGA2+hOl6VMH6g4m7uNF7HUM06HcdepZF1lIY
   Os7PTV4wReHZpW3MoC0ANLxq00IDh2uTDjNkaYNLICm8sXDt6LQLc48lE
   Wf6beH8Bm4VkV8XezNNP/FOZvwprX0VN9wp7cQhu1QN/9t/zDpF2eKI+t
   gMO5uG1ui9t+pBYyQWCdYYaYv37oVrTEPaxCj3TbCrW9W+twspK2mHTa6
   HX8NaS5Nnc1TZyLxqSt62G4e+OrE5odXozSa62ryadS+vxPIGyg9WCrM4
   2dL1izTH3n4o3fA7kxOgk3doQJr9WVdsoKR4H5zWrkyPGXLR8C9B7be7Q
   A==;
X-CSE-ConnectionGUID: nUj4cd9SRju4Rw59OidH/A==
X-CSE-MsgGUID: Ha28zPMvRnqEhjACXK3swQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157419"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157419"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:03 -0800
X-CSE-ConnectionGUID: 4GisYBsNSP2Ovo2NUqNJKQ==
X-CSE-MsgGUID: 4xJsj3aBRFm3++5akp/Xyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868038"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:00 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/42] ACPICA: namespace: Fix possible underflow and NULL pointer dereference
Date: Fri, 20 Nov 2026 18:18:40 +0100
Message-ID: <06aed38d0201b7ff7c088058e7b1625660279327.1795194329.git.maciej.wieczor-retman@intel.com>
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

AcpiPsGetNextNamestring modifies ParserState.Aml. Since it can take on
the AmlEnd value, further instruction that do Aml++ can cause underflows
on pointer arithmetic that's done to calculate AmlLength. Also the
return value can be NULL which is not checked currently.

Verify that return value is not NULL and check if ParserState.Aml can be
incremented safely.

Link: https://github.com/acpica/acpica/commit/ff5efd5d4ee3
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/nsxfname.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index fcd94947fedb..c0466139fd96 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -519,6 +519,14 @@ acpi_status acpi_install_method(u8 *buffer)
 	}
 	path = acpi_ps_get_next_namestring(&parser_state);
 
+	/*
+	 * Path can be NULL, and Aml can be pkg_end which combined with the Aml++
+	 * a few lines below will cause aml_length to underflow.
+	 */
+	if (!path || (parser_state.aml >= parser_state.pkg_end)) {
+		return (AE_AML_PACKAGE_LIMIT);
+	}
+
 	method_flags = *parser_state.aml++;
 	aml_start = parser_state.aml;
 	aml_length = (u32)ACPI_PTR_DIFF(parser_state.pkg_end, aml_start);
-- 
2.56.0

