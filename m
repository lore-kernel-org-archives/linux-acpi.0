From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/16] ACPI: Kconfig: fix typo.
Date: Tue, 28 Sep 2010 23:44:41 -0400
Message-ID: <25cb1bfdd8256cd1c614947e1696e42176ac22ec.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58382 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab0I2DyR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:54:17 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00JMZPI2KR79@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:54:05 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Len Brown <len.brown@intel.com>

From: Andrea Gelmini <andrea.gelmini@gelma.net>

"power of" -> "power off"

Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.3.2.g9027fa

