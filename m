From: Vasily Averin <vvs@sw.ru>
Subject: [PATCH ACPI] memory leak in acpi_evaluate_integer()
Date: Sun, 09 Apr 2006 19:07:51 +0400
Message-ID: <44392347.406@sw.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030307080301040809040306"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:48676 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750764AbWDIPFA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Apr 2006 11:05:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>, devel@openvz.org

This is a multi-part message in MIME format.
--------------030307080301040809040306
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

acpi_evaluate_integer() does not release allocated memory on the error path.

Signed-off-by: Vasily Averin <vvs@sw.ru>

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

--------------030307080301040809040306
Content-Type: text/plain;
 name="diff-ms-acpi-evint-20060409"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-acpi-evint-20060409"

--- a/drivers/acpi/utils.c	2006-04-09 14:31:39.000000000 +0400
+++ b/drivers/acpi/utils.c	2006-04-09 14:35:02.000000000 +0400
@@ -273,11 +273,13 @@ acpi_evaluate_integer(acpi_handle handle
 	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
+		kfree(element);
 		return_ACPI_STATUS(status);
 	}
 
 	if (element->type != ACPI_TYPE_INTEGER) {
 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
+		kfree(element);
 		return_ACPI_STATUS(AE_BAD_DATA);
 	}
 

--------------030307080301040809040306--
