From: akpm@osdl.org
Subject: [patch 3/5] acpi: do not abort method execution if asked to release not acquired mutex
Date: Thu, 06 Jul 2006 23:52:57 -0700
Message-ID: <200607070652.k676qvOo030084@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:12480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWGGGxG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jul 2006 02:53:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, alexey.y.starikovskiy@intel.com, bcollins@ubuntu.com, zulcss@gmail.com

From:  Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

See http://bugme.osdl.org/show_bug.cgi?id=6687
Closes: #50088

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=202ddb5b6498af53e110f78edd41a217587c1ffb

Signed-off-by: Chuck Short <zulcss@gmail.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/executer/exmutex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/executer/exmutex.c~acpi-do-not-abort-method-execution-if-asked-to-release drivers/acpi/executer/exmutex.c
--- a/drivers/acpi/executer/exmutex.c~acpi-do-not-abort-method-execution-if-asked-to-release
+++ a/drivers/acpi/executer/exmutex.c
@@ -246,7 +246,7 @@ acpi_ex_release_mutex(union acpi_operand
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], not acquired",
 			    acpi_ut_get_node_name(obj_desc->mutex.node)));
-		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* Sanity check -- we must have a valid thread ID */
_
