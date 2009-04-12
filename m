From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 5/6] sony-laptop: fix bogus error message display on resume
Date: Sun, 12 Apr 2009 20:26:30 +0900
Message-ID: <1239535591-15514-6-git-send-email-malattia@linux.it>
References: <1239535591-15514-1-git-send-email-malattia@linux.it>
 <1239535591-15514-2-git-send-email-malattia@linux.it>
 <1239535591-15514-3-git-send-email-malattia@linux.it>
 <1239535591-15514-4-git-send-email-malattia@linux.it>
 <1239535591-15514-5-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41443
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760059AbZDLL0f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 07:26:35 -0400
In-Reply-To: <1239535591-15514-5-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

sony_backlight_update_status returns 0 on success -1 on failure (i.e.: the
return value from acpi_callsetfunc. The return value in the resume path
was broken and thus always displaying a bogus warning about not being able
to restore the brightness level.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index ddbd86b..419873a 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1041,7 +1041,7 @@ static int sony_nc_resume(struct acpi_device *device)
 
 	/* set the last requested brightness level */
 	if (sony_backlight_device &&
-			!sony_backlight_update_status(sony_backlight_device))
+			sony_backlight_update_status(sony_backlight_device) < 0)
 		printk(KERN_WARNING DRV_PFX "unable to restore brightness level\n");
 
 	return 0;
-- 
1.6.2.2

