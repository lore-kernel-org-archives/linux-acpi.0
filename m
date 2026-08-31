Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED12CCC5;
	Mon, 31 Aug 2026 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154468; cv=none; b=hwbXPhkRqcfyI4BMAicd3yhs+zOiVp9HJC8kkNtz5LxL9Zhk6POmfqfp56xmAp2g5ZvtvQZSf6pda7jx8gBY7zrLl2TyfmuRLCh3zQZ0sfoYGlxYmH74xs1YX4Bj/OrIzZSprktVgu6dt3NAba6kwgTbQqDaKTMF89IT5NTeC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154468; c=relaxed/simple;
	bh=f+qKhm6YgnI1IN7mXEUB8BGXJtbOHNxLRC8aqnwqtXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdEhrI+brRpoXIr+ow1zJbk5JJJlYE2Ficn8icGO/zJs2pMpEFJajkIBfVxZo5qyZxzidPsSQlAtm+KdC+2onTyvxaa//W6Gl0yKKX6YKjImhb999Croa2DBEbTdzxNdGXsmVIX0oDTvnemWA3Vm/KkRHf2qHS6zVTHFMZUvCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPgRC1FX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPgRC1FX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E41F000E9;
	Mon, 31 Aug 2026 05:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788154466;
	bh=tq1gogeedDdmnn7l++w8o8E9cqyqpc8vNhmUeqp0Gu8=;
	h=From:To:Cc:Subject:Date;
	b=oPgRC1FX8YFjLRiMp1M3Bktvb+r83gmOTqNMiSv8QPAo54KZiq65Cn3G1+M2fY/9h
	 CaLNxFkF04s9f+f2wJBbIlL3b5k3t8bTzEpUPgxGwPJXwNnPCOdCYdZDpZeo80Ebyw
	 9g6O/VEsektTfBBfjoGJ/qT7hejKt1WfpxbWbhf6rB9zJw8lEPw5Y7BvsjTBsnXFPm
	 f69IA1d/WGVIrZOKcNPPL1mWnFv971kq6j4dWR8Pn7R/c6lgm97q6zSzTaHcllxgWC
	 zh++q+f99lf+XY7rEQ65klv6mpywz3GGdrBucrojhJXpM2rEAD0k8LQLPjGWInlC00
	 Ck+FOop+DjgdA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	lenb@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH] ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output
Date: Mon, 31 Aug 2026 00:34:19 -0500
Message-ID: <20260831053420.1729024-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
Given this is purely for Linux - it's not obvious to me if it should
go upstream to ACPICA or directly to Linux.  Sending here for now.
---
 drivers/acpi/acpica/acutils.h   | 3 +++
 drivers/acpi/acpica/utdebug.c   | 4 ++--
 include/acpi/platform/aclinux.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 9049bfee409c4..766a3080b5ea1 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -100,6 +100,9 @@ extern const char *acpi_gbl_clock_input_scale[];
 #ifndef ACPI_MSG_BIOS_WARNING
 #define ACPI_MSG_BIOS_WARNING   "Firmware Warning (ACPI): "
 #endif
+#ifndef ACPI_MSG_DEBUG
+#define ACPI_MSG_DEBUG          ""
+#endif
 
 /*
  * Common message suffix
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index a31e07400c34d..1f2cab491637f 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -156,7 +156,7 @@ acpi_debug_print(u32 requested_debug_level,
 	if (thread_id != acpi_gbl_previous_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %u to TID %u ****\n\n",
+			    (ACPI_MSG_DEBUG "\n**** Context Switch from TID %u to TID %u ****\n\n",
 			     (u32)acpi_gbl_previous_thread_id, (u32)thread_id);
 		}
 
@@ -168,7 +168,7 @@ acpi_debug_print(u32 requested_debug_level,
 	 * Display the module name, current line number, thread ID (if requested),
 	 * current procedure nesting level, and the current procedure name
 	 */
-	acpi_os_printf("%9s-%04d ", module_name, line_number);
+	acpi_os_printf(ACPI_MSG_DEBUG "%9s-%04d ", module_name, line_number);
 
 #ifdef ACPI_APPLICATION
 	/*
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 9b30bb9ed711c..5e2ed5e79d3b8 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -169,6 +169,7 @@
 
 #define ACPI_MSG_BIOS_ERROR     KERN_ERR "ACPI BIOS Error (bug): "
 #define ACPI_MSG_BIOS_WARNING   KERN_WARNING "ACPI BIOS Warning (bug): "
+#define ACPI_MSG_DEBUG          KERN_DEBUG
 
 /*
  * Linux wants to use designated initializers for function pointer structs.
-- 
2.53.0

