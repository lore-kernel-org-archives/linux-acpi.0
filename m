Return-Path: <SRS0=A6Sl=S4=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBB3C43219
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53C02077B
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Loe0zQsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDZPcA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:32:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33429 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfDZPb7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Apr 2019 11:31:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so1920866pfo.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2019 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YdenmkYf08ijkzIciU/t9HCcpllEEpM9kySg53BytIE=;
        b=Loe0zQsXKQxnou5F3tAX2ubrqPsmELvblvGNH8HLznjRolmJyaehH7kaKneBjvpAjp
         5Sxqz0lvt7kAtimfJgE0yA58yKU1WWrkJ7GH2+vcYtxyfrEKXvqhnfmb/2yr7TWY/9W+
         1jPwR/B6DBQ+6GJX8HkSjAFCZEhkYuVejcJcSZ2IL5NGgj7DGklqowsTEt6XtJrxS5yb
         v7J024dfb6RKhjl0ToZKztSE1jKmg4ZoEI3NBwJ72KG+olvtk8lb6VmJmjEbVzugqqxn
         +UTx6k+QKTHCc53Z536JttWYavgtIQsWqf0y1QOk5Hp3X8/OGbt8y69uE964ZO3Hp+4i
         VMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YdenmkYf08ijkzIciU/t9HCcpllEEpM9kySg53BytIE=;
        b=ELJ9FGXLp0Gb/obkRk7GAk7KBh6MHmYn5FKRWm4Yt3nGvm5sx4jER7EJP79gC1DMIR
         1fOSBIpf1dbxtw3Oc/VHFuTWmrY6YvaHfLirNaAOYrFuQOohG4RjufA7Ir8cXn8cv8pE
         hmILMG2MLrkkMpert7dUAAOspyvR8rsOTRJ//TWKceVFC8D0TOrLP68GU0tEw+Cmxouz
         NFh4tHjBtpZtRhQz4ineAmjKAZ2MaP8es+6TDDvfu8Kwbq2srUwwdqoItu0BYy7JMMgl
         vvVUgfR7dnvVd0XxXiUWM2yfJ39B/aiCVcCzcRvAYELoN8ufQTDbiV7027nz44XkcAOS
         ZEzA==
X-Gm-Message-State: APjAAAXXs9gKww3kJ8exdJggIkRoxOQRLTIHxylA/i6taTYT/1x87ui+
        kefyb2G6GXFMSxVNg4g4gIBqbHmAEA==
X-Google-Smtp-Source: APXvYqy3ZQHF3f8OLRDEBmiDk8x/FTYEKk9HIMSckYO5S3vJyyxFGvlMQAzFgf6mJqchsnjCtdUfLA==
X-Received: by 2002:a63:4144:: with SMTP id o65mr44118909pga.241.1556292718872;
        Fri, 26 Apr 2019 08:31:58 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72c4:4b94:e0ad:83b0:3987:aa05])
        by smtp.gmail.com with ESMTPSA id e184sm24541623pfc.102.2019.04.26.08.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:31:57 -0700 (PDT)
Date:   Fri, 26 Apr 2019 21:01:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190426153150.GA28444@Mani-XPS-13-9360>
References: <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
 <bc856e19-470d-7655-5680-a031831ab513@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <bc856e19-470d-7655-5680-a031831ab513@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190426153150.tqPElB4ySnKzdI784Vz69uEInJsfLvvQN1fTk8jhQDM@z>

On Fri, Apr 26, 2019 at 04:42:35PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 26.04.19 15:36, Jan Kiszka wrote:
> 
> > At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
> switch> the engine.
> Which value exactly does that collection of crude wrappers and broken
> attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
> provide ?
> 

/dev/mem access to gpio's were done during the sysfs days (yes to bypass
the kernel interface) but now mraa will use chardev if the kernel is
chardev supported. Still, it just behaves the way you want (/dev/mem was
also optional back then) and I couldn't find a better alternative for playing
in the userspace with multiple languages.

-Mani

> mraa belongs to the category of software, I would never put onto any
> production system. (yes, I already had a client who asked me to repair
> his mraa-based software. finally, I've replaced mraa w/ a few LoC ...)
> 
> 
> --mtx
> 
> -- 
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
