From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: [Resend PATCH]acpi c-states: Fix multiply C-states name disturbance
Date: Wed, 16 Dec 2009 11:06:02 -0500
Message-ID: <20091216160602.GA32481@youquan-linux.bj.intel.com>
References: <20091214130233.GA3898@youquan-linux.bj.intel.com> <E9B3B63B4561864CB95EB36DAD19BB2D5819FF09@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58544 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbZLPIai (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2009 03:30:38 -0500
Content-Disposition: inline
In-Reply-To: <E9B3B63B4561864CB95EB36DAD19BB2D5819FF09@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: venkatesh.pallipadi@intel.com, "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>, "Liu, Kent" <kent.liu@intel.com>, "Guo, Chaohong" <chaohong.guo@intel.com>, "Song, Youquan" <youquan.song@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

There are possible multiply C-states for special type of ACPI C-state, such as
 ACPI C3, processor C3,C6,C7 are possible all mapped to ACPI C3.

In /sys/devices/system/cpu/cpu0/cpuidle/stateXX, state<number> will increase 
with number of validate C-states. But its C-state name under stateXX will also
increase with number of validate C-state.
 
This patch unify that all the multiply C-states to one special ACPI C-state. 

Signed-off-by: Youquan, Song <youquan.song@intel.com>
Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>  
---


diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 302d656..f14785d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1086,7 +1086,6 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 #endif
 		cpuidle_set_statedata(state, cx);
 
-		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
 		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = cx->latency;
 		state->target_residency = cx->latency * latency_factor;
@@ -1099,6 +1098,8 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			if (cx->entry_method == ACPI_CSTATE_FFH)
 				state->flags |= CPUIDLE_FLAG_TIME_VALID;
 
+			snprintf(state->name, CPUIDLE_NAME_LEN, "ACPI C%d",
+					ACPI_STATE_C1);
 			state->enter = acpi_idle_enter_c1;
 			dev->safe_state = state;
 			break;
@@ -1106,6 +1107,8 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			case ACPI_STATE_C2:
 			state->flags |= CPUIDLE_FLAG_BALANCED;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
+			snprintf(state->name, CPUIDLE_NAME_LEN, "ACPI C%d",
+				ACPI_STATE_C2);
 			state->enter = acpi_idle_enter_simple;
 			dev->safe_state = state;
 			break;
@@ -1114,6 +1117,8 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			state->flags |= CPUIDLE_FLAG_DEEP;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
 			state->flags |= CPUIDLE_FLAG_CHECK_BM;
+			snprintf(state->name, CPUIDLE_NAME_LEN, "ACPI C%d",
+				ACPI_STATE_C3);
 			state->enter = pr->flags.bm_check ?
 					acpi_idle_enter_bm :
 					acpi_idle_enter_simple;
