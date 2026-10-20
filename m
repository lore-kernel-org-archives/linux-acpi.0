Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505505;
	b=KSUU5T06q1fUwZtFfd3hNY5RYln6TpSBNj9EnsQCw8JgmCYpJeuUfWjOCKiiEk1gD9SN
	 DZzajzTRHRw2ytKtYdPXcNFMXsjKvTcEMLLNQERhzR153Z0npCTj2ymmx2hwKSIJmGkCJ
	 KGCKuYuEgR73NBactZCnQIKNMZJ7cox3mo+x5eT6QmXgPDIM4SvPQQLW7ajHQnZ1AP4ll
	 JTjx17XZdPULVo49vCpwgWxSNaSHphYiPFZsVMVMfCRKvNABpHE44z39rpe6vWeg9Wfo5
	 3lSPJEkOe0+/tV1HiKfnZMnM7eHAegfQHXkZsSpA38rweeZ8Klx8fY2Eq36qFbGQRgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505505;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2BkszcjgqVx5XlmoujHjnEBXBKsVA1Aj0cLZRlZkj8E=;
	b=F910sKhbmioj7OIcltmILWOCQ/WTkv8Nl7qH5DkOcmcesOWUwnMpRRXfozWWXVb/Yiqq
	 4kA3Rk4bqHKAb/U5cX09unlj/UQ22JSVEyI9luirMZA5ng9eJ7DYIPUpFhifBjE7CzagK
	 tnrgEPzOJn+vZrIVyxtTEzc7c+dWuxxIHps8WrdwPbBnWbvmbm/Mapfy+EZDAMXtHoM6E
	 4mzcPGBtB5xfNKRn4qm1XuWgZtNJK4FZkEEn2sC1XE5oM93XV3z+2h9lMpt77BKQT8PR5
	 zd8vyH6X0H4bC8bsmkNlA2B1w99ibFgklTrvLlsgpUqBUBieKTjTCukw/W+bA4KGLvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dG5dK2Yn;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7660A4AF2;
	Tue, 20 Oct 2026 14:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C7660A4AF2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dG5dK2Yn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505505; x=1824041505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORik7M8WUFwvvAclPTNaQEexSX2cJjVMdVjcNe31Zlc=;
  b=dG5dK2Yn6pAjkNEi5nuuR8lJBliKowed4lZktbHV1oEUMQ5AfUcdkknD
   Rnypfo3udd8jgZcjEQTkVR9t6UlqTUGhXLJTRs7H/iSkY1rlCbqFbNZsA
   Cqq8HiY50ciH01GxXGdiZNuzAbUP0QrePgpWqosAWT5LK7W2PDk/Lur8n
   ZzvCXaqb/9IqazPxW3WNS1E9tqhDUVTTu+aYA6ab77AMVvYtFZxJ7H8Pd
   AO6sbhc33LxEM8Ar4b0Oyv6mda2AhG2iEM0/DoxbRLSGQfIRY6uLJLW/r
   SwLpdw5dUeQyfiVq8S96yXJd+BKHDf7mCgCgrbAlpXEkgIusbYawHndSE
   g==;
X-CSE-ConnectionGUID: i8Hug4v1ToaMvCytI6ksBg==
X-CSE-MsgGUID: pDHQPMxbTP2IRz+ArmwIbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222275"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222275"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:44 -0700
X-CSE-ConnectionGUID: jXYg8to5SEOXFFjQytXjrg==
X-CSE-MsgGUID: iADF7eITRvm5iPQ6xu9zMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887994"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:42 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Rong Zhang <i@rong.moe>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 18/30] ACPICA: parser: Set AML length for bytelist
Date: Tue, 20 Oct 2026 16:10:39 +0200
Message-Id: <20261020141051.2194123-19-pawel.chmielewski@intel.com>
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
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
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
2.50.1

