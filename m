From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] drivers/acpi: make apei/ghes.c more explicitly non-modular
Date: Mon, 15 Feb 2016 00:27:50 -0500
Message-ID: <1455514071-26368-3-git-send-email-paul.gortmaker@windriver.com>
References: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

config ACPI_APEI_GHES
      bool "APEI Generic Hardware Error Source"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We replace module.h with moduleparam.h as we are keeping the
pre-existing module_param that the file has, as currently that is
the easiest way to maintain compatibility with the existing boot
arg use cases.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/apei/ghes.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3dd9c462d22a..60746ef904e4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -26,7 +26,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
@@ -79,6 +79,11 @@
 	((struct acpi_hest_generic_status *)				\
 	 ((struct ghes_estatus_node *)(estatus_node) + 1))
 
+/*
+ * This driver isn't really modular, however for the time being,
+ * continuing to use module_param is the easiest way to remain
+ * compatible with existing boot arg use cases.
+ */
 bool ghes_disable;
 module_param_named(disable, ghes_disable, bool, 0);
 
@@ -1148,18 +1153,4 @@ err_ioremap_exit:
 err:
 	return rc;
 }
-
-static void __exit ghes_exit(void)
-{
-	platform_driver_unregister(&ghes_platform_driver);
-	ghes_estatus_pool_exit();
-	ghes_ioremap_exit();
-}
-
-module_init(ghes_init);
-module_exit(ghes_exit);
-
-MODULE_AUTHOR("Huang Ying");
-MODULE_DESCRIPTION("APEI Generic Hardware Error Source support");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:GHES");
+device_initcall(ghes_init);
-- 
2.6.1
