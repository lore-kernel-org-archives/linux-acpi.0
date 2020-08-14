Return-Path: <SRS0=+ZpL=BY=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9A9C433E1
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD6320885
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597418326;
	bh=bHOTY1E8dATHJp1lj0tnX99t1aKMJrPOH/kzyqQm4mA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i6AUboy2MjJSyjEhZd5WN+a/7Efjz9M/q5VvoFUeP1LZXhsKlUD7VqtGjvuREV9fT
	 sM26ezw+zEG6SzgEOwLJ9UEl8BQcilVTQYyBXsmejl29MXbSlxceoull6U870wIgLY
	 wodUpyoGHmgXlzjldpHfgYpB0JMjF3T9cZm1KMgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgHNPSp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:18:45 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41596 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHNPSp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2020 11:18:45 -0400
Received: by mail-oo1-f66.google.com with SMTP id x6so1975001ooe.8
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2020 08:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUjdMZtIuiYbXdJE74Geizg/VhO0MCDx7FPHghZ5oEc=;
        b=OT2ym1odC8ln+YYbyFAc5JkIMw2sAjpMrAbppYhKIP18ZCVgPXVwFE1YuFW6ICPEOJ
         HbRQu8SS1NcT9lFcarndZnJdJW03U4WMBf7t/ltYmzMchrl96Xaku38FfGk83+uwHr/z
         bhfV3Wsxh9FZJege82YjFBzcv3rQqmzUp714/N8Ze37pRq7h/+HeiYLsbeKPjEPnqwaF
         Kxt5tQPJsjKKkxewXx/kqLtlpQj7Kf2/Vn2L3CfbviRYBeEjgB7KqmKJR2vf9uCAKHLS
         efKtnNNLqQ9dLBhJbFQyquS9lGJEufhlgQQqrx0c3RithphEekLyiy0IztI9JN0OUmb8
         xdVg==
X-Gm-Message-State: AOAM532PGWOTr0kI3/L6IMj/yAvyuVnxptm8Wq/lbeFZC3qyvKNuhgS0
        MEAk+8wozFRWZHSsJ9vWdLINSla7m4Uh6yhJpQ0rDuZD
X-Google-Smtp-Source: ABdhPJz8Cj6Y2podbfsBjn6T//GrwYF0wmBYmDs1suBLjjYSfXRYkJ68c/r3Wph5S0FKFaFFXSUwqJ5gfRKDqE2do9g=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr2043238ooj.1.1597418324737;
 Fri, 14 Aug 2020 08:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com> <20200813175729.15088-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200813175729.15088-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:18:33 +0200
Message-ID: <CAJZ5v0gsE6fwdkZdmgucUD7mt=BWDh-C8LagDSCTm8Awz-ddfw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] resource: Group resource_overlaps() with other
 inline helpers
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
> For better maintenance group resource_overlaps() with other inline helpers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/ioport.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6c2b06fe8beb..0193987b9968 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -226,6 +226,11 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
>         return r1->start <= r2->start && r1->end >= r2->end;
>  }
>
> +/* True if any part of r1 overlaps r2 */
> +static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
> +{
> +       return (r1->start <= r2->end && r1->end >= r2->start);

The redundant parens can be dropped while at it.

> +}
>
>  /* Convenience shorthand with allocation */
>  #define request_region(start,n,name)           __request_region(&ioport_resource, (start), (n), (name), 0)
> @@ -291,12 +296,6 @@ extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>                     void *arg, int (*func)(struct resource *, void *));
>
> -/* True if any part of r1 overlaps r2 */
> -static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
> -{
> -       return (r1->start <= r2->end && r1->end >= r2->start);
> -}
> -
>  struct resource *devm_request_free_mem_region(struct device *dev,
>                 struct resource *base, unsigned long size);
>  struct resource *request_free_mem_region(struct resource *base,
> --
> 2.28.0
>
