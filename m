From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch] ACPI / CPPC: set an error code on probe error path
Date: Wed, 30 Nov 2016 22:53:55 +0100
Message-ID: <CAJZ5v0h06CXGzdAt=ZmB+pnWRumDGiic-eEpyLAojKVUVrJnnw@mail.gmail.com>
References: <20161130192254.GE28180@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36615 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753815AbcK3Vx5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Nov 2016 16:53:57 -0500
In-Reply-To: <20161130192254.GE28180@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Wed, Nov 30, 2016 at 8:22 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We should return -EINVAL if get_cpu_device() fails.
>
> Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index d0d0504..e0ea8f5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -784,8 +784,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>
>         /* Add per logical CPU nodes for reading its feedback counters. */
>         cpu_dev = get_cpu_device(pr->id);
> -       if (!cpu_dev)
> +       if (!cpu_dev) {
> +               ret = -EINVAL;

ret is initialized here AFAICS.

Do you that its value is not the right one?

>                 goto out_free;
> +       }
>
>         ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
>                         "acpi_cppc");
> --

Thanks,
Rafael
