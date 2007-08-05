From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: ACPI: thinkpad-acpi: change thinkpad-acpi input default and kconfig help
Date: Sun,  5 Aug 2007 15:20:45 -0300
Message-ID: <1186338045352-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35785 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179AbXHESUr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Aug 2007 14:20:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Hugh Dickins <hugh@veritas.com>

The current kconfig help text was misleading users.  Also, the default for
an input-layer-optimized support caused way too many problems without
up-to-date userspace in place.

So, rework the help text, and change the default to N.  Note that
distributions are supposed to enable this option as soon as they update HAL
to a version that handles the thinkpad-acpi new input layer interface.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Michael S. Tsirkin <mst@dev.mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>
---
 drivers/misc/Kconfig |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index aaaa61e..518d5d3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -200,14 +200,22 @@ config THINKPAD_ACPI_BAY
 config THINKPAD_ACPI_INPUT_ENABLED
 	bool "Enable input layer support by default"
 	depends on THINKPAD_ACPI
-	default y
+	default n
 	---help---
-	  Enables hot key handling over the input layer by default.  If unset,
-	  the driver does not enable any hot key handling by default, and also
-	  starts up with a mostly empty keymap.
-
-	  If you are not sure, say Y here.  Say N to retain the deprecated
-	  behavior of ibm-acpi, and thinkpad-acpi for kernels up to 2.6.21.
+	  This option enables thinkpad-acpi hot key handling over the input
+	  layer at driver load time.  When it is unset, the driver does not
+	  enable hot key handling by default, and also starts up with a mostly
+	  empty keymap.
+
+	  This option should be enabled if you have a new enough HAL or other
+	  userspace support that properly handles the thinkpad-acpi event
+	  device.  It auto-tunes the hot key support to those reported by the
+	  firmware and enables it automatically.
+
+	  If unsure, say N here to retain the old behaviour of ibm-acpi, and
+	  thinkpad-acpi up to kernel 2.6.21: userspace will have to enable and
+	  set up the thinkpad-acpi hot key handling using the sysfs interace
+	  after loading the driver.
 
 
 endif # MISC_DEVICES
-- 
1.5.2.1

