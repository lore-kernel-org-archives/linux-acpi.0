From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 2/5] ACPI: Check parameter when calling
	acpi_processor_get/set_throttling
Date: Mon, 28 Jan 2008 13:53:30 +0800
Message-ID: <1201499610.17068.21.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26242 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbYA1GLk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 01:11:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Check parameter when calling acpi_processor_get/set_throttling
>From : Zhao Yakui <yakui.zhao@intel.com>

It is necessary to check the parameter when calling the function of 
acpi_processor_get/set_throttling function so as to avoid the NULL 
pointer reference in pr or throttling.

http://bugzilla.kernel.org/show_bug.cgi?id=9747

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_throttling.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux-2.6/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6/drivers/acpi/processor_throttling.c
@@ -589,6 +589,11 @@ static int acpi_processor_get_throttling
 	cpumask_t saved_mask;
 	int ret;
 
+	if (!pr)
+		return -EINVAL;
+
+	if (!pr->flags.throttling)
+		return -ENODEV;
 	/*
 	 * Migrate task to the cpu pointed by pr.
 	 */
@@ -743,6 +748,16 @@ int acpi_processor_set_throttling(struct
 {
 	cpumask_t saved_mask;
 	int ret;
+
+	if (!pr)
+		return -EINVAL;
+
+	if (!pr->flags.throttling)
+		return -ENODEV;
+
+	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
+		return -EINVAL;
+
 	/*
 	 * Migrate task to the cpu pointed by pr.
 	 */


