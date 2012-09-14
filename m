From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND] ACPI: power: Use KERN_DEBUG when no power resources are found
Date: Fri, 14 Sep 2012 21:30:25 +0200
Message-ID: <201209142130.25635.rjw@sisk.pl>
References: <1347584884-1486-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:54951 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759886Ab2INTYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Sep 2012 15:24:00 -0400
In-Reply-To: <1347584884-1486-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, Borislav Petkov <bp@amd64.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Friday, September 14, 2012, Aaron Lu wrote:
> commit a606dac368eed5696fb38e16b1394f1d049c09e9 adds support to link
> devices which have _PRx, if a device does not have _PRx, a warning
> message will be printed.
> 
> This commit is for ZPODD on Intel ZPODD capable platforms, on other
> platforms, it has no problem if there is no power resource for this
> device, so a warning here is not appropriate, change it to debug.
> 
> Reported-by: Borislav Petkov <bp@amd64.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Applied to the linux-next branch of the linux-pm.git tree as a -stable fix
for v3.6.

Thanks,
Rafael


> ---
>  drivers/acpi/power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 215ecd0..e5e01d9 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -460,7 +460,7 @@ int acpi_power_resource_register_device(struct device *dev, acpi_handle handle)
>  	return ret;
>  
>  no_power_resource:
> -	printk(KERN_WARNING PREFIX "Invalid Power Resource to register!");
> +	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!");
>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(acpi_power_resource_register_device);
> 

