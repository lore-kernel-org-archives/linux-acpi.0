From: Colin King <colin.king@canonical.com>
Subject: [PATCH 2/2] ACPI / processor_thermal: avoid null pointer deference error
Date: Mon, 25 Mar 2013 10:50:06 +0000
Message-ID: <1364208606-8446-3-git-send-email-colin.king@canonical.com>
References: <1364208606-8446-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45571 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab3CYKuN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Mar 2013 06:50:13 -0400
In-Reply-To: <1364208606-8446-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix a null pointer deference by acpi_driver_data() if device is
null.  We should only set pr and check this is OK after we are
sure device is not null.

Smatch analysis:

drivers/acpi/processor_thermal.c:223 processor_get_max_state() warn:
  variable dereferenced before check 'device' (see line 221)
drivers/acpi/processor_thermal.c:237 processor_get_cur_state() warn:
  variable dereferenced before check 'device' (see line 235)
drivers/acpi/processor_thermal.c:255 processor_set_cur_state() warn:
  variable dereferenced before check 'device' (see line 251)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/processor_thermal.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 641b545..e8e6527 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -218,9 +218,13 @@ processor_get_max_state(struct thermal_cooling_device *cdev,
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
+	if (!pr)
 		return -EINVAL;
 
 	*state = acpi_processor_max_state(pr);
@@ -232,9 +236,13 @@ processor_get_cur_state(struct thermal_cooling_device *cdev,
 			unsigned long *cur_state)
 {
 	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr = acpi_driver_data(device);
+	struct acpi_processor *pr;
 
-	if (!device || !pr)
+	if (!device)
+		return -EINVAL;
+
+	pr = acpi_driver_data(device);
+	if (!pr)
 		return -EINVAL;
 
 	*cur_state = cpufreq_get_cur_state(pr->id);
@@ -248,11 +256,15 @@ processor_set_cur_state(struct thermal_cooling_device *cdev,
 			unsigned long state)
 {
 	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr = acpi_driver_data(device);
+	struct acpi_processor *pr;
 	int result = 0;
 	int max_pstate;
 
-	if (!device || !pr)
+	if (!device)
+		return -EINVAL;
+
+	pr = acpi_driver_data(device);
+	if (!pr)
 		return -EINVAL;
 
 	max_pstate = cpufreq_get_max_state(pr->id);
-- 
1.7.9.5

