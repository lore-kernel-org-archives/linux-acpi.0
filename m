From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: add standard linux WARN_ON() output to ACPI errors
 and exceptions
Date: Sat, 28 Jun 2008 02:06:37 -0400
Message-ID: <9e030ab0bffdc8b6d8be663b639bd5e2374537f0.1214633028.git.len.brown@intel.com>
References: <1214633197-3344-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:43763 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYF1GHJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 02:07:09 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K35001IJSNQAL0F@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:59:51 -0500 (CDT)
In-reply-to: <1214633197-3344-1-git-send-email-lenb@kernel.org>
In-reply-to: <beda7788389c03279ae772f5423ff9baaa1b514c.1214633028.git.len.brown@intel.com>
References: <beda7788389c03279ae772f5423ff9baaa1b514c.1214633028.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

In linux-2.6.27, we expect WARN() with printk semantics
to become available, and we'll be able to simplify
this code.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utmisc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 1f057b7..0a340b0 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -1028,6 +1028,7 @@ acpi_ut_error(char *module_name, u32 line_number, char *format, ...)
 {
 	va_list args;
 
+	warn_on_slowpath(module_name, line_number);
 	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
 
 	va_start(args, format);
@@ -1042,6 +1043,7 @@ acpi_ut_exception(char *module_name,
 {
 	va_list args;
 
+	warn_on_slowpath(module_name, line_number);
 	acpi_os_printf("ACPI Exception (%s-%04d): %s, ", module_name,
 		       line_number, acpi_format_exception(status));
 
-- 
1.5.6.1.89.gd544

