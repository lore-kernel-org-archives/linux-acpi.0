From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 1/11]avoid check _STA method
Date: Fri, 29 Aug 2008 17:19:15 +0200
Message-ID: <200808291719.17266.trenn@suse.de>
References: <1219888923.29375.21.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34660 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbYH2PTU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Aug 2008 11:19:20 -0400
In-Reply-To: <1219888923.29375.21.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

Hi,

could this patchset eventually help here:
kacpi* eat a lot of cpu after s2disk
https://bugzilla.novell.com/show_bug.cgi?id=401740
This seem to happen on all recent Dells.

Shaohua Li, Andi: Can you keep me up to date about these patches, pls

If Andi thinks they are suitable for mainline, I'd like to
add them to our recent codebase.
Or is there a chance that these (or some critical ones) go into
.27-rcX?

Thanks,

      Thomas

On Thursday 28 August 2008 04:02:03 Shaohua Li wrote:
> In some BIOSes, every _STA method call will send a notification again,
> this cause freeze. And in some BIOSes, it appears _STA should be called
> after _DCK. This tries to avoid calls _STA, and still keep the device
> present check.
> http://bugzilla.kernel.org/show_bug.cgi?id=10431
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


