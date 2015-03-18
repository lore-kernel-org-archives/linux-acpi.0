From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Add acpi_device_uid() for convenience
Date: Wed, 18 Mar 2015 16:25:57 +0100
Message-ID: <1471778.Wbz0YErtLr@vostro.rjw.lan>
References: <1426585710-31947-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62699 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755282AbbCRPCD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2015 11:02:03 -0400
In-Reply-To: <1426585710-31947-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, March 17, 2015 11:48:30 AM Adrian Hunter wrote:
> Add a nicer way to get the ACPI _UID.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Queued up for 4.1, thanks!

> ---
>  include/acpi/acpi_bus.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 61e32ec..f8009d9 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -252,6 +252,7 @@ struct acpi_device_pnp {
>  #define acpi_device_bid(d)	((d)->pnp.bus_id)
>  #define acpi_device_adr(d)	((d)->pnp.bus_address)
>  const char *acpi_device_hid(struct acpi_device *device);
> +#define acpi_device_uid(d)	((d)->pnp.unique_id)
>  #define acpi_device_name(d)	((d)->pnp.device_name)
>  #define acpi_device_class(d)	((d)->pnp.device_class)
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
