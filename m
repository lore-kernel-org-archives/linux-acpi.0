From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] fujitsu-laptop: depends on INPUT
Date: Mon, 23 Jun 2008 09:34:49 -0700
Message-ID: <20080623093449.b4f19f85.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:46395 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYFWQf2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 12:35:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jwoithe@physics.adelaide.edu.au
Cc: linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

fujitsu-laptop uses input_* functions, so it should depend
on INPUT.

drivers/built-in.o: In function `acpi_fujitsu_add':
fujitsu-laptop.c:(.text+0xaaec7): undefined reference to `input_allocate_device'
fujitsu-laptop.c:(.text+0xaaf39): undefined reference to `input_register_device'
fujitsu-laptop.c:(.text+0xab025): undefined reference to `input_free_device'
drivers/built-in.o: In function `acpi_fujitsu_notify':
fujitsu-laptop.c:(.text+0xab0d8): undefined reference to `input_event'
fujitsu-laptop.c:(.text+0xab0e5): undefined reference to `input_event'
fujitsu-laptop.c:(.text+0xab0f5): undefined reference to `input_event'
fujitsu-laptop.c:(.text+0xab102): undefined reference to `input_event'
drivers/built-in.o: In function `acpi_fujitsu_hotkey_notify':
fujitsu-laptop.c:(.text+0xab261): undefined reference to `input_event'
drivers/built-in.o:fujitsu-laptop.c:(.text+0xab26e): more undefined references to `input_event' follow
drivers/built-in.o: In function `acpi_fujitsu_hotkey_add':
fujitsu-laptop.c:(.text+0xab49c): undefined reference to `input_allocate_device'
fujitsu-laptop.c:(.text+0xab51a): undefined reference to `input_register_device'
fujitsu-laptop.c:(.text+0xab5e4): undefined reference to `input_free_device'
make[1]: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/misc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20080623.orig/drivers/misc/Kconfig
+++ linux-next-20080623/drivers/misc/Kconfig
@@ -179,6 +179,7 @@ config FUJITSU_LAPTOP
         tristate "Fujitsu Laptop Extras"
         depends on X86
         depends on ACPI
+        depends on INPUT
         depends on BACKLIGHT_CLASS_DEVICE
         ---help---
 	  This is a driver for laptops built by Fujitsu:


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
