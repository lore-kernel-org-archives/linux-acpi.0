From: walter harms <wharms@bfs.de>
Subject: Re: [patch] acpi_pad: "processor_aggregator" name too long
Date: Fri, 19 Mar 2010 13:25:45 +0100
Message-ID: <4BA36D49.7080703__29381.0757845224$1269002672$gmane$org@bfs.de>
References: <20100319114806.GN5331@bicker>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx01.sz.bfs.de ([194.94.69.103]:5547 "EHLO mx01.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab0CSMoY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Mar 2010 08:44:24 -0400
In-Reply-To: <20100319114806.GN5331@bicker>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chen Gong <gong.chen@linux.intel.com>, P



Dan Carpenter schrieb:
> cpi_device_class can only be 19 characters and a NULL terminator.
> 
> With the current name we get a buffer overflow in acpi_pad_add()
>         strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> Feel free to pick your own name if you don't like mine.  :)
> 
> 
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 7e52295..2db89d9 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -30,7 +30,7 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> -#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"processor_aggregator"
> +#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"proc_aggregator"
>  #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
>  #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
>  static DEFINE_MUTEX(isolated_cpus_lock);


Hi Dan,
IMHO this does not solve the core problem. acpi should use kstrncpy or better a pointer.
The next guy that use "my_great_indentifier_is_longer_than_yours" will cause the same
problem.
But this is something that the acpi group needs to answer (fast).

re,
 wh

