From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] ACPI: Enable Windows ioport access compatibility on Windows-compatible systems
Date: Wed, 19 May 2010 11:43:11 -0400
Message-ID: <1274283791-3380-3-git-send-email-mjg@redhat.com>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044Ab0ESPnb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 May 2010 11:43:31 -0400
In-Reply-To: <1274283791-3380-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

Windows ignores everything but the lower 16 bits of system io accesses.
Enable compatibility with it if the firmware indicates Windows compatibility
by requesting a version of Windows via the _OSI method.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/bus.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 743576b..a10144b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -904,6 +904,14 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
+	/*
+	 * _SB_._INI has been called, so any _OSI requests should now have
+	 * been completed - enable any OS-specific workarounds
+	 */
+
+	if (acpi_gbl_osi_data >= ACPI_OSI_WIN_2000)
+		acpi_gbl_ignore_high_ioport_bits = TRUE;
+
 	acpi_early_processor_set_pdc();
 
 	/*
-- 
1.7.0.1

