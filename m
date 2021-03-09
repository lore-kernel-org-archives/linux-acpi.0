Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E8FC433DB
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Mar 2021 15:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DBB65279
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Mar 2021 15:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhCIPp7 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhCIPpi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 10:45:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC6C06174A;
        Tue,  9 Mar 2021 07:45:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a8so256494plp.13;
        Tue, 09 Mar 2021 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8Qvh7vXz+RGh7AobfzttthYwnkmt26QhU7CX/4xu5A=;
        b=PcbFxprzkAed7mPNYBMmHkNCkwRsmLtn8oAF3k6djUATbCe3f7fnepkgPIc2VM8DCh
         AOJzK5YnwLFIDN1IZa++ljahy46pfkBbgWGvsIzjXn3ucswAAwN76JTo79/h8wc9buL6
         m+cGaaLIwtHSYDi+zaG7FnQ7GCe5QA5JyXBUGK8b2xcD49pfj7cSbVlLQUtruOVWvihN
         ZbHJkdxRpg8QS5GS0pYeKcCwq6iVBPEjmkGUqG/GeeDHgeFi1ANBrGsFL5TmI50+js5a
         ECRLJgPnJAkTSP/oJYoJhj3v46ugZf1tyRIn5cEoSz2fjYgDwdM00DpUdk1ccuw8tK7U
         lmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8Qvh7vXz+RGh7AobfzttthYwnkmt26QhU7CX/4xu5A=;
        b=gBfVj1OpCfkeDiYOoemelcR0Iz+SjcQVf32dAhir2ZrHYlxj3eZ1yHLv0Rs8f3SUnZ
         vW6Ipj/8CzpdBJ5scbiUcLvcMT9zvMw/Xz7dJQQqZmIT1scOUlmaAApsVc0oZyyF0MtV
         DYZmYwzOc7QdCvkfr8gf4sJiWrLmkQ5XFqk1V0NIsfMNLho6u7v0ZRu0KNmuGAS3Vwho
         v7Ehi4Z5LbGXwpurzF8dRqDG68uD8+p7THffhxqrc/1m5zspObM+VqzH5WBkOxzDgCC0
         dNM+H/9yLJ2D+7PxRlvpPtbNvs/shE3GClhjEg1TuYW+6iyZGWxxX8AEdGJreBD5wgJE
         HznA==
X-Gm-Message-State: AOAM5330iFSbgnEcygmUGbD59WJklYLjhcELKOwNO+aFf6fZpFBYoFMP
        0bsldYlUh8d1jAsOM/iLIK2q5soDHvMuzIx3Uyw=
X-Google-Smtp-Source: ABdhPJzSoFiL3P4ci/EMkimx4mXTxMANjodJaiyBmH7NqAnJdSfFqeiM07kbHj11SdjdwAJaXdKlLZtbVHybytXudD8=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr5487996pjx.181.1615304737103;
 Tue, 09 Mar 2021 07:45:37 -0800 (PST)
MIME-Version: 1.0
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com> <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
 <YEX72lTYIwxc0I8O@smile.fi.intel.com> <CAMRc=MeWppCHTc5G3wu3MMb0ZvncbaNJfOLU=WFFTbaw7EVnXQ@mail.gmail.com>
 <CACRpkdZF2x-mAs3p=d1gx-rfrSGQA4J5v+-6WHOjFwt=62De5w@mail.gmail.com>
 <CAMRc=MftNQMNA4riDBkGBo0A1nmO808mux0fWf_inLzy8jfPnA@mail.gmail.com> <CACRpkdYS-wN72EGAkVDx4DS4RFLSqt5n+tsBMAJgYCnFOboKjg@mail.gmail.com>
In-Reply-To: <CACRpkdYS-wN72EGAkVDx4DS4RFLSqt5n+tsBMAJgYCnFOboKjg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 17:45:20 +0200
Message-ID: <CAHp75VeGsXo9d+aUBMyh4y1xucW9KEpxvZbUUZ+8+kOrQE70DA@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 9, 2021 at 5:43 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Mar 9, 2021 at 4:36 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > Ah cr*p I did because of the v5.12-rc1 problem signalled by Linus Torvalds. :(
> >
> > And I already sent a PR to him too...
> >
> > Anything I can do now to fix that?
>
> Fix up the branch (just add your own Signed-off-by's) then send an updated
> pull request from the new signed hash. That's what I do :D

I think it's easier and actually preferable to save my tag.

This time it won't matter, but previously (when you, Linus, did that)
it broke my fast-forward capabilities.

So, it is a way to fix, but I say "not recommended"



-- 
With Best Regards,
Andy Shevchenko
