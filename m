From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/2] acpiphp: Identify more removable slots
Date: Thu, 13 Nov 2008 13:48:59 -0700
Message-ID: <20081113204859.GC1617@parisc-linux.org>
References: <20081113202739.GA11107@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081113202739.GA11107@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 13, 2008 at 08:27:39PM +0000, Matthew Garrett wrote:
> @@ -94,11 +95,14 @@ static int is_ejectable(acpi_handle handle)
>  	}
>  
>  	status = acpi_get_handle(handle, "_EJ0", &tmp);
> -	if (ACPI_FAILURE(status)) {
> -		return 0;
> -	}
> +	if (ACPI_SUCCESS(status))
> +		ret = 1;
> +
> +	status = acpi_get_handle(handle, "_RMV", &tmp);
> +	if (ACPI_SUCCESS(status))
> +		ret = 1;
>  
> -	return 1;
> +	return ret;
>  }

Why not:

 	status = acpi_get_handle(handle, "_EJ0", &tmp);
	if (ACPI_SUCCESS(status))
		return 1;

	status = acpi_get_handle(handle, "_RMV", &tmp);
	if (ACPI_SUCCESS(status))
		return 1;

	return 0;

>  
>  
> @@ -182,17 +186,26 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
>  	struct acpiphp_func *newfunc;
>  	acpi_handle tmp;
>  	acpi_status status = AE_OK;
> -	unsigned long long adr, sun;
> -	int device, function, retval;
> +	unsigned long long adr, sun, removable;
> +	int device, function, retval, valid = 0;
>  
>  	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
>  
>  	if (ACPI_FAILURE(status))
>  		return AE_OK;
>  
> -	status = acpi_get_handle(handle, "_EJ0", &tmp);
> +	status = acpi_get_handle(handle, "_RMV", &tmp);
> +	if (ACPI_SUCCESS(status)) {
> +		acpi_evaluate_integer(handle, "_RMV", NULL, &removable);
> +		if (removable)
> +			valid = 1;
> +	}
>  
> -	if (ACPI_FAILURE(status) && !(is_dock_device(handle)))
> +	status = acpi_get_handle(handle, "_EJ0", &tmp);
> +	if (ACPI_SUCCESS(status) || is_dock_device(handle))
> +		valid = 1;
> +
> +	if (!valid)
>  		return AE_OK;

This looks like almost the same code as above.  New helper function?

>  	device = (adr >> 16) & 0xffff;
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
