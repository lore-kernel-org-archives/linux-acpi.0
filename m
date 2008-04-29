From: Len Brown <lenb@kernel.org>
Subject: [PATCH 092/171] 2.6.25 regression: powertop says 120K wakeups/sec
Date: Tue, 29 Apr 2008 04:44:12 -0400
Message-ID: <0fda6b403f0eca66ad8a7c946b3996e359100443.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:45231 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760571AbYD2IpJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:09 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Patch to fix huge number of wakeups reported due to recent changes in
processor_idle.c. The problem was that the entry_method determination was
broken due to one of the recent commits (bc71bec91f987) causing
C1 entry to not to go to halt.

http://lkml.org/lkml/2008/3/22/124

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 788da97..836362b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -848,6 +848,7 @@ static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
 		/* all processors need to support C1 */
 		pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
 		pr->power.states[ACPI_STATE_C1].valid = 1;
+		pr->power.states[ACPI_STATE_C1].entry_method = ACPI_CSTATE_HALT;
 	}
 	/* the C0 state only exists as a filler in our array */
 	pr->power.states[ACPI_STATE_C0].valid = 1;
@@ -960,6 +961,9 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 				 cx.address);
 		}
 
+		if (cx.type == ACPI_STATE_C1) {
+			cx.valid = 1;
+		}
 
 		obj = &(element->package.elements[2]);
 		if (obj->type != ACPI_TYPE_INTEGER)
-- 
1.5.5.1.99.gf0ec4

