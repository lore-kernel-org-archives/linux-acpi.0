From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/32] acpi_video: kernel build error if !INPUT
Date: Fri, 21 Sep 2007 23:46:27 -0400
Message-ID: <11904328151023-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
 <11904328111749-git-send-email-lenb@kernel.org>
 <11904328122495-git-send-email-lenb@kernel.org>
 <1190432813700-git-send-email-lenb@kernel.org>
 <11904328141573-git-send-email-lenb@kernel.org>
 <11904328153830-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:59706 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756832AbXIVDq5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:57 -0400
In-Reply-To: <11904328153830-git-send-email-lenb@kernel.org>
Message-Id: <03e2bf261e832abf48d40113ce08a70338dd18c9.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
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
1.5.3.1.27.g57543
