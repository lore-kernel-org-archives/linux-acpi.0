Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F06ECAAD4
	for <linux-acpi@archiver.kernel.org>; Sat,  3 Sep 2022 18:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiICS4w (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 3 Sep 2022 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiICS4v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 14:56:51 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124253039;
        Sat,  3 Sep 2022 11:56:50 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-344fc86d87cso27557807b3.3;
        Sat, 03 Sep 2022 11:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=k3aPelvksG7Dd9zWdqlGhSnmSXk+Wnv0ZCgCIZwJ+f0=;
        b=vhhAQ9FNyO4opvCLoP2haEVN56bifwAxFQgNNv1XUWINxmSN8IoEu33k+R4oE4fwtx
         2HjzNNyI5yEu+WJf4GkMjFv2LV1tPAxfnCbnmbBo5CKMxwY4tq6CVVG8WNL/ZrXVs2se
         iVBTHbEI8dxdcXELqoxlTlxWEqc4fRt3s4gMedrpj75GhvONaC/BxNW0kWBSUbW+kam/
         UiLBlH4imqwCi8338UzOuUCQZuHmlab7ILc8BYBoHV8iepmdHiR072L2te/Wtp90nT2F
         IIf2/j0e8J3VoVjQ0o2nc0YakfRI+zqDGPFi7hdkmLyksRBHl0UpjkAyzctrBpPznWRU
         iJgw==
X-Gm-Message-State: ACgBeo2uMkwbiG8tjPhMo/oK2gu/poKU3wcb1tHo4U70ViRaa3BC1Z+z
        a+mMElIktMea5K/QR1OCTizStuci2SBXj8DBBD3//mS5
X-Google-Smtp-Source: AA6agR4fzkDRBM1gRJdHewWs2rje07jCubxT/0t6gpASp2fSRyJV5ktEkaoescdv4MhszJip0HF4fGPOuFv+A9IcRvE=
X-Received: by 2002:a0d:da83:0:b0:329:9c04:fe6d with SMTP id
 c125-20020a0dda83000000b003299c04fe6dmr32687635ywe.196.1662231409261; Sat, 03
 Sep 2022 11:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <1662026651-172787-1-git-send-email-john.garry@huawei.com> <CAHp75VdObOKv0aamL3+d8A7f3Asxj0SnOXtV5TYAUDAC_s3Mpg@mail.gmail.com>
In-Reply-To: <CAHp75VdObOKv0aamL3+d8A7f3Asxj0SnOXtV5TYAUDAC_s3Mpg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:56:37 +0200
Message-ID: <CAJZ5v0haL5qM+_k-vR8oSLHCytKTHhAVdqQru+fqL6RFBAAasw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform: Use PLATFORM_DEVID_NONE in acpi_create_platform_device()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 1, 2022 at 12:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Sep 1, 2022 at 1:10 PM John Garry <john.garry@huawei.com> wrote:
> >
> > Instead of hardcoding the value for the id, use PLATFORM_DEVID_NONE.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Signed-off-by: John Garry <john.garry@huawei.com>
> >
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> > index de3cbf152dee..d33334c9b8e5 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -140,7 +140,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
> >         pdevinfo.parent = adev->parent ?
> >                 acpi_get_first_physical_node(adev->parent) : NULL;
> >         pdevinfo.name = dev_name(&adev->dev);
> > -       pdevinfo.id = -1;
> > +       pdevinfo.id = PLATFORM_DEVID_NONE;
> >         pdevinfo.res = resources;
> >         pdevinfo.num_res = count;
> >         pdevinfo.fwnode = acpi_fwnode_handle(adev);
> > --

Applied as 6.1 material, thanks!
