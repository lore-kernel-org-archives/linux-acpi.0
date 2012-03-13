From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH V2 1/4] ACPI: Fix up _PLD methods
Date: Tue, 13 Mar 2012 14:32:07 -0700
Message-ID: <20120313213207.GA23216@kroah.com>
References: <1331588747-1247-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331588747-1247-1-git-send-email-mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 12, 2012 at 05:45:44PM -0400, Matthew Garrett wrote:
> _PLD is defined as returning a package of buffers, but many implementations
> simply return a buffer. Fix this up.
> 
> (Original patch by Bob Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>)

Does that mean the "From:" line should be set to Bob?

Any objection from the ACPI developers for me to apply this series?

thanks,

greg k-h

> ---
>  drivers/acpi/acpica/nsrepair.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
> index 9c35d20..6217cfd 100644
> --- a/drivers/acpi/acpica/nsrepair.c
> +++ b/drivers/acpi/acpica/nsrepair.c
> @@ -151,9 +151,18 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
>  		}
>  	}
>  	if (expected_btypes & ACPI_RTYPE_PACKAGE) {
> -		status = acpi_ns_convert_to_package(return_object, &new_object);
> -		if (ACPI_SUCCESS(status)) {
> -			goto object_repaired;
> +		if (return_object->common.type == ACPI_TYPE_BUFFER) {
> +			status = acpi_ns_repair_package_list(data, &return_object);
> +			if (ACPI_SUCCESS(status)) {
> +				*return_object_ptr = return_object;
> +				data->flags |= ACPI_OBJECT_REPAIRED;
> +				return (AE_OK);
> +			}
> +		} else {
> +			status = acpi_ns_convert_to_package(return_object, &new_object);
> +			if (ACPI_SUCCESS(status)) {
> +				goto object_repaired;
> +			}
>  		}
>  	}
>  
> -- 
> 1.7.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
