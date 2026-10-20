Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505479;
	b=TCqG16o4yQTJZ3g5Xifp2oS0OFPi9CNEMgCdJ0EBwyjk8QkY/CetBJKZuzwUTvoTp51V
	 ot1wHPZ3VcF+MMALMtjklnquWE5JCtNwNjpW441xHByfnCMtPMUoAsTg7AD32b/quGBEY
	 qJUCtR7jTeUJJuPBvyZFnYxtdx7fmXRHcvXjL9grQ+LPhNMAjEFXl9RpBwnyPfb/67krK
	 eCcCG0L3jyQmjpyZcwin6cQ/d0bhH0ep+ncyeAZv3WmAOichaf/kFKlzTB+s07Qxnb/r9
	 gNrMr9PN30a6XenBlZ0dO0drgx9+N021uGCaTbrumLR8rqGHAhqxpSNew+36uo+FS4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505479;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6387roAUY7kOobRj8ASwm4q2TdSCrixasARnc0YXNUQ=;
	b=t8pubRabmdtO00Yo2mDnwRnTRxwu0qQW3Z97kaM+GrmUqkI163P5DePo2LUyV8jk248r
	 CApivecqCOfzOrlhuFVT1F49I1bObAM1WD8NZXtzm8uG4nylYNVRrqAkMvNgMrXMzoRxj
	 5Wq0NXRxXbjdLxlErJn78ZDruMfw1kRwUGOBsTMFswjHhAKRbM4vAcHF9MZm6qZO3Z3aK
	 hyTsp7fP1KnZprqtjpBd1KFyFo63C5xPxAGTHy3To1B26u6/vLQOHIg1JPE8V/g0iZAVb
	 +sWfdijkmV4b3XgUjVoMNimNuZYcwSZgDI/nr0kCszSktQO7xfSVLl+H9sUvf7yC0fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jmSE/C7o";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375D606A336;
	Tue, 20 Oct 2026 14:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0375D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jmSE/C7o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505480; x=1824041480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ho5wONgr6OGGw3TazYHLpJKHFiQg6ve0OA94QO+E2Qc=;
  b=jmSE/C7os5sqTShj4lKk9Drv2tYUNpArR9Fi1HcXt3NqlIKYFdD41hPA
   knTqDJIEpT3AKZ67WzYfYDtWd5GwTCBUKqhhc2Rji3yL9VEmp7NztEQ6q
   uNMi8zM4Vf8xxPP5bFBfiVgW1iEHZHkTFeJ9LMtNIXnWjmu3LwHsQFlg+
   vLbXDDygQ2K0PwIys/Bi1CvKhno4bMReMNo5fVjbyxDOV4R7gxK73m4AF
   bqeSzRlweRQIRvWnK6g9y4ml9Sa/sS2XYP5p6/dkqZixqWxSWeEYhURFH
   xYLdYSCal165Ncs56pOHkm8SbhWBsPvFLOHLSEp/QYJng0iWmGKIAcMoG
   A==;
X-CSE-ConnectionGUID: OevgV0+sQMuNWPV2NqTluQ==
X-CSE-MsgGUID: POEM+bD6Ts2BUjqUgYnKHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222209"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222209"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:19 -0700
X-CSE-ConnectionGUID: 8H2mVjOFSR+fEXphEoiMUg==
X-CSE-MsgGUID: bVg+gbIGRbujW3o6ml8jNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887917"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:16 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 04/30] ACPICA: Utilities: Fix for AcpiUtVerifyChecksum warning display
Date: Tue, 20 Oct 2026 16:10:25 +0200
Message-Id: <20261020141051.2194123-5-pawel.chmielewski@intel.com>
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

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

Remove redundant subtraction which is done already in
AcpiUtGenerateChecksum.
Looks like it is a leftover from a refactor [1] where
AcpiTbVerifyChecksum used to call AcpiTbChecksum which does not
do the substraction (like the Acpi(Dm\Ut)GenerateChecksum does).
Found by using iasl to generate checksum for SWFT tables.

[1]:
https://github.com/acpica/acpica/commit/8ac4e5116f59d6f9ba2fbeb9ce22ab58237a278f

Link: https://github.com/acpica/acpica/commit/9b2b1dd021a6
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/utcksum.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
index 040e34569ac7..1be8b5da055b 100644
--- a/drivers/acpi/acpica/utcksum.c
+++ b/drivers/acpi/acpica/utcksum.c
@@ -58,8 +58,7 @@ acpi_status acpi_ut_verify_checksum(struct acpi_table_header *table, u32 length)
 		ACPI_BIOS_WARNING((AE_INFO,
 				   "Incorrect checksum in table [%4.4s] - 0x%2.2X, "
 				   "should be 0x%2.2X",
-				   table->signature, table->checksum,
-				   table->checksum - checksum));
+				   table->signature, table->checksum, checksum));
 
 #if (ACPI_CHECKSUM_ABORT)
 		return (AE_BAD_CHECKSUM);
-- 
2.50.1

