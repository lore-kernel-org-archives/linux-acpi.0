Return-Path: <SRS0=+ZpL=BY=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F0C433E1
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Aug 2020 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA4207DA
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Aug 2020 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597418255;
	bh=g3EMgMRl+jdpH60Qpiy97Zeb5fgWlnDAWDSvdxD+O0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hhsmWm/rr3PW9c6G2d62fEzuNsnq9WUMsiSnqwgaGpgOShseftcsBa1kgiung7ZX6
	 nfkow3P/PeROB0K2UGPMD/sUSfjnJb+tr74I0kgXmBCHtg3QHFBBCsM6Q39W5f2pPP
	 tWWNyypY3iHbnDNBTeSnZmMW2n5ohnZOb4GJ5jZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHNPRe (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:17:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41830 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHNPRd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2020 11:17:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id b22so8403500oic.8
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2020 08:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5QSUsn7AHtqsHxJkSa8oIGs23Urh8IXLhVGhEvPcIw=;
        b=XyvNLxEoa+DYEpC1zY+38oEwS8yk2NwccKzB2Q/xiIMQ5nhwjtwUHOo68lK40OPZG8
         XfLlfAB7K4pA+mhbBbUvoaBLvkEbT4Ejjk67/y/5FmgfSsT5Az7XHArYgTji7sBzq72W
         HDTyHSQ6bz3tK76Bx1LPQNddF/iEQ4dL8jTmEXtR8hcOK/QlJ0uf3Gh6r0p/of20r5n4
         AhCwGjGhi64XdgmufAaQe1O36uXc6k4h+6xVi97j4p0Dz1XKq8C41CMql+n1Kl0ckf8D
         XzmZybYv8HG3yZkpWXNyzT6w4tWt2E4dPcOoW6iHbznGZYyBStyhmLd8pb8TNLaYcPGH
         YxBg==
X-Gm-Message-State: AOAM530DxosSB+18VjCuxSHAW+jjpdfcZA+79erlZYjcSYjaGNbQW8W5
        JYLrbKqqmB4UssgikgbadGATnziJn3bfz/KOKbw=
X-Google-Smtp-Source: ABdhPJypDWjXczz3E+fot8wqoLJVWSlDBEJKpOZVvEYwAgtAx2rwgQSuIoPRueOkb+4varwoalV9cMjWvauAOrPIoZI=
X-Received: by 2002:aca:a88e:: with SMTP id r136mr1910309oie.110.1597418252901;
 Fri, 14 Aug 2020 08:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:17:22 +0200
Message-ID: <CAJZ5v0hF7CJYQJsvGbPCr+1Rfi_QqeMkT4z3MrGfmB00CdQvyA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] resource: Simplify region_intersects() by reducing conditionals
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Now we have for 'other' and 'type' variables
>
> other   type    return
>   0       0     REGION_DISJOINT
>   0       x     REGION_INTERSECTS
>   x       0     REGION_DISJOINT
>   x       x     REGION_MIXED
>
> Obviously it's easier to check 'type' for 0 first instead of
> currently checked 'other'.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/resource.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 841737bbda9e..70575a61bf20 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -554,13 +554,10 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>         }
>         read_unlock(&resource_lock);
>
> -       if (other == 0)
> -               return type ? REGION_INTERSECTS : REGION_DISJOINT;
> +       if (type == 0)
> +               return REGION_DISJOINT;
>
> -       if (type)
> -               return REGION_MIXED;
> -
> -       return REGION_DISJOINT;
> +       return (other == 0) ? REGION_INTERSECTS : REGION_MIXED;

The parens are not needed here.

Also I would do

if (other == 0)
       REGION_INTERSECTS;

return REGION_MIXED;

>  }
>  EXPORT_SYMBOL_GPL(region_intersects);
>
> --
> 2.28.0
>
