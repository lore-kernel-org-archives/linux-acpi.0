From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH resend] ACPICA: fix acpi_ex_release_mutex() comment
Date: Tue, 5 Jan 2010 20:19:03 +0100
Message-ID: <201001052019.03588.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58884 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab0AETUk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2010 14:20:40 -0500
Received: by ewy19 with SMTP id 19so8798930ewy.21
        for <linux-acpi@vger.kernel.org>; Tue, 05 Jan 2010 11:20:37 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
trivial, leftover from my NULL pointer dereference patch which got
'superseded' by commit fbc3be2

 drivers/acpi/acpica/exmutex.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/acpi/acpica/exmutex.c
===================================================================
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -375,8 +375,7 @@ acpi_ex_release_mutex(union acpi_operand
 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
 	}
 
-	/* Must have a valid thread ID */
-
+	/* Must have a valid thread. */
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], null thread info",
