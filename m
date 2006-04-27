From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.17-rc2-mm1: ACPI_DOCK=n, HOTPLUG_PCI_ACPI=y compile error
Date: Thu, 27 Apr 2006 17:01:56 +0200
Message-ID: <20060427150156.GF3570@stusta.de>
References: <20060427014141.06b88072.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29971 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965135AbWD0PB6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 11:01:58 -0400
Content-Disposition: inline
In-Reply-To: <20060427014141.06b88072.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, len.brown@intel.com, linux-acpi@vger.kernel.org

Although not mentioned in the changelog, acpi-dock-driver.patch was 
updated in 2.6.17-rc2-mm1.

The changes cause the following compile error with CONFIG_ACPI_DOCK=n, 
CONFIG_HOTPLUG_PCI_ACPI=y:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function 
`is_pci_dock_device':acpiphp_glue.c:(.text+0x1a08a): undefined reference to `is_dock_device'
drivers/built-in.o: In function `cleanup_bridge':
acpiphp_glue.c:(.text+0x1a127): undefined reference to `is_dock_device'
:acpiphp_glue.c:(.text+0x1a133): undefined reference to `unregister_hotplug_dock_device'
:acpiphp_glue.c:(.text+0x1a13b): undefined reference to `unregister_dock_notifier'
drivers/built-in.o: In function `register_slot':
acpiphp_glue.c:(.text+0x1b545): undefined reference to `is_dock_device'
:acpiphp_glue.c:(.text+0x1b742): undefined reference to `is_dock_device'
:acpiphp_glue.c:(.text+0x1b759): undefined reference to `register_hotplug_dock_device'
:acpiphp_glue.c:(.text+0x1b786): undefined reference to `register_dock_notifier'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

