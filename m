From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2] ACPI / button: remove pointer to old lid_sysfs on
 unbind
Date: Mon, 1 Aug 2016 00:35:31 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC082AA@SHSMSX101.ccr.corp.intel.com>
References: <1469804921-23086-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:40645 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbcHAAfl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Jul 2016 20:35:41 -0400
In-Reply-To: <1469804921-23086-1-git-send-email-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Benjamin

> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> Subject: [PATCH v2] ACPI / button: remove pointer to old lid_sysfs on
> unbind
> 
> When we removed the procfs dir on error or if the driver is
> unbound, the two variables acpi_lid_dir and acpi_button_dir
> were not reset. On the next rebind, those static variables
> were not null and we couldn't re-register the device again.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
[Lv Zheng] 
Looks good.
Acked-by: Lv Zheng <lv.zheng@intel.com>

Chhers
Lv

> 
> --
> changes in v2:
> - put the NULL assignments at their correct place
> ---
>  drivers/acpi/button.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 5c3b091..a3873b3 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -191,8 +191,10 @@ remove_dev_dir:
>  	acpi_device_dir(device) = NULL;
>  remove_lid_dir:
>  	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID,
> acpi_button_dir);
> +	acpi_lid_dir = NULL;
>  remove_button_dir:
>  	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
> +	acpi_button_dir = NULL;
>  	goto done;
>  }
> 
> @@ -209,7 +211,9 @@ static int acpi_button_remove_fs(struct
> acpi_device *device)
>  			  acpi_lid_dir);
>  	acpi_device_dir(device) = NULL;
>  	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID,
> acpi_button_dir);
> +	acpi_lid_dir = NULL;
>  	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
> +	acpi_button_dir = NULL;
> 
>  	return 0;
>  }
> --
> 2.5.5

