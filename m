Return-Path: <SRS0=283r=7O=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A3C433E0
	for <linux-acpi@archiver.kernel.org>; Mon,  1 Jun 2020 23:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD03207D5
	for <linux-acpi@archiver.kernel.org>; Mon,  1 Jun 2020 23:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JP+Lp/jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgFAXsn (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgFAXsm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jun 2020 19:48:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB7C03E96F
        for <linux-acpi@vger.kernel.org>; Mon,  1 Jun 2020 16:48:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so574123plt.5
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jun 2020 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNBmHiSKwvMr5X38foIQI0sKfyxQ431ExlrJTn0/i7Y=;
        b=JP+Lp/jNYkdXX/HqPZKX2SgK5X0i+zDFGOg2ww7dtjG0sp6+PGSQ9bK3jx7AAwgHgJ
         o4FT4hVdzYCxXc0WH1nFHjqoOyqVRS88r7xLjnMssWgONz5eA+xjJ69RP6XO0zAq2X7M
         XJ3HbDqOKrcI58B5+9jcBtMDajE5h35bKOQBKIVMzttYj+uUId6KcRVn55gYO9ZYTHIJ
         90CfC5AreAzmnRK53W2uiqONvL5NPR53F8EQR6ykK0w6XL51XbB86M2HVM8mWb/FGgEn
         JR5eXLsDjabEHuSKeT8o+NWzFLtsVkkP2y157PXkg56HkTU0VZ0WhUg8vG3zI/f55YC8
         01Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNBmHiSKwvMr5X38foIQI0sKfyxQ431ExlrJTn0/i7Y=;
        b=pA6FfGWxNNM3v2zcdpddFRUAYMCi94WcqtYHSxucRsx6YqB99jNMZrhk0vGEo1hgB2
         E42f+RJuoXy63XXBow9XLgfDMPqM/r7yN3RTM3zy1a2cN0gH7QvbDdJqltTS34pdzRaY
         kzYZQrOxdCjEHAsin8IcR4vNhZWwbzEibiHvb7+DkVOe6sv0VBbLWwRIGT+ydDAHXvCg
         e5a2thjCU/xhZ8efxeIExe5O1SPVBdMSltwzK8JdVZRG4UCgHLsqdyx87XKAcIUr0Qlq
         ORhlOhR+/0aTCth/nQSnwrC0zUu1STl/twmSyJL6xEKLGj/gkrC2N5abOpdNil8WZSLG
         VgXw==
X-Gm-Message-State: AOAM530x7xGyQhs/RGB32hCcodf2mzvKQZeGu57lhZSjEbwpvWcc5ki8
        VkJCLbNXu7aAL0C6wOqHK2Iodfc4HyDHJ/xW5qkJGQ==
X-Google-Smtp-Source: ABdhPJzPdil5JHB2JFiBUPImTahZQgK7CsLdhBg5zRviWYOCKk53kYc+N0bKVKMXxkL7FCDBIFnYLwHPPms3V0bgy48=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr22127472pll.223.1591055321894;
 Mon, 01 Jun 2020 16:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
 <20200601231805.207441-1-ndesaulniers@google.com> <CAMn1gO7MrbgpEzaAYZ3vNnbWPdSsHhMkDNXq9rZajur+sqtBsw@mail.gmail.com>
In-Reply-To: <CAMn1gO7MrbgpEzaAYZ3vNnbWPdSsHhMkDNXq9rZajur+sqtBsw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 16:48:29 -0700
Message-ID: <CAKwvOd=BgiaiWWkHX=Z4OX927KNGu1CTnvVkhKRJ=vRTQKbu8Q@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
To:     Peter Collingbourne <pcc@google.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will@kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 1, 2020 at 4:37 PM Peter Collingbourne <pcc@google.com> wrote:
>
> On Mon, Jun 1, 2020 at 4:18 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Will reported UBSAN warnings:
> > UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
> > UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
> >
> > Looks like the emulated offsetof macro ACPI_OFFSET is causing these. We
> > can avoid this by using the compiler builtin, __builtin_offsetof.
>
> Would it be better to s/ACPI_OFFSET/offsetof/g the existing users of
> this macro and remove it? It looks like offsetof is already being used
> pervasively in the kernel, and its definition comes from
> <linux/stddef.h>.

I count only 9 uses in the tree, so not too bad a yak shave. Good
idea; I'll send tomorrow short of any other feedback.  I still think
we want the builtin, since we don't want to include stddef.h in the
kernel, I think.
-- 
Thanks,
~Nick Desaulniers
