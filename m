From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] tools/acpi: use CROSS_COMPILE to define prefix
Date: Fri, 17 Jun 2016 16:01:08 +0300
Message-ID: <1466168468-113522-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51775 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbcFQNBO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Jun 2016 09:01:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

CROSS_COMPILE can be considered as standard definition for toolchain prefix
when cross-compiling. Use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/power/acpi/Makefile.config | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index 552af68..a538ff4 100644
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -54,9 +54,10 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
 # to something more interesting, like "arm-linux-".  If you want
 # to compile vs uClibc, that can be done here as well.
 CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
-CC = $(CROSS)gcc
-LD = $(CROSS)gcc
-STRIP = $(CROSS)strip
+CROSS_COMPILE ?= $(CROSS)
+CC = $(CROSS_COMPILE)gcc
+LD = $(CROSS_COMPILE)gcc
+STRIP = $(CROSS_COMPILE)strip
 HOSTCC = gcc
 
 # check if compiler option is supported
-- 
2.8.1

