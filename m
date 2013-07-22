From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPI: Add facility to remove all _OSI strings
Date: Mon, 22 Jul 2013 16:08:36 +0800
Message-ID: <c9f8ce77de33f95598bd7063933502e849a1ecdb.1374474116.git.lv.zheng@intel.com>
References: <cover.1369380671.git.lv.zheng@intel.com> <cover.1374474116.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47882 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756025Ab3GVIIu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jul 2013 04:08:50 -0400
In-Reply-To: <cover.1374474116.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch changes the "acpi_osi=" boot parameter implementation so that:
1. "acpi_osi=!" can be used to disable all _OSI OS vendor strings by
   default.  It is meaningless to specify "acpi_osi=!" multiple times as
   it can only affect the default state of the target _OSI strings.
2. "acpi_osi=!*" can be used to more all _OSI OS vendor strings and all
   _OSI feature group strings.  It is useful to specify "acpi_osi=!*"
   multiple times through kernel command line to override the current
   state of the target _OSI strings.

This patch has passed the test brought by an ACPICA commit for the unit
test purpose.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |   28 +++++++++++++++++++++++++++-
 drivers/acpi/osl.c                  |    7 +++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 131394f..4bec7a5 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -237,6 +237,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	acpi_osi=	[HW,ACPI] Modify list of supported OS interface strings
 			acpi_osi="string1"	# add string1
 			acpi_osi="!string2"	# remove string2
+			acpi_osi=!*		# remove all strings
 			acpi_osi=!		# disable all built-in OS vendor
 						  strings
 			acpi_osi=		# disable all strings
@@ -248,7 +249,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			it cannot affect the default state of the feature group
 			strings and the current state of the OS vendor strings,
 			specifying it multiple times through kernel command line
-			is meaningless.
+			is meaningless.  This command is useful when one do not
+			care about the state of the feature group strings which
+			should be controlled by the OSPM.
 			Examples:
 			  1. 'acpi_osi=! acpi_osi="Windows 2000"' is equivalent
 			     to 'acpi_osi="Windows 2000" acpi_osi=!', they all
@@ -264,6 +267,29 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			  1. 'acpi_osi=' can make 'CondRefOf(_OSI, Local1)'
 			     FALSE.
 
+			'acpi_osi=!*' can be used in combination with single or
+			multiple 'acpi_osi="string1"' to support specific
+			string(s).  Note that such command can affect the
+			current state of both the OS vendor strings and the
+			feature group strings, thus specifying it multiple times
+			through kernel command line is meaningful.  But it may
+			still not able to affect the final state of a string if
+			there are quirks related to this string.  This command
+			is useful when one want to control the state of the
+			feature group strings to debug BIOS issues related to
+			the OSPM features.
+			Examples:
+			  1. 'acpi_osi="Module Device" acpi_osi=!*' can make
+			     '_OSI("Module Device")' FALSE.
+			  2. 'acpi_osi=!* acpi_osi="Module Device"' can make
+			     '_OSI("Module Device")' TRUE.
+			  3. 'acpi_osi=! acpi_osi=!* acpi_osi="Windows 2000"' is
+			     equivalent to
+			     'acpi_osi=!* acpi_osi=! acpi_osi="Windows 2000"'
+			     and
+			     'acpi_osi=!* acpi_osi="Windows 2000" acpi_osi=!',
+			     they all will make '_OSI("Windows 2000")' TRUE.
+
 	acpi_pm_good	[X86]
 			Override the pmtimer bug detection: force the kernel
 			to assume that this machine's pmtimer latches its value
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5dc311d..4b75e46 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1390,6 +1390,13 @@ void __init acpi_osi_setup(char *str)
 		if (*str == '\0') {
 			osi_linux.default_disabling = 1;
 			return;
+		} else if (*str == '*') {
+			acpi_update_interfaces(ACPI_DISABLE_ALL_STRINGS);
+			for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+				osi = &osi_setup_entries[i];
+				osi->enable = false;
+			}
+			return;
 		}
 		enable = false;
 	}
-- 
1.7.10

