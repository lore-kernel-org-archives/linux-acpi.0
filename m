From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH_1/7] ACPI: Add the _TPC throttling limit for TSS
Date: Thu, 15 Nov 2007 16:59:30 +0800
Message-ID: <1195117170.6817.30.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25380 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbXKOIuB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 03:50:01 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Subject: ACPI :Add the _TPC throttling limit for TSS
>From : Zhao Yakui <yakui.zhao@intel.com>

When Tstate limit change notification is received, OSPM should 
evaluate the _TPC object and change the current TState according to the new
limit. 

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_throttling.c |   50 +++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

Index: linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.24-rc1.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
@@ -70,7 +70,55 @@ static int acpi_processor_get_platform_l
 
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
 {
-	return acpi_processor_get_platform_limit(pr);
+	int result = 0;
+	int throttling_limit;
+	int current_state;
+	struct acpi_processor_limit *limit;
+	int target_state;
+
+	result = acpi_processor_get_platform_limit(pr);
+	if (result) {
+		/* Throttling Limit is unsupported */
+		return result;
+	}
+
+	throttling_limit = pr->throttling_platform_limit;
+	if (throttling_limit >= pr->throttling.state_count) {
+		/* Uncorrect Throttling Limit */
+		return -EINVAL;
+	}
+
+	current_state = pr->throttling.state;
+	if (current_state > throttling_limit) {
+		/*
+		 * The current state can meet the requirement of
+		 * _TPC limit. But it is reasonable that OSPM changes
+		 * t-states from high to low for better performance.
+		 * Of course the limit condition of thermal
+		 * and user should be considered.
+		 */
+		limit = &pr->limit;
+		target_state = throttling_limit;
+		if (limit->thermal.tx > target_state)
+			target_state = limit->thermal.tx;
+		if (limit->user.tx > target_state)
+			target_state = limit->user.tx;
+	} else if (current_state == throttling_limit) {
+		/*
+		 * Unnecessary to change the throttling state
+		 */
+		return 0;
+	} else {
+		/*
+		 * If the current state is lower than the limit of _TPC, it
+		 * will be forced to switch to the throttling state defined
+		 * by throttling_platfor_limit.
+		 * Because the previous state meets with the limit condition
+		 * of thermal and user, it is unnecessary to check it again.
+		 */
+		target_state = throttling_limit;
+	}
+	return acpi_processor_set_throttling(pr, target_state);
 }
 
 /*
