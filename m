Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195256;
	b=MBfRpQh3vneVDod5TVnRbfeKFO0juxZYV1dEOye42lTa4ZYTla58s2WY8pvrQvdRueIl
	 9a9O2NSFsm//d/5bzzuxQbHb/mGXae3cvIeMhlAQsnF6M+82vY8F9ypODso+sMuUcJxb2
	 lHsJY2B9zSaAsbqAKRFD9Rr8LA7Qbus/fi2RvgINjNeAwCVINP/1/VYWGD0HRJyUaryyX
	 obaBDTSLKj73DI2fTztU70uoxh/K4HZF3iFm8473jLq2VMppmYnE+7YB+lUMIOzCGvtHX
	 3Jk9Cg8ZgKkKULHCdTnNeorUEWSajPbBTGcrz60zqp6BR4invDUlXYBgoa/ppkjvARA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qJPHQhYfedjCOJYrgLzd0ECOSbf8JTv2hZq1jKTSmrI=;
	b=ltSJLGjAPopPKTSn01FMfyAl3gI1L6nCP0q/EIJL3Xy6jS7dECX15YeQCc1UW2k/jmQf
	 BjuYsQzvEZfNMBMgIQ0bYYmJIqC2iuV9u1eclUSTbmeJ0TNz8IVdRl1ALtvNIdE8Mu48N
	 NAWx9HxKxIVE09dVZa26ln2qYemlepTa5dq3PoPoUkqhI+AvXvnQ0tt7AVN4bQibEgGxQ
	 P5kNQ91Vy+rRUMVp49uOpdt76xeCzELu4l+rU5Ag+XFo/mkqrBKu7jBAajomRxJRXL5+f
	 9KFA5DncMT+sWreFEVzRa2xqzuNtLqeOHuimB9MTSBfPS5ekuA9I60x07XQD1OdvahA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KoARb4BS;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DC60A3834;
	Fri, 20 Nov 2026 17:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 657DC60A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KoARb4BS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195256; x=1826731256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ultTTMBLv2vDOVju1DP16lSpu87uKSHH9VOkiMbZsK0=;
  b=KoARb4BSaGdF5/vnOOCHp00vg0+VNjUrXNE9RvJPeXqEWmdcGAyxZ4T+
   zsYNiLyJ17TG915kPXYFeujIJp5BbhBdM6bxHA6T77M6Wgk/omugENKwZ
   T8SPZ57TZKAguEgelGV4VVynTx88NyPro+9fed0NfpLvp39CLPHREpOAs
   FBN99yZ/XmbCwKWbANerh7v1E1DprUYZnr+NGuQIdGvS/QyM12R0WCsmo
   YpMSq7OpfBhIQODAoBr8ZtxX/68aDrTy15HRy2CCvhG51OheCz80LIrMZ
   /5YVEYYjoAzwFORIf8DCMz/rGSq2l1R18IJw1euaIdEjdpvNLsTqPrAMa
   A==;
X-CSE-ConnectionGUID: jGC59BfKQt+bufSyMARkOA==
X-CSE-MsgGUID: 1AY3bGVIRuuLPfkXq05Q7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157402"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157402"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:55 -0800
X-CSE-ConnectionGUID: iw8AZoajSvC0GCTfN3JU/g==
X-CSE-MsgGUID: X3200TdbSyOFihYGkQAB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868005"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:52 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/42] ACPICA: parser: Set AML length for bytelist
Date: Fri, 20 Nov 2026 18:18:37 +0100
Message-ID: <d32f3fdc439e5aa8153a14f5ea979465b3ee87c4.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Rong Zhang <i@rong.moe>

The sanity check introduced in [1] leads to failures for
resource templates. AcpiDmIsResourceTemplate compares the Length
variable to BufferLength - the problem being that Length was never
set. This causes the decompiler to decompile valid resource
templates as plain buffers.

Fix it by setting the AML length properly.

[1] https://github.com/open-acpica/acpica/commit/3ce09021b677

Link: https://github.com/acpica/acpica/commit/bb546a65fa3e
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/psargs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 4643c839df7f..b0f5a11f9696 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -760,6 +760,8 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 				ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 				arg->named.value.size = buffer_length;
+				arg->named.length = (u32)ACPI_PTR_DIFF(
+					pkg_end, parser_state->aml);
 				arg->named.data = parser_state->aml;
 			}
 
@@ -933,9 +935,9 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 
 			/* Fill in bytelist data */
 
-			arg->common.value.size = (u32)
-			    ACPI_PTR_DIFF(parser_state->pkg_end,
-					  parser_state->aml);
+			arg->common.value.size = arg->named.length =
+				(u32)ACPI_PTR_DIFF(parser_state->pkg_end,
+						   parser_state->aml);
 			arg->named.data = parser_state->aml;
 
 			/* Skip to End of byte data */
-- 
2.56.0

