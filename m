From: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/20] ACPI: fix S3 fan resume issue
Date: Fri,  9 Mar 2007 22:49:19 -0500
Message-ID: <11734985791126-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23581 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965668AbXCJDtk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:40 -0500
In-Reply-To: <11734985781377-git-send-email-len.brown@intel.com>
Message-Id: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Len Brown <len.brown@intel.com>

From: Konstantin Karasyov <konstantin.a.karasyov@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=7570#c14

Signed-off-by: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 1ef3385..547eee7 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -436,8 +436,6 @@ int acpi_power_transition(struct acpi_device *device, int state)
 	cl = &device->power.states[device->power.state].resources;
 	tl = &device->power.states[state].resources;
 
-	device->power.state = ACPI_STATE_UNKNOWN;
-
 	if (!cl->count && !tl->count) {
 		result = -ENODEV;
 		goto end;
@@ -468,12 +466,15 @@ int acpi_power_transition(struct acpi_device *device, int state)
 			goto end;
 	}
 
-	/* We shouldn't change the state till all above operations succeed */
-	device->power.state = state;
-      end:
-	if (result)
+     end:
+	if (result) {
+		device->power.state = ACPI_STATE_UNKNOWN;
 		printk(KERN_WARNING PREFIX "Transitioning device [%s] to D%d\n",
 			      device->pnp.bus_id, state);
+	} else {
+	/* We shouldn't change the state till all above operations succeed */
+		device->power.state = state;
+	}
 
 	return result;
 }
-- 
1.5.0.3.310.g05ef5
