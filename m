From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: 2.6.20-mm2 CONFIG_ACPI_BAY=y: undefined reference to `is_dock_device'
Date: Thu, 22 Feb 2007 22:15:22 +0100
Message-ID: <20070222211522.GA6939@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751901AbXBVVPY@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hello all,

make-kpkg kernel_image bombed with:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `bay_is_dock_device':
drivers/acpi/bay.c:261: undefined reference to `is_dock_device'
drivers/acpi/bay.c:261: undefined reference to `is_dock_device'
drivers/built-in.o: In function `bay_add':
drivers/acpi/bay.c:308: undefined reference to `register_hotplug_dock_device'
drivers/built-in.o: In function `bay_exit':
drivers/acpi/bay.c:384: undefined reference to `is_dock_device'
drivers/acpi/bay.c:385: undefined reference to `unregister_hotplug_dock_device'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/src/linux-2.6.20-mm2'


Famous last words: CONFIG_ACPI_DOCK=m...

Andreas Mohr
