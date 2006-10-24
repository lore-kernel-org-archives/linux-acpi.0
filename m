From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] acpi: make ec_transaction not extern
Date: Mon, 23 Oct 2006 19:59:22 -0700
Message-ID: <20061023195922.23ac1ba2.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:30340 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751550AbWJXDAi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Oct 2006 23:00:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm <akpm@osdl.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse warning:
drivers/acpi/ec.c:372:12: warning: function 'ec_transaction' with external linkage has definition

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/ec.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc2-git8.orig/drivers/acpi/ec.c
+++ linux-2.6.19-rc2-git8/drivers/acpi/ec.c
@@ -369,7 +369,7 @@ int ec_write(u8 addr, u8 val)
 
 EXPORT_SYMBOL(ec_write);
 
-extern int ec_transaction(u8 command,
+int ec_transaction(u8 command,
                           const u8 *wdata, unsigned wdata_len,
                           u8 *rdata, unsigned rdata_len)
 {


---
---
~Randy
