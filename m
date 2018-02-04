From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/6] ACPI / bus: Return error code from
 __acpi_match_device() in one case
Date: Sun, 4 Feb 2018 08:16:14 +0100
Message-ID: <CAJZ5v0gL5d5Ypar2GJSLCFNWAPhy9RGbwhF9iAKuAWaeu_hxFg@mail.gmail.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:46439 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeBDHQP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Feb 2018 02:16:15 -0500
In-Reply-To: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, Feb 1, 2018 at 9:20 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Instead of playing tricks with last invalid entry,
> return simple -ENODATA error code casted to pointer.
>
> It would be good for future in case caller passes NULL pointer for
> ID table. Moreover, caller can check the code to be sure what happened
> inside callee.
>
> Fixes: 2b9c698efa58 ("ACPI / scan: Take the PRP0001 position in the list of IDs into account")
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch
>  drivers/acpi/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f87ed3be779a..a87a97bf75f8 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -762,7 +762,7 @@ static const struct acpi_device_id *__acpi_match_device(
>                  */
>                 if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
>                     && acpi_of_match_device(device, of_ids))
> -                       return id;
> +                       return ERR_PTR(-ENODATA);

So why is returning id from here a problem?

>         }
>         return NULL;
>  }
> --
