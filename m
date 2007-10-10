From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/37] acpi_video: kernel build error if !INPUT
Date: Wed, 10 Oct 2007 01:06:16 -0400
Message-ID: <1191992804-14965-10-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20396 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751143AbXJJFGw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:52 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <03e2bf261e832abf48d40113ce08a70338dd18c9.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andreas Herrmann <aherrman@arcor.de>, Len Brown <len.brown@intel.com>

From: Andreas Herrmann <aherrman@arcor.de>

Commit e9dab1960ac9746fa34eff726b81635147615a79
(ACPI video hotkey: export missing ACPI video hotkey events via input layer)
exports ACPI video hotkey events via input layer. But this breaks kernel
build if ACPI_VIDEO && !INPUT:

 LD      .tmp_vmlinux1
drivers/built-in.o: In function `acpi_video_bus_remove':
drivers/acpi/video.c:2007: undefined reference to `input_unregister_device'
    ...

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.3.4.206.g58ba4
