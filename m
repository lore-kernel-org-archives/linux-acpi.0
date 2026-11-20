Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195278;
	b=B3T+PW+NYIi9nyHDjCjkUbbtSPCcvD947tUBk9e5F6/s8EOabVwI/+YbNnQrOnvfPzoL
	 GegEhQmcr8hQSZCNBJILYIihMoUYRWWk8Vcwwf+uO7G/eHfARWhZNi+n9uR9AHzWyhWQ8
	 K7w+YCClskc5TcyKY8QBftEWsWfync/RnSsQKM28cpVNFTEATKi2gTJIQlcgaFPrIbYvd
	 80WxUO3xwIwNFyLF6iPVZdpHaR2zbXA1kBBpTyrpQLjthz5HYIxiZek07e70/wiK1Fm+c
	 qkrbhJbGEW88qfULh2KzkLVxnN/i3D/BSGtKaRE4wb18nwaZAocCQZgau2Ji41I5tSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pBSfg6wFLb8885eXcfB/zlwPq5TD0EaZYVmvQvTjVuM=;
	b=USQZRGUVHTFXXDLuJAcpfX1MkhL9UA49nD0vKBrphwrcLmvoknEWU1Sgcxhmw7YPJRVR
	 U63TLw7AJCAiQTpI0MZYgyIP/onIHlFv+VvMX4vyuv1IoaDYrucoi9R4R8bJs7EYmoPFi
	 F0yBUl6tnQfdhyzSDmsFswhZPKkBPmsin2m71P5RD6qM3NEugMK/g8hXDqnBqSRyij3Ms
	 MjIVUbT4HtjJfVx/77oQXJR6OvNnIYVgRLjAwvWve0be4ZxJE9qNG/E3HC7kLwhhMJdYh
	 u03kiuVptVK0aDUNSYOkdB96ZLWmqSNTuCAnN6pOmw2lio0Tqz15mNqikOZ1T1TM+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HNMSERwo;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBF606A336;
	Fri, 20 Nov 2026 17:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFBF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HNMSERwo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195270; x=1826731270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9td7btWiVZKUOXrg9UGzbySRIAfn784gxhmykIlLJY=;
  b=HNMSERwoFGv7BzmW2ckVRAzUvYFWkfiQfdkbi6QNm5VvpZiDQXalAeJi
   QxAAJpk13vzR6sTLN+cuCk/PCSRXdG8AYfbDyA8pOceizd8OzPa/7qlyB
   6gsCX08RHcNYNWRwjGdwYr26RVERGEnqXnA3E821z3lIHZ8oK4WLzIVEG
   Xm85kGr392+boM6MRF8FkqpUrGWgrB9TKhIQhQ2Rvy9bFUtkPPk1uE4j7
   EPpnz7ZAQ38aHrpp4YkUvW8Z9c2vI8bCPfQBF5V4WK+V9lgY5EEa+hSl7
   a+G4IiyPEYliR2AGl8/B0lol66r+UXx+RF05/HBAPwDkPKAaTmOjvN1t4
   Q==;
X-CSE-ConnectionGUID: XQssyPohQq23wYgxQKZ1Zw==
X-CSE-MsgGUID: T6i0JiOeTwyMxLMM6HVfCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157430"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157430"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:09 -0800
X-CSE-ConnectionGUID: oKVcfid/ThyQKbbaBFGQkA==
X-CSE-MsgGUID: zCMNRB4hRU+h678MYJkozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868091"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:06 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/42] ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output
Date: Fri, 20 Nov 2026 18:18:42 +0100
Message-ID: <f8a7b2b9416e1de4675bd5867472641c51fc13e0.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Mario Limonciello (AMD) <superm1@kernel.org>

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
2.56.0

