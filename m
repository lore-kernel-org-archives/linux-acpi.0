From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch] power_meter: acpi_device_class "power_meter_resource" too long
Date: Tue, 23 Mar 2010 17:26:07 +0100
Message-ID: <201003231726.07480.trenn@suse.de>
References: <20100319114920.GP5331@bicker>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100319114920.GP5331@bicker>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, =?iso-8859-1?q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday 19 March 2010 12:49:20 Dan Carpenter wrote:
> acpi_device_class can only be 19 characters and a NULL terminator.
> 
> The current code has a buffer overflow in acpi_power_meter_add():
>        strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
Sounds as if it would be worth to add:
CC: stable@kernel.org
?
Same for processor_aggregator.

     Thomas
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> Feel free to change the name to anything you like.
> 
> diff --git a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
> index 834c5af..31baa1e 100644
> --- a/drivers/acpi/power_meter.c
> +++ b/drivers/acpi/power_meter.c
> @@ -34,7 +34,7 @@
>  #define ACPI_POWER_METER_NAME		"power_meter"
>  ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
>  #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
> -#define ACPI_POWER_METER_CLASS		"power_meter_resource"
> +#define ACPI_POWER_METER_CLASS		"pwr_meter_resource"
>  
>  #define NUM_SENSORS			17
>  
> --
