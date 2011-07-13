From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 03/17] ACPI, APEI, ERST, Fix erst-dbg long record reading issue
Date: Wed, 13 Jul 2011 13:14:14 +0800
Message-ID: <1310534068-30547-4-git-send-email-ying.huang@intel.com>
References: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Chen Gong <gong.chen@linux.intel.com>

When we debug ERST table with erst-dbg, if the error record in ERST
table is too long(>4K), it can't be read out.  So this patch increases
the buffer size to 16K to ensure such error records can be read from
ERST table.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/erst-dbg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -33,7 +33,7 @@
 
 #define ERST_DBG_PFX			"ERST DBG: "
 
-#define ERST_DBG_RECORD_LEN_MAX		4096
+#define ERST_DBG_RECORD_LEN_MAX		0x4000
 
 static void *erst_dbg_buf;
 static unsigned int erst_dbg_buf_len;
