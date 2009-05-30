From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/65] ACPI processor: remove spurious newline from warning
 message
Date: Fri, 29 May 2009 21:42:41 -0400
Message-ID: <21671b88be331fb9c95891d5ee7d2e940e6b024c.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:39590 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbZE3BnJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:09 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF004QRORS9LR3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:05 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Len Brown <len.brown@intel.com>

From: Frans Pop <elendil@planet.nl>

Commit 4973b22a ("ACPI processor: reset the throttling state once it's
invalid") introduced a new warning which prints a spurious newline.

The ACPI_WARNING macro that is used already takes care of adding a
newline, after adding ACPI_CA_VERSION to the message. Remove the newline
to avoid the message getting split into two lines.

Signed-off-by: Frans Pop <elendil@planet.nl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 7f16f5f..2275437 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -840,7 +840,7 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 		state = acpi_get_throttling_state(pr, value);
 		if (state == -1) {
 			ACPI_WARNING((AE_INFO,
-				"Invalid throttling state, reset\n"));
+				"Invalid throttling state, reset"));
 			state = 0;
 			ret = acpi_processor_set_throttling(pr, state);
 			if (ret)
-- 
1.6.0.6

