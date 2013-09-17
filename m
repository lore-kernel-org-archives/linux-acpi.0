From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 06/14] ACPICA: Validate start object for acpi_walk_namespace.
Date: Mon, 16 Sep 2013 20:44:08 -0400
Message-ID: <CAJvTdKnjwTG+M-2-xKQnhd0e1GfT8VeqxBLm+zQ31xmjEKKz2g@mail.gmail.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<557903201460512616d36b45c10d989f7196a690.1377844863.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:64305 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab3IQAoK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 20:44:10 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so4467093wes.9
        for <linux-acpi@vger.kernel.org>; Mon, 16 Sep 2013 17:44:09 -0700 (PDT)
In-Reply-To: <557903201460512616d36b45c10d989f7196a690.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

This was filed an fixed very quickly.
Is it something we see in the field?
The patch is small, should we mark it for -stable?

thanks

On Thu, Sep 12, 2013 at 4:55 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> From: Bob Moore <robert.moore@intel.com>
>
> Perform a sanity check on the start object to prevent problems
> later. ACPICA BZ 1025.
>
> Buglink: http://bugs.acpica.org/show_bug.cgi?id=1025
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/nsxfeval.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
> index b38b4b0..481a6b4 100644
> --- a/drivers/acpi/acpica/nsxfeval.c
> +++ b/drivers/acpi/acpica/nsxfeval.c
> @@ -605,11 +605,19 @@ acpi_walk_namespace(acpi_object_type type,
>                 goto unlock_and_exit;
>         }
>
> +       /* Now we can validate the starting node */
> +
> +       if (!acpi_ns_validate_handle(start_object)) {
> +               status = AE_BAD_PARAMETER;
> +               goto unlock_and_exit2;
> +       }
> +
>         status = acpi_ns_walk_namespace(type, start_object, max_depth,
>                                         ACPI_NS_WALK_UNLOCK,
>                                         descending_callback, ascending_callback,
>                                         context, return_value);
>
> +      unlock_and_exit2:
>         (void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
>
>        unlock_and_exit:
> --
> 1.7.10
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Len Brown, Intel Open Source Technology Center
