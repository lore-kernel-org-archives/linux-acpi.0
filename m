From: Len Brown <lenb@kernel.org>
Subject: [PATCH 047/122] ACPI: Clear WAK_STS on resume
Date: Thu, 23 Oct 2008 02:38:21 -0400
Message-ID: <a68823ee5285e65b51ceb96f8b13a5b4f99a6888.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:46373 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbYJWGkG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:06 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KFGIINS7O2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:00 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The leading other brand OS appears to clear the WAK_STS flag on resume.
When rebooted, certain BIOSes assume that the system is actually
resuming if it's still set and so fail to reboot correctly. Make sure
that it's cleared at resume time.

Comment clarified as suggested by Bob Moore

http://bugzilla.kernel.org/show_bug.cgi?id=11634

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Romano Giannetti <romano.giannetti@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

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
1.5.5.1

