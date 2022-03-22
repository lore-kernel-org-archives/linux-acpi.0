Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77906C433F5
	for <linux-acpi@archiver.kernel.org>; Tue, 22 Mar 2022 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbiCVRzZ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbiCVRzZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 13:55:25 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C122BF64;
        Tue, 22 Mar 2022 10:53:56 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id k25so21023258iok.8;
        Tue, 22 Mar 2022 10:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2A9hIX+HQzPzacEyBKyVneC9YjFuPVHNWbb21zj8QU=;
        b=G/DRqWnO9oBa0v0mWBmqqXKQ5SNJsSqPyhH0BoBDRvJyp4+xHHEz+jMWcTTVFfAgXY
         d/tp4ZhvPzQ37rac+aBMQA2ZqASTpGBg4sPyRKH1a+rQOJ7Ttvz0L2aktpuHnUCQPbKf
         gWf0I5jtylNmEIwDvIrfk6+zBceNm5BS4veR5QzOKLIcO1/iSX6/42DrEPbyuv3q/f2T
         b81jM52Dt1THbZO/4r/mLzaOgmN7MzyIniKCoSWgrjh4tLRXANpbZYsUEzGEx0u2Kamq
         oGlPIahZCYWEeA1IU1SlWigcGtVJQCgI/eCLETEqN04pTJU5Ck4g2w1hjInLmpRS5cC6
         +vZw==
X-Gm-Message-State: AOAM530KFAVOAu47W35AkkG/ruMC+Fh+yyB5PLrzUnwql4EIVafn9aFK
        X23Kukrdcuj0AJpEEYV8gTWW+09vEUnF9PMXPnQ=
X-Google-Smtp-Source: ABdhPJybQ9Fg8kVP1Ef/Uke9w08AyhnVuzLoJLnuIy27SVBKgSVsDfe9yCvTgOOjjxApYyfs7pQj6d/+xpbswqqZdTU=
X-Received: by 2002:a05:6602:2a4e:b0:648:b557:e84b with SMTP id
 k14-20020a0566022a4e00b00648b557e84bmr12893660iov.91.1647971636300; Tue, 22
 Mar 2022 10:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220319215447.2625681-1-jakobkoschel@gmail.com>
In-Reply-To: <20220319215447.2625681-1-jakobkoschel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Mar 2022 18:53:22 +0100
Message-ID: <CAJZ5v0iRvaRyWEZqBxgx5juXUc6Oec5tsiiXfFPd_JGBMKVvJQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI, APEI: fix using the correct variable for sizeof()
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Mar 19, 2022 at 10:55 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> While the original code is valid, it is not the obvious choice for the
> sizeof() call and in preparation to limit the scope of the list iterator
> variable the sizeof should be changed to the size of the variable
> being allocated.
>
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/acpi/apei/apei-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index c7fdb12c3310..33b7fbbeda82 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -319,7 +319,7 @@ static int apei_res_add(struct list_head *res_list,
>         if (res_ins)
>                 list_add(&res_ins->list, res_list);
>         else {
> -               res_ins = kmalloc(sizeof(*res), GFP_KERNEL);
> +               res_ins = kmalloc(sizeof(*res_ins), GFP_KERNEL);
>                 if (!res_ins)
>                         return -ENOMEM;
>                 res_ins->start = start;
>
> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
> --

Applied as 5.18-rc material, thanks!
