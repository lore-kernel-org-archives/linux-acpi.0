From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/3] ACPI: Disambiguate processor declaration type
Date: Fri, 24 Oct 2008 09:16:22 +0800
Message-ID: <1224810982.3945.22.camel@yakui_zhao.sh.intel.com>
References: <1224702636.6784.13.camel@localhost>
	 <1224702749.6784.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16603 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbYJXBKK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Oct 2008 21:10:10 -0400
In-Reply-To: <1224702749.6784.15.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: lenb@kernel.org, aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2008-10-22 at 13:12 -0600, Myron Stowe wrote:
> Declaring processors in ACPI namespace can be done using either a "Processor"
> definition or a "Device" definition (see section 8.4 - Declaring Processors;
> "Advanced Configuration and Power Interface Specification", Revision 3.0b).
> Currently the two processor declaration types are conflated.
In most cases there is no _UID object under the scope of processor
namespace. So the current source can work well without adding the new
HID("ACPI_CPU") for processor definition.

If there exists the _UID object under the scope of processor namespace,
IMO the ProcessorID returned by _UID will have higher priority. In such
case the patch can't work well.

> 
> This patch disambiguates the processor declaration's definition type enabling
> subsequent code to behave uniquely based explicitly on the declaration's type.
> 
> Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> CC: Alexey Starikovskiy <aystarik@gmail.com>
> 
> ---
>  drivers/acpi/processor_core.c |    1 +
>  drivers/acpi/scan.c           |    2 +-
>  include/acpi/acpi_drivers.h   |    1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c	2008-10-16 19:00:37.000000000 -0600
> +++ linux-2.6/drivers/acpi/processor_core.c	2008-10-21 13:11:00.000000000 -0600
> @@ -89,6 +89,7 @@ static int acpi_processor_handle_eject(s
>  
> 
>  static const struct acpi_device_id processor_device_ids[] = {
> +	{ACPI_PROCESSOR_OBJECT_HID, 0},
>  	{ACPI_PROCESSOR_HID, 0},
>  	{"", 0},
>  };
> Index: linux-2.6/include/acpi/acpi_drivers.h
> ===================================================================
> --- linux-2.6.orig/include/acpi/acpi_drivers.h	2008-10-16 18:53:26.000000000 -0600
> +++ linux-2.6/include/acpi/acpi_drivers.h	2008-10-20 13:23:28.000000000 -0600
> @@ -41,6 +41,7 @@
>   */
>  
>  #define ACPI_POWER_HID			"LNXPOWER"
> +#define ACPI_PROCESSOR_OBJECT_HID	"ACPI_CPU"
>  #define ACPI_PROCESSOR_HID		"ACPI0007"
>  #define ACPI_SYSTEM_HID			"LNXSYSTM"
>  #define ACPI_THERMAL_HID		"LNXTHERM"
> Index: linux-2.6/drivers/acpi/scan.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/scan.c	2008-10-16 19:04:58.000000000 -0600
> +++ linux-2.6/drivers/acpi/scan.c	2008-10-21 13:09:09.000000000 -0600
> @@ -1025,7 +1025,7 @@ static void acpi_device_set_id(struct ac
>  		hid = ACPI_POWER_HID;
>  		break;
>  	case ACPI_BUS_TYPE_PROCESSOR:
> -		hid = ACPI_PROCESSOR_HID;
> +		hid = ACPI_PROCESSOR_OBJECT_HID;
>  		break;
>  	case ACPI_BUS_TYPE_SYSTEM:
>  		hid = ACPI_SYSTEM_HID;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

