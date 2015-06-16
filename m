From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Fwd: ASoC : WM5102 Audio Codec needs ACPI support and a
	baytrail machine driver
Date: Tue, 16 Jun 2015 15:47:33 +0100
Message-ID: <20150616144732.GN32730@opensource.wolfsonmicro.com>
References: <CAKor6TdbnLuJCsBPykPEmhGk-zBLggKxw4Z+=QuBb6Mz2ThD3g@mail.gmail.com> <CAKor6TeP2HfqpHiKK86GLYLpCNk87y66bdjye_mAqXuMXxPMWA@mail.gmail.com> <CAKor6Tdg5yHaLVrCrWFVuydVcYUUtYr=oSj+k37Yd9O64+tg6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49528 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756159AbbFPOrf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:47:35 -0400
Content-Disposition: inline
In-Reply-To: <CAKor6Tdg5yHaLVrCrWFVuydVcYUUtYr=oSj+k37Yd9O64+tg6A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hartmann <cornogle@googlemail.com>
Cc: patches@opensource.wolfsonmicro.com, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, Jun 16, 2015 at 03:10:42PM +0200, Christian Hartmann wrote:
> ---------- Forwarded message ----------
> From: Christian Hartmann <cornogle@googlemail.com>
> Date: 2015-06-16 14:27 GMT+02:00
> Subject: Re: ASoC : WM5102 Audio Codec needs ACPI support and a
> baytrail machine driver
> To: alsa-devel@alsa-project.org
> 
> 
> Hi again,
> 
> 
> some notes to the NULL pointer dereference error
> I have changed the function arizona_spi_probe in arizona-spi.c and
> have looked into the code where the NULL is coming...
> 
> in drivers/spi/spi.c the function spi_get_device_id() returns NULL,
> cause the called function spi_match_id() does never match an id string
> (there is no modalias string available I think).
> With the id = NULL the line
> type = id->driver_data; will throw the described exception.
> 
> Going on further, it seems that "id" has no such structure element of
> "->driver_data", or I cannot find it.
> 
> Can someone please explain me in some simple words where the element
> driver_data is coming or will be set
> in THIS function of arizona_spi_probe()
> 
> The id->driver_data is not working for the acpi case...
> This tablet does not have openfirmware (OF) by the way. The code seems
> to be optimized for the Openfirmware API, but not for the ACPI case.
> 

Alas you are correct this driver has no built in support for ACPI
at the moment. So you are going to need to add that to get it
working on an ACPI system.

I don't really have any experience with ACPI so can't really be of
much assistance here. However, most of these device match functions
OF or the SPI built in system contain two fields an ID and some
driver data. As you can see in the code:

	if (spi->dev.of_node)
		type = arizona_of_get_type(&spi->dev);
	else
		type = id->driver_data;

We extract the type in suitable ways for the SPI built in match
and for the OF match up, I presume you need to do something
similar that is specific to the ACPI case. I would suggest here
looking up other ACPI drivers and seeing how they handle this
situation.

What I would expect to see is an extra else if in this statement
that does something specific to the ACPI case.

> 
> 
> this is the currently local changed code to test and find null pointer
> inarizona-spi.c.
> 
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 1e845f6..de48cf6 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -25,16 +25,26 @@
> 
>  static int arizona_spi_probe(struct spi_device *spi)
>  {
> -       const struct spi_device_id *id = spi_get_device_id(spi);
> +       const struct spi_device_id *id ;
>         struct arizona *arizona;
>         const struct regmap_config *regmap_config;
>         unsigned long type;
>         int ret;
> 
> -       if (spi->dev.of_node)
> -               type = arizona_of_get_type(&spi->dev);
> -       else
> +       /*
> +       id = spi_get_device_id(spi);
> +
> +       if (!id)
> +               return -EINVAL;
> +       type = id->driver_data;
> +       */
> +       id = WM5102;
> +
> +       if (id->driver_data)
>                 type = id->driver_data;
> +       else
> +               type = WM5102;
> +

This just defaults to WM5102 whenever we arn't using the spi
matching, which will probably get you running but clearly isn't
going to be a suitable solution.

> 
>         switch (type) {
>  #ifdef CONFIG_MFD_WM5102
> @@ -90,11 +100,23 @@ static const struct spi_device_id arizona_spi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, arizona_spi_ids);
> 
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id wm5102_acpi_match[] = {
> +       { "WM510205", WM5102 },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id wm5102_acpi_match[] = {
> +       { "WM510205", WM5102 },

The second entry here should be the driver_data, the ACPI id does
look a bit odd but I guess this is what our Windows guys are
using.

Thanks,
Charles

