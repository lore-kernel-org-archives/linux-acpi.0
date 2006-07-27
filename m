From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Date: Thu, 27 Jul 2006 02:23:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0607270218190.6761@scrub.home>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
 <20060725164125.A15861@unix-os.sc.intel.com> <20060726103226.69aa79c1.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:35300 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751833AbWG0A0z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jul 2006 20:26:55 -0400
In-Reply-To: <20060726103226.69aa79c1.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, rdunlap@xenotime.net, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net

Hi,

On Wed, 26 Jul 2006, Kristen Carlson Accardi wrote:

>  config HOTPLUG_PCI_ACPI
>  	tristate "ACPI PCI Hotplug driver"
> -	depends on ACPI_DOCK && HOTPLUG_PCI
> +	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)
>  	help

If you keep the HOTPLUG_PCI separate, it won't break the menu, e.g. 
((!ACPI_DOCK && ACPI) || ACPI_DOCK) && HOTPLUG_PCI
BTW most of this file could be put into a "if HOTPLUG_PCI" group, so all 
the HOTPLUG_PCI dependencies don't have to be repeated.

bye, Roman
