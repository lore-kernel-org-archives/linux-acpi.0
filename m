From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/4] sony-laptop: remove _INI call at init time
Date: Wed, 16 Sep 2009 00:05:31 +0900
Message-ID: <1253027132-5903-4-git-send-email-malattia@linux.it>
References: <1253027132-5903-1-git-send-email-malattia@linux.it>
 <1253027132-5903-2-git-send-email-malattia@linux.it>
 <1253027132-5903-3-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:43820
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbZIOPO0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2009 11:14:26 -0400
In-Reply-To: <1253027132-5903-3-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

This is unnecessary as OSPM is supposed to call the method already when
the device is discovered.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index f2482f2..11fed29 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1205,15 +1205,6 @@ static int sony_nc_add(struct acpi_device *device)
 		}
 	}
 
-	/* try to _INI the device if such method exists (ACPI spec 3.0-6.5.1
-	 * should be respected as we already checked for the device presence above */
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, METHOD_NAME__INI, &handle))) {
-		dprintk("Invoking _INI\n");
-		if (ACPI_FAILURE(acpi_evaluate_object(sony_nc_acpi_handle, METHOD_NAME__INI,
-						NULL, NULL)))
-			dprintk("_INI Method failed\n");
-	}
-
 	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
 					 &handle))) {
 		if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, NULL))
-- 
1.6.3.3

