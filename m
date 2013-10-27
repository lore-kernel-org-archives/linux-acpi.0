From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: [PATCH] ACPI: remove unused ACPI_PROCFS Kconfig param
Date: Sun, 27 Oct 2013 07:56:52 +0100
Message-ID: <1382857012-2971-1-git-send-email-michael.opdenacker@free-electrons.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58490 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751881Ab3J0G5A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Oct 2013 02:57:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>

This patch removes the ACPI_PROCFS parameter
(support for legacy /proc/acpi), which is defined
but no longer used anywhere in the makefiles and source code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 drivers/acpi/Kconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6efe2ac..201cfb7 100644
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
 config ACPI_PROCFS_POWER
 	bool "Deprecated power /proc/acpi directories"
 	depends on PROC_FS
-- 
1.8.1.2

