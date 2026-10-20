Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505520;
	b=1Lb9pxQdRfMhpNqSMqJOc0GfnFuNkTFCmDjQ6rFpyticWn4mdpHsnGTuaeAoMhWK+rZH
	 lCYFK5pNfZy6rfGr4WxRZ4x2rQKOA3zNBJ+zYSz9IaqGBIqxoTgdB0/83ach3k2HNRBMG
	 5k8NOMlmR3ptNj0Az8ER0qjzIt9bpCvF7PbnEcuGqq/HNzGOA6WCMip06vvfvTGhaHIXM
	 5HI/Mq68ejAvZAbM6/TfMLDlLti17HkGMYAEKfGerqDcpermhji73rMzm1Y+PrnmJh9sL
	 WBtMz/3+L4fucVTCkLBoIi08oJ38gSMBUf/stSrPiaZRdK3/Cz+xoq6iL0iz8o5R6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505520;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pCw758cRkp4cr5Hna+p142mONUzPFCXRoqz/qJPbUzw=;
	b=t4NXMki3m5Kucy/MOwX4fDH7hq+g4INSaHN1MpWRaVQNbSg1G6VPo3dOwUwYieCTGNMP
	 cLh+z5Was0iwEwBajPapQfKUFJ7CXb1Duo6SXeB6WKhw0Vpq9EakXYwMrc/Vqa84MrxJP
	 wTd9MngK0eMyPoATwpples1PnD7vuaebLDUbFM6ceBmmsBcAqXFr3QwSwQAgRjnG5deEt
	 Zjh/AylseW3AVGFClTpjSTpUFIUbMftfqg/6YbRJFOSMmCQG/mGaCtQy5ujp+7ZF4SsWS
	 cmbMsJy+69FIxSNiaWuWFX4s5bmFYVFMme1A8Y8Y/oWEEWC5xZCK9O5XUds/Hm29NwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwYFT699;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D360A6F7C;
	Tue, 20 Oct 2026 14:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 341D360A6F7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwYFT699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505521; x=1824041521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=USiDI1qK8EolHEmcvM5xnuwkCPYtoaqPcMgpTBv9c3Y=;
  b=hwYFT699DjGhOEpZuhAR1dss77ciaIGI8BXkzUKkYFHLGWj7XrSBVnpO
   DucMVcLvpzCffxeRjhmG6hXYG5ss1C93lZQb9kyVlxUCkUmkwuAc+W4A5
   rBBaC1VMxeEGj7at+0zL+hT1BUC65g53QCabRnFMoB3adzZ3NhaTcBkR8
   VD24GXdMCGcfr0bVkVUXK51rU0RjoCVgdD69g5iWjcoVIJQm/IfzH0qa+
   rvSPuRsq7P9/OouAvG4C9My/WEtn9CWMRP+r0a8tFI5xW1bCSOa/ZCpO9
   zE9Nsppr0oI+Ay4sZsFZvX/BI5nyKsLO9etg42+LEPt0Ylfkdk22fu0sS
   w==;
X-CSE-ConnectionGUID: +yRqR/olRpuuq7ClQ16Kpg==
X-CSE-MsgGUID: ZVlAZgvaQW+m1q2bqgFi9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222313"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222313"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:59 -0700
X-CSE-ConnectionGUID: UX+TTphQRkCQrZCIC1pDnw==
X-CSE-MsgGUID: KsIi3sxqSoKUg50as0tPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888063"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:55 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 25/30] ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output
Date: Tue, 20 Oct 2026 16:10:46 +0200
Message-Id: <20261020141051.2194123-26-pawel.chmielewski@intel.com>
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

acpi_debug_print() emits ACPI debug output using multi-part
acpi_os_printf() and acpi_os_vprintf() calls without any loglevel
prefix.

When acpi_os_vprintf() processes a chunk without a loglevel prefix
(printk_get_level() returns 0), it prepends KERN_CONT. Because the initial
header chunk lacks a loglevel prefix, it either attaches to a preceding
unfinalized log message (inheriting its level) or, when split across
printk buffer records, falls back to the default message loglevel rather
than KERN_DEBUG. This can cause dmesg to misinterpret and colorize debug
messages as errors.

Define ACPI_MSG_DEBUG as KERN_DEBUG in aclinux.h (with an empty fallback
in acutils.h for ACPICA OS-independence) and prefix debug message headers
and context switch output in acpi_debug_print() with ACPI_MSG_DEBUG so
that printk records are properly tagged with KERN_DEBUG.

Link: https://github.com/acpica/acpica/commit/802446cd7816
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/acutils.h   | 3 +++
 drivers/acpi/acpica/utdebug.c   | 9 +++++----
 include/acpi/platform/aclinux.h | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 9049bfee409c..6b06f126c653 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -100,6 +100,9 @@ extern const char *acpi_gbl_clock_input_scale[];
 #ifndef ACPI_MSG_BIOS_WARNING
 #define ACPI_MSG_BIOS_WARNING   "Firmware Warning (ACPI): "
 #endif
+#ifndef ACPI_MSG_DEBUG
+#define ACPI_MSG_DEBUG ""
+#endif
 
 /*
  * Common message suffix
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index a31e07400c34..d031c5ab63bc 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -155,9 +155,10 @@ acpi_debug_print(u32 requested_debug_level,
 	thread_id = acpi_os_get_thread_id();
 	if (thread_id != acpi_gbl_previous_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
-			acpi_os_printf
-			    ("\n**** Context Switch from TID %u to TID %u ****\n\n",
-			     (u32)acpi_gbl_previous_thread_id, (u32)thread_id);
+			acpi_os_printf(ACPI_MSG_DEBUG
+				       "\n**** Context Switch from TID %u to TID %u ****\n\n",
+				       (u32)acpi_gbl_previous_thread_id,
+				       (u32)thread_id);
 		}
 
 		acpi_gbl_previous_thread_id = thread_id;
@@ -168,7 +169,7 @@ acpi_debug_print(u32 requested_debug_level,
 	 * Display the module name, current line number, thread ID (if requested),
 	 * current procedure nesting level, and the current procedure name
 	 */
-	acpi_os_printf("%9s-%04d ", module_name, line_number);
+	acpi_os_printf(ACPI_MSG_DEBUG "%9s-%04d ", module_name, line_number);
 
 #ifdef ACPI_APPLICATION
 	/*
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 9b30bb9ed711..5e2ed5e79d3b 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -169,6 +169,7 @@
 
 #define ACPI_MSG_BIOS_ERROR     KERN_ERR "ACPI BIOS Error (bug): "
 #define ACPI_MSG_BIOS_WARNING   KERN_WARNING "ACPI BIOS Warning (bug): "
+#define ACPI_MSG_DEBUG          KERN_DEBUG
 
 /*
  * Linux wants to use designated initializers for function pointer structs.
-- 
2.50.1

