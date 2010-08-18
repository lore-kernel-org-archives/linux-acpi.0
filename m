From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 1/2] Drivers: ACPI: Kconfig: fix typo.
Date: Wed, 18 Aug 2010 15:22:10 +0200
Message-ID: <1282137731-10469-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38699 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab0HRNWf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Aug 2010 09:22:35 -0400
Received: by bwz11 with SMTP id 11so183240bwz.19
        for <linux-acpi@vger.kernel.org>; Wed, 18 Aug 2010 06:22:33 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gelma@gelma.net
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Huang Ying <ying.huang@intel.com>, Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

"power of" -> "power off"
---
 drivers/acpi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b811f21..88681ac 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -105,7 +105,7 @@ config ACPI_EC_DEBUGFS
 
 	  Be aware that using this interface can confuse your Embedded
 	  Controller in a way that a normal reboot is not enough. You then
-	  have to power of your system, and remove the laptop battery for
+	  have to power off your system, and remove the laptop battery for
 	  some seconds.
 	  An Embedded Controller typically is available on laptops and reads
 	  sensor values like battery state and temperature.
-- 
1.7.2.1.138.g54ed9

