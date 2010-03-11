From: akpm@linux-foundation.org
Subject: [patch 1/2] acpica: fix acpi_ex_release_mutex() comment
Date: Thu, 11 Mar 2010 13:59:03 -0800
Message-ID: <201003112159.o2BLx3MG012830@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48043 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757330Ab0CKV7X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Mar 2010 16:59:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bzolnier@gmail.com, error27@gmail.com, ming.m.lin@intel.com, robert.moore@intel.com

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

trivial, leftover from my NULL pointer dereference patch which got
'superseded' by commit fbc3be2

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Dan Carpenter <error27@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/acpica/exmutex.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/acpi/acpica/exmutex.c~acpica-fix-acpi_ex_release_mutex-comment drivers/acpi/acpica/exmutex.c
--- a/drivers/acpi/acpica/exmutex.c~acpica-fix-acpi_ex_release_mutex-comment
+++ a/drivers/acpi/acpica/exmutex.c
@@ -234,8 +234,7 @@ acpi_ex_acquire_mutex(union acpi_operand
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Must have a valid thread ID */
-
+	/* Must have a valid thread. */
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot acquire Mutex [%4.4s], null thread info",
_
