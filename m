From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/21] ACPI EC: Fix regression due to use of uninitialized
 variable
Date: Thu, 06 Nov 2008 23:39:11 -0500
Message-ID: <29086e19e9149aadd17ece7112d7d2cf3a8b82f3.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36434 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYKGEja (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:30 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y0061Y4XU8221@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:30 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

breakage introduced by following patch
commit 27663c5855b10af9ec67bc7dfba001426ba21222
Author: Matthew Wilcox <willy@linux.intel.com>
Date:   Fri Oct 10 02:22:59 2008 -0400

acpi_evaluate_integer() does not clear passed variable if
there is an error at evaluation.
So if we ignore error, we must supply initialized variable.

References: http://bugzilla.kernel.org/show_bug.cgi?id=11917
	    http://bugzilla.kernel.org/show_bug.cgi?id=11896

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ef42316..523ac5b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -736,7 +736,7 @@ static acpi_status
 ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 {
 	acpi_status status;
-	unsigned long long tmp;
+	unsigned long long tmp = 0;
 
 	struct acpi_ec *ec = context;
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
@@ -751,6 +751,7 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 		return status;
 	ec->gpe = tmp;
 	/* Use the global lock for all EC transactions? */
+	tmp = 0;
 	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
 	ec->global_lock = tmp;
 	ec->handle = handle;
-- 
1.5.6.5

