Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64528EB64D8
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Jun 2023 15:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjFVP5S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 22 Jun 2023 11:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFVP5R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 11:57:17 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88731BC
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2023 08:57:16 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-98273ae42d0so216794266b.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2023 08:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687449435; x=1690041435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SawjbF/DUwS0Hnb8ZHXe+MqP5qAl/C7Byfeep7sU8xA=;
        b=ePwyZe/L70GZDYXzsKWVxhvcE7j2qZ4E8j/0Qq+iPUanvj2RsQJciu3VeDSrx3gbkn
         IUlOCbEIyfFtOv21hr2fdbSvUO/j81DFLEwfrzpoqXQPtS5BBxJ6gR0dBYjjiQ/A1dOF
         YxLMeZsBCrkFFCzjN2HfU4kmxD+48i+IQ56yvQafPqBQjWRnmtX6CV+JAbRZVxjLXigo
         Uhm3LtKyS2QoZA/wBwvbMp+pbzZgd9Sn8D0HCyMQQWpKFaDvpM4gA38vUf1J05YBzNWO
         SXUoOlUZTbQRy93wqDierGNDY09Ou5wWLEThnDy7XVc0nYiFlC5rw05NZXaOCKfgbwZu
         VT/Q==
X-Gm-Message-State: AC+VfDx2M4xU9SWJUgvwFKnwReElUKlvfL3Q5tBmtJo5m7WYSdrCpszy
        VqxYf9yV8jEmDUvAcOiBES1PMWDrkdv4IzNCg/0=
X-Google-Smtp-Source: ACHHUZ7cg7txG6KhSHSF+6B323mh0K8yE+JUmI08xMLNr2ipUhcdAuInc1venT4rHnntVZDta+8vgTYj05GnC9G/EcA=
X-Received: by 2002:a17:906:5198:b0:987:6960:36c8 with SMTP id
 y24-20020a170906519800b00987696036c8mr12147298ejk.7.1687449434781; Thu, 22
 Jun 2023 08:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230620184504.12451-1-hdegoede@redhat.com>
In-Reply-To: <20230620184504.12451-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Jun 2023 17:57:03 +0200
Message-ID: <CAJZ5v0hxU2zM-iqy6ocRx02ikS16n7nZvD+1EjB_XZ2E5=gwUQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell
 Studio 1569
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        raycekarneal <raycekarneal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 20, 2023 at 8:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Dell Studio 1569 predates Windows 8, so it defaults to using
> acpi_video# for backlight control, but this is non functional on
> this model.
>
> Add a DMI quirk to use the native intel_backlight interface which
> does work properly.
>
> Reported-by: raycekarneal <raycekarneal@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index eb014c0eba42..18cc08c858cf 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -528,6 +528,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
>                 },
>         },
> +       {
> +        .callback = video_detect_force_native,
> +        /* Dell Studio 1569 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1569"),
> +               },
> +       },
>         {
>          .callback = video_detect_force_native,
>          /* Acer Aspire 3830TG */
> --

Applied as 6.5 material, thanks!
