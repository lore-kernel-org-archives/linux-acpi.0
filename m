From: al.stone@linaro.org
Subject: [PATCH 10/12] ACPI: ACPI_FADT_C2_MP_SUPPORTED must be ignored in HW reduced mode
Date: Sat,  9 Nov 2013 18:36:20 -0700
Message-ID: <1384047382-20623-11-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61786 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab3KJBgm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:42 -0500
Received: by mail-ie0-f175.google.com with SMTP id u16so2367842iet.6
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:42 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e2bd0bf..262b84b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -290,7 +290,8 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 	 * Check for P_LVL2_UP flag before entering C2 and above on
 	 * an SMP system.
 	 */
-	if ((num_online_cpus() > 1) &&
+	if (!acpi_gbl_reduced_hardware &&
+	    (num_online_cpus() > 1) &&
 	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
 		return -ENODEV;
 #endif
@@ -965,7 +966,8 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 			continue;
 
 #ifdef CONFIG_HOTPLUG_CPU
-		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+		if (!acpi_gbl_reduced_hardware &&
+		    (cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
 		    !pr->flags.has_cst &&
 		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
 			continue;
@@ -1020,7 +1022,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 			continue;
 
 #ifdef CONFIG_HOTPLUG_CPU
-		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+		if (!acpi_gbl_reduced_hardware &&
+		    (cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
 		    !pr->flags.has_cst &&
 		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
 			continue;
-- 
1.8.3.1

