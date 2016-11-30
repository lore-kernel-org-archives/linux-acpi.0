From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 02/11] ACPICA: Back port of "ACPICA: Dispatcher: Tune
 interpreter lock around AcpiEvInitializeRegion()"
Date: Wed, 30 Nov 2016 23:30:07 +0100
Message-ID: <CAJZ5v0gvXuvKSkgMqUYw+7OhqohA1rXx-tM2DfvtC-CG7BT0gA@mail.gmail.com>
References: <cover.1480490191.git.lv.zheng@intel.com> <26416a54d74f43b07e27cf6f79d6b8f2976f84bb.1480490191.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34061 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754924AbcK3WaJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Nov 2016 17:30:09 -0500
In-Reply-To: <26416a54d74f43b07e27cf6f79d6b8f2976f84bb.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bob Moore <robert.moore@intel.com>

On Wed, Nov 30, 2016 at 8:20 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> ACPICA commit bc481e758e54f7644fd0b657119ca7763d8b6a9c
>
> This is a back port result of the following commit:
>   Commit: 8633db6b027952449e155a316f4ae3a530bbe18f
>   Subject: ACPICA: Dispatcher: Fix interpreter locking around acpi_ev_initialize_region()
>
> Link: https://github.com/acpica/acpica/commit/bc481e75
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/acpica/dsinit.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
> index 54d48b9..5de3f10 100644
> --- a/drivers/acpi/acpica/dsinit.c
> +++ b/drivers/acpi/acpica/dsinit.c
> @@ -221,8 +221,8 @@
>          */
>         status =
>             acpi_ns_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
> -                                  0, acpi_ds_init_one_object, NULL, &info,
> -                                  NULL);
> +                                  ACPI_NS_WALK_NO_UNLOCK,
> +                                  acpi_ds_init_one_object, NULL, &info, NULL);
>         if (ACPI_FAILURE(status)) {
>                 ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
>         }
> --

This isn't necessary IMO, the current code linux-next code looks like
the change has been made in there already AFAICS (please double check,
though).

I'm skipping this patch.

Thanks,
Rafael
