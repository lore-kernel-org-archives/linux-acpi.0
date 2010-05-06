From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 6 (acpi: PCI=n)
Date: Thu, 6 May 2010 13:42:11 -0700
Message-ID: <20100506134211.e08c795a.randy.dunlap@oracle.com>
References: <20100506151502.f97afe54.sfr@canb.auug.org.au>
	<20100506080722.3b724475.randy.dunlap@oracle.com>
	<alpine.LFD.2.00.1005061628070.12696@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005061628070.12696@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, James Morris <jmorris@namei.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 06 May 2010 16:29:42 -0400 (EDT) Len Brown wrote:

> > When CONFIG_PCI is not enabled:
> > 
> > arch/x86/kernel/acpi/boot.c:1034: error: 'pci_bus_type' undeclared
> > 
> > drivers/acpi/reboot.c:30: error:implicit declaration of function 'pci_find_bus'
> > drivers/acpi/reboot.c:30: warning: assignment makes pointer from integer without a cast
> > drivers/acpi/reboot.c:38: error:implicit declaration of function 'pci_bus_write_config_byte'
> 
> CONFIG_ACPI depends on CONFIG_PCI, so this file should not be build with 
> CONFIG_PCI=n.
> 
> Please let me know how you were able to generate this illegal 
> configuration.


Same TPM kconfig that selects ACPI without any other qualifications.

In 50 randconfig builds, 12 build failures were due to that one bad kconfig.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
