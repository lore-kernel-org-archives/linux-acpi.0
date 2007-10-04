From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: idle: delete access to ACPI_BITREG_BUS_MASTER_RLD
Date: Thu, 4 Oct 2007 00:53:04 -0400
Message-ID: <200710040053.04489.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60874 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbXJDExS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Oct 2007 00:53:18 -0400
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id l944rABo000546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 4 Oct 2007 04:53:11 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Len Brown <len.brown@intel.com>

The ACPI specification describes PM1*_CNT_BLK.BM_RLD in two places.

The first description says that the OS needs to set BM_RLD
to enable bus master activity to wake the processor from C3.

The second description says that the platform sets BM_RLD
to indicate whether it was bus master activity that woke the
platform from C3 or not.

The first description is erroneous, the second description is correct.
Delete Linux's implementation of the first description.

Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f182613..4f004f1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -192,26 +192,6 @@ acpi_processor_power_activate(struct acpi_processor *pr,
 		old->promotion.count = 0;
 	new->demotion.count = 0;
 
-	/* Cleanup from old state. */
-	if (old) {
-		switch (old->type) {
-		case ACPI_STATE_C3:
-			/* Disable bus master reload */
-			if (new->type != ACPI_STATE_C3 && pr->flags.bm_check)
-				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
-			break;
-		}
-	}
-
-	/* Prepare to use new state. */
-	switch (new->type) {
-	case ACPI_STATE_C3:
-		/* Enable bus master reload */
-		if (old->type != ACPI_STATE_C3 && pr->flags.bm_check)
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
-		break;
-	}
-
 	pr->power.state = new;
 
 	return;
@@ -1027,7 +1007,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 					  " for C3 to be enabled on SMP systems\n"));
 			return;
 		}
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
 	}
 
 	/*
