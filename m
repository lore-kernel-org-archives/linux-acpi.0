From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Fix a cast of a 32-bit int to a pointer in ACPI
Date: Wed, 02 Jul 2008 12:21:46 +0100
Message-ID: <20080702112146.5332.53087.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501AbYGBLVy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jul 2008 07:21:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com, ming.m.lin@intel.com, len.brown@intel.com, ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org, dhowells@redhat.com

Fix a cast of a 32-bit int to a pointer in ACPI to avoid a compiler warning.

This problem was introduced by the following patch:

	commit 1f3ee987b56d6354cdbbe8faa90079886a464b9c
	Author: Bob Moore <robert.moore@intel.com>
	Date:   Tue Jun 10 13:42:13 2008 +0800

	    ACPICA: Eliminate acpi_native_uint type

	    No longer needed; replaced mostly with u32, but also acpi_size
	    where a type that changes 32/64 bit on 32/64-bit platforms is
	    required.

	    Signed-off-by: Bob Moore <robert.moore@intel.com>
	    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
	    Signed-off-by: Len Brown <len.brown@intel.com>

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/acpi/executer/exconfig.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index b8ee161..4f7edce 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -96,7 +96,8 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Install the new table into the local data structures */
 
-	obj_desc->reference.object = ACPI_CAST_PTR(void, table_index);
+	obj_desc->reference.object =
+		ACPI_CAST_PTR(void, (unsigned long) table_index);
 
 	/* Add the table to the namespace */
 

