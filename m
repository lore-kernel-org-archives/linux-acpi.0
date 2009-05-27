From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Wed, 27 May 2009 13:28:06 +0800
Message-ID: <1243402086.3634.109.camel@localhost.localdomain>
References: <1243234105.3634.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24864 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757053AbZE0F0h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 May 2009 01:26:37 -0400
In-Reply-To: <1243234105.3634.1.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-05-25 at 14:48 +0800, yakui_zhao wrote:
> On some boxes several processors use the same processor bus id.
> But they are located in different scope. For example:
> 	\_SB.SCK0.CPU0
> 	\_SB.SCK1.CPU0
> This follows the ACPI spec.
> 
> 	As they use the same bus id, it can't be registered when
> registering proc I/F. It causes that the ACPI processor driver can't
> be bound with the processor device.
> 	
> Rename the processor device bus id. And the new bus id will be 
> generated as the following format:
> 	CPU+ CPU ID
> 	
> For example: If the cpu ID is 5, then the bus ID will be "CPU5".
> 	If the CPU ID is 10, then the bus ID will be "CPUA".
> 
> 
HI, Len
    How about this patch?

After renaming the bus id, it will be similar with the CPU sys I/F. Of
course the difference is that the decimal mode is used in CPU sys I/F.
And in my patch the hex mode is used.
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/processor_core.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c	2009-05-21 14:44:18.000000000 +0800
> +++ linux-2.6/drivers/acpi/processor_core.c	2009-05-21 15:55:13.000000000 +0800
> @@ -649,7 +649,16 @@
>  			return -ENODEV;
>  		}
>  	}
> -
> +	/*
> +	 * On some boxes several processors use the same processor bus id.
> +	 * But they are located in different scope. For example:
> +	 * \_SB.SCK0.CPU0
> +	 * \_SB.SCK1.CPU0
> +	 * Rename the processor device bus id. And the new bus id will be
> +	 * generated as the following format:
> +	 * CPU+CPU ID.
> +	 */
> +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
>  			  pr->acpi_id));
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

