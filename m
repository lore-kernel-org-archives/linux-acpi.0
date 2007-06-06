From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] toshica_acpi: fix section mismatch in allyesconfig
Date: Wed, 6 Jun 2007 14:18:50 -0700
Message-ID: <20070606141850.717b2749.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:63255 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935083AbXFFVT2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jun 2007 17:19:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: toshiba_acpi@memebeam.org, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix section error (allyesconfig).  The exit function is called from init,
so functions that are called by the exit function cannot be marked __exit.

WARNING: drivers/built-in.o(.text+0xe5bc6): Section mismatch: reference to .exit.
text: (between 'toshiba_acpi_exit' and 'hci_raw')

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/toshiba_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2622-rc4.orig/drivers/acpi/toshiba_acpi.c
+++ linux-2622-rc4/drivers/acpi/toshiba_acpi.c
@@ -524,7 +524,7 @@ static acpi_status __init add_device(voi
 	return AE_OK;
 }
 
-static acpi_status __exit remove_device(void)
+static acpi_status remove_device(void)
 {
 	ProcItem *item;
 
