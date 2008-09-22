From: Holger Macht <hmacht@suse.de>
Subject: Re: [patch 1/11]avoid check _STA method
Date: Mon, 22 Sep 2008 12:57:59 +0200
Message-ID: <20080922105759.GB26633@homac.suse.de>
References: <1219888923.29375.21.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54713 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298AbYIVK6K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 06:58:10 -0400
Content-Disposition: inline
In-Reply-To: <1219888923.29375.21.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

On Thu 28. Aug - 10:02:03, Shaohua Li wrote:
> In some BIOSes, every _STA method call will send a notification again,
> this cause freeze. And in some BIOSes, it appears _STA should be called
> after _DCK. This tries to avoid calls _STA, and still keep the device
> present check.
> http://bugzilla.kernel.org/show_bug.cgi?id=10431

Finally found some time to test this...

> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
> ---
>  drivers/acpi/dock.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux/drivers/acpi/dock.c
> ===================================================================
> --- linux.orig/drivers/acpi/dock.c	2008-08-27 14:38:44.000000000 +0800
> +++ linux/drivers/acpi/dock.c	2008-08-28 09:33:02.000000000 +0800
> @@ -604,14 +604,17 @@ static int handle_eject_request(struct d
>  static void dock_notify(acpi_handle handle, u32 event, void *data)
>  {
>  	struct dock_station *ds = data;
> +	struct acpi_device *tmp;
>  
>  	switch (event) {
>  	case ACPI_NOTIFY_BUS_CHECK:
> -		if (!dock_in_progress(ds) && dock_present(ds)) {
> +		if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle,

On the Thinkpad X60, when booting undocked, the first time I dock,
acpi_bus_get_device() returns 0, so hotplug is not performed
properly. Second time (undock->dock), it works.

However, dock_present(ds) would return 1, so on this system, it works
without applying this patch.

Regards,
	Holger

> +		   &tmp)) {
>  			begin_dock(ds);
>  			dock(ds);
>  			if (!dock_present(ds)) {
>  				printk(KERN_ERR PREFIX "Unable to dock!\n");
> +				complete_dock(ds);
>  				break;
>  			}
>  			atomic_notifier_call_chain(&dock_notifier_list,
> 
> 
