Return-Path: <SRS0=21jG=BG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7ABC433E0
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D02120729
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="RmPx0BV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgG0Rd1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731345AbgG0Rd0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 13:33:26 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625C8C0619D2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2020 10:33:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so9435108edv.4
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2020 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFy4EwbQ1hruQWfyvxwpSGaXyhWKJikN0d4fu77mACg=;
        b=RmPx0BV42vUOcwd6ebaLWVEV3xBH7X9PAQSv83L03SIFI38M/jJtJazZ3TwolatQ8y
         LW25YtGedcK6Lvbf2QFtQf1I7i6+e5kyKSkBS33TDbX4Zf1Rcshg6HmnH1xZp7VoOI6z
         orcmWNCVVVD2JEHaKhLaShcj/wUKD3V+H/9293vXHQORXdSJTWcW2O0hCp6mmaIomX8Y
         1tgbgL3iGQWANfdbxYof7ErgwrNtR+cWT2isVO2f4zInlZMplwNQNQI7enp5IsCTc2NU
         tjOGLzxcFujqeunVANKELdCFk9/mFnRj9SCE8RrQ8QMwaXL96FOgG1do4SaDKkfyx3R2
         nsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFy4EwbQ1hruQWfyvxwpSGaXyhWKJikN0d4fu77mACg=;
        b=FceFfP2W25JvSbmvj8G93V5mzo9NxnpiKblHFI70trbrAxeZ7grS+h5cewXjSA0hh+
         eiFT/qQ7lHx+nLUASPgKUJpKQKy434M/RnH2ArdXUg9oQKwYxDpWd8zPB6RkyYbYztxV
         g1ePCVbAHaXK/v4A+I6cH/UZml6SL6wZYylV3zQFDajY4SWi3brIEDLgO11UGBFMHJmE
         9AGFmjTZ0L4kN3dLbPxxuu8pcZeQhssGxcE11ANkx3/ivCy/bGidZEtLGZsQvIzZAL10
         M2GYJ3KM5TU8/wMlhzq65f6F/BzyySQ+kwoeGDJ7pC8sWxNXggJMjmq/+xs+7/nnNHn/
         lymw==
X-Gm-Message-State: AOAM532ai0GFp6QLN+Hf952EHVsCnQTVpDsvFMkdtVrCH4rsSidjpxFw
        Qd2iQBVPYz6mOHn5d7awuIBdDQlB33hDgzcpms3GWA==
X-Google-Smtp-Source: ABdhPJyCby+l6ZVi63IKbukfxKvjhl/3EyTd2nMQvtsiJ3YYTfQjolzylNOe+Otu/6trXR5xLKLWDz+9I1WIK/g2lUc=
X-Received: by 2002:a05:6402:b4b:: with SMTP id bx11mr21696778edb.286.1595871205077;
 Mon, 27 Jul 2020 10:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200715090400.4733-1-calvin.johnson@oss.nxp.com>
 <20200715090400.4733-2-calvin.johnson@oss.nxp.com> <1a031e62-1e87-fdc1-b672-e3ccf3530fda@arm.com>
 <20200724133931.GF1472201@lunn.ch> <97973095-5458-8ac2-890c-667f4ea6cd0e@arm.com>
 <20200724191436.GH1594328@lunn.ch>
In-Reply-To: <20200724191436.GH1594328@lunn.ch>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Mon, 27 Jul 2020 19:32:48 +0200
Message-ID: <CABdtJHtpSGWBZh2A7XA8hMmRetow8XsHBUORLo-hD8Bn+WEmdw@mail.gmail.com>
Subject: Re: [net-next PATCH v7 1/6] Documentation: ACPI: DSD: Document MDIO PHY
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        linux.cj@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 24, 2020 at 9:14 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Hence my previous comment that we should consider this an escape
> > hatch rather than the last word in how to describe networking on
> > ACPI/SBSA platforms.
>
> One problem i have is that this patch set suggests ACPI can be used to
> describe complex network hardware. It is opening the door for others
> to follow and add more ACPI support in networking. How long before it
> is not considered an escape hatch, but the front door?
>
> For an example, see
>
> https://patchwork.ozlabs.org/project/netdev/patch/1595417547-18957-3-git-send-email-vikas.singh@puresoftware.com/
>
> It is hard to see what the big picture is here. The [0/2] patch is not
> particularly good. But it makes it clear that people are wanting to
> add fixed-link PHYs into ACPI. These are pseudo devices, used to make
> the MAC think it is connected to a PHY when it is not. The MAC still
> gets informed of link speed, etc via the standard PHYLIB API. They are
> mostly used for when the Ethernet MAC is directly connected to an
> Ethernet Switch, at a MAC to MAC level.
>
> Now i could be wrong, but are Ethernet switches something you expect
> to see on ACPI/SBSA platforms? Or is this a legitimate use of the
> escape hatch?

I think with the rise in adoption of Smart-NICs in datacenters there
will definitely be a lot more crossover between ACPI/SBSA and network
appliance oriented hardware.

-Jon
