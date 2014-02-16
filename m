From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] acpi: Remove Kconfig symbol ACPI_PROCFS
Date: Sun, 16 Feb 2014 18:08:05 +0100
Message-ID: <1392570485.28866.10.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Michael Opdenacker <michael.opdenacker@free-electrons.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Nothing cares about ACPI_PROCFS. This has been the case since v2.6.38.
This Kconfig symbol serves no purpose and its help text is now
misleading. It can safely be removed. If this symbol would be needed
again in the future it can be readded in a commit that adds code that
actually uses it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep" only.

Michael Opdenacker did a previous attempt in
https://lkml.org/lkml/2013/10/27/15 . That patch that needed some
context changes, so I redid it. I also wrote a new commit explanation.
It also addresses the reasons not to accept Michael's patch.

 drivers/acpi/Kconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4770de5..436111b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -43,19 +43,6 @@ config ACPI_SLEEP
 	depends on SUSPEND || HIBERNATION
 	default y
 
-config ACPI_PROCFS
-	bool "Deprecated /proc/acpi files"
-	depends on PROC_FS
-	help
-	  For backwards compatibility, this option allows
-	  deprecated /proc/acpi/ files to exist, even when
-	  they have been replaced by functions in /sys.
-
-	  This option has no effect on /proc/acpi/ files
-	  and functions which do not yet exist in /sys.
-
-	  Say N to delete /proc/acpi/ files that have moved to /sys/
-
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
 	default n
-- 
1.8.5.3
