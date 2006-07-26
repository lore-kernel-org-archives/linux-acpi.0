From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Date: Tue, 25 Jul 2006 17:13:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0607251711020.15622@shark.he.net>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
 <20060725164125.A15861@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:40652 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030286AbWGZANd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 20:13:33 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 25 Jul 2006 17:13:31 -0700
In-Reply-To: <20060725164125.A15861@unix-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, akpm@osdl.org, zippel@linux-m68k.org, rdunlap@xenotime.net, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net

On Tue, 25 Jul 2006, Keshavamurthy Anil S wrote:

> On Tue, Jul 25, 2006 at 04:18:54PM -0700, Kristen Carlson Accardi wrote:
> >     drivers/pci/hotplug/Kconfig |   17 ++++++++++++++++-
> >     1 file changed, 16 insertions(+), 1 deletion(-)
> Can;t this be done with just one line change?

The first attempted patch was something like:

	depends on HOTPLUG_PCI && ACPI_DOCK!=n

but that is not legal kconfig language.
Did you have something else in mind?

> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
> >
> >     config HOTPLUG_PCI_ACPI
> >            tristate "ACPI PCI Hotplug driver"
> >    -       depends on ACPI_DOCK && HOTPLUG_PCI
> 	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)

-- 
~Randy
