From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] Clear WAK_STS on resume
Date: Wed, 6 Aug 2008 11:01:43 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3CE0ABE@orsmsx415.amr.corp.intel.com>
References: <20080806175818.GA27134@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44140 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbYHFSBp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2008 14:01:45 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080806175818.GA27134@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>, pavel@suse.cz, rjw@sisk.pl, ak@linux.intel.com

Hey, why not:

/*
 * The leading other brand OS appears to clear the WAK_STS flag on
resume.
 * When rebooted, certain BIOSes assume that the system is actually
 * resuming if it's still set and so fail to reboot correctly. Make sure
 * that it's cleared at resume time.
 */
 acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Matthew Garrett
>Sent: Wednesday, August 06, 2008 10:58 AM
>To: linux-acpi@vger.kernel.org
>Cc: Brown, Len; pavel@suse.cz; rjw@sisk.pl; ak@linux.intel.com
>Subject: [PATCH] Clear WAK_STS on resume
>
>The leading other brand OS appears to clear the WAK_STS flag on resume.
>When rebooted, certain BIOSes assume that the system is actually
>resuming if it's still set and so fail to reboot correctly. Make sure
>that it's cleared at resume time.
>
>Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
>---
>
>I've had it confirmed by AMI that some of their BIOSes make this
>assumption - there may well be others out there as well.
>
>diff --git a/drivers/acpi/hardware/hwsleep.c
>b/drivers/acpi/hardware/hwsleep.c
>index dba3cfb..1cda856 100644
>--- a/drivers/acpi/hardware/hwsleep.c
>+++ b/drivers/acpi/hardware/hwsleep.c
>@@ -627,6 +627,9 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
> 	}
> 	/* TBD: _WAK "sometimes" returns stuff - do we want to look at
it? */
>
>+	/* Clear wake status */
>+	acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
>+
> 	acpi_gbl_system_awake_and_running = TRUE;
>
> 	/* Enable power button */
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
