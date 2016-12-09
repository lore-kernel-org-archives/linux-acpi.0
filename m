From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / OSL: Fix a regression by returning table size via acpi_get_table_with_size()
Date: Fri, 9 Dec 2016 04:48:53 +0100
Message-ID: <CAJZ5v0hqYRGU_Ok8ZGhv4OS=JYj7YY5hxhFnTqZSdw=cpV3-mw@mail.gmail.com>
References: <cover.1480490191.git.lv.zheng@intel.com> <b8107fa792de9cb442c342433043604080699fc6.1481249993.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33560 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbcLIDsz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2016 22:48:55 -0500
In-Reply-To: <b8107fa792de9cb442c342433043604080699fc6.1481249993.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>

On Fri, Dec 9, 2016 at 3:21 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> The returned size is still used by the drivers.
>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/osl.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 5bef0f65..adf1ec4 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -445,8 +445,12 @@ void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
>
>         status = acpi_get_table(signature, instance, out_table);
>         if (ACPI_SUCCESS(status)) {
> -               /* No longer used by early_acpi_os_unmap_memory() */
> -               *tbl_size = 0;
> +               /*
> +                * No longer used by early_acpi_os_unmap_memory(), but still
> +                * used by the ACPI table drivers.
> +                */
> +               if (*out_table)
> +                       *tbl_size = (*out_table)->length;
>         }
>
>         return (status);
> --

The changelog doesn't explain anything.  Please say (a) what the
problem is and (b) how it is being addressed by your patch.

Thanks,
Rafael
