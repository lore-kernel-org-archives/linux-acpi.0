Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505474;
	b=NM45zbAHVh7knSfTU6hkCcrZVzV4Hs4mAfOH/KzYlRZLHmsg18PBAv99VllMdbcmcPOL
	 fGMGiyXq/bqy7NMISnlt9MU1dllz7jhcw4hSj9VglFyIcxrptaA9+3EsAnYn+l9BjMNWe
	 beGeirK35Z3rKaW32wjBKLuCcv6xJbN2EwdkUevCR5CNCeNH2oUlivw2TJZeBWQOzlUFT
	 unCSD8rjdkv+30fgkfBqliu24Ecx/JywIZ+MB0T+YCAB9sUkb4rfoHZNe5PhdRf5jnspK
	 Huth2SJU4QX1L/0UBHiCvgZBs9CEy0/2bhVgIkDIrG1UOA5lj9jqmVIzhxCtRYxrILg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505474;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wowm5LfVq81I7O/gtaOdBEmALpo9P5ydoLQfcJ85Chg=;
	b=nLmYtxjxy2cmePGB0xeo60AORxXhr9PpaCX6nvAhtkO1X9D/CYI/JrSdOvAYG5LzzoHk
	 LGB11vGezoWGSpHngFO4ZkQ7kJAwVcf6Ouzehei91ncYs7N40kA9B/K+xFxNy6g12Sm6M
	 iIshssE2Bd0GqNz8hz81ki/fUl48W2CvzyhhpiUBgOZmXoIpBHXfRY+75G/gqjSN7nNBj
	 apelmlzPH3IGCRzGexy5nnZmlC4Xq7Kalc2MKpCmOk5gBhy4fptteZw53ieZZv94Rj4P+
	 bQK7Vnkrysxm2S0/ymxYpX5qUWSF5sisGS4p/78lwxOFCdtKDaUZGkheBpal1pZOelA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="lGxBjlH/";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F36606A31B;
	Tue, 20 Oct 2026 14:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F36606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGxBjlH/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505474; x=1824041474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=env/PgKR7GTFXaZkWYo7U6db0JQm0Tj+fk84rCd0wOI=;
  b=lGxBjlH/hvSH1zss7t0wlvGz8MKzUgexzM3qidcLLEXFoErf1nCXcwrT
   HVv+W5phogFrqbuGYOjQP0XjlacpCRz/AHIfvTGrTRes0wzunA3LA533U
   X+JntA3KpnuqKgTmcd89KmnuGIOvXEggaOzkKvzLXx11dz0VYdL1rjR7Y
   +aZ9WVKuwdrB72m0DsXxsllhmbmKp8ekfpLy2r85P6WiFDsTBx+TeY0ek
   p3qQpMioxPucH0SSvaUdjLV2k72ud6O1SIazi5oTSxl9YjCWXtPnG+duk
   hHMWhGrFvPf5uIqsmo9FGk2D7OePPbkf/yZoBLtwiTueu9mbU90z3upvI
   g==;
X-CSE-ConnectionGUID: 0ZcfdOksQBe0rN3GF8yM5w==
X-CSE-MsgGUID: vibpxQI2RpqNE9+RQf/J/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222195"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222195"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:14 -0700
X-CSE-ConnectionGUID: WYbKPJ/oS+69eK4qWhW1lQ==
X-CSE-MsgGUID: ByclLybGRyiBbXTqDCy+SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887905"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:11 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 01/30] ACPICA: components: Fix typo "Supress" -> "Suppress"
Date: Tue, 20 Oct 2026 16:10:22 +0200
Message-Id: <20261020141051.2194123-2-pawel.chmielewski@intel.com>
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

From: Colin Ian King <colin.i.king@gmail.com>

There are typos in comments. Fix them.

Link: https://github.com/acpica/acpica/commit/b4c87a6253ad
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
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
2.50.1

