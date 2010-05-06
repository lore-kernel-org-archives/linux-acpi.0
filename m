From: Len Brown <lenb@kernel.org>
Subject: Re: linux-next: Tree for May 6 (acpi: PCI=n)
Date: Thu, 06 May 2010 16:29:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005061628070.12696@localhost.localdomain>
References: <20100506151502.f97afe54.sfr@canb.auug.org.au>
 <20100506080722.3b724475.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <20100506080722.3b724475.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> When CONFIG_PCI is not enabled:
> 
> arch/x86/kernel/acpi/boot.c:1034: error: 'pci_bus_type' undeclared
> 
> drivers/acpi/reboot.c:30: error:implicit declaration of function 'pci_find_bus'
> drivers/acpi/reboot.c:30: warning: assignment makes pointer from integer without a cast
> drivers/acpi/reboot.c:38: error:implicit declaration of function 'pci_bus_write_config_byte'

CONFIG_ACPI depends on CONFIG_PCI, so this file should not be build with 
CONFIG_PCI=n.

Please let me know how you were able to generate this illegal 
configuration.

thanks,
Len Brown, Intel Open Source Technology Center
