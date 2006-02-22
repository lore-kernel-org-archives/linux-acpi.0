From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch 3/3] acpi: remove dock event handling from ibm_acpi
Date: Wed, 22 Feb 2006 23:57:41 +0100
Message-ID: <20060222225740.GJ13621@elf.ucw.cz>
References: <20060222190839.268403000@intel.com> <1140636091.32574.21.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9097 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750951AbWBVW6C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Feb 2006 17:58:02 -0500
Content-Disposition: inline
In-Reply-To: <1140636091.32574.21.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com

On St 22-02-06 11:21:31, Kristen Accardi wrote:
> Remove dock station support from ibm_acpi by default.  This support has been 
> put into acpiphp instead.  Allow ibm_acpi to continue to provide docking
> station support via config option for laptops/docking stations that are 
> not supported by acpiphp.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com> 
> 
> ---
>  drivers/acpi/Kconfig    |   12 ++++++++++++
>  drivers/acpi/ibm_acpi.c |   13 ++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> --- linux-dock-mm.orig/drivers/acpi/Kconfig
> +++ linux-dock-mm/drivers/acpi/Kconfig
> @@ -205,6 +205,18 @@ config ACPI_IBM
>  
>  	  If you have an IBM ThinkPad laptop, say Y or M here.
>  
> +config ACPI_IBM_DOCK
> +	bool "Legacy Docking Station Support"
> +	depends on ACPI_IBM
> +	default n
> +	---help---
> +	  Allows the ibm_acpi driver to handle docking station events.
> +	  This support is limited and should only be enabled if the generic
> +          docking station support driver does not support your laptop/dock
> +	  station.

This support is obsoleted by
CONFIG_PCI_HOTPLUG_ACPIHP_or_how_it_is_called. It will allow
ejecting/locking machine in dock, but will not properly connect PCI
buses.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
