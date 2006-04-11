From: akpm@osdl.org
Subject: [patch 11/13] acpi: memory leak in acpi_evaluate_integer()
Date: Mon, 10 Apr 2006 23:17:00 -0700
Message-ID: <200604110717.k3B7HfWu014926@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:52868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932314AbWDKHSV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Apr 2006 03:18:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, vvs@sw.ru


From: Vasily Averin <vvs@sw.ru>

acpi_evaluate_integer() does not release allocated memory on the error path.

(akpm: this is what happens when one uses multiple `return' statements...)

Signed-off-by: Vasily Averin <vvs@sw.ru>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/utils.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/acpi/utils.c~memory-leak-in-acpi_evaluate_integer drivers/acpi/utils.c
--- devel/drivers/acpi/utils.c~memory-leak-in-acpi_evaluate_integer	2006-04-10 23:16:23.000000000 -0700
+++ devel-akpm/drivers/acpi/utils.c	2006-04-10 23:16:23.000000000 -0700
@@ -274,11 +274,13 @@ acpi_evaluate_integer(acpi_handle handle
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
 
_
