From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/8] ACPI: Kconfig, fix proc aggregator text
Date: Thu, 15 Oct 2009 00:59:37 -0400
Message-ID: <c4c4e2a58996d774429ded2fe386e88b47a10e98.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:33491 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZJOFAa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:00:30 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ00A9MHVPFJGF@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 14 Oct 2009 23:59:52 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
In-reply-to: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jiri Slaby <jirislaby@gmail.com>, Len Brown <len.brown@intel.com>

From: Jiri Slaby <jirislaby@gmail.com>

Fix two typos in the Kconfig text about ACPI_PROCESSOR_AGGREGATOR.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0ed42d8..93d2c79 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -218,10 +218,10 @@ config ACPI_PROCESSOR_AGGREGATOR
 	depends on X86
 	help
 	  ACPI 4.0 defines processor Aggregator, which enables OS to perform
-	  specfic processor configuration and control that applies to all
+	  specific processor configuration and control that applies to all
 	  processors in the platform. Currently only logical processor idling
 	  is defined, which is to reduce power consumption. This driver
-	  support the new device.
+	  supports the new device.
 
 config ACPI_THERMAL
 	tristate "Thermal Zone"
-- 
1.6.0.6

