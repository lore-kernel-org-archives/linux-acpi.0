From: akpm@linux-foundation.org
Subject: [patch 4/4] acpi utmisc: use WARN_ON() instead of warn_on_slowpath()
Date: Fri, 04 Jul 2008 00:05:32 -0700
Message-ID: <200807040705.m6475WXV018519@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49045 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027AbYGDHFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 03:05:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, randy.dunlap@oracle.com, lenb@kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

utmisc.c needs to include asm-generic/bug.h for warn()/WARN() functions,
but it should use WARN_ON() instead of warn_on_slowpath() since arches can
provide their own implementation of WARN_ON(), which does not have to
use/provide/implement warn_on_slowpath() at all.  Just use the front door
(WARN_ON).

linux-next-20080702/drivers/acpi/utilities/utmisc.c:1027: error: implicit declaration of function 'warn_on_slowpath'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/utilities/utmisc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/utilities/utmisc.c~acpi-utmisc-use-warn_on-instead-of-warn_on_slowpath drivers/acpi/utilities/utmisc.c
--- a/drivers/acpi/utilities/utmisc.c~acpi-utmisc-use-warn_on-instead-of-warn_on_slowpath
+++ a/drivers/acpi/utilities/utmisc.c
@@ -42,6 +42,7 @@
  */
 
 #include <linux/module.h>
+#include <asm-generic/bug.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -1024,7 +1025,7 @@ acpi_ut_error(const char *module_name, u
 {
 	va_list args;
 
-	warn_on_slowpath(module_name, line_number);
+	WARN_ON(1);
 	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
 
 	va_start(args, format);
@@ -1039,7 +1040,7 @@ acpi_ut_exception(const char *module_nam
 {
 	va_list args;
 
-	warn_on_slowpath(module_name, line_number);
+	WARN_ON(1);
 	acpi_os_printf("ACPI Exception (%s-%04d): %s, ", module_name,
 		       line_number, acpi_format_exception(status));
 
_
