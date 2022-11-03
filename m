Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DEC4332F
	for <linux-acpi@archiver.kernel.org>; Thu,  3 Nov 2022 18:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiKCSn7 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 3 Nov 2022 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKCSn5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2022 14:43:57 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5669FEF;
        Thu,  3 Nov 2022 11:43:56 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id cg5so1780214qtb.12;
        Thu, 03 Nov 2022 11:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXI/xKCKGC5kxj9+tkw9pFSKrL0xw7nU2EjZVTKszx4=;
        b=vYbsrkcnyFOFdvuN7zPeRqL9O1MhHTDOkPKvet14A63+xSgdAwtOne3T9v9zVOIUNn
         JZx0YtRzl/7kRTQwxWpCayio8UW53dQOBe8/wYQE1pcsB9QPuduHXaxbZgwVjf+CoZcm
         LypCrgIX0C0geyZm6/7VDzObYDhjpcbJR2dTOQ+e78neyWuVlGE5PU9rK9jWvej7QSEX
         wZ5TC9vFtVQi+QV/86ZYkLlKApQfNwKF7TWWAMTv5amjDSWr/pNobLfsXH8pL23BAq/o
         /EhT+8y39AZiepFcoZ+yYt1Co+nmgncF7HUWsZpKmV/Ly9lJymIS/9UXj4kyzWR6cQoO
         jpKA==
X-Gm-Message-State: ACrzQf3GY+y82al/K47DZoE4vug4h0wYRf+t32oXZgGoC+p/22oFObN1
        z0fsjKzShHAT9fyVqgBC91OsiUBI40CUVMxh0GILTK+3
X-Google-Smtp-Source: AMsMyM7lE0rPz4rvK4p4ShxvDCRY5rqOe6G3LC7CZHJxN3SeVFBdZ2G2SB1he41nqCUj21KS0hyRcDIRly4Vi/eNnRo=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr26100061qtb.147.1667501035443; Thu, 03
 Nov 2022 11:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221029222008.32793-1-chad@redpilled.dev>
In-Reply-To: <20221029222008.32793-1-chad@redpilled.dev>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:43:44 +0100
Message-ID: <CAJZ5v0hkSvZjEKLC+7RY2yz_Ldfq+83Jz2mATneKubN6GAX3gg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-cx0041ur
To:     Mia Kanashi <chad@redpilled.dev>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 30, 2022 at 12:20 AM Mia Kanashi <chad@redpilled.dev> wrote:
>
> Added GPE quirk entry for the HP Pavilion Gaming 15-cx0041ur.
> There is a quirk entry for the 15-cx0xxx laptops, but this one has
> different DMI_PRODUCT_NAME.
>
> Notably backlight keys and other ACPI events now function correctly.
>
> Signed-off-by: Mia Kanashi <chad@redpilled.dev>
> ---
>  drivers/acpi/ec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 9b42628cf21b..9751b84c1b22 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1875,6 +1875,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-cx0xxx"),
>                 },
>         },
> +       {
> +               /*
> +                * HP Pavilion Gaming Laptop 15-cx0041ur
> +                */
> +               .callback = ec_honor_dsdt_gpe,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP 15-cx0041ur"),
> +               },
> +       },
>         {
>                 /*
>                  * Samsung hardware
> --

Applied as 6.2 material, thanks!
