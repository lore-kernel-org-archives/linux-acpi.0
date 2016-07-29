From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / button: remove pointer to old lid_sysfs on unbind
Date: Fri, 29 Jul 2016 04:35:37 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC07E6E@SHSMSX101.ccr.corp.intel.com>
References: <1469701167-24257-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:20842 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcG2Efm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jul 2016 00:35:42 -0400
In-Reply-To: <1469701167-24257-1-git-send-email-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Benjamin

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
> Subject: [PATCH] ACPI / button: remove pointer to old lid_sysfs on unbind
> 
> When we removed the procfs dir on error or if the driver is
> unbound, the two variables acpi_lid_dir and acpi_button_dir
> were not reset. On the next rebind, those static variables
> were not null and we couldn't re-register the device again.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/acpi/button.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 5c3b091..e413599 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -188,9 +188,11 @@ done:
[Lv Zheng] 
I have a concern here for acpi_button_add_fs().
It looks like that this function doesn't support 2 lid devices.
So why do we need /proc/acpi/button/lid/LID0 folder?

>  remove_dev_dir:
>  	remove_proc_entry(acpi_device_bid(device),
>  			  acpi_lid_dir);
> +	acpi_lid_dir = NULL;
>  	acpi_device_dir(device) = NULL;
>  remove_lid_dir:
>  	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID,
> acpi_button_dir);
[Lv Zheng] 
Should acpi_lid_dir = NULL be put here?

> +	acpi_button_dir = NULL;
>  remove_button_dir:
>  	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
[Lv Zheng] 
Should acpi_button_dir = NULL be put here?

>  	goto done;
> @@ -207,8 +209,10 @@ static int acpi_button_remove_fs(struct
> acpi_device *device)
>  			  acpi_device_dir(device));
>  	remove_proc_entry(acpi_device_bid(device),
>  			  acpi_lid_dir);
> +	acpi_lid_dir = NULL;
>  	acpi_device_dir(device) = NULL;
>  	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID,
> acpi_button_dir);
[Lv Zheng] 
Should acpi_lid_dir = NULL be put here?

> +	acpi_button_dir = NULL;
>  	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
[Lv Zheng] 
Should acpi_button_dir = NULL be put here?

Thanks and best regards
Lv

> 
>  	return 0;
> --
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
