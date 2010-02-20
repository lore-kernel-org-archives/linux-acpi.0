From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] eeepc-laptop: disable wireless hotplug for 1005PE
Date: Sat, 20 Feb 2010 11:02:24 +0000
Message-ID: <4B7FC140.60501@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:42596 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab0BTLCa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Feb 2010 06:02:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org, Ansgar Burchardt <ansgar@43-1.org>

The wireless hotplug code is not needed on this model, and it disables
the wired ethernet card.  (Like on the 1005HA and 1201N).

References: <http://lists.alioth.debian.org/pipermail/debian-eeepc-devel/2010-February/003281.html>

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Reported-by: Ansgar Burchardt <ansgar@43-1.org>
CC: stable@kernel.org
---
 drivers/platform/x86/eeepc-laptop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index e2be6bb..6a47bb7 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1277,7 +1277,8 @@ static void eeepc_dmi_check(struct eeepc_laptop *eeepc)
 	 * hotplug code. In fact, current hotplug code seems to unplug another
 	 * device...
 	 */
-	if (strcmp(model, "1005HA") == 0 || strcmp(model, "1201N") == 0) {
+	if (strcmp(model, "1005HA") == 0 || strcmp(model, "1201N") == 0 ||
+	    strcmp(model, "1005PE") == 0) {
 		eeepc->hotplug_disabled = true;
 		pr_info("wlan hotplug disabled\n");
 	}
-- 
1.6.3.3



