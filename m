From: Darren Jenkins <darrenrjenkins@gmail.com>
Subject: [PATCH] drivers/acpi/processor_thermal.c
Date: Thu, 11 Feb 2010 20:56:51 +1100
Message-ID: <1265882211.27789.1.camel@ICE-BOX>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f193.google.com ([209.85.210.193]:63529 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab0BKJ46 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2010 04:56:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Janitors <kernel-janitors@vger.kernel.org>

There are a few places where a pointer is dereferenced with acpi_driver_data()
before a NULL test. This re-orders the code to fix these issues.

Coverity CID: 2752 2751 2750

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
---
 drivers/acpi/processor_thermal.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 6deafb4..ec33554 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -379,9 +379,14 @@ processor_get_max_state(struct thermal_cooling_device *cdev,
 			unsigned long *state)
 {
 	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr = acpi_driver_data(device);
+	struct acpi_processor *pr;
 
-	if (!device || !pr)
+	if (!device)
+		return -EINVAL;
+
+	pr = acpi_driver_data(device);
+
+	if (!pr)
 		return -EINVAL;
 
 	*state = acpi_processor_max_state(pr);
@@ -393,9 +398,14 @@ processor_get_cur_state(struct thermal_cooling_device *cdev,
 			unsigned long *cur_state)
 {
 	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr = acpi_driver_data(device);
+	struct acpi_processor *pr;
+
+	if (!device)
+		return -EINVAL;
 
-	if (!device || !pr)
+	pr = acpi_driver_data(device);
+
+	if (!pr)
 		return -EINVAL;
 
 	*cur_state = cpufreq_get_cur_state(pr->id);
@@ -409,18 +419,20 @@ processor_set_cur_state(struct thermal_cooling_device *cdev,
 			unsigned long state)
 {
 	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr = acpi_driver_data(device);
+	struct acpi_processor *pr;
 	int result = 0;
 	int max_pstate;
 
-	if (!device || !pr)
+	if (!device)
 		return -EINVAL;
 
-	max_pstate = cpufreq_get_max_state(pr->id);
+	pr = acpi_driver_data(device);
 
-	if (state > acpi_processor_max_state(pr))
+	if (!pr || state > acpi_processor_max_state(pr))
 		return -EINVAL;
 
+	max_pstate = cpufreq_get_max_state(pr->id);
+
 	if (state <= max_pstate) {
 		if (pr->flags.throttling && pr->throttling.state)
 			result = acpi_processor_set_throttling(pr, 0, false);
-- 
1.6.3.3




