From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/6] sony-laptop: SNC 127 Initialization Fix
Date: Sun, 12 Apr 2009 20:26:27 +0900
Message-ID: <1239535591-15514-3-git-send-email-malattia@linux.it>
References: <1239535591-15514-1-git-send-email-malattia@linux.it>
 <1239535591-15514-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41425
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756037AbZDLL0d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 07:26:33 -0400
In-Reply-To: <1239535591-15514-2-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>

From: Almer S. Tigelaar <almer@gnome.org>

Fixes additional special key initialization for SNC 127 key events.
Verified / tested on a Sony VAIO SR model.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a537467..7b1da3f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1003,6 +1003,7 @@ static int sony_nc_function_setup(struct acpi_device *device)
 	sony_call_snc_handle(0x0100, 0, &result);
 	sony_call_snc_handle(0x0101, 0, &result);
 	sony_call_snc_handle(0x0102, 0x100, &result);
+	sony_call_snc_handle(0x0127, 0, &result);
 
 	return 0;
 }
-- 
1.6.2.2

