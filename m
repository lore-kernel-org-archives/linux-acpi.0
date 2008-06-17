From: Randy Dunlap <randy.dunlap@ORACLE.COM>
Subject: [PATCH -next] acpi: fix printk format warning
Date: Tue, 17 Jun 2008 09:43:41 -0700
Message-ID: <20080617094341.d144a5f8.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warning:

linux-next-20080617/drivers/acpi/processor_throttling.c:1258: warning: format '%d' expects type 'int', but argument 4 has type 'size_t'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/processor_throttling.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20080617.orig/drivers/acpi/processor_throttling.c
+++ linux-next-20080617/drivers/acpi/processor_throttling.c
@@ -1255,7 +1255,7 @@ static ssize_t acpi_processor_write_thro
 	if (state_val >= pr->throttling.state_count)
 		return -EINVAL;
 
-	snprintf(tmpbuf, 5, "%d", state_val);
+	snprintf(tmpbuf, 5, "%zu", state_val);
 
 	if (strcmp(tmpbuf, charp) != 0)
 		return -EINVAL;
