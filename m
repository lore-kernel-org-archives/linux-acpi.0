From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 26/31] ACPICA: Add "//" before ascii output of buffers.
Date: Mon, 13 Apr 2015 11:50:56 +0800
Message-ID: <4b2cc90b14569234157a997c20b1a739fb4f53fd.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34030 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbbDMDvA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:51:00 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 657dc227672709895df3192fa5ea59a649b9a76f

Updates the dump buffer utility to comment out the ascii part
of buffer dump. Prevents some tools from getting confused.

Link: https://github.com/acpica/acpica/commit/657dc227
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utbuffer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 242bd07..a8c3964 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -150,6 +150,14 @@ void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
 				return;
 			}
 
+			/*
+			 * Add comment characters so rest of line is ignored when
+			 * compiled
+			 */
+			if (j == 0) {
+				acpi_os_printf("// ");
+			}
+
 			buf_char = buffer[(acpi_size) i + j];
 			if (ACPI_IS_PRINT(buf_char)) {
 				acpi_os_printf("%c", buf_char);
-- 
1.7.10

