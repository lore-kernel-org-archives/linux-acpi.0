From: malattia@linux.it
Subject: [PATCH 3/4] Small update to the Kconfig help to make people believe this driver is useful.
Date: Wed,  7 Feb 2007 20:01:55 +0100
Message-ID: <11708749161762-git-send-email-malattia@linux.it>
References: <11708749163025-git-send-email-malattia@linux.it> <11708749161009-git-send-email-malattia@linux.it> <11708749161045-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:47491 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161416AbXBGTDS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 14:03:18 -0500
In-Reply-To: <11708749161045-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4acd922..926ae11 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -117,7 +117,8 @@ config SONY_LAPTOP
 
 	  It gives access to some extra laptop functionalities. In
 	  its current form, the only thing this driver does is letting
-	  the user set or query the screen brightness.
+	  the user set or query the screen brightness and remove/apply
+	  power to some devices.
 
 	  Read <file:Documentation/acpi/sony_acpi.txt> for more information.
 
-- 
1.4.4.3

