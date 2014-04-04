From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/28] ACPICA: acpidump: Update manual file.
Date: Fri,  4 Apr 2014 12:40:09 +0800
Message-ID: <fd222573d9cb4fb66454b0a924eb9d25250d0adb.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23383 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbaDDEki (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:40:38 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Chao Guan <guanchao@mail.ustc.edu.cn>, Bob Moore <robert.moore@intel.com>

This patch updates man file of acpidump.

Cc: Chao Guan <guanchao@mail.ustc.edu.cn>
Cc: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/man/acpidump.8 |   85 +++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 12 deletions(-)

diff --git a/tools/power/acpi/man/acpidump.8 b/tools/power/acpi/man/acpidump.8
index adfa991..38f095d 100644
--- a/tools/power/acpi/man/acpidump.8
+++ b/tools/power/acpi/man/acpidump.8
@@ -1,18 +1,64 @@
 .TH ACPIDUMP 8
 .SH NAME
-acpidump \- Dump system's ACPI tables to an ASCII file.
+acpidump \- dump a system's ACPI tables to an ASCII file
+
 .SH SYNOPSIS
-.ft B
-.B acpidump > acpidump.out
+.B acpidump
+.RI [ options ]
+.br
+
 .SH DESCRIPTION
-\fBacpidump \fP dumps the systems ACPI tables to an ASCII file
-appropriate for attaching to a bug report.
+.B acpidump
+dumps the systems ACPI tables to an ASCII file appropriate for
+attaching to a bug report.
 
 Subsequently, they can be processed by utilities in the ACPICA package.
-.SS Options
-no options worth worrying about.
-.PP
-.SH EXAMPLE
+
+.SH OPTIONS
+acpidump options are as follow:
+.TP
+.B Options
+.TP
+.B \-b
+Dump tables to binary files
+.TP
+.B \-c
+Dump customized tables
+.TP
+.B \-h \-?
+This help message
+.TP
+.B \-o <File>
+Redirect output to file
+.TP
+.B \-r <Address>
+Dump tables from specified RSDP
+.TP
+.B \-s
+Print table summaries only
+.TP
+.B \-v
+Display version information
+.TP
+.B \-z
+Verbose mode
+.TP
+.B Table Options
+.TP
+.B \-a <Address>
+Get table via a physical address
+.TP
+.B \-f <BinaryFile>
+Get table via a binary file
+.TP
+.B \-n <Signature>
+Get table via a name/signature
+.TP
+Invocation without parameters dumps all available tables
+.TP
+Multiple mixed instances of -a, -f, and -n are supported
+
+.SH EXAMPLES
 
 .nf
 # acpidump > acpidump.out
@@ -50,10 +96,25 @@ ACPICA: https://acpica.org/
 .ta
 .nf
 /dev/mem
+/sys/firmware/acpi/tables/*
 /sys/firmware/acpi/tables/dynamic/*
+/sys/firmware/efi/systab
 .fi
 
-.PP
 .SH AUTHOR
-.nf
-Written by Len Brown <len.brown@intel.com>
+.TP
+Original by:
+ Len Brown <len.brown@intel.com>
+.TP
+Written by:
+ Chao Guan <chao.guan@intel.com>
+.TP
+Updated by:
+ Bob Moore <robert.moore@intel.com>
+ Lv Zheng <lv.zheng@intel.com>
+
+.SH SEE ALSO
+\&\fIacpixtract\fR\|(8), \fIiasl\fR\|(8).
+
+.SH COPYRIGHT
+COPYRIGHT (c) 2013, Intel Corporation.
-- 
1.7.10

