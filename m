Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195213;
	b=JCImGmrriTX3BQRbPG/gNDQD6zzpQLKxwOGXvBC83tTvsGOck3mhqsnPtovbTqLyWKCg
	 s74BXAT+ECfr4kiSjxrzlJMNREhJEJJihITZmrSKSPCeip3Ca+AeYOVa5ec3bCOONLKrP
	 E6USwQrKz8blikrczpZKDt9FikXauusac7XBYF1MxCi44j/6pWcZZgcjQq0uuV2TvBTY5
	 fUTBHpLvXSELzZH41zcOOycn2TljLooVjIFljClexR/Pnz9wQcX3Mg8SHiKr+K6k+koGY
	 ZqU085mk9YRtvJXoMwfEIIjhm88T5zv+2WrtJ7M6w7u9przrRKpYR2rxFSlZYbJXpPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195213;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Psbw3M5QFo2PG3uijKfFP4lY6XlQCRXfFYDjnQLDsQA=;
	b=2ju9pY0ryIDgRvimnRJnivX1aAZy5+/RGiMhlOhCXUAMVmQ1Mz2nNl2mEIE6rFbHFcQP
	 /CkgQuz/61saMqcI0i69kTLFQnjwugeIuoeNI0ZvXBg1F4fYJJoy34JnEC5ICY/fWJLp2
	 sCtdcvcbgbfmkFIMZ6zQMc3iDdm9DgvZ+Ut0DSH//9eT0zzHq0qcr12iecULlftzqnGLt
	 /1Ev556bUDnlYfb1IRIMR+GK1voZu5STs1UDtdS1YVRR5173q7ypve5RdGxSB1PXTurwS
	 JzBcqXTnseU73q/SptqbHKdgtTPf5shSm5t289lGd9vbq1TuYoZSnZfBfxhJgTAQSew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BNlWgqV1;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767660A2605;
	Fri, 20 Nov 2026 17:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7767660A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BNlWgqV1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195212; x=1826731212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gWduC7hWiArbKNOehbUAr8ojhXyukCpKp9UeihBdZs=;
  b=BNlWgqV1ZbbGW1QPXA1mVqdTXikUOuDIJra2CClaGs9gyaHXkFGtZ61S
   IkgYCFtjSBUyHiwITIgOtl0K7eIgSlUOy2AwAkcwupHs8KYWm3C9B4/Vw
   K79hYLAnI84/L1oC/2+L+Wsa/kvviN6Ftaxf8XTBjMDrp6n370c36gbXo
   MyfTAvy4XeNG8a2Xo2odPIAeFHFDO+mG6Q+YyEQcvuQim4cv/EXIfWN3j
   NCo2T1FbMESb+a7LWn9AKsE1BC1Ev3NbLuJ1TaoUaaEahm0GXCDw2d2+D
   gNeTvjxgLIWaLO8HH/XTc+vUy/9wp7D+Jax4pI3EmC1FMtisNXCWqbJmN
   A==;
X-CSE-ConnectionGUID: K/w0O6rmTvi81UQ1n71nmw==
X-CSE-MsgGUID: Ll51otKPTZ6pC0MO69KIwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157244"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157244"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:11 -0800
X-CSE-ConnectionGUID: 8kcDrLSeT3KO3HI08gXPGw==
X-CSE-MsgGUID: hzquPt2mQYitaDjNozKSuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867803"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:09 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/42] ACPICA: components: Fix typo "Supress" -> "Suppress"
Date: Fri, 20 Nov 2026 18:18:22 +0100
Message-ID: <ea95dedff9e3c834ecf6612ca51a9392f26c20aa.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Colin Ian King <colin.i.king@gmail.com>

There are typos in comments. Fix them.

Link: https://github.com/acpica/acpica/commit/b4c87a6253ad
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exconvrt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index b51f20d0978e..ce5bdf519886 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -334,7 +334,7 @@ acpi_ex_convert_to_ascii(u64 integer,
 			hex_char = (u8)
 			    acpi_ut_hex_to_ascii_char(integer, ACPI_MUL_4(j));
 
-			/* Supress leading zeros until the first non-zero character */
+			/* Suppress leading zeros until the first non-zero character */
 
 			if (hex_char == ACPI_ASCII_ZERO && supress_zeros) {
 				continue;
@@ -421,7 +421,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			/*
 			 * From to_hex_string.
 			 *
-			 * Supress leading zeros and append "0x"
+			 * Suppress leading zeros and append "0x"
 			 */
 			string_length =
 			    ACPI_MUL_2(acpi_gbl_integer_byte_width) + 2;
-- 
2.56.0

