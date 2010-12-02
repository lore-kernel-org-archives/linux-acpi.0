From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/8] acpi: Use ACPI C-state type instead of enumeration value to export cpuidle state name
Date: Thu,  2 Dec 2010 17:42:21 +0100
Message-ID: <1291308148-28628-2-git-send-email-trenn@suse.de>
References: <1291308148-28628-1-git-send-email-trenn@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291308148-28628-1-git-send-email-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, arjan@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

In the former /proc/acpi/processor/power/* there were Cx showing the
enumerated number/amount of C-states and type[Cy] which is
what should get shown as the cpuidle state name.

Typically on latest Nehalem and later CPUs, BIOS vendors miss
out C2 and C3 wrongly shows up as C2.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: arjan@linux.intel.com
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
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
1.6.0.2
