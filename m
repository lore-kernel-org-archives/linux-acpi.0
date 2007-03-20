From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC PATCH] _TPC support
Date: Tue, 20 Mar 2007 09:11:10 +0800
Message-ID: <1174353070.1665.7.camel@sli10-conroe.sh.intel.com>
References: <3877989d0703190230v3a3c1c7alfa52fe0c87a12aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24211 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030823AbXCTBOA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 21:14:00 -0400
In-Reply-To: <3877989d0703190230v3a3c1c7alfa52fe0c87a12aca@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, 2007-03-19 at 17:30 +0800, Luming Yu wrote:
> adds _TPC support which support Throttling Present Capabilities
> change for ACPI processor driver
> 
> signed-off-by: Luming Yu <Luming.yu@intel.com>
> --
> 
>  drivers/acpi/processor_core.c       |    4 ++++
>  drivers/acpi/processor_throttling.c |   30
> ++++++++++++++++++++++++++++--
>  include/acpi/processor.h            |    3 +++
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/acpi/processor_core.c
> b/drivers/acpi/processor_core.c
> index ddc9e20..b2093ca 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -67,6 +67,7 @@ #define ACPI_PROCESSOR_FILE_THROTTLING        "
>  #define ACPI_PROCESSOR_FILE_LIMIT      "limit"
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER    0x81
> +#define ACPI_PROCESSOR_NOTIFY_THROTTLING       0x82
> 
>  #define ACPI_PROCESSOR_LIMIT_USER      0
>  #define ACPI_PROCESSOR_LIMIT_THERMAL   1
> @@ -702,6 +703,9 @@ static void acpi_processor_notify(acpi_h
>                 acpi_processor_cst_has_changed(pr);
>                 acpi_bus_generate_event(device, event, 0);
>                 break;
> +       case ACPI_PROCESSOR_NOTIFY_THROTTLING:
> +               acpi_processor_tstate_has_changed(pr);
> +               acpi_bus_generate_event(device, event, 0);
>         default:
>                 ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>                                   "Unsupported event [0x%x]\n",
> event));
> diff --git a/drivers/acpi/processor_throttling.c
> b/drivers/acpi/processor_throttling.c
> index b334860..0528b27 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -44,6 +44,27 @@ #define ACPI_PROCESSOR_CLASS
>  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_throttling");
> 
> +static int acpi_processor_get_platform_limit(struct acpi_processor
> *pr)
> +{
> +       acpi_status status = 0;
> +       unsigned long tpc = 0;
> +
> +       if(!pr)
> +               return -EINVAL;
> +       status = acpi_evaluate_integer(pr->handle, "_TPC", NULL,
> &tpc);
> +       if(ACPI_FAILURE(status) && status != AE_NOT_FOUND){
> +               ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
> +               return -ENODEV;
> +       }
> +       pr->throttling_platform_limit = (int)tpc;
> +       return 0;
> +}
I think we should reset throttling here, as limit is changed, previous
throttling setting might not be feasible.

Thanks,
Shaohua
