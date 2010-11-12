From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] acpi: Use ACPI C-state type instead of enumeration value to export cpuidle state name
Date: Fri, 12 Nov 2010 18:02:12 +0100
Message-ID: <1289581334-26836-2-git-send-email-trenn@suse.de>
References: <1289581334-26836-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60863 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569Ab0KLRCS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Nov 2010 12:02:18 -0500
In-Reply-To: <1289581334-26836-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, trenn@suse.de

In the former /proc/acpi/processor/power/* there were Cx showing the
enumerated number/amount of C-states and type[Cy] which is
what should get shown as the cpuidle state name.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: arjan@linux.intel.com
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_idle.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dcb38f8..104ae77 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1008,7 +1008,6 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 #endif
 		cpuidle_set_statedata(state, cx);
 
-		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
 		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = cx->latency;
 		state->target_residency = cx->latency * latency_factor;
@@ -1016,6 +1015,7 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		state->flags = 0;
 		switch (cx->type) {
 			case ACPI_STATE_C1:
+			snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
 			state->flags |= CPUIDLE_FLAG_SHALLOW;
 			if (cx->entry_method == ACPI_CSTATE_FFH)
 				state->flags |= CPUIDLE_FLAG_TIME_VALID;
@@ -1025,6 +1025,7 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			break;
 
 			case ACPI_STATE_C2:
+			snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
 			state->flags |= CPUIDLE_FLAG_BALANCED;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
 			state->enter = acpi_idle_enter_simple;
@@ -1032,6 +1033,7 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			break;
 
 			case ACPI_STATE_C3:
+			snprintf(state->name, CPUIDLE_NAME_LEN, "C3");
 			state->flags |= CPUIDLE_FLAG_DEEP;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
 			state->flags |= CPUIDLE_FLAG_CHECK_BM;
-- 
1.6.3

