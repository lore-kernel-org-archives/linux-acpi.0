From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 20/26] ACPI / acpidump: Update acpidump manual.
Date: Wed,  1 Jul 2015 14:45:05 +0800
Message-ID: <6539f04a1f37dc6d812b99d5e71baec55bebd126.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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
