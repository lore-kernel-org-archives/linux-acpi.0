From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Thu, 20 Apr 2017 22:59:59 +0200
Message-ID: <CAJZ5v0gD9h97cPw+q25nWcpvNik_0EYt0jOxN5+D5BeiS5ogqg@mail.gmail.com>
References: <20170420201219.21568-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34789 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947474AbdDTVAA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2017 17:00:00 -0400
Received: by mail-oi0-f68.google.com with SMTP id y11so11482214oie.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2017 14:00:00 -0700 (PDT)
In-Reply-To: <20170420201219.21568-1-drake@endlessm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, Lv <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, chiu@endlessm.com, linux@endlessm.com

On Thu, Apr 20, 2017 at 10:12 PM, Daniel Drake <drake@endlessm.com> wrote:
> The Asus laptops X550VXK/FX502VD/FX502VE have a BIOS bug where the
> ECDT (correctly) states that EC events trigger GPE 0x23, but the
> DSDT _GPE method (incorrectly) says GPE 0x33.
>
> A cursory glance of the code suggests that this should work regardless
> (because it looks like Linux would treat the ECDT and DSDT as two separate
> ECs supported simultaneously), but in practice it is not working since the
> ECDT is ultimately ignored in favour of the DSDT EC. The sequence of
> events is:
>
> 1. acpi_ec_ecdt_probe() is called in early boot, and calls
>    acpi_config_boot_ec(is_ecdt=true) for the ECDT EC.
>
> acpi_config_boot_ec() sets boot_ec to this new EC, and
> boot_ec_is_ecdt = true.
>
> 2. Later, acpi_ec_dsdt_probe() is called and creates a new ec to represent
>    the DSDT EC. Then:
>     /*
>      * When the DSDT EC is available, always re-configure boot EC to
>      * have _REG evaluated. _REG can only be evaluated after the
>      * namespace initialization.
>      * At this point, the GPE is not fully initialized, so do not to
>      * handle the events.
>      */
>     ret = acpi_config_boot_ec(ec, ec->handle, false, false);
>
> So the DSDT EC is passed to acpi_config_boot_ec() which does:
>     /* Unset old boot EC */
>     if (boot_ec != ec)
>         acpi_ec_free(boot_ec);
>
> acpi_ec_free() sets boot_ec to NULL.
> Further down in acpi_config_boot_ec() we reach:
>
>     /* Set new boot EC */
>     if (!boot_ec) {
>         boot_ec = ec;
>         boot_ec_is_ecdt = is_ecdt;
>     }
>
> So now boot_ec points to the DSDT EC and boot_ec_is_ecdt is false.
>
> 3. Later, ecpi_ec_ecdt_start() is called and this looks like it would
>    enable GPEs on our ECDT, but it bails out because of:
>
>     if (!boot_ec_is_ecdt)
>         return -ENODEV;
>
>
> The comment I pasted above from acpi_ec_dsdt_probe() says that it is going
> to reconfigure the boot EC, but it instead calls acpi_config_boot_ec() on
> the newly probed DSDT EC. It seems like the code is not following the
> comment here.
>
> Adjusting that code to work with boot_ec adjusts the sequence of events so
> that both boot EC and DSDT are treated independently and as a result, we
> get EC interrupts firing correctly.
>
> This fixes media keys on the mentioned laptop models.
> Thanks to Chris Chiu for diagnosis.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Lv, can you have a look at this, please?

> ---
>  drivers/acpi/ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index c24235d8fb52..78395395e3d9 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1691,7 +1691,7 @@ int __init acpi_ec_dsdt_probe(void)
>          * At this point, the GPE is not fully initialized, so do not to
>          * handle the events.
>          */
> -       ret = acpi_config_boot_ec(ec, ec->handle, false, false);
> +       ret = acpi_config_boot_ec(boot_ec, boot_ec->handle, false, false);
>  error:
>         if (ret)
>                 acpi_ec_free(ec);
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
