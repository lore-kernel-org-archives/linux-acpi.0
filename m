From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 04/33] asus-laptop: Remove uneccesary acpi_disabled check
Date: Thu,  3 Dec 2009 08:44:48 +0100
Message-ID: <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44214 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbZLCHoc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:32 -0500
In-Reply-To: <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

acpi_bus_register_driver() already checks acpi_disabled, so acpi bus
drivers don't need to.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/asus-laptop.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 8af43e9..4234edb 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1438,9 +1438,6 @@ static int __init asus_laptop_init(void)
 {
 	int result;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	result = acpi_bus_register_driver(&asus_hotk_driver);
 	if (result < 0)
 		return result;
-- 
1.6.5.3

