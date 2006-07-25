From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Date: Tue, 25 Jul 2006 16:41:25 -0700
Message-ID: <20060725164125.A15861@unix-os.sc.intel.com>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:12372 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S964879AbWGYXvJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 19:51:09 -0400
Content-Disposition: inline
In-Reply-To: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>; from kristen.c.accardi@intel.com on Tue, Jul 25, 2006 at 04:18:54PM -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, akpm@osdl.org, zippel@linux-m68k.org, rdunlap@xenotime.net, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net

On Tue, Jul 25, 2006 at 04:18:54PM -0700, Kristen Carlson Accardi wrote:
>     drivers/pci/hotplug/Kconfig |   17 ++++++++++++++++-
>     1 file changed, 16 insertions(+), 1 deletion(-)
Can;t this be done with just one line change?

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

> 
>     config HOTPLUG_PCI_ACPI
>            tristate "ACPI PCI Hotplug driver"
>    -       depends on ACPI_DOCK && HOTPLUG_PCI
	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)
