Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073EFC77B7D
	for <linux-acpi@archiver.kernel.org>; Thu, 18 May 2023 18:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjERSTU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 18 May 2023 14:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERSTT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 14:19:19 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87CDE46
        for <linux-acpi@vger.kernel.org>; Thu, 18 May 2023 11:19:18 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9659dee48edso52903266b.0
        for <linux-acpi@vger.kernel.org>; Thu, 18 May 2023 11:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684433957; x=1687025957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zdcS9pStqK1h8VcMBqOoDwl6oyMyM8+DG//pzqY/T8=;
        b=ED44N9/P/f1H73qdV8OxkRBtSbYe556i4r1IPU0OebLTKrpDVEcqnaqHB3Rrw68oc4
         0F+erT0fKLWx4nOUs/ZRjrLbTiJ8LtnKeG/osP1lu/2wqd8wWdQT/t/KVc0LAifdvkLr
         yPjMuuklT2gPF/nYDu0WXa/8V8TAQ/S6okjK/O7XoCbgr4ZIpo9Ye4WBXBPNVE7Xn0IM
         1BD2VKqX8Xm/czkoVNd4muMaCNYXTgKkM0te8LJi9BaPu20lrQPo+mXhcb7911JJxoaY
         2Y2Du8De0bc8hpwXMo/+BQjGOa3pqOLf4SWwtyBltDhN9wwYLx0vzLNwlkWpx2kbC7/3
         tRdw==
X-Gm-Message-State: AC+VfDygehXmzHpP3oQpEhInN2tgVXlEtmJYDPp0HCX1Kh5uHq6w9yhV
        HubmT7te92xSLwJul9iURUsIitnlHgMXgw0qVvLLVr10
X-Google-Smtp-Source: ACHHUZ7t8Pigonj7gNAD2NeNZpPEZUNxQnRRyCRj+evCLRmFl+O2Rcimg6ai8ldJjI3o0lF/5phmD10hWI4giBWVGLc=
X-Received: by 2002:a17:906:748c:b0:965:9c7d:df96 with SMTP id
 e12-20020a170906748c00b009659c7ddf96mr2593ejl.1.1684433956922; Thu, 18 May
 2023 11:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230429163458.73479-1-hdegoede@redhat.com>
In-Reply-To: <20230429163458.73479-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 May 2023 20:19:05 +0200
Message-ID: <CAJZ5v0jR-P_VdRSasZo0vXrYzQtpzvRG0UWV_iTgPZGJ59G2-Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI / x86: Add ACPI_QUIRK_UART1_SKIP for Lenovo Yoga
 Book yb1-x90f/l
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 29, 2023 at 6:35 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Lenovo Yoga Book yb1-x90f/l 2-in-1 which ships with Android as
> Factory OS has (another) bug in its DSDT where the UART resource for
> the BTH0 ACPI device contains "\\_SB.PCIO.URT1" as path to the UART.
>
> Note that is with a letter 'O' instead of the number '0' which is wrong.
>
> This causes Linux to instantiate a standard /dev/ttyS? device for
> the UART instead of a /sys/bus/serial device, which in turn causes
> bluetooth to not work.
>
> Similar DSDT bugs have been encountered before and to work around those
> the acpi_quirk_skip_serdev_enumeration() helper exists.
>
> Previous devices had the broken resource pointing to the first UART, while
> the BT HCI was on the second UART, which ACPI_QUIRK_UART1_TTY_UART2_SKIP
> deals with. Add a new ACPI_QUIRK_UART1_SKIP quirk for skipping enumeration
> of UART1 instead for the Yoga Book case and add this quirk to the
> existing DMI quirk table entry for the yb1-x90f/l .
>
> This leaves the UART1 controller unbound allowing the x86-android-tablets
> module to manually instantiate a serdev for it fixing bluetooth.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 4cfee2da0675..c2b925f8cd4e 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -259,10 +259,11 @@ bool force_storage_d3(void)
>   * drivers/platform/x86/x86-android-tablets.c kernel module.
>   */
>  #define ACPI_QUIRK_SKIP_I2C_CLIENTS                            BIT(0)
> -#define ACPI_QUIRK_UART1_TTY_UART2_SKIP                                BIT(1)
> -#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY                    BIT(2)
> -#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY                     BIT(3)
> -#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS                    BIT(4)
> +#define ACPI_QUIRK_UART1_SKIP                                  BIT(1)
> +#define ACPI_QUIRK_UART1_TTY_UART2_SKIP                                BIT(2)
> +#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY                    BIT(3)
> +#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY                     BIT(4)
> +#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS                    BIT(5)
>
>  static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>         /*
> @@ -319,6 +320,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>                         DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
>                 },
>                 .driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> +                                       ACPI_QUIRK_UART1_SKIP |
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
>                                         ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
>         },
> @@ -449,6 +451,9 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
>         if (dmi_id)
>                 quirks = (unsigned long)dmi_id->driver_data;
>
> +       if ((quirks & ACPI_QUIRK_UART1_SKIP) && uid == 1)
> +               *skip = true;
> +
>         if (quirks & ACPI_QUIRK_UART1_TTY_UART2_SKIP) {
>                 if (uid == 1)
>                         return -ENODEV; /* Create tty cdev instead of serdev */
> --

Applied as 6.5 material, thanks!
