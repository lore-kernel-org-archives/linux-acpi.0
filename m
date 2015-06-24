From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 22/28] ACPI / acpidump: Update acpidump manual.
Date: Wed, 24 Jun 2015 11:05:13 +0800
Message-ID: <0e726e9e8b83a2b37e27ce42949facfe43e64d15.1435114811.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10988 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826AbbFXDFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 23:05:18 -0400
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch updates acpidump manual according to the recent changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/man/acpidump.8 |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/power/acpi/man/acpidump.8 b/tools/power/acpi/man/acpidump.8
index 38f095d..79e2d1d 100644
--- a/tools/power/acpi/man/acpidump.8
+++ b/tools/power/acpi/man/acpidump.8
@@ -22,9 +22,6 @@ acpidump options are as follow:
 .B \-b
 Dump tables to binary files
 .TP
-.B \-c
-Dump customized tables
-.TP
 .B \-h \-?
 This help message
 .TP
@@ -48,15 +45,25 @@ Verbose mode
 .B \-a <Address>
 Get table via a physical address
 .TP
+.B \-c <on|off>
+Turning on/off customized table dumping
+.TP
 .B \-f <BinaryFile>
 Get table via a binary file
 .TP
 .B \-n <Signature>
 Get table via a name/signature
 .TP
-Invocation without parameters dumps all available tables
+.B \-x
+Do not use but dump XSDT
+.TP
+.B \-x \-x
+Do not use or dump XSDT
+.TP
+.fi
+Invocation without parameters dumps all available tables.
 .TP
-Multiple mixed instances of -a, -f, and -n are supported
+Multiple mixed instances of -a, -f, and -n are supported.
 
 .SH EXAMPLES
 
-- 
1.7.10

