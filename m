From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] ACPI: processor: make new processor.h header local to
 driver
Date: Sat, 21 Feb 2009 22:58:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902212258220.5009@localhost.localdomain>
References: <20090219195009.20619.20334.stgit@bob.kio>
 <20090219195148.20619.14362.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:49192 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZBVD7H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Feb 2009 22:59:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFG000J38E46GLN@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 21 Feb 2009 21:59:05 -0600 (CST)
In-reply-to: <20090219195148.20619.14362.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

we already have include/acpi/processor.h,
i'd rather not also have a drivers/acpi/processor.h

--
Len Brown, Intel Open Source Technology Center

On Thu, 19 Feb 2009, Bjorn Helgaas wrote:

> The processor-related declarations in acpi_drivers.h are used
> only by the processor driver, which happens to be split across
> several files.  This patch moves those declarations to a new
> drivers/acpi/processor.h file.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/processor.h         |    5 +++++
>  drivers/acpi/processor_core.c    |    2 ++
>  drivers/acpi/processor_thermal.c |    2 ++
>  drivers/acpi/thermal.c           |    2 ++
>  include/acpi/acpi_drivers.h      |   10 ----------
>  5 files changed, 11 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/acpi/processor.h
> 
> diff --git a/drivers/acpi/processor.h b/drivers/acpi/processor.h
> new file mode 100644
> index 0000000..51df8cb
> --- /dev/null
> +++ b/drivers/acpi/processor.h
> @@ -0,0 +1,5 @@
> +#define ACPI_PROCESSOR_LIMIT_NONE	0x00
> +#define ACPI_PROCESSOR_LIMIT_INCREMENT	0x01
> +#define ACPI_PROCESSOR_LIMIT_DECREMENT	0x02
> +
> +int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 0cc2fd3..a744ad4 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -59,6 +59,8 @@
>  #include <acpi/acpi_drivers.h>
>  #include <acpi/processor.h>
>  
> +#include "processor.h"
> +
>  #define ACPI_PROCESSOR_CLASS		"processor"
>  #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
>  #define ACPI_PROCESSOR_FILE_INFO	"info"
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index b1eb376..a778ac2 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -40,6 +40,8 @@
>  #include <acpi/processor.h>
>  #include <acpi/acpi_drivers.h>
>  
> +#include "processor.h"
> +
>  #define ACPI_PROCESSOR_CLASS            "processor"
>  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_thermal");
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 99e6f1f..23c5bc9 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -47,6 +47,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> +#include "processor.h"
> +
>  #define ACPI_THERMAL_CLASS		"thermal_zone"
>  #define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
>  #define ACPI_THERMAL_FILE_STATE		"state"
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 9ea2684..4358917 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -103,16 +103,6 @@ extern int acpi_power_nocheck;
>  int acpi_ec_ecdt_probe(void);
>  int acpi_boot_ec_enable(void);
>  
> -/* --------------------------------------------------------------------------
> -                                    Processor
> -   -------------------------------------------------------------------------- */
> -
> -#define ACPI_PROCESSOR_LIMIT_NONE	0x00
> -#define ACPI_PROCESSOR_LIMIT_INCREMENT	0x01
> -#define ACPI_PROCESSOR_LIMIT_DECREMENT	0x02
> -
> -int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
> -
>  /*--------------------------------------------------------------------------
>                                    Dock Station
>    -------------------------------------------------------------------------- */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
