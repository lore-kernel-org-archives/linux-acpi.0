From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] ACPI / lpat: make it explicitly non-modular
Date: Mon, 11 Jul 2016 17:22:41 -0400
Message-ID: <20160711212241.14774-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The Makefile for building this is "acpi-y" and so it is not built
as a module.  Hence including module.h and everything that comes
with it just for the no-op MODULE_LICENSE is rather heavy handed.

The license info is found at the top of the file, so we just remove
the MODULE_LICENSE and the include of module.h

We add an include of export.h since the file exports some symbols.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/acpi_lpat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_lpat.c b/drivers/acpi/acpi_lpat.c
index feb61c1630eb..c1c4877ca96c 100644
--- a/drivers/acpi/acpi_lpat.c
+++ b/drivers/acpi/acpi_lpat.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_lpat.h>
 
@@ -157,5 +157,3 @@ void acpi_lpat_free_conversion_table(struct acpi_lpat_conversion_table
 	}
 }
 EXPORT_SYMBOL_GPL(acpi_lpat_free_conversion_table);
-
-MODULE_LICENSE("GPL");
-- 
2.8.4
