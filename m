From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] fix the issue when reading longer records from ERST DEBUG module
Date: Fri, 20 May 2011 16:22:15 +0800
Message-ID: <1305879735-29540-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12425 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934688Ab1ETIVq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 May 2011 04:21:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ying.huang@intel.com, tony.luck@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

In the driver erst-dbg, There is an issue when the log in ERST
table is too long(>4K), it can't be read out. Increase the buffer
size to 16K to ensure such logs can be read from ERST table.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/erst-dbg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index a4cfb64..3f7b0b2 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -33,7 +33,7 @@
 
 #define ERST_DBG_PFX			"ERST DBG: "
 
-#define ERST_DBG_RECORD_LEN_MAX		4096
+#define ERST_DBG_RECORD_LEN_MAX		0x4000
 
 static void *erst_dbg_buf;
 static unsigned int erst_dbg_buf_len;
-- 
1.7.5.185.g0b9dee

