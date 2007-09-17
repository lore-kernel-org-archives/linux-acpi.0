From: Andreas Herrmann <aherrman@arcor.de>
Subject: [PATCH] acpi_video: kernel build error if !INPUT
Date: Mon, 17 Sep 2007 23:41:05 +0200
Message-ID: <20070917214105.GC22458@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:39417 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753249AbXIQVjm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Sep 2007 17:39:42 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Yu Luming <luming.yu@intel.com>, linux-acpi@vger.kernel.org

Commit e9dab1960ac9746fa34eff726b81635147615a79 exports ACPI
video hotkey events via input layer. But this breaks kernel
build if ACPI_VIDEO && !INPUT:

 LD      .tmp_vmlinux1
drivers/built-in.o: In function `acpi_video_bus_remove':
drivers/acpi/video.c:2007: undefined reference to `input_unregister_device'
    ...

Add dependency to INPUT for ACPI_VIDEO to prevent this error.

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
---
 drivers/acpi/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4875f01..9685b75 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -117,6 +117,7 @@ config ACPI_BUTTON
 config ACPI_VIDEO
 	tristate "Video"
 	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
+	depends on INPUT
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
-- 
1.5.3


