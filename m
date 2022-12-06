Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033BAC4708C
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Dec 2022 14:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiLFOtA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 6 Dec 2022 09:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiLFOs6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 09:48:58 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0656225289
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 06:48:05 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3c21d6e2f3aso153843067b3.10
        for <linux-acpi@vger.kernel.org>; Tue, 06 Dec 2022 06:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qAOa1VhlRWQEWutYVn7vsc8dfFCMbpsWAMAMKpfYJbc=;
        b=iAQthZPcPJ5luFrqpYx+Hvc4oHP8Ccb4UYtmP0xE+RPeft+3SA0p4DC6T0FzLpemL2
         OErbcqBm3jSUWcVaV4ng/cZcErre30SLODycpD4+V6p/uE1/8bCA7174JQn8PQ+2TANI
         98JRA9Ehie8pPmpahFZJtVMjzXb5X7KZcB59LEHTMZSFfNaMSJWDdJuhWIglmtfMEZ6x
         z+YUx6VImUd0rHWlYQdkTxlfSmk/Xewjbm/IXYYXjGBtO5XLew7NXCcF/icLxcDMjkG6
         ggtLh71tcx1qsoVTK3d/SGdsz2jVRir0hRxiu2PZDDTBcAolekBuLf11tjjUx6AJn2nx
         i8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAOa1VhlRWQEWutYVn7vsc8dfFCMbpsWAMAMKpfYJbc=;
        b=O2oF+hYuwFajxWv63auH6ZN2s4CCiOW//mcEPy0sWFOZvK3HY9dKmXdXo0bZzal9/z
         QdW7/FUn0bjcAWQX4tj6vco4veuJViMqFXVKPWk6pEDsrXDDax1aJuPwQGRYFJmLOh+/
         o8eJJiP50QE0pDkhNPLjtElQ/W/jAmS7n8X7g1vImxCY0fb0u4NRcxrxatOVU288u2Ow
         VHSehsWIYMUtpNe5erMp0a0rQyKnRF9RTUcx3SzMFeAyj2NpHa0vtprVv2vCnkd5JA1O
         zf4rm5fk1/FSAbpkFGtQ2aIfbWg5Nl0sYDkzz+NEOHkUStWuB/sAn+/I7P32b/OGTWZa
         +f6g==
X-Gm-Message-State: ANoB5plYpK8So3gBJN5fCnMGkuNDX9QFGNC/ww2wUKHlJqruH2+9flPC
        Yqe97gMPz21DLTSJ9C4mHcocK37hNnxup9vlbBgcPA==
X-Google-Smtp-Source: AA0mqf4b9tOLZLYYojLjivmAujfjzfHVMh/sYYeoG+Kpfejl5KHbHnNiGiv5U2z1dPMfEMZ2g09GHiB1kUUyrfb4Ln8=
X-Received: by 2002:a0d:e645:0:b0:3bb:6406:3df1 with SMTP id
 p66-20020a0de645000000b003bb64063df1mr47726538ywe.319.1670338084259; Tue, 06
 Dec 2022 06:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20211015164809.22009-1-asmaa@nvidia.com> <20211015164809.22009-2-asmaa@nvidia.com>
 <CACRpkdbvR0+5gKUH7eE2tZ1H9DR-WiYyh9KSnUTesYiZ=AezNw@mail.gmail.com> <CAHp75VfaoS4yu0UOJj4V2N+4tWdD0JF47TFgfKCGt7SC-Uhfaw@mail.gmail.com>
In-Reply-To: <CAHp75VfaoS4yu0UOJj4V2N+4tWdD0JF47TFgfKCGt7SC-Uhfaw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Dec 2022 15:47:52 +0100
Message-ID: <CACRpkdYqrdT4K8wZGkjo=+zbtQ9R7GvdOLzEeHQUx=Xr54en6Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] gpio: mlxbf2: Introduce IRQ support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
        bgolaszewski@baylibre.com, davem@davemloft.net, rjw@rjwysocki.net,
        davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 3, 2022 at 1:36 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Dec 3, 2022 at 12:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Oct 15, 2021 at 6:48 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
> >
> > > Introduce standard IRQ handling in the gpio-mlxbf2.c
> > > driver.
> > >
> > > Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> >
> > Looks good to me!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> It was more than a year ago :-)

:D

Searched my inbox in some weird way.


Yours,
Linus Walleij
