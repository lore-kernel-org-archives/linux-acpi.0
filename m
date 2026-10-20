Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505485;
	b=UT0weFMfrahQF2ssnvDEWKR2ht4vTXmd6Rw6Xcn6PnF9bNKJH6+Ce5BBFhPq4pZt1v0Y
	 XQwbFZVoApvJdOMFsFJIsxFcoD839Qab8D8XT6CX6qG5nO5dsLtE5jk7DlDFc4DejfdH8
	 /z7dqc1gkSZlVjQe7xw2DDlBWPagqRIsmWFxnfFQ75uFxETlYPdV54XdSFYmvsbXhaQeF
	 gA2TQdI0eVIPjGkSLt7dJfdpCN8VX/sI3/H//uSo2YWGViK7hrgVXeIiHvuxcPM0RQtcF
	 WS3kWmh5hsbsdZOnjaKcjJVmgSBMEB9+6hl0H03r8EHCIPlQIvNyg426wXowhnle9oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505485;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FiazhCdc+ugkiOpUi3c3bf9Zh1istRd9/K58OlPKmDw=;
	b=svN/d10XYkbZjUEe5dYOKRZRzjtN6wx9rUq3zvGc+6LUggzF+ujaQ0bx9RVZQZYDOJxU
	 v9pybFL5PUQEIOa3Ct2Y6Pq4r1eEQeip5lnXPvHdsy0BK5bJx3dRuE0z95caIYEW75m8N
	 qX5M9Xlr6RDzwQMlD6z7Ja79HBWXSz0Hqzb7YEWF7jXHTXpwjKP/kqOmRLRW8WDrukkwV
	 PNSfqOgXBUGQoFfydG7oSfch542X0KJSrs7WrfwzQVWeCRa7aYeFM/xtkhHTaqwa2CcBA
	 tBsEdu0U2EuP8F3ocxopzgeCJGdkFYij5fPRB8XXHEr6OOtTgG/M1KERGToG27rG19g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="h+Zac3P/";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72037606A339;
	Tue, 20 Oct 2026 14:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72037606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h+Zac3P/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505484; x=1824041484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YET2C83OEpsJ10nT6vmkLI7B3GfmaIlyc/AdjEFAY4M=;
  b=h+Zac3P/apqWVeCexq701xaMwRufbHxMYT+zQ4ZYCf4r6un/c/Xr8ySU
   Senib157rrpYG/gIphqutdPjTAINm7TW+7IMzzMt9OcYV9eMfcCg3i8ak
   l934xPK9UHpNTBQIIhPEAtdZ7snCRVSsuWA/z1yrGE21ZiDG8BnSqyeoD
   Wx7zksHbfD+M07PvW1ZcxrRpUcgd4n/f6Mljc11MiMZRP1S4ovsgFQxk0
   zNFMnOhRNz1oa3dyeW5QbG+6BVKwNMmO1cAuCNQWS2xphfBFXrLB6fmBs
   x0j+/VfyoYytUZjPPCn18a9KeDuLPMn68ZJ9c9u7+NajseXDc6Qhtr2Hp
   A==;
X-CSE-ConnectionGUID: m4gofIqOSQ2JVuVb/md8gg==
X-CSE-MsgGUID: hzlDaE2vRneKlblTW62pjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222215"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222215"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:24 -0700
X-CSE-ConnectionGUID: SIf4R7ZmRI+5EjsZcE05hQ==
X-CSE-MsgGUID: H0a18YeYRNiNlmG4e/Wj/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887920"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:18 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 05/30] ACPICA: CEDT: RDPAS: Add missing reserved field in RDPAS structure
Date: Tue, 20 Oct 2026 16:10:26 +0200
Message-Id: <20261020141051.2194123-6-pawel.chmielewski@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

Add the missing 3 reserved bytes at the end of the RDPAS structure.

Link: https://github.com/acpica/acpica/commit/88d82d3ae53e
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/actbl1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 73ebc089e96d..5b4207af046a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -590,6 +590,7 @@ struct acpi_cedt_rdpas {
 	u16 bdf;
 	u8 protocol;
 	u64 address;
+	u8 reserved[3];
 };
 
 /* Masks for bdf field above */
-- 
2.50.1

