From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] acpi utmisc.c: include bug.h
Date: Tue, 1 Jul 2008 10:30:57 -0700
Message-ID: <20080701103057.198c50be.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:64612 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYGARb2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 13:31:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org, len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

acpi utmisc.c needs to include bug.h:

linux-next-20080701/drivers/acpi/utilities/utmisc.c: In function 'acpi_ut_error':
linux-next-20080701/drivers/acpi/utilities/utmisc.c:1028: error: implicit declaration of function 'warn_on_slowpath'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/utilities/utmisc.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20080701.orig/drivers/acpi/utilities/utmisc.c
+++ linux-next-20080701/drivers/acpi/utilities/utmisc.c
@@ -42,6 +42,7 @@
  */
 
 #include <linux/module.h>
+#include <asm-generic/bug.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
