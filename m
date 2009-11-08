From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/12] ACPI: Move dereference after NULL test
Date: Sat, 07 Nov 2009 21:57:09 -0500
Message-ID: <5cfa245b0b63c3d79568e78a1ee3d00654d5517d.1257648659.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:13314 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbZKHC5R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:57:17 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSR004V2S7ME76U@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:57:22 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
In-reply-to: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Julia Lawall <julia@diku.dk>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Julia Lawall <julia@diku.dk>

If the NULL test on pr is needed, then the dereference should be after the
NULL test.

A simplified version of the semantic match that detects this problem is as
follows (http://coccinelle.lip6.fr/):

// <smpl>
@match exists@
expression x, E;
identifier fld;
@@

* x->fld
  ... when != \(x = E\|&x\)
* x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 4c6c14c..1c5d7a8 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -1133,15 +1133,15 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	int result = 0;
 	struct acpi_processor_throttling *pthrottling;
 
+	if (!pr)
+		return -EINVAL;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
 			  pr->throttling.duty_offset,
 			  pr->throttling.duty_width));
 
-	if (!pr)
-		return -EINVAL;
-
 	/*
 	 * Evaluate _PTC, _TSS and _TPC
 	 * They must all be present or none of them can be used.
-- 
1.6.0.6

