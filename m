From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] ACPI: add standard linux WARN() output to ACPI warnings
Date: Tue, 24 Jun 2008 23:07:42 -0400
Message-ID: <27587d0c4b2f6aecf5c54d943c1dc8deebcfcc1a.1214362900.git.len.brown@intel.com>
References: <20080620135639.GA5073@damson.getinternet.no>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53034 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYFYDHt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 23:07:49 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3000H9O0DN6BX7@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 24 Jun 2008 22:01:00 -0500 (CDT)
In-reply-to: <20080620135639.GA5073@damson.getinternet.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernrel@vger.kernrel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utmisc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 1f057b7..d53e82c 100644
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
 
@@ -1058,6 +1060,7 @@ acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
 {
 	va_list args;
 
+	warn_on_slowpath(module_name, line_number);
 	acpi_os_printf("ACPI Warning (%s-%04d): ", module_name, line_number);
 
 	va_start(args, format);
-- 
1.5.6.56.g29b0d

