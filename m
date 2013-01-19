From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / platform: fix comment about the platform device name
Date: Sat, 19 Jan 2013 01:37:39 +0100
Message-ID: <1745742.JqCREJosvU@vostro.rjw.lan>
References: <1358518175-23197-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46165 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab3ASAbo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2013 19:31:44 -0500
In-Reply-To: <1358518175-23197-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Friday, January 18, 2013 04:09:35 PM Mika Westerberg wrote:
> We don't use _UID anymore, instead the name will be taken from the
> corresponding ACPI device (adev). Fix the obsolete comment.

I'm going to apply it.

Thanks,
Rafael


> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/acpi_platform.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index db129b9..5554aea 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -29,7 +29,7 @@ ACPI_MODULE_NAME("platform");
>   * that's the case, create and register a platform device, populate its common
>   * resources and returns a pointer to it.  Otherwise, return %NULL.
>   *
> - * The platform device's name will be taken from the @adev's _HID and _UID.
> + * Name of the platform device will be the same as @adev's.
>   */
>  struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
>  {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
