From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PNPACPI: check return value of pnpacpi_parse_allocated_resource() and pnpacpi_parse_resource_option_data()
Date: Wed, 23 Jul 2014 00:12:03 +0200
Message-ID: <6018343.yi13pxNXUP@vostro.rjw.lan>
References: <1406056419-3047-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51057 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932102AbaGVVxj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2014 17:53:39 -0400
In-Reply-To: <1406056419-3047-1-git-send-email-arjun024@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, July 23, 2014 12:43:39 AM Arjun Sreedharan wrote:
> Handle error condition since pnpacpi_parse_allocated_resource() and pnpacpi_parse_resource_option_data() could return -EPERM.
> 
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>

I wonder if this fixes any functional issue you've seen or someone has
reported to you or it's just an "Oh, we probably should handle the return
values here" kind of thing?

> ---
>  drivers/pnp/pnpacpi/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index b81448b..c3214e9 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -272,10 +272,14 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
>  		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
>  
>  	if (dev->active)
> -		pnpacpi_parse_allocated_resource(dev);
> +		error = pnpacpi_parse_allocated_resource(dev);
> +		if (error)
> +			return error;
>  
>  	if (dev->capabilities & PNP_CONFIGURABLE)
> -		pnpacpi_parse_resource_option_data(dev);
> +		error = pnpacpi_parse_resource_option_data(dev);
> +		if (error)
> +			return error;
>  
>  	list_for_each_entry(id, &device->pnp.ids, list) {
>  		if (!strcmp(id->id, pnpid))
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
