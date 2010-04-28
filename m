From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [patch for 2.6.34? 1/1] power_meter: acpi_device_class
	"power_meter_resource" too long
Date: Wed, 28 Apr 2010 10:25:32 -0700
Message-ID: <20100428172532.GD15515@tux1.beaverton.ibm.com>
References: <201004272101.o3RL17kH019428@imap1.linux-foundation.org>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:42749 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab0D1RZk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Apr 2010 13:25:40 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SD71Qq030693
	for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 09:07:01 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o3SHPcQl1736898
	for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 13:25:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o3SHPaTe017340
	for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 13:25:38 -0400
Content-Disposition: inline
In-Reply-To: <201004272101.o3RL17kH019428@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, error27@gmail.com, stable@kernel.org

On Tue, Apr 27, 2010 at 02:01:07PM -0700, akpm@linux-foundation.org wrote:
> From: Dan Carpenter <error27@gmail.com>
> 
> acpi_device_class can only be 19 characters and a NULL terminator.
> 
> The current code has a buffer overflow in acpi_power_meter_add():
>        strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Darrick J. Wong" <djwong@us.ibm.com>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Looks ok to me, so:

Acked-by: Darrick J. Wong <djwong@us.ibm.com>

> ---
> 
>  drivers/acpi/power_meter.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/power_meter.c~power_meter-acpi_device_class-power_meter_resource-too-long drivers/acpi/power_meter.c
> --- a/drivers/acpi/power_meter.c~power_meter-acpi_device_class-power_meter_resource-too-long
> +++ a/drivers/acpi/power_meter.c
> @@ -35,7 +35,7 @@
>  #define ACPI_POWER_METER_NAME		"power_meter"
>  ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
>  #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
> -#define ACPI_POWER_METER_CLASS		"power_meter_resource"
> +#define ACPI_POWER_METER_CLASS		"pwr_meter_resource"
> 
>  #define NUM_SENSORS			17
> 
> _
