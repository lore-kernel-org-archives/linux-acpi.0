From: Len Brown <lenb@kernel.org>
Subject: [PATCH 075/103] ACPICA: Move check for valid Thread ID structure
Date: Wed, 16 Dec 2009 03:36:26 -0500
Message-ID: <fbc3be2af3e8beb581a20c2a0cfda5692f5a1c08.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61822 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761123AbZLPMGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:06 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:56 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Dan Carpenter <error27@gmail.com>

This change moves the check for a valid Thread ID structure up a
few lines to insure that the check is made before the structure
is actually used.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exmutex.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 2f01142..3c456bd 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -375,6 +375,15 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
 	}
 
+	/* Must have a valid thread ID */
+
+	if (!walk_state->thread) {
+		ACPI_ERROR((AE_INFO,
+			    "Cannot release Mutex [%4.4s], null thread info",
+			    acpi_ut_get_node_name(obj_desc->mutex.node)));
+		return_ACPI_STATUS(AE_AML_INTERNAL);
+	}
+
 	/*
 	 * The Mutex is owned, but this thread must be the owner.
 	 * Special case for Global Lock, any thread can release
@@ -392,15 +401,6 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
-	/* Must have a valid thread ID */
-
-	if (!walk_state->thread) {
-		ACPI_ERROR((AE_INFO,
-			    "Cannot release Mutex [%4.4s], null thread info",
-			    acpi_ut_get_node_name(obj_desc->mutex.node)));
-		return_ACPI_STATUS(AE_AML_INTERNAL);
-	}
-
 	/*
 	 * The sync level of the mutex must be equal to the current sync level. In
 	 * other words, the current level means that at least one mutex at that
-- 
1.6.0.6

