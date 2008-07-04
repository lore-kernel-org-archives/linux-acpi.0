From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] Delete an unwanted return statement at evgpe.c
Date: Fri, 04 Jul 2008 13:26:48 +0800
Message-ID: <1215149208.13289.9.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63520 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbYGDF3l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jul 2008 01:29:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Len's tree branch release-2.6.27, found an unwanted return statement at
evgpe.c.

(git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6
release-2.6.27)

Signed-of-by Lin Ming <ming.m.lin@intel.com>
---
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index c5e53aa..f45c74f 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -289,8 +289,6 @@ acpi_status acpi_ev_disable_gpe(struct
acpi_gpe_event_info *gpe_event_info)
 	 */
 	status = acpi_hw_low_disable_gpe(gpe_event_info);
 	return_ACPI_STATUS(status);
-
-	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************

Lin Ming

