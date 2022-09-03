Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B092ECAAD4
	for <linux-acpi@archiver.kernel.org>; Sat,  3 Sep 2022 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiICSyt (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 3 Sep 2022 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiICSyt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 14:54:49 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251C9193CA;
        Sat,  3 Sep 2022 11:54:48 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 202so2881445ybe.13;
        Sat, 03 Sep 2022 11:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c2u8J3e6VWb+BJya6Kv1BbnFoz2femQjTxZJArvM/N0=;
        b=Tslxu42YP74NEGXdYVj4/VZGT3UKLtLi0kRDy7KiQn7RD5t9QXp6jgHIE6jn6PO+bp
         Z+mzXc0eirpYmRRTHJx2krTZpFzcLJ38v29yKolst1J2WPVlsJy9yPcjGU+rgUICoHqJ
         b65YjZau8yKsKU27yvquH2ZLkItSUaLGEi7b7GsulN37aCoEVtyroisCd1n4cjYqAdM+
         ukkl+iB2FN3Q6cE00L3QGWzj4I2zw1cb8SKBn2cz2A9HVUzTvlIS2ERnSx1a3QO8pfPy
         dk3JjXRMLrF8jxoC8Rada5jvevQyZDvW9jNs9rVnzWwhPSgRlwP7OcokhC1A0mbvgKeC
         lbuQ==
X-Gm-Message-State: ACgBeo1WMj8TFw3iFQlew2BgvZi66Qx0eZYqKWvd9A0yyaOIuKh1cB6J
        PM5OJkaXboDLyclEymL/KLolvok8012hqu+XlnbYPxMz
X-Google-Smtp-Source: AA6agR56QRT8XFU2RNWpZ9enfUA6I+xPDm5x89hd8la9xofTrximH4goCU+VQBtVboB5wh3qaLrNJ9jKuptajTYrG58=
X-Received: by 2002:a25:2785:0:b0:69b:b1d2:fd05 with SMTP id
 n127-20020a252785000000b0069bb1d2fd05mr23048084ybn.81.1662231287387; Sat, 03
 Sep 2022 11:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:54:36 +0200
Message-ID: <CAJZ5v0jRPmq--RRNHLNR+b+MfrefXexBdTXEuZitg0-VbB6omA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPI: platform: Get rid of redundant 'else'
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 31, 2022 at 4:03 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In the snippets like the following
>
>         if (...)
>                 return / goto / break / continue ...;
>         else
>                 ...
>
> the 'else' is redundant. Get rid of it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>  drivers/acpi/acpi_platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 1a1c78b23fba..75e26528056d 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -114,9 +114,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>
>         INIT_LIST_HEAD(&resource_list);
>         count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> -       if (count < 0) {
> +       if (count < 0)
>                 return NULL;
> -       } else if (count > 0) {
> +       if (count > 0) {
>                 resources = kcalloc(count, sizeof(struct resource),
>                                     GFP_KERNEL);
>                 if (!resources) {
> --

Whole series applied as 6.1 material, thanks!
