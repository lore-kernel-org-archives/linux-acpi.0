From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/7] acpiphp - slots management fix
Date: Thu, 26 Jan 2006 20:14:25 -0800
Message-ID: <20060127041425.GA20453@kroah.com>
References: <87acdrp5y9.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28882
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751226AbWA0EO0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jan 2006 23:14:26 -0500
Content-Disposition: inline
In-Reply-To: <87acdrp5y9.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: pavel@ucw.cz, kristen.c.accardi@intel.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org, len.brown@intel.com

On Fri, Jan 20, 2006 at 07:08:30PM +0900, MUNEDA Takahiro wrote:
> Hi,
> 
> This series of patches contains slots management fix.
> Here are summary of changes:
> 
> o [PATCH 1/7] - removes unnecesary struct members
> 
> o [PATCH 2/7] - removes init_slots(), because acpiphp doesn't
>                 register slots when driver is loaded.
> 
> o [PATCH 3/7] - changes register_slot() to register hotplug
>                 slots when they are found
> 
> o [PATCH 4/7] - changes init_bridge_misc() to register hotplug
>                 slots when they are found
> 
> o [PATCH 5/7] - removes cleanup_slots(), because acpiphp
>                 doesn't unregister slots when driver is going
>                 to be un-loaded.
> 
> o [PATCH 6/7] - changes cleanup_brige() to unregister hotplug
>                 slots when acpiphp cleanup the bridge.
> 
> o [PATCH 7/7] - adds spin_lock/_unlock to protect slot_list
> 
> 
> For more specifc information, please see the header of each patch.
> These patches are against 2.6.16-rc1. I tested them on Tiger4.

This patch series does not even compile when applied:

  CC [M]  drivers/pci/hotplug/acpiphp_core.o
drivers/pci/hotplug/acpiphp_core.c: In function `acpiphp_register_hotplug_slot':
drivers/pci/hotplug/acpiphp_core.c:355: error: `hotplug_slot' undeclared (first use in this function)
drivers/pci/hotplug/acpiphp_core.c:355: error: (Each undeclared identifier is reported only once
drivers/pci/hotplug/acpiphp_core.c:355: error: for each function it appears in.)
drivers/pci/hotplug/acpiphp_core.c:359: error: `hotplug_slot_info' undeclared (first use in this function)
make[2]: *** [drivers/pci/hotplug/acpiphp_core.o] Error 1

Care to redo them?

thanks,

greg k-h
