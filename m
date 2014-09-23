From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] gpio / ACPI: Use pin index and bit length
Date: Tue, 23 Sep 2014 13:27:28 +0300
Message-ID: <20140923102728.GK1786@lahna.fi.intel.com>
References: <715ed7865378d29b78003c710d50dba77b2cb9bb.1411439631.git.lv.zheng@intel.com>
 <7b41a3ca1f673c6e3d6e6b7c94c0792c7b18badf.1411439632.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47667 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466AbaIWK1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Sep 2014 06:27:33 -0400
Content-Disposition: inline
In-Reply-To: <7b41a3ca1f673c6e3d6e6b7c94c0792c7b18badf.1411439632.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>

On Tue, Sep 23, 2014 at 10:35:54AM +0800, Lv Zheng wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Fix code when the operation region callback is for an gpio, which
> is not at index 0 and for partial pins in a GPIO definition.
> For example:
> Name (GMOD, ResourceTemplate ()
> {
> 	//3 Outputs that define the Power mode of the device
> 	GpioIo (Exclusive, PullDown, , , , "\\_SB.GPI2") {10, 11, 12}
> 	})
> }
> 
> If opregion callback calls is for:
> - Set pin 10, then address = 0 and bit length = 1
> - Set pin 11, then address = 1 and bit length = 1
> - Set for both pin 11 and pin 12, then address = 1, bit length = 2
> 
> This change requires updated ACPICA gpio operation handler code to
> send the pin index and bit length.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Adding the GPIO maintainers since we need their ACK to get this merged
through ACPI tree.

> ---
>  drivers/gpio/gpiolib-acpi.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index d62eaaa..687476f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -377,8 +377,10 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>  	struct gpio_chip *chip = achip->chip;
>  	struct acpi_resource_gpio *agpio;
>  	struct acpi_resource *ares;
> +	int pin_index = (int)address;
>  	acpi_status status;
>  	bool pull_up;
> +	int length;
>  	int i;
>  
>  	status = acpi_buffer_to_resource(achip->conn_info.connection,
> @@ -400,7 +402,8 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>  		return AE_BAD_PARAMETER;
>  	}
>  
> -	for (i = 0; i < agpio->pin_table_length; i++) {
> +	length = min(agpio->pin_table_length, (u16)(pin_index + bits));
> +	for (i = pin_index; i < length; ++i) {
>  		unsigned pin = agpio->pin_table[i];
>  		struct acpi_gpio_connection *conn;
>  		struct gpio_desc *desc;
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
