From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPI OSC: Increase buffer length of 3rd argument to 12 bytes
Date: Thu, 26 May 2011 14:04:25 +0200
Message-ID: <1306411465-9779-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59922 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab1EZME3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 May 2011 08:04:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Robert.Moore@intel.com, rjwysocki@sisk.pl, youquan.song@intel.com, linux-acpi@vger.kernel.org, lenb@kernel.org, stable@kernel.org

This works around a widespread BIOS issue (seen on quite some Intel
systems).
There the BIOS tries to reference the capabilities buffer beyond
the buffer's size.

According to the ACPI spec the capabilities buffer (3rd argument)
must at least be 4 bytes in size and is used to return error codes
Compare with ACPI spec: 6.2.10 _OSC (Operating System Capabilities)
But BIOSes reference up to 12 bytes without checking the size of
the 3rd argument. This results in breaking out of interpreting/processing
the _OSC method and in this error message:
ACPI Error: Field [CPB3] at 96 exceeds Buffer [NULL] size 64 (bits) (20110112/dsopcode-597)
ACPI Error: Method parse/execution failed [\_SB_._OSC] (Node ffff88081f4cdb78), AE_AML_BUFFER_LIMIT (20110112/psparse-536)

This patch fixes the issue.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Robert.Moore@intel.com
CC: rjwysocki@sisk.pl
CC: youquan.song@intel.com
CC: linux-acpi@vger.kernel.org
CC: lenb@kernel.org
CC: stable@kernel.org
---
 drivers/acpi/bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9749980..feb97b3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -526,7 +526,7 @@ static void acpi_bus_osc_support(void)
 	struct acpi_osc_context context = {
 		.uuid_str = sb_uuid_str,
 		.rev = 1,
-		.cap.length = 8,
+		.cap.length = 12,
 		.cap.pointer = capbuf,
 	};
 	acpi_handle handle;
-- 
1.7.3.4

