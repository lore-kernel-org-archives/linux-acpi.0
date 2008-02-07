From: Len Brown <lenb@kernel.org>
Subject: [PATCH 107/112] ACPI: its a directory not a folder....
Date: Thu,  7 Feb 2008 04:35:09 -0500
Message-ID: <9e52797131e83688f66fbca6d4cd25b83f33c48f.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:44102 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757744AbYBGJg7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:59 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, Len Brown <len.brown@intel.com>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

The kernel help consistently uses 'directory'

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccf6ea9..95588c2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -68,26 +68,28 @@ config ACPI_PROCFS
 
 	  Say N to delete /proc/acpi/ files that have moved to /sys/
 config ACPI_PROCFS_POWER
-	bool "Deprecated power /proc/acpi folders"
+	bool "Deprecated power /proc/acpi directories"
 	depends on PROC_FS
 	default y
 	---help---
 	  For backwards compatibility, this option allows
-          deprecated power /proc/acpi/ folders to exist, even when
+          deprecated power /proc/acpi/ directories to exist, even when
           they have been replaced by functions in /sys.
-          The deprecated folders (and their replacements) include:
+          The deprecated directories (and their replacements) include:
 	  /proc/acpi/battery/* (/sys/class/power_supply/*)
 	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
-	  This option has no effect on /proc/acpi/ folders
+	  This option has no effect on /proc/acpi/ directories
 	  and functions, which do not yet exist in /sys
 
-	  Say N to delete power /proc/acpi/ folders that have moved to /sys/
+	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
+
 config ACPI_SYSFS_POWER
 	bool "Future power /sys interface"
 	select POWER_SUPPLY
 	default y
 	---help---
 	  Say N to disable power /sys interface
+
 config ACPI_PROC_EVENT
 	bool "Deprecated /proc/acpi/event support"
 	depends on PROC_FS
-- 
1.5.4.23.gef5b9

