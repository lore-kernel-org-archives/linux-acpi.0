From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Clear WAK_STS on resume
Date: Wed, 6 Aug 2008 19:12:04 +0100
Message-ID: <20080806181204.GA27374@srcf.ucam.org>
References: <20080806175818.GA27134@srcf.ucam.org> <9D39833986E69849A2A8E74C1078B6B3CE0ABE@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54439 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbYHFSMJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2008 14:12:09 -0400
Content-Disposition: inline
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3CE0ABE@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, pavel@suse.cz, rjw@sisk.pl, ak@linux.intel.com

The leading other brand OS appears to clear the WAK_STS flag on resume.                                                                                                                                
When rebooted, certain BIOSes assume that the system is actually                                                                                                                                       
resuming if it's still set and so fail to reboot correctly. Make sure                                                                                                                                  
that it's cleared at resume time.                                                                                                                                                                      
                                                                                                                                                                                                       
Signed-off-by: Matthew Garrett <mjg@redhat.com>                                                                                                                                                        
                            
---

Comment clarified as suggested by Bob Moore

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index dba3cfb..130a44b 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -627,6 +627,13 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 	}
 	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
 
+	/*
+	 * Some BIOSes assume that WAK_STS will be cleared on resume and use
+	 * it to determine whether the system is rebooting or resuming. Clear
+	 * it for compatibility.
+	 */
+	acpi_set_register(ACPI_BITREG_WAKE_STATUS, 1);
+
 	acpi_gbl_system_awake_and_running = TRUE;
 
 	/* Enable power button */

-- 
Matthew Garrett | mjg59@srcf.ucam.org
