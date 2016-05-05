From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch] ACPI / sysfs: fix error code in get_status()
Date: Thu, 05 May 2016 15:57:18 +0200
Message-ID: <5672229.qojIpb3PLe@vostro.rjw.lan>
References: <20160505132304.GF3038@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64126 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751890AbcEENyG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 09:54:06 -0400
In-Reply-To: <20160505132304.GF3038@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thursday, May 05, 2016 04:23:04 PM Dan Carpenter wrote:
> The problem with ornamental, do-nothing gotos is that they lead to
> "forgot to set the error code" bugs.  We should be returning -EINVAL
> here but we don't.  It leads to an uninitalized variable in
> counter_show():
> 
>     drivers/acpi/sysfs.c:603 counter_show()
>     error: uninitialized symbol 'status'.
> 
> Fixes: 1c8fce27e275 ('ACPI: introduce drivers/acpi/sysfs.c')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch!

> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 0243d37..4b3a9e2 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -555,23 +555,22 @@ static void acpi_global_event_handler(u32 event_type, acpi_handle device,
>  static int get_status(u32 index, acpi_event_status *status,
>  		      acpi_handle *handle)
>  {
> -	int result = 0;
> +	int result;
>  
>  	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
> -		goto end;
> +		return -EINVAL;
>  
>  	if (index < num_gpes) {
>  		result = acpi_get_gpe_device(index, handle);
>  		if (result) {
>  			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
>  					"Invalid GPE 0x%x", index));
> -			goto end;
> +			return result;
>  		}
>  		result = acpi_get_gpe_status(*handle, index, status);
>  	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
>  		result = acpi_get_event_status(index - num_gpes, status);
>  
> -end:
>  	return result;
>  }

Applied, thanks!

