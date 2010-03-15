From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/34] ACPI: remove superfluous NULL pointer check from
 acpi_processor_get_throttling_info()
Date: Sun, 14 Mar 2010 21:40:49 -0400
Message-ID: <ded180e7ebfc324b36a94931f99d0705dcd8da29.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:51051 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0COBvg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:51:36 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA008D9VTSTMB7@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:51:29 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Dan's list contains:

drivers/acpi/processor_throttling.c +1139 acpi_processor_get_throttling_info(11) warning: variable derefenced before check 'pr'

acpi_processor_get_throttling_info() is never called with pr == NULL.

[ bart: the potential NULL pointer dereference was finally fixed in
  (much later than mine) commit 5cfa245 but my patch is still valid ]

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 1c5d7a8..649b2b9 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -1133,9 +1133,6 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	int result = 0;
 	struct acpi_processor_throttling *pthrottling;
 
-	if (!pr)
-		return -EINVAL;
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
-- 
1.7.0.2.201.g80978

