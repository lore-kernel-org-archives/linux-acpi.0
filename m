Return-Path: <SRS0=A6Sl=S4=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580A3C43219
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Apr 2019 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246D1208CB
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Apr 2019 17:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftY3v4mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfDZRdl (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:33:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46120 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZRdk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Apr 2019 13:33:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1923368pgg.13
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2019 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sm+6PV4qO4p3LMjzPSC4UvyriaxOjRBgjPP0hAT2ZFY=;
        b=ftY3v4mbU2gilH9hxC/R1Ti+xcNKo+fPZWt9wNLIc5HMQfJBzl5s4Qjesgm/vjiJ6f
         JAdHADTAB+BqIJFjD908ybVDA1O8fvoz2hYen4s2gAiEdX4mBEmukzhs1VqOOkN7/irD
         YiDmUPUofIdHhKF3UCKu1vJ2hbUC8oSkn/qUfCHh+pSqCVFvprfsHTINFh2nSRyzw2Pt
         MHkWb/qosVNJ57CTKSyzJWQnS2VMQPZLtpRUDu1zhtSjn6V5YWGFHbKqfyHCsHO+pU55
         4UbnPJmlHX5lv4dNMN+S+20kztWt3ylOubCS56TCyM2WXl7b0fGHWk5fBDet6N1AQK7z
         g+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sm+6PV4qO4p3LMjzPSC4UvyriaxOjRBgjPP0hAT2ZFY=;
        b=sWjRxXgx/3XL/esMydU8PSMv714ZggIIsQaH7954jFGy99nq7vNbfTZ8tZDbcjp60J
         EtirW6kT6FKibb+XSnZBdn46C+LI6+vnYkXer3GHAaoNocf4u9JLo5aorPKF/TrieRZR
         698p5yJcyYd5EZZYWAi1uYecgOlvSRR6uBjhwFBVn4YDXXhSDFWUxA2dE9etRPDA4Gcz
         UL5ZMMxsUTzJL3R/1VZIBZCwro/7VhAxlUibLoemMPvcMOtDkd3sBx+SGUZFdWhfMQKr
         LgltQ8HZ/DCpUDCpolAxWnCNeHWhKIpds6/clc0yyTQZM4AUVEWq7yoo19+Kpr+RpLF6
         rvWA==
X-Gm-Message-State: APjAAAX80UkSAAq80c8Abtj4p2xX4+zwG0kIFA4D32Ui/nAMgdtEazBK
        TgSqhfbqMtQqGPVmUDKwup8H
X-Google-Smtp-Source: APXvYqxPcyf6OP99og9HLvzrsh/muKUGo4qFDMQAmGJkcY4zBk9DKKw7GbfeB4ugdsM03MQuhKVZww==
X-Received: by 2002:a65:6688:: with SMTP id b8mr22690428pgw.81.1556300019817;
        Fri, 26 Apr 2019 10:33:39 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72c4:4b94:e0ad:83b0:3987:aa05])
        by smtp.gmail.com with ESMTPSA id b2sm7006416pff.63.2019.04.26.10.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:33:38 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:03:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190426173329.GA31161@Mani-XPS-13-9360>
References: <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
 <2f3da791-4a10-c2c4-dc5a-22ad16ed7be6@siemens.com>
 <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VfonL_f1GjRFFhp59R8U+bGzT9pcC7p8XDJ32-_cxT29g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190426173329.O2ZApuyYX-J5l4Z_MP3XYIFmhsMj3iXAPD5awKPthnE@z>

On Fri, Apr 26, 2019 at 08:20:19PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 26, 2019 at 7:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 26.04.19 16:42, Enrico Weigelt, metux IT consult wrote:
> > > On 26.04.19 15:36, Jan Kiszka wrote:
> > >
> > >> At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
> > > switch> the engine.
> > > Which value exactly does that collection of crude wrappers and broken
> > > attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
> > > provide ?
> >
> > Leaving that blunt hack aside:
> >
> > import mraa
> >
> > pin = mraa.Gpio(13)
> > pin.dir(mraa.DIR_OUT)
> > pin.write(1)
> >
> > And the same goes for nodejs, java and c++.
> >
> > Moreover, this allows you to abstract away where "Pin 13" actually came from on
> > that board if the kernel changes (BSP -> upstream...) or the extension board or
> > ...
> 
> The problem here is opaque number. This has to be chip + *relative* pin number/
> See this:
> https://stackoverflow.com/questions/55532410/how-do-linux-gpio-numbers-get-their-values/55579640#55579640
> 

But for platform like 96Boards we don't need controller specific lookup, these
are all handled by the platform code [1] so that the users can use the standard
pinout number to access GPIOs. For instance, pin 23 on the Low Speed expansion
header is the GPIO for all 96Boards platform, so the user can access that pin
using 23 itself in the application and it will run across all supported
96Boards.

That's one of the reason why we prefer MRAA.

Thanks,
Mani

[1] https://github.com/intel-iot-devkit/mraa/blob/master/src/arm/96boards.c#L75

> -- 
> With Best Regards,
> Andy Shevchenko
