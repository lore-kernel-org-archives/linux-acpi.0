Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790313;
	b=S2IrZbPZkmr0BhkFmvGvWll2syMTme49oA0Nh0CBVCrNmc+68ETwANQkRyjHv+nOvgU5
	 5/akYJJdowfuzyX43uY+fExEVmRI+t3ONuLbZz4mgEQ9AbizyXIzyjcjw/hUKmNcaYWQa
	 eguIbQS5jxEMRlZFDL+iZdzEz4dyLTeBTnM2HLQGvyBaF6L1mNZJbzDtP1WEqBWlp5VpP
	 rcnRmaRkhNXQc6rVh5GF2geh3t+rk6Uiso6UIw83xGj25seHADtqQp4WbRQwEC31xpQiC
	 LaLaU7V9ZwQ6WWIs7KkULtoVX7FXKiTiGJ45AWcvLsW/6sTMWWbQ85FwATo4T4YyGeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790313;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zWO9fTY1l00I493GwG+dvXsBJFpaNYO5JVcgTmMBdGw=;
	b=Lrv5rdQhwRSSAz09wlrY1QDTb2z89TTfqOgrRuoubd0/h+LE330YobwEHfke8lL3tSJr
	 l35i77bxAWvA86Rk7Fu30CEtjqzGwyG+sIgRLfBESY4dt0t2m4LDc6fAsMol2S/fTLMoN
	 IIWohUui6CHr6OU5XamLT+EDtKwqwDyjJUATXkcp6GFF4JM6URJRWzz3DcK9gdtTBrTBR
	 NTvaKNudhMvhJ0OLzyshj+2JiKBr+kDkURj9mbZ9mcMxd3s13mFFA3xEuJng5urDv0pVJ
	 x+Nqlz917Le5hmXrabzlL+e7uk5p+FmzBf5UVmKDnxQ7/l65ymzRoYhO2sOm+/ywQ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UfrxxX95;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A5606A326;
	Wed,  4 Nov 2026 11:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 702A5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UfrxxX95
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF8822EA;
	Wed,  4 Nov 2026 03:05:08 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.64.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26D553F632;
	Wed,  4 Nov 2026 03:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793790311; bh=XXjfz1gd37X3boaZweOwGCsLH8DHwjpk9PRswkXYj20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfrxxX95Y0R9ll52BJW30mC1SAjG58soPASiZSlc2SM+kcTt30KhCtP7D0ibqUeYG
	 CIK/6wCx8m47PrnVAUnsz6Q1biEf8O/eZLCdrwTsqXEiwYVJ8WpAf1xSfNeaPJ9yNO
	 co8W79z3d6zd4d+23P3+bUEH0f16+ZpcmR+Cd3ZE=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 5/7] ACPI: APEI: Extract common memory failure handling
Date: Wed,  4 Nov 2026 12:03:13 +0100
Message-ID: <20261104110355.1437249-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104110355.1437249-1-pierre.gondois@arm.com>
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
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

Extract ghes_handle_memory_failure_common() to share the severity checks
and memory failure dispatch with the upcoming Memory Error Section 2
handler.

No functional change.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 663dc2e601cf..d6bbee466b48 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -528,15 +528,11 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 	return true;
 }
 
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+static bool ghes_handle_memory_failure_common(struct acpi_hest_generic_data *gdata,
+					      int sev, bool sync, u64 physical_addr)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
 
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
@@ -546,11 +542,22 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
-		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+		return ghes_do_memory_failure(physical_addr, flags);
 
 	return false;
 }
 
+static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
+{
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return false;
+
+	return ghes_handle_memory_failure_common(gdata, sev, sync, mem_err->physical_addr);
+}
+
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				     int sev, bool sync)
 {
-- 
2.43.0

