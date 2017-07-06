From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Only call pwm_add_table for the first PWM
 controller
Date: Thu, 06 Jul 2017 20:11:39 +0300
Message-ID: <1499361099.22624.292.camel@linux.intel.com>
References: <20170706164927.15076-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:53414 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbdGFRLn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jul 2017 13:11:43 -0400
In-Reply-To: <20170706164927.15076-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org

On Thu, 2017-07-06 at 18:49 +0200, Hans de Goede wrote:
> At least on the UP board SBC both PWMs are enabled leading to us
> trying to add the same pwm_lookup twice, which leads to the following:
> 
> [    0.902224] list_add double add: new=ffffffffb8efd400,
>                prev=ffffffffb8efd400, next=ffffffffb8eeede0.
> [    0.912466] ------------[ cut here ]------------
> [    0.917624] kernel BUG at lib/list_debug.c:31!
> [    0.922588] invalid opcode: 0000 [#1] SMP
> ...
> [    1.027450] Call Trace:
> [    1.030185]  pwm_add_table+0x4c/0x90
> [    1.034181]  bsw_pwm_setup+0x1a/0x20
> [    1.038175]  acpi_lpss_create_device+0xfe/0x420
> ...
> 
> This commit fixes this by only calling pwm_add_table for the first
> PWM controller (which is the one used for the backlight).
> 

Thanks, my comment below.

For the quick fix I agree on this:
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

By the way, do you need a shell script that allows to setup pin muxing
via external CPLD?

> Cc: stable@vger.kernel.org
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1458599
> Fixes: bf7696a12071 ("acpi: lpss: call pwm_add_table() for BSW...")
> Fixes: 04434ab5120a ("ACPI / LPSS: Call pwm_add_table() for Bay
> Trail...")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_lpss.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 10347e3d73ad..5bd58bd4ab05 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -85,6 +85,7 @@ static const struct lpss_device_desc lpss_dma_desc =
> {
>  };
>  
>  struct lpss_private_data {
> +	struct acpi_device *adev;
>  	void __iomem *mmio_base;
>  	resource_size_t mmio_size;
>  	unsigned int fixed_clk_rate;
> @@ -155,6 +156,12 @@ static struct pwm_lookup byt_pwm_lookup[] = {
>  
>  static void byt_pwm_setup(struct lpss_private_data *pdata)
>  {
> +	struct acpi_device *adev = pdata->adev;
> +
> +	/* Only call pwm_add_table for the first PWM controller */
> +	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
> +		return;
> +

It would be nice to have a separate mapping between UID and lookup
table.

Though, for now it's only one case, perhaps we may do this later.

>  	if (!acpi_dev_present("INT33FD", NULL, -1))
>  		pwm_add_table(byt_pwm_lookup,
> ARRAY_SIZE(byt_pwm_lookup));
>  }
> @@ -180,6 +187,12 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
>  
>  static void bsw_pwm_setup(struct lpss_private_data *pdata)
>  {
> +	struct acpi_device *adev = pdata->adev;
> +
> +	/* Only call pwm_add_table for the first PWM controller */
> +	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
> +		return;
> +
>  	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
>  }
>  
> @@ -456,6 +469,7 @@ static int acpi_lpss_create_device(struct
> acpi_device *adev,
>  		goto err_out;
>  	}
>  
> +	pdata->adev = adev;
>  	pdata->dev_desc = dev_desc;
>  
>  	if (dev_desc->setup)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
