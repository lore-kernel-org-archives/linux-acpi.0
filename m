From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/27] ACPICA: iASL: Finish support for CSRT table.
Date: Mon, 31 Dec 2012 08:06:38 +0800
Message-ID: <0d527615ac4acc98a38d545208cae518104c3cd4.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9457 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:48 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add intel-specific shared info subtable.  Add data table compiler
and template support.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 1b2b356..ef9dae1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -261,9 +261,28 @@ struct acpi_csrt_group {
 	u16 subdevice_id;
 	u16 revision;
 	u16 reserved;
-	u32 info_length;
+	u32 shared_info_length;
 
-	/* Shared data (length = info_length) immediately follows */
+	/* Shared data immediately follows (Length = shared_info_length) */
+};
+
+/* Shared Info subtable */
+
+struct acpi_csrt_shared_info {
+	u16 major_version;
+	u16 minor_version;
+	u32 mmio_base_low;
+	u32 mmio_base_high;
+	u32 gsi_interrupt;
+	u8 interrupt_polarity;
+	u8 interrupt_mode;
+	u8 num_channels;
+	u8 dma_address_width;
+	u16 base_request_line;
+	u16 num_handshake_signals;
+	u32 max_block_size;
+
+	/* Resource descriptors immediately follow (Length = Group length - shared_info_length) */
 };
 
 /* Resource Descriptor subtable */
-- 
1.7.10

