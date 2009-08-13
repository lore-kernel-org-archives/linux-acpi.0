From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Thu, 13 Aug 2009 09:55:02 -0600
Message-ID: <200908130955.03393.bjorn.helgaas@hp.com>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org> <Pine.LNX.4.64.0908070012490.11170@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:22056 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbZHMPzD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 11:55:03 -0400
In-Reply-To: <Pine.LNX.4.64.0908070012490.11170@sister.anvils>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, ming.m.lin@intel.com, Valdis.Kletnieks@vt.edu, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>Lin Ming <ming.m.lin@intel.com>

On Thursday 06 August 2009 05:18:12 pm Hugh Dickins wrote:
> It's up to Len to choose, but I thought we preferred...
> 
> From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> 
> acpi_device->pnp.hardware_id and unique_id are now allocated pointers,
> replacing the previous arrays.  acpi_device_install_notify_handler()
> oopsed on the NULL hid when probing the video device, 

I'm sorry I wasn't aware of the acpi_device_install_notify_handler()
issue until just now, since I added the code that oopses (46ec8598fd).

I recently posted patches that removed the dependency on the HID
in this path:

  http://marc.info/?l=linux-acpi&m=124907623701270&w=2

I thought Len said they had been applied to acpi-test, but I don't
see them there.

But I don't object to Hugh's patch, since it might be useful for other
paths.

Bjorn


> and perhaps other 
> uses are vulnerable too.  So initialize those pointers to empty strings
> when there is no hid or uid.  Also, free hardware_id and unique_id when
> when acpi_device is going to be freed.
> 
> Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
> 
>  drivers/acpi/scan.c |   20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> --- mmotm/drivers/acpi/scan.c	2009-07-17 12:53:20.000000000 +0100
> +++ linux/drivers/acpi/scan.c	2009-07-27 18:01:32.000000000 +0100
> @@ -309,6 +309,10 @@ static void acpi_device_release(struct d
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  
>  	kfree(acpi_dev->pnp.cid_list);
> +	if (acpi_dev->flags.hardware_id)
> +		kfree(acpi_dev->pnp.hardware_id);
> +	if (acpi_dev->flags.unique_id)
> +		kfree(acpi_dev->pnp.unique_id);
>  	kfree(acpi_dev);
>  }
>  
> @@ -1144,8 +1148,9 @@ static void acpi_device_set_id(struct ac
>  			strcpy(device->pnp.hardware_id, hid);
>  			device->flags.hardware_id = 1;
>  		}
> -	} else
> -		device->pnp.hardware_id = NULL;
> +	}
> +	if (!device->flags.hardware_id)
> +		device->pnp.hardware_id = "";
>  
>  	if (uid) {
>  		device->pnp.unique_id = ACPI_ALLOCATE_ZEROED(strlen (uid) + 1);
> @@ -1153,8 +1158,9 @@ static void acpi_device_set_id(struct ac
>  			strcpy(device->pnp.unique_id, uid);
>  			device->flags.unique_id = 1;
>  		}
> -	} else
> -		device->pnp.unique_id = NULL;
> +	}
> +	if (!device->flags.unique_id)
> +		device->pnp.unique_id = "";
>  
>  	if (cid_list || cid_add) {
>  		struct acpica_device_id_list *list;
> @@ -1369,10 +1375,8 @@ acpi_add_single_object(struct acpi_devic
>  end:
>  	if (!result)
>  		*child = device;
> -	else {
> -		kfree(device->pnp.cid_list);
> -		kfree(device);
> -	}
> +	else
> +		acpi_device_release(&device->dev);
>  
>  	return result;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


