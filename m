From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if it's already on.
Date: Fri, 16 Oct 2009 22:22:47 +0200
Message-ID: <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
 <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:43233 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbZJPUVt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Oct 2009 16:21:49 -0400
In-Reply-To: <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Luca Niccoli <lultimouomo@gmail.com>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

From: Luca Niccoli <lultimouomo@gmail.com>

Switching the camera takes 500ms, checking if it's on is almost free...
The BIOS remembers the setting through reboots, so there's good chance the
camera is already enabled.

Signed-off-by: Luca Niccoli <lultimouomo@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 789d6ae..4226e53 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -356,7 +356,8 @@ static void __devinit eeepc_enable_camera(void)
 	 * If the following call to set_acpi() fails, it's because there's no
 	 * camera so we can ignore the error.
 	 */
-	set_acpi(CM_ASL_CAMERA, 1);
+	if (get_acpi(CM_ASL_CAMERA) == 0)
+		set_acpi(CM_ASL_CAMERA, 1);
 }
 
 /*
-- 
1.6.5.rc2

