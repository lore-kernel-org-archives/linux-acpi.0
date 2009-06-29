From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] eeepc-laptop: fix hot-unplug on resume
Date: Mon, 29 Jun 2009 16:16:56 +0200
Message-ID: <200906291616.57440.rjw@sisk.pl>
References: <4A48A196.3060409@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A48A196.3060409-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Content-Disposition: inline
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Cc: Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>, linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 29 June 2009, Alan Jenkins wrote:
> The patch below fixes a regression introduced by the rfkill rewrite. 
> Please consider it for inclusion in 2.6.31 via the ACPI tree.

Is there a Bugzilla # for this regression?

Rafael

> -------------------->
> 
> From d0265f0bfe63086816d61c69ee4b2dc4cb491d06 Mon Sep 17 00:00:00 2001
> From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
> Date: Mon, 29 Jun 2009 09:40:07 +0100
> Subject: [PATCH] eeepc-laptop: fix hot-unplug on resume
> 
> OOPS on resume when the wireless adaptor is disabled during suspend was
> introduced by "eeepc-laptop: read rfkill soft-blocked state on resume".
> 
> Unable to handle kernel NULL pointer dereference
> 
> Process s2disk
> Tainted: G W
> IP: klist_put
> 
> Call trace:
> ? klist_del
> ? device_del
> ? device_unregister
> ? pci_stop_dev
> ? pci_stop_bus
> ? pci_remove_device
> ? eeepc_rfkill_hotplug [eeepc_laptop]
> ? eeepc_hotk_resume [eeepc_laptop]
> ? acpi_device_resume
> ? device_resume
> ? hibernation_snapshot
> 
> It appears the PCI device is removed twice.  The eeepc_rfkill_hotplug()
> call from the resume handler is racing against the call from the ACPI
> notifier callback.  The ACPI notification is triggered by the resume
> handler when it refreshes the value of CM_ASL_WLAN.
> 
> The fix is to serialize hotplug calls using a workqueue.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
> ---
>  drivers/platform/x86/eeepc-laptop.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index ec560f1..222ffb8 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -143,6 +143,7 @@ struct eeepc_hotk {
>  	struct rfkill *bluetooth_rfkill;
>  	struct rfkill *wwan3g_rfkill;
>  	struct hotplug_slot *hotplug_slot;
> +	struct work_struct hotplug_work;
>  };
>  
>  /* The actual device the driver binds to */
> @@ -660,7 +661,7 @@ static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
>  	return 0;
>  }
>  
> -static void eeepc_rfkill_hotplug(void)
> +static void eeepc_hotplug_work(struct work_struct *work)
>  {
>  	struct pci_dev *dev;
>  	struct pci_bus *bus = pci_find_bus(0, 1);
> @@ -701,7 +702,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
>  	if (event != ACPI_NOTIFY_BUS_CHECK)
>  		return;
>  
> -	eeepc_rfkill_hotplug();
> +	schedule_work(&ehotk->hotplug_work);
>  }
>  
>  static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
> @@ -892,7 +893,7 @@ static int eeepc_hotk_resume(struct acpi_device *device)
>  
>  		rfkill_set_sw_state(ehotk->wlan_rfkill, wlan != 1);
>  
> -		eeepc_rfkill_hotplug();
> +		schedule_work(&ehotk->hotplug_work);
>  	}
>  
>  	if (ehotk->bluetooth_rfkill)
> @@ -1093,6 +1094,8 @@ static int eeepc_rfkill_init(struct device *dev)
>  {
>  	int result = 0;
>  
> +	INIT_WORK(&ehotk->hotplug_work, eeepc_hotplug_work);
> +
>  	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
>  	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
