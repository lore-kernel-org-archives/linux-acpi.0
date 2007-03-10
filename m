From: Len Brown <len.brown@intel.com>
Subject: [PATCH 16/20] libata-acpi: allow _GTF on SATA, but disable on PATA for now
Date: Fri,  9 Mar 2007 22:49:34 -0500
Message-ID: <11734985912054-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <1173498587849-git-send-email-len.brown@intel.com> <11734985882949-git-send-email-len.brown@intel.com> <11734985891723-git-send-email-len.brown@intel.com> <11734985892382-git-send-email-len.brown@intel.com> <11734985901640-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965826AbXCJDtw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:52 -0500
In-Reply-To: <11734985901640-git-send-email-len.brown@intel.com>
Message-Id: <df33c77e3981e71afc8727ee5c432ba1a1bba68c.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Accardi <kristen.c.accardi@intel.com>

The ACPI specification states, and BIOS implementations depend on,
_STM being called before _GTF.

SATA does this, but PATA does not.  So for now, simply
prevent execution of _GTF on PATA devices.  Longer term we
should implement ACPI support for PATA devices in libata.

Signed-off-by: Kristen Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/ata/libata-acpi.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index d14a48e..89aaf74 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -561,6 +561,13 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 
 	if (noacpi)
 		return 0;
+	/*
+	 * TBD - implement PATA support.  For now,
+	 * we should not run GTF on PATA devices since some
+	 * PATA require execution of GTM/STM before GTF.
+	 */
+	if (!(ap->cbl == ATA_CBL_SATA))
+		return 0;
 
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
 		if (!ata_dev_enabled(&ap->device[ix]))
-- 
1.5.0.3.310.g05ef5
