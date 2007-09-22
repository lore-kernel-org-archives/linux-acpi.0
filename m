From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/32] sony-laptop/thinkpad-acpi: fix INPUT=n build
Date: Fri, 21 Sep 2007 23:46:26 -0400
Message-ID: <11904328153830-git-send-email-lenb@kernel.org>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:40564 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757194AbXIVDq4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:56 -0400
In-Reply-To: <11904328141573-git-send-email-lenb@kernel.org>
Message-Id: <8a66074c379cacc79168681bf7dea37ad278f5d1.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andreas Herrmann <aherrman@arcor.de>, Len Brown <len.brown@intel.com>

From: Andreas Herrmann <aherrman@arcor.de>

Build errors if CONFIG_SONY_LAPTOP && !INPUT or
if CONFIG_THINKPAD_ACPI && !INPUT:

 LD      vmlinux
    ...
drivers/built-in.o: In function `sony_laptop_remove_input':
sony-laptop.c:(.text+0x768fb): undefined reference to `input_unregister_device'
    ...
drivers/built-in.o: In function `thinkpad_acpi_module_exit':
thinkpad_acpi.c:(.text+0x78c1b): undefined reference to `input_free_device'
    ...

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 73e248f..7b580c3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -134,6 +134,7 @@ config SONY_LAPTOP
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
+	depends on INPUT
 	  ---help---
 	  This mini-driver drives the SNC and SPIC devices present in the ACPI
 	  BIOS of the Sony Vaio laptops.
@@ -156,6 +157,7 @@ config THINKPAD_ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select NVRAM
+	depends on INPUT
 	---help---
 	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
-- 
1.5.3.1.27.g57543
