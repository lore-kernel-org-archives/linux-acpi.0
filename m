From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: Create platform device for BSG2150 ACPI nodes
Date: Thu, 20 Dec 2018 21:59:51 +0100
Message-ID: <1571328.CfEAWKtrWq@aspire.rjw.lan>
References: <20181220143451.25962-1-hdegoede@redhat.com> <20181220143451.25962-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220143451.25962-2-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 20, 2018 3:34:51 PM CET Hans de Goede wrote:
> The Point of View TAB-P1006W-232-3G tablet has an ACPI firmware node with
> a HID of BSG2150 describing the 2 Bosch sensors used in the device a
> BMC150 compatible accelerometer and a BMC150 compatible magnetometer.
> 
> The ACPI firmware node actually contains 3 I2cSerialBusV2 resources,
> but this seems to be a copy and paste job from the BSG1160 firmware node
> on other devices, since there is no i2c-client listening to the 0x68
> address listed in the third resource and the 0x68 address is identical
> to the address of the third resource in the BSG1160 nodes, where as the
> other 2 addresses are different.
> 
> Add the ID to the I2C multi instantiate list, so that the
> i2c-multi-instantiate.c driver can handle it;
> 
> And add the necessary info to the i2c-multi-instantiate.c driver to
> enumerate all I2C slaves correctly.
> 
> To avoid triggering the:
> 
>         if (i < multi->num_clients) {
>                 dev_err(dev, "Error finding driver, idx %d\n", i);
> 
> Error this commit lists the 3th device in the i2c_inst_data with a
> type of "bsg2150_dummy_dev".
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c                          | 1 +
>  drivers/platform/x86/i2c-multi-instantiate.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e9eda5558c1f..d5b981cafaf8 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1540,6 +1540,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	 */
>  	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
>  		{"BSG1160", },
> +		{"BSG2150", },
>  		{"INT33FE", },
>  		{"INT3515", },
>  		{}
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index 3d893e0ac250..197d8a192721 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -159,6 +159,14 @@ static const struct i2c_inst_data bsg1160_data[]  = {
>  	{}
>  };
>  
> +static const struct i2c_inst_data bsg2150_data[]  = {
> +	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
> +	{ "bmc150_magn" },
> +	/* The resources describe a 3th client, but it is not really there. */
> +	{ "bsg2150_dummy_dev" },
> +	{}
> +};
> +
>  static const struct i2c_inst_data int3515_data[]  = {
>  	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
>  	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
> @@ -173,6 +181,7 @@ static const struct i2c_inst_data int3515_data[]  = {
>   */
>  static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>  	{ "BSG1160", (unsigned long)bsg1160_data },
> +	{ "BSG2150", (unsigned long)bsg2150_data },
>  	{ "INT3515", (unsigned long)int3515_data },
>  	{ }
>  };
> 
