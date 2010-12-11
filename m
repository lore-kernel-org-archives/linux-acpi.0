From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/15] ACPI / PM: Check device state before refcounting power
 resources
Date: Sat, 11 Dec 2010 02:06:26 -0500
Message-ID: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:49937 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab0LKHHG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:07:06 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD9009DX53BW5K1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:06:53 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit 3e384ee6c687cb397581ee8f9440fc8220cfac80 (ACPI / PM: Fix
reference counting of power resources) introduced a regression by
causing fan power resources to be turned on and reference counted
unnecessarily during resume, so on some boxes fans are always on
after resume.

Fix the problem by checking if the current device state is different
from the new state before reference counting and turning on power
resources in acpi_power_transition().

Addresses https://bugzilla.kernel.org/show_bug.cgi?id=22932 .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Maciej Rutecki <maciej.rutecki@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 67dedee..792a830 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -465,10 +465,12 @@ int acpi_power_transition(struct acpi_device *device, int state)
 	struct acpi_handle_list *tl = NULL;	/* Target Resources */
 	int i = 0;
 
-
 	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
 		return -EINVAL;
 
+	if (device->power.state == state)
+		return 0;
+
 	if ((device->power.state < ACPI_STATE_D0)
 	    || (device->power.state > ACPI_STATE_D3))
 		return -ENODEV;
@@ -488,10 +490,6 @@ int acpi_power_transition(struct acpi_device *device, int state)
 			goto end;
 	}
 
-	if (device->power.state == state) {
-		goto end;
-	}
-
 	/*
 	 * Then we dereference all power resources used in the current list.
 	 */
-- 
1.7.3.3.480.g2f76a

