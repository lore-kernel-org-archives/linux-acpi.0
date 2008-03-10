From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH] ACPI: disable stray gpe correctly
Date: Mon, 10 Mar 2008 10:04:09 +0800
Message-ID: <1205114649.10256.200.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41956 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbYCJCRY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Mar 2008 22:17:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, robert.moore@intel.com, davej@redhat.com

Disable stray GPE correctly
https://bugzilla.redhat.com/show_bug.cgi?id=251744
http://bugzilla.kernel.org/show_bug.cgi?id=6217

Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/events/evgpe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/events/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/events/evgpe.c
+++ linux-2.6/drivers/acpi/events/evgpe.c
@@ -248,7 +248,8 @@ acpi_status acpi_ev_disable_gpe(struct a
 
 	ACPI_FUNCTION_TRACE(ev_disable_gpe);
 
-	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
+	if (gpe_event_info->flags &&
+		(!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK))) {
 		return_ACPI_STATUS(AE_OK);
 	}
 


