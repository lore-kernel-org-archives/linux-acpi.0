Return-Path: <SRS0=PXo4=CQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBC3C2D0A8
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7362080A
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vXqecv/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgIGRvY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgIGMGk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 08:06:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEDCC061755
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 05:06:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so17908118eja.5
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tw4f2wX8YqmmfCG4fLEsa1aDy9xcwa2clW6NhysDtyc=;
        b=vXqecv/JD1j08x2l2xv8uMY2f5Yrx4K3HukAwUizDgeJSij+T75ajGmL1q9blQ9UrJ
         qCvwj8FsbXkYLIOkfpnIyoCMd0YWDwu7jzDwuPBz5d/I0pvFV2rv2MaIlzwpB+L6BBvL
         KLuAAE/uYoT21Qcb0Ek9uNjNv+Tc1kJZB6gBNZEqfR4K8F3owTI8UDBaBNdeerEXBRQf
         svknQedIT00FvncGNd3SMt5eJGRvr9n1qI1k7jYBXFJTuIChik7GAJQR8GK7RuqOeYDV
         6OpI9z0F1CVv5xPg/cyAf/YafdgiGJcwRMOp33wT+hcztaMEzFbH2LHAvgY5FPcU8BxK
         qNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tw4f2wX8YqmmfCG4fLEsa1aDy9xcwa2clW6NhysDtyc=;
        b=FDh657n+UoPBW45Wvixfcx4Nh697E1zhWOa050nLUle7KkFgjiwPiga5VTpIv0xvda
         +Cgz1tXazkiQbcgonBljQbZftf/mZI3pCRhoRSklPo4eJwWaJWqgbdRWfh5OVctQYZts
         f4KTyT3WkKi7iH3A7IZ7PgDQhkq1lDCzt14eieK2Me9oU6qV1kPlotb9QBRNPEsEQfIZ
         SCvH09wZVwV4jFZzQ0Y/b6SXbEU8dPx08qPUPub3esvq1KakYg2rboPwzNdKqjbkxT3I
         dsvDNCKZ5C8+Xvi/Tp3topEq/XEjSU3BZTDO7whAm2rtIDpne1I1oBwGw04SMkcoIkuw
         0U3A==
X-Gm-Message-State: AOAM533+Qq3qYRvzvn/RtQQVGYTOrnVvSaFUehjKJAlRLInTW0gmF8jY
        Dd0qWEOF+JB60SNMMBZIQgIarEdx6q59zzTpXCl8dw==
X-Google-Smtp-Source: ABdhPJw+GbBoK76Yk9oXUxiHnhTP8BrVOQx6dDXADdyKLjOSvFHDs9IyPG0ZhERjAUhRxXRKmTxwpbMibpY7sdicuFI=
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr2135074eji.88.1599480386425;
 Mon, 07 Sep 2020 05:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org> <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com> <20200907115310.GA1891694@smile.fi.intel.com>
In-Reply-To: <20200907115310.GA1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 14:06:15 +0200
Message-ID: <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 7, 2020 at 1:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> > >
> > > ...
> > >
> > > > > +GPIO Testing Driver
> > > > > +===================
> > > > > +
> > > > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > > > +by the module. The lines can be accessed using the standard GPIO character
> > > > > +device interface as well as manipulated using the dedicated debugfs directory
> > > > > +structure.
> > > >
> > > > Could configfs be used for this instead of debugfs?
> > > > debugfs is ad hoc.
> > >
> > > Actually sounds like a good idea.
> > >
> >
> > Well, then we can go on and write an entirely new mockup driver
> > (ditching module params and dropping any backwards compatibility)
> > because we're already using debugfs for line values.
> >
> > How would we pass the device properties to configfs created GPIO chips
> > anyway? Devices seem to only be created using mkdir. Am I missing
> > something?
>
> Same way how USB composite works, no?
>

OK, so create a new chip directory in configfs, configure it using
some defined configfs attributes and then finally instantiate it from
sysfs?

Makes sense and is probably the right way to go. Now the question is:
is it fine to just entirely remove the previous gpio-mockup? Should we
keep some backwards compatibility? Should we introduce an entirely new
module and have a transition period before removing previous
gpio-mockup?

Also: this is a testing module so to me debugfs is just fine. Is
configfs considered stable ABI like sysfs?

Bart
