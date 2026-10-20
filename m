Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505503;
	b=bhh1ZDLj2N7fsnO/J/Gx+TaRsgY1vqzLCFfKAwmMCfAkBy3gLRVIKvPB13OyJpc3BQJt
	 WhZJOT8/W26u3Pby8vcjurBL9WB080WvXzvKGyTgBm5WFSbN507KjP3WrSEuVm3HmonFv
	 dbMRcplguVA+PoiM7vbI6R5z71SiLQ52xYPT3GclvE1k0ULJQgBkWPophRlv2eLAiRgWD
	 9qjwpY3v4ElW15v3BuBADM6i0AKCgSt3PPz+gFORExsLSrz5GRbR6V7W6XSyt/Jb9KdrW
	 AMwQ5FgEa0yrxcwdyY08AAsykxvB2HZS7/xVIKHo0DRrEiaODFhTGX2ZXYkX5841h3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505503;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YFXlTO7Tr3/97Xhv6ky5y4fjTkIfr+4YxqaMXtlTx9U=;
	b=4sNDmSAYaGeOosQS3K+LKuKOlDokaEs2v153bvbpajg2dsl645nIbgkyNcFhnwMt4XVn
	 0uReDgaTp+m6HwLu6VP2d73b6/Ze1csoUqJ8YWKhDxZteKijvyVFyRz/KMnPgdXVIjpG2
	 pN2WwS8bZJd/dZ2U/qmE1HLdnsaa3U/kvQ6SQif2V4PdvaQ6L4WurvnA1/lEn+REgptDM
	 iVtx98XKfQvg3GuI7jmEbI1pHKHFIdca52V/zwWDAvpQh9xNAkwanFMwPtr5RNHkrc6ZU
	 TjKk4EhpNB0ullnm1YgaNWIJ63gsEgTiOdncUIvE6aoY9FkZR9Ukw7oMhOHO/KoFYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mp79jowA;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04C60A4AD8;
	Tue, 20 Oct 2026 14:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED04C60A4AD8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mp79jowA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505503; x=1824041503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/Ok7OFFTC/VuYc5ZC9zQZbfejqno//JWUg21dpary8=;
  b=Mp79jowARboY17aXxvc10v/f+SXdzD7tnCQAGywq4uhgqTTuTOE60zE2
   4HzMk6GwTSl8JUaeOBM5VE3Ln7jg2CQwgsbLWdBFw316K9AoTYnJAME+j
   Y64F3UGENaJB8WLMpXAciDcDfxNmapnWgadNsb3ZKCilDxEDxSM9I9amb
   OvF1Hgm+PA+4hP8Pw4vPYeoZpes09wC/8uxozHtfSxingJp6HY8QbCQ0N
   m9rmYU7+jKQkPDlb9NYljsl3cWe3t0kp9QE2AnHBNONkhXHIbqYiUtJaO
   JkhrGaSwSm7bpSpF9eh0ngE5XxI9hLOuHf4k2F3LNVTtSVkemJ3OA3g1Y
   w==;
X-CSE-ConnectionGUID: J0MWxMMsS1yAdieZWV2sAw==
X-CSE-MsgGUID: otKRIWYrRX2bMkT+YzJckQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222262"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:42 -0700
X-CSE-ConnectionGUID: PVD6VZARR5mN5sIc56g2Kw==
X-CSE-MsgGUID: APGumq65QhueHP/+Qq5wWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887970"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:36 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 15/30] ACPICA: namespace: Recognize alias node types in detach
Date: Tue, 20 Oct 2026 16:10:36 +0200
Message-Id: <20261020141051.2194123-16-pawel.chmielewski@intel.com>
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

From: ikaros <void0red@gmail.com>

Link: https://github.com/acpica/acpica/commit/1ee856f62d40
Closes: https://github.com/open-acpica/acpica/issues/1183
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/nsobject.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index a4ccacecca53..49d9d917fa73 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -174,7 +174,9 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 	obj_desc = node->object;
 
 	/* Alias nodes point directly to other namespace nodes; skip teardown */
-	if (node->flags & ANOBJ_IS_ALIAS) {
+	if ((node->type == ACPI_TYPE_LOCAL_ALIAS) ||
+	    (node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS) ||
+	    (node->flags & ANOBJ_IS_ALIAS)) {
 		node->object = NULL;
 		return_VOID;
 	}
-- 
2.50.1

