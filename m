From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/16] ACPI: enable repeated PCIEXP wakeup by clearing
 PCIEXP_WAKE_STS on resume
Date: Tue, 28 Sep 2010 23:44:33 -0400
Message-ID: <573b638158029898caf9470c8214b7ddd29751e3.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:38468 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab0I2DpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:24 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H009O4P35UW16@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:11 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Colin Ian King <colin.king@canonical.com>, Len Brown <len.brown@intel.com>

From: Colin Ian King <colin.king@canonical.com>

Section 4.7.3.1.1 (PM1 Status Registers) of version 4.0 of
the ACPI spec concerning PCIEXP_WAKE_STS points out in
in the final note field in table 4-11 that if this bit is
set to 1 and the system is put into a sleeping state then
the system will not automatically wake.

This bit gets set by hardware to indicate that the system
woke up due to a PCI Express wakeup event, so clear it during
acpi_hw_clear_acpi_status() calls to enable subsequent
resumes to work.

BugLink: http://bugs.launchpad.net/bugs/613381

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index df85b53..7dad916 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -854,6 +854,7 @@ struct acpi_bit_register_info {
 	ACPI_BITMASK_POWER_BUTTON_STATUS   | \
 	ACPI_BITMASK_SLEEP_BUTTON_STATUS   | \
 	ACPI_BITMASK_RT_CLOCK_STATUS       | \
+	ACPI_BITMASK_PCIEXP_WAKE_DISABLE   | \
 	ACPI_BITMASK_WAKE_STATUS)
 
 #define ACPI_BITMASK_TIMER_ENABLE               0x0001
-- 
1.7.3.2.g9027fa

