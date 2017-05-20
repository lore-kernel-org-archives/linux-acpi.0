From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: [PATCH] ACPI: fix whitespace in pr_fmt() to align log entries
Date: Sat, 20 May 2017 20:38:13 +0200
Message-ID: <1495305493-4905-1-git-send-email-vincent.legoll@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33096 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdETSi2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 20 May 2017 14:38:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vincent Legoll <vincent.legoll@gmail.com>

See this dmesg extract before the patch:

[    0.679466] ACPI: Dynamic OEM Table Load:
[    0.679470] ACPI: SSDT 0xFFFF910F6B497E00 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.679579] ACPI: Executed 1 blocks of module-level executable AML code
[    0.681477] ACPI : EC: EC started
[    0.681478] ACPI : EC: interrupt blocked
[    0.684798] ACPI: Interpreter enabled
[    0.684835] ACPI: (supports S0 S3 S4 S5)

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 drivers/acpi/acpi_dbg.c | 2 +-
 drivers/acpi/button.c   | 2 +-
 drivers/acpi/ec.c       | 2 +-
 drivers/acpi/ioapic.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index dee8692..3ec05aa 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -10,7 +10,7 @@
  */
 
 /* #define DEBUG */
-#define pr_fmt(fmt) "ACPI : AML: " fmt
+#define pr_fmt(fmt) "ACPI: AML: " fmt
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index b7c2a06..f265588 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -19,7 +19,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-#define pr_fmt(fmt) "ACPI : button: " fmt
+#define pr_fmt(fmt) "ACPI: button: " fmt
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c24235d..01e6e39 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -27,7 +27,7 @@
 
 /* Uncomment next line to get verbose printout */
 /* #define DEBUG */
-#define pr_fmt(fmt) "ACPI : EC: " fmt
+#define pr_fmt(fmt) "ACPI: EC: " fmt
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 7e4fbf9..3595aa9 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -21,7 +21,7 @@
  * registered when we parsed the ACPI MADT.
  */
 
-#define pr_fmt(fmt) "ACPI : IOAPIC: " fmt
+#define pr_fmt(fmt) "ACPI: IOAPIC: " fmt
 
 #include <linux/slab.h>
 #include <linux/acpi.h>
-- 
2.7.4

