From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/34] ACPICA: fix acpi_ex_release_mutex() comment
Date: Sun, 14 Mar 2010 21:40:50 -0400
Message-ID: <38bcb37a6f63fcdfcc0dd0af3ec5c03a4b7be48e.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:48240 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab0COBwb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:52:31 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA007YYVVI5HW2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:52:30 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

trivial, leftover from my NULL pointer dereference patch which got
'superseded' by commit fbc3be2

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exmutex.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 3c456bd..c4a47dd 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -375,8 +375,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
 	}
 
-	/* Must have a valid thread ID */
-
+	/* Must have a valid thread. */
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], null thread info",
-- 
1.7.0.2.201.g80978

