From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 3/8] acpi: reboot: use acpi_reset interface
Date: Wed, 26 Nov 2008 10:54:03 +0800
Message-ID: <1227668043.7702.91.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10362 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbYKZC7Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 21:59:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

We have changed the acpi_hw_low_level_read and acpi_low_level_write functions
to the public acpi_read and acpi_write to allow direct access to ACPI registers.

acpi_read/write: http://git.acpica.org/repos/?p=acpica.git;a=commitdiff;h=8ce404a262f4eccf8ef484ef7e9a8f3604e031da
acpi_reset: http://git.acpica.org/repos/?p=acpica.git;a=commitdiff;h=3409e43b6386884be43dd3e6ec54de60e4fc191e


Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/reboot.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index a6b662c..93f9114 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -42,7 +42,7 @@ void acpi_reboot(void)
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
-		acpi_hw_low_level_write(8, reset_value, rr);
+		acpi_reset();
 		break;
 	}
 	/* Wait ten seconds */


