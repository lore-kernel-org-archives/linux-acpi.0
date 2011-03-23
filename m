From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/42] ACPI: Bug compatibility for Windows on the ACPI reboot
 vector
Date: Wed, 23 Mar 2011 02:42:50 -0400
Message-ID: <6734fe57a07b2dd23ef1ef2ac1f790747e53eefc.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37008 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab1CWHHg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:36 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:35 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

Windows ignores the bit_offset and bit_width, despite the spec requiring
that they be validated. Drop the checks so that we match this behaviour.
Windows also goes straight for the keyboard controller if the ACPI reboot
fails, so we shouldn't sleep if we're still alive.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/reboot.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 93f9114..4870aaa 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -15,9 +15,10 @@ void acpi_reboot(void)
 
 	rr = &acpi_gbl_FADT.reset_register;
 
-	/* Is the reset register supported? */
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
-	    rr->bit_width != 8 || rr->bit_offset != 0)
+	/* Is the reset register supported? The spec says we should be
+	 * checking the bit width and bit offset, but Windows ignores
+	 * these fields */
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER))
 		return;
 
 	reset_value = acpi_gbl_FADT.reset_value;
@@ -45,6 +46,4 @@ void acpi_reboot(void)
 		acpi_reset();
 		break;
 	}
-	/* Wait ten seconds */
-	acpi_os_stall(10000000);
 }
-- 
1.7.4.1.343.ga91df

