From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] tc1100-wmi: Mark as experimental
Date: Fri, 08 Feb 2008 09:44:14 +0000
Message-ID: <20080208094414.2023.84909.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:34938 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932702AbYBHJoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 04:44:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>

tc1100-wmi has not undergone as much testing as acer-wmi, so it certainly
should be marked as experimental as well until we get more user feedback.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
---

 drivers/misc/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4e7f000..e6c4892 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -143,8 +143,9 @@ config FUJITSU_LAPTOP
 	  If you have a Fujitsu laptop, say Y or M here.
 
 config TC1100_WMI
-	tristate "HP Compaq TC1100 Tablet WMI Extras"
+	tristate "HP Compaq TC1100 Tablet WMI Extras (EXPERIMENTAL)"
 	depends on X86 && !X86_64
+	depends on EXPERIMENTAL
 	depends on ACPI
 	select ACPI_WMI
 	---help---

