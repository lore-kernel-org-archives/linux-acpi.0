From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: replaced kmalloc+memcpy with kmemdup
Date: Tue, 26 Mar 2013 14:25:15 +0100
Message-ID: <3996362.Dl8iZzsvl7@vostro.rjw.lan>
References: <1362990016-21249-1-git-send-email-epure.andrei@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362990016-21249-1-git-send-email-epure.andrei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrei Epure <epure.andrei@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, March 11, 2013 10:20:16 AM Andrei Epure wrote:
> Signed-off-by: Andrei Epure <epure.andrei@gmail.com>

Added a changelog and applied to linux-pm.git/linux-next.

Thanks,
Rafael


> ---
>  drivers/acpi/bus.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 01708a1..292de3c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -288,13 +288,12 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
>  	}
>  out_success:
>  	context->ret.length = out_obj->buffer.length;
> -	context->ret.pointer = kmalloc(context->ret.length, GFP_KERNEL);
> +	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
> +				       context->ret.length, GFP_KERNEL);
>  	if (!context->ret.pointer) {
>  		status =  AE_NO_MEMORY;
>  		goto out_kfree;
>  	}
> -	memcpy(context->ret.pointer, out_obj->buffer.pointer,
> -		context->ret.length);
>  	status =  AE_OK;
>  
>  out_kfree:
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
