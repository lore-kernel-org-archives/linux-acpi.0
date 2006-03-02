From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [RFC][PATCH] acpiphp: configure _PRT
Date: Thu, 02 Mar 2006 15:34:09 -0800
Message-ID: <1141342449.913.7.camel@whizzy>
References: <873bi19ces.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:4746 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752075AbWCBX2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Mar 2006 18:28:31 -0500
In-Reply-To: <873bi19ces.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: pcihpd-discuss@lists.sourceforge.net, Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, len.brown@intel.com

On Thu, 2006-03-02 at 22:58 +0900, MUNEDA Takahiro wrote:
> Hi,
> 
> Current acpiphp does not free acpi_device structs when the
> PCI devices are removed. When the PCI device is added,
> acpi_bus_add() fails because acpi_device struct has already
> exists. So, _PRT method does not evaluate.
> 
> This patch fixes this issue.
> 
> This patch is against 2.6.16-rc5-mm1 plus following patches.
> 
>  o Kristen's latest patch set
>  o Kenji's acpiphp: Scan slots under the nested P2P bridge
> 
> I tested this patch on my tiger4 box except for dock eject
> case, because I don't have any pc which has _DCK method.
> 

I tested this on a couple laptops that have _DCK methods - It seems to
work fine, however, see comment below:
<snip>

> Index: linux-2.6.16-rc5-mm1/drivers/pci/hotplug/acpiphp_dock.c
> ===================================================================
> --- linux-2.6.16-rc5-mm1.orig/drivers/pci/hotplug/acpiphp_dock.c
> +++ linux-2.6.16-rc5-mm1/drivers/pci/hotplug/acpiphp_dock.c
> @@ -290,6 +290,7 @@ handle_hotplug_event_dock(acpi_handle ha
>  			dbg("EJECT request\n");
>  			if (!dock_in_progress() && dock_present()) {
>  				hotplug_pci(type);
> +				acpiphp_bus_trim(handle);

This is not necessary.  hotplug_pci() will pass the eject event down to
the acpiphp handle_hotplug_event_func() routine, which will call
disable_device() and remove the bus that way as part of your new patch.

>  				undock();
>  				eject_dock();
>  				if (dock_present())
