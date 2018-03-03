From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] acpi: edit ACPI_PROCFS_POWER help text
Date: Fri, 2 Mar 2018 16:55:54 -0800
Message-ID: <dbb2b722-aa1e-04ca-1487-08984f68d91e@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix grammar and punctuation (end sentences with a period) in the
Kconfig help text for ACPI_PROCFS_POWER.

I was looking at this since it appears to be going away (again,
some day) and I have a working script that uses this info to tell me
battery usage. I can update the script to use /sys/class/power_supply
(in theory) but the contents (with units) should be documented in
Documentation/ABI/ before /proc/acpi/battery/ is removed (IMO).

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/acpi/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20180302.orig/drivers/acpi/Kconfig
+++ linux-next-20180302/drivers/acpi/Kconfig
@@ -105,14 +105,14 @@ config ACPI_PROCFS_POWER
           deprecated power /proc/acpi/ directories to exist, even when
           they have been replaced by functions in /sys.
           The deprecated directories (and their replacements) include:
-	  /proc/acpi/battery/* (/sys/class/power_supply/*)
-	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
+	  /proc/acpi/battery/* (/sys/class/power_supply/*) and
+	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*).
 	  This option has no effect on /proc/acpi/ directories
-	  and functions, which do not yet exist in /sys
+	  and functions which do not yet exist in /sys.
 	  This option, together with the proc directories, will be
 	  deleted in the future.
 
-	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
+	  Say N to delete power /proc/acpi/ directories that have moved to /sys.
 
 config ACPI_REV_OVERRIDE_POSSIBLE
 	bool "Allow supported ACPI revision to be overridden"
