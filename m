From: Len Brown <lenb@kernel.org>
Subject: [PATCH 55/65] ACPI: don't check power state after _ON/_OFF
Date: Fri, 29 May 2009 21:42:33 -0400
Message-ID: <bdf43bbf2e19952d82995a50e00cb4b66afa4f0c.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbZE3BnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:03 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00CGYORR7NE3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:03 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

We used to evaluate _STA to check the power state of a device after
running _ON or _OFF.  But as far as I can tell, there's no benefit
to evaluating _STA, and sometimes we trip over bugs when BIOSes don't
implement _STA correctly.

Yakui says Windows XP doesn't evaluate _STA during power transition.
So let's skip it in Linux, too.  It's conceivable that we'll need to
check _STA in the future for some reason, but until we do, I don't
see a reason to clutter this code path.

References:
    http://bugzilla.kernel.org/show_bug.cgi?id=13243
    http://marc.info/?l=linux-acpi&m=124166053803753&w=2
    http://marc.info/?l=linux-acpi&m=124175761408256&w=2
    http://marc.info/?l=linux-acpi&m=124210593114061&w=2

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |   28 ++--------------------------
 1 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 56665a6..d74365d 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -194,7 +194,7 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
 
 static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
 {
-	int result = 0, state;
+	int result = 0;
 	int found = 0;
 	acpi_status status = AE_OK;
 	struct acpi_power_resource *resource = NULL;
@@ -236,18 +236,6 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	if (!acpi_power_nocheck) {
-		/*
-		 * If acpi_power_nocheck is set, it is unnecessary to check
-		 * the power state after power transition.
-		 */
-		result = acpi_power_get_state(resource->device->handle,
-				&state);
-		if (result)
-			return result;
-		if (state != ACPI_POWER_RESOURCE_STATE_ON)
-			return -ENOEXEC;
-	}
 	/* Update the power resource's _device_ power state */
 	resource->device->power.state = ACPI_STATE_D0;
 
@@ -258,7 +246,7 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
 
 static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
 {
-	int result = 0, state;
+	int result = 0;
 	acpi_status status = AE_OK;
 	struct acpi_power_resource *resource = NULL;
 	struct list_head *node, *next;
@@ -293,18 +281,6 @@ static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	if (!acpi_power_nocheck) {
-		/*
-		 * If acpi_power_nocheck is set, it is unnecessary to check
-		 * the power state after power transition.
-		 */
-		result = acpi_power_get_state(handle, &state);
-		if (result)
-			return result;
-		if (state != ACPI_POWER_RESOURCE_STATE_OFF)
-			return -ENOEXEC;
-	}
-
 	/* Update the power resource's _device_ power state */
 	resource->device->power.state = ACPI_STATE_D3;
 
-- 
1.6.0.6

