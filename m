Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505507;
	b=FayDoJ1uSSoWxQUBCvx7z4AxYysgIwBsLY1tlp04HZ9z47RweETzrETRFWXeJTNXZm0g
	 fvUfsC8XfmEilArJYqXfi0P4Y3AQkjfz6rd2HGlO9BBaMfWGtrOUtK6QpWPohoNbj2A3w
	 ZWoH50w88g+IIDK1nh5QXtELRz02YpsiJhfKgUGXYQjnEtBnbYEoVP9JviTY8qFcIw+92
	 Y4MRrSYReqaHh6Tn1CVnN+WqQrL5okoMQax+jBe2Sdo3FQTXB7ysEnL7Ia8uAdgmPHff2
	 U1igCSjvQKpRMrmPBZ7MwCIaaO5WR/D4rVAhTZFXUBunjZ4O9SkL/0XiUA0ZbvhZ2XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505507;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qCiEp6obcdDHlYvRbGEFkKJC2SmZ9yBcCS11F46SXFk=;
	b=o1GDiZUoSNZhxX30SmcfpCgPjl0EsvOiukeT+bnFKlyY99/RT1w64h9Hfpilmhh2SLuD
	 xV2MVmZzK1Xr8f9Tw8le7t7DO1gKZKxjQnoNSuIGedOguigh0ZenGdNo78MgkJME6Pkmo
	 LZ2+NaXCS5VDbLE9D2sgweaDSwNYgnWDv1vbRvzIPTvAadVjUXDfeE+kZBuTse5EwSmNf
	 N2Tjfmzy2Q51rnw3nWLwp9ogbO1DRd5yJzHtPSg04SHAG6ZlDgHkusgMT3eZoYXx58xcQ
	 fzbC2EVrY0pQiabHx2e4v/MopVkxlVexA0TI1NYAe1NRILbuJz40F0I5/a4CNjSqiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bGPWd7on;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE460A263B;
	Tue, 20 Oct 2026 14:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33BE460A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bGPWd7on
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505508; x=1824041508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1Mt346quxM/k1Kl9TlJ8hHKZiUqxcige+Kq/v9n6ho=;
  b=bGPWd7onYE7OkY6YL2f2yY1Q+NyRtWvto5p1shuQrweCM7M2pZNPE5mJ
   vDtlRcNopHwkvzb9kI1zRWjx1OIJmaXAq1hptXh9zbamPX+pnBz2lnrK8
   qQ25mcna7rJ1jDZz3eGhbSpO7IHfs5gXHrj5jV0ft6JfdfqBVH61g9o1A
   OdwevdhxG20LCW6SksW/jRUePf0yRVk43UCZVDVhwKmp3NisH85WjVCqJ
   do7pP50V1/1n4u0ueNLVE+/30OhIT2byvGHASU29i28wKAu60SGfo0gsn
   MFywk6PXVsC+BnRz71UfFt2NG3juxLgxfNxJwRPhnl58tgwspRWZAdPqg
   Q==;
X-CSE-ConnectionGUID: U1wpmziMQcmxjYiic1Y6Xw==
X-CSE-MsgGUID: iIRCQygVS0GEZIp8y6r//g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222282"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:48 -0700
X-CSE-ConnectionGUID: MDx845v9QWutjXXJPtcL8A==
X-CSE-MsgGUID: DFh0xxc8ShS4Cy1BxaCBpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888007"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:46 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Ivan Hu <ivan.hu@canonical.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 20/30] ACPICA: Namespace: Initialize ParserState.AmlEnd in AcpiInstallMethod
Date: Tue, 20 Oct 2026 16:10:41 +0200
Message-Id: <20261020141051.2194123-21-pawel.chmielewski@intel.com>
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

From: Ivan Hu <ivan.hu@canonical.com>

In AcpiInstallMethod(), the local ParserState is stack-allocated and
only ParserState.Aml was initialized. Parser helpers called by this path
read ParserState.AmlEnd for bounds checking: AcpiPsPeekOpcode() reads it
before validating the first AML opcode, and AcpiPsGetNextPackageEnd()
reads it indirectly via AcpiPsGetNextPackageLength(). The subsequent
package-limit check also compares against ParserState.AmlEnd. Because
AmlEnd was never set, these checks operated on an uninitialized value,
which Coverity flagged as an uninitialized read (CID 1684785) and which
could lead to incorrect parser bounds decisions.

Coverity report:

*** CID 1684785:         Memory - illegal accesses  (UNINIT)
/src/acpica/source/components/namespace/nsxfname.c: 712             in
AcpiInstallMethod()
        ParserState.Aml += AcpiPsGetOpcodeSize (Opcode);
>>>     CID 1684785:         Memory - illegal accesses  (UNINIT)
>>>     Using uninitialized value "ParserState.AmlEnd" when calling
"AcpiPsGetNextPackageEnd".
        ParserState.PkgEnd = AcpiPsGetNextPackageEnd (&ParserState);

Initialize ParserState.AmlEnd to the end of the table
(Buffer + Table->Length) so the parser bounds checks operate on a
valid limit.

Link: https://github.com/acpica/acpica/commit/19429ef91ebf
Link: https://github.com/open-acpica/acpica/pull/1216
Fixes: bdc357540129 ("ACPICA: add boundary checks in two places")
Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/nsxfname.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index b6534187cd43..fcd94947fedb 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -503,6 +503,7 @@ acpi_status acpi_install_method(u8 *buffer)
 	/* First AML opcode in the table must be a control method */
 
 	parser_state.aml = buffer + sizeof(struct acpi_table_header);
+	parser_state.aml_end = buffer + table->length;
 	opcode = acpi_ps_peek_opcode(&parser_state);
 	if (opcode != AML_METHOD_OP) {
 		return (AE_BAD_PARAMETER);
-- 
2.50.1

