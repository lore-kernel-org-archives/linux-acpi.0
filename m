From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: clean up tmp variable before reuse
Date: Fri, 31 Oct 2008 21:42:37 +0300
Message-ID: <20081031184233.8588.42241.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:41027 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751978AbYJaSmj (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 14:42:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Fix breakage introduced by following patch
27663c5855b10af9ec67bc7dfba001426ba21222 is first bad commit
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

