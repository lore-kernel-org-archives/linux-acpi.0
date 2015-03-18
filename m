From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Update GPIO documentation to mention _DSD
Date: Wed, 18 Mar 2015 16:25:37 +0100
Message-ID: <19307384.PnLJQHkALI@vostro.rjw.lan>
References: <1426588812-229641-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55789 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755282AbbCRPBm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2015 11:01:42 -0400
In-Reply-To: <1426588812-229641-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org

On Tuesday, March 17, 2015 12:40:12 PM Mika Westerberg wrote:
> Make sure that the ACPI enumeration.txt provides latest information on how
> to describe and retrieve GPIOs now that we can take advantage of _DSD
> device properties.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Queued up for 4.1, thanks!

> ---
>  Documentation/acpi/enumeration.txt | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
> index 9b121a569ab4..750401f91341 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -254,8 +254,13 @@ GPIO support
>  ~~~~~~~~~~~~
>  ACPI 5 introduced two new resources to describe GPIO connections: GpioIo
>  and GpioInt. These resources are used be used to pass GPIO numbers used by
> -the device to the driver. For example:
> +the device to the driver. ACPI 5.1 extended this with _DSD (Device
> +Specific Data) which made it possible to name the GPIOs among other things.
>  
> +For example:
> +
> +Device (DEV)
> +{
>  	Method (_CRS, 0, NotSerialized)
>  	{
>  		Name (SBUF, ResourceTemplate()
> @@ -285,6 +290,18 @@ the device to the driver. For example:
>  		Return (SBUF)
>  	}
>  
> +	// ACPI 5.1 _DSD used for naming the GPIOs
> +	Name (_DSD, Package ()
> +	{
> +		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +		Package ()
> +		{
> +			Package () {"power-gpios", Package() {^DEV, 0, 0, 0 }},
> +			Package () {"irq-gpios", Package() {^DEV, 1, 0, 0 }},
> +		}
> +	})
> +	...
> +
>  These GPIO numbers are controller relative and path "\\_SB.PCI0.GPI0"
>  specifies the path to the controller. In order to use these GPIOs in Linux
>  we need to translate them to the corresponding Linux GPIO descriptors.
> @@ -300,11 +317,11 @@ a code like this:
>  
>  	struct gpio_desc *irq_desc, *power_desc;
>  
> -	irq_desc = gpiod_get_index(dev, NULL, 1);
> +	irq_desc = gpiod_get(dev, "irq");
>  	if (IS_ERR(irq_desc))
>  		/* handle error */
>  
> -	power_desc = gpiod_get_index(dev, NULL, 0);
> +	power_desc = gpiod_get(dev, "power");
>  	if (IS_ERR(power_desc))
>  		/* handle error */
>  
> @@ -313,6 +330,9 @@ a code like this:
>  There are also devm_* versions of these functions which release the
>  descriptors once the device is released.
>  
> +See Documentation/acpi/gpio-properties.txt for more information about the
> +_DSD binding related to GPIOs.
> +
>  MFD devices
>  ~~~~~~~~~~~
>  The MFD devices register their children as platform devices. For the child
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
