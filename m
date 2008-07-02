From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] acpi utmisc: use WARN_ON() instead of
 warn_on_slowpath()
Date: Wed, 2 Jul 2008 11:28:52 -0700
Message-ID: <20080702112852.05f30950.randy.dunlap@oracle.com>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>
	<20080701131714.5093fa49.akpm@linux-foundation.org>
	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>
	<20080701133535.f92a673c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080701133535.f92a673c.akpm@linux-foundation.org>
Sender: linux-next-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: andi@firstfloor.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

utmisc.c needs to include asm-generic/bug.h for warn()/WARN() functions,
but it should use WARN_ON() instead of warn_on_slowpath() since
arches can provide their own implementation of WARN_ON(), which does
not have to use/provide/implement warn_on_slowpath() at all.
Just use the front door (WARN_ON).

linux-next-20080702/drivers/acpi/utilities/utmisc.c:1027: error: implicit declaration of function 'warn_on_slowpath'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/utilities/utmisc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20080702.orig/drivers/acpi/utilities/utmisc.c
+++ linux-next-20080702/drivers/acpi/utilities/utmisc.c
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
 


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
