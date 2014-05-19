From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / platform: add IDs for Broadcom Bluetooth and GPS chips
Date: Tue, 20 May 2014 00:58:13 +0200
Message-ID: <1608612.pjc5VE5jnP@vostro.rjw.lan>
References: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55630 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750852AbaESWlT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 May 2014 18:41:19 -0400
In-Reply-To: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Thursday, May 08, 2014 02:59:04 PM Heikki Krogerus wrote:
> These IDs are used on Baytrail boards such as Lenovo Miix 2
> and Asus Transformer Book T100TA. On lenovo Miix 2 8",
> BCM4752 is called LNV4752. All the rest of the IDs are for
> Broadcom BCM43241 module with the ID referring to different
> revision number.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Queued up for 3.16, thanks!

> ---
>  drivers/acpi/acpi_platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 1d49503..34a64c5 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -31,6 +31,10 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
>  	{ "PNP0D40" },
>  	{ "VPC2004" },
>  	{ "BCM4752" },
> +	{ "LNV4752" },
> +	{ "BCM2E1A" },
> +	{ "BCM2E39" },
> +	{ "BCM2E3D" },
>  
>  	/* Intel Smart Sound Technology */
>  	{ "INT33C8" },
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
