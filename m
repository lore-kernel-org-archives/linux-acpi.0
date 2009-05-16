From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/19] ACPI processor: reset the throttling state once it's
 invalid
Date: Sat, 16 May 2009 02:02:14 -0400
Message-ID: <4973b22aa8c70fe036e3e0039f104cf5bb7fe2b1.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57099 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbZEPGC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ005C13G3YY4T@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:27 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

If the BIOS hands us an invalid throttling state,
write a valid state.

http://bugzilla.kernel.org/show_bug.cgi?id=13259

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: James Ettle <theholyettlz@googlemail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 5f09fb8..7f16f5f 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -838,6 +838,14 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 	ret = acpi_read_throttling_status(pr, &value);
 	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
+		if (state == -1) {
+			ACPI_WARNING((AE_INFO,
+				"Invalid throttling state, reset\n"));
+			state = 0;
+			ret = acpi_processor_set_throttling(pr, state);
+			if (ret)
+				return ret;
+		}
 		pr->throttling.state = state;
 	}
 
-- 
1.6.0.6

