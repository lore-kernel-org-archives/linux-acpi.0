From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Clear WAK_STS on resume
Date: Wed, 6 Aug 2008 18:58:18 +0100
Message-ID: <20080806175818.GA27134@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54476 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYHFR6X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2008 13:58:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, pavel@suse.cz, rjw@sisk.pl, ak@linux.intel.com

The leading other brand OS appears to clear the WAK_STS flag on resume. 
When rebooted, certain BIOSes assume that the system is actually 
resuming if it's still set and so fail to reboot correctly. Make sure 
that it's cleared at resume time.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

I've had it confirmed by AMI that some of their BIOSes make this 
assumption - there may well be others out there as well.

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index dba3cfb..1cda856 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -627,6 +627,9 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	}
 	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
 
+	/* Clear wake status */
+	acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
+
 	acpi_gbl_system_awake_and_running = TRUE;
 
 	/* Enable power button */

-- 
Matthew Garrett | mjg59@srcf.ucam.org
