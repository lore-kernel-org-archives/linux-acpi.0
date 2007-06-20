From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 3/3] ACPI autoloading - Create __mod_acpi_device_table symbol for all acpi drivers.
Date: Thu, 21 Jun 2007 02:06:18 +0900
Message-ID: <20070620170617.GA3226@inferi.kami.home>
References: <1182112047.4204.12.camel@noname> <1182111863.4204.6.camel@noname>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:44145 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbXFTRGx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jun 2007 13:06:53 -0400
Content-Disposition: inline
In-Reply-To: <1182111863.4204.6.camel@noname>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Sun, Jun 17, 2007 at 10:24:23PM +0200, Thomas Renninger wrote:
> Create __mod_acpi_device_table symbol for all acpi drivers.
> 
> modpost is going to use this one to create modules.alias
> 
> Hopefully thinkpad module still works.
> IMO this one should get restructured and make use of acpi_bus_register_driver
> and try to avoid to test for HIDs/CIDs for its own.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>

Tested, except for the compile error already reported it does its job on
my vaios.
A question though:

> Index: linux-2.6.22-rc4/drivers/misc/sony-laptop.c
> ===================================================================
> --- linux-2.6.22-rc4.orig/drivers/misc/sony-laptop.c
> +++ linux-2.6.22-rc4/drivers/misc/sony-laptop.c
> @@ -890,10 +890,22 @@ static int sony_nc_remove(struct acpi_de
>  	return 0;
>  }
>  
> +static const struct acpi_device_id sony_device_ids[] = {
> +	{SONY_NC_HID, 0},
> +	{SONY_PIC_HID, 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, sony_device_ids);
> +
> +static const struct acpi_device_id sony_nc_device_ids[] = {
> +	{SONY_NC_HID, 0},
> +	{"", 0},
> +};
> +
...
> +static const struct acpi_device_id sony_pic_device_ids[] = {
> +	{SONY_PIC_HID, 0},
> +	{"", 0},
> +};
> +

is it really necessary to have those duplicate entries?

Also, I guess that when this patch set is applied we also should declare
sonypi obsolete as sony-laptop will grab the same device that sonypi
wants (the SPIC one). sony-laptop has options to avoid doing that would
make things clear to users.
I still haven't received reports of mafunctioning vaios using the new
sony-laptop instead of sonypi but 2.6.22 isn't final yet.

-- 
mattia
:wq!
