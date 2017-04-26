From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] ACPICA: Tables: Fix regression introduced by a too
 early mechanism enabling
Date: Tue, 25 Apr 2017 22:00:57 -0700
Message-ID: <CAPcyv4gtYzkeUL-Ou8bap5Sye=1Tq2PmuhZM04nFPwdjmCwCgg@mail.gmail.com>
References: <1493171393-1825-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34904 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1177341AbdDZFA6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 01:00:58 -0400
Received: by mail-oi0-f54.google.com with SMTP id j201so196235714oih.2
        for <linux-acpi@vger.kernel.org>; Tue, 25 Apr 2017 22:00:58 -0700 (PDT)
In-Reply-To: <1493171393-1825-1-git-send-email-lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Apr 25, 2017 at 6:49 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> In the Linux kernel side, acpi_get_table() hasn't been fully balanced by
> acpi_put_table() invocations. So it is not a good timing to report errors.
> The strict balanced validation count check should only be enabled after
> confirming that all kernel side invocations are safe.

We've been living with this bug for 7 years, let's just go fix all
acpi_get_table() invocations to make sure they have a corresponding
acpi_put_table().

>
> Thus this patch removes the fatal error but leaves the error report to
> indicate the leak so that developers can notice the required engineering
> change. Reported by Dan Williams, fixed by Lv Zheng.
>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/tbutils.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index 5a968a7..9e7d95cf 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -422,7 +422,6 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
>                             "Table %p, Validation count is zero after increment\n",
>                             table_desc));
>                 table_desc->validation_count--;
> -               return_ACPI_STATUS(AE_LIMIT);

If you want to leave the error report turn it into a WARN_ON_ONCE() so
it doesn't keep triggering, but I'd rather we just focus on the
missing acpi_put_table() calls.
