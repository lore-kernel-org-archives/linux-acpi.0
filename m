From: Andreas Herrmann <aherrman@arcor.de>
Subject: [PATCH] sony-laptop/thinkpad-acpi: fix build error
Date: Mon, 17 Sep 2007 22:54:34 +0200
Message-ID: <20070917205434.GA22458@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:44900 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754047AbXIQUxN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Sep 2007 16:53:13 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

sony-laptop and thinkpad-acpi make use of input-core functions.
Hence you get link errors if those drivers are built but CONFIG_INPUT
is not set. Attached patch fixes this minor issue.


Regards,

Andreas

--
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

I suggest to auto-select CONFIG_INPUT for both drivers.

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
---
 drivers/misc/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 73e248f..c077df8 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -134,6 +134,7 @@ config SONY_LAPTOP
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
+	select INPUT
 	  ---help---
 	  This mini-driver drives the SNC and SPIC devices present in the ACPI
 	  BIOS of the Sony Vaio laptops.
@@ -156,6 +157,7 @@ config THINKPAD_ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select NVRAM
+	select INPUT
 	---help---
 	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
-- 
1.5.3


