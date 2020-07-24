Return-Path: <SRS0=i7Kw=BD=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6985FC433DF
	for <linux-acpi@archiver.kernel.org>; Fri, 24 Jul 2020 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FA3206F6
	for <linux-acpi@archiver.kernel.org>; Fri, 24 Jul 2020 20:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMIIT2ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXUUV (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgGXUUV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 16:20:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECDC0619D3;
        Fri, 24 Jul 2020 13:20:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so6013890pgm.2;
        Fri, 24 Jul 2020 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdGo5gLqICRp7zs+7G5ug48iKskyEOsTuq55Ciwe614=;
        b=AMIIT2eivh94UzAlbtkWbP2hXnm5WJhexzIa8bXIxWAuYeyNbTaCYkriNDE/ITIAsD
         Z9kVUcuq5h11XuabG9rZKIS40nF41MSAJzX51VqoIREKk+FDWaXhr8gj+JQcT4TFh1qp
         VlQL3mK9/4CpU1GSmNyn7hX9Zb3QB//tiCTnpIOfvJbaTM7Jf5ordMMjqh5G7qTVRvJA
         4aoRDMz1UCjbnj5R9anUtk30sJFmKqpbZLUc9Vy1HqYzGShzvJ0/hAdgHeBtXmk9MDFw
         0RY+3H6k7Zujgr4yd3hpQn4ZbWT6+6kG1kNFmoeMl8CpcDFPf6J/RTPXlvYbFEB7pnEB
         uMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdGo5gLqICRp7zs+7G5ug48iKskyEOsTuq55Ciwe614=;
        b=m7Yf0Hfgyj2KHrKUEsFqdmYqVQZyHDFNuNS5drfHszdrJ7kbxP0ID0Oh8BxAH9B8bR
         hnhumKT74kBtBevySRgLLr2UoN5MDU5ggw4+lLbVOkQuuy1bcrUalpKR6huAyKffTiuF
         xd8ox0nQ+9H0ZQuxPSfaekYALYKhkZKzfgmi/fJ85mkPtoPe14ZfSQAOZexr20eNXjiq
         yR7XaNhiKhzxdUyc5uCbVRmG0w5r8EImcIHx3qKrFYCLmXvgrmWnIkGZceP4gv97BsVE
         WLTJUZQVdUKSL4qhIYaVt0Ykm2LmysUOO2svGlJMj3ORZrNTOzjb4il0zPO8cJRXjy/E
         JFfA==
X-Gm-Message-State: AOAM532/pshP49dTcKHMVICXwcY16e2prQ0WiGGGcjpVRzrxzyyD1FFB
        x46dQLOIW82Zt7qy8fZkA21PHxBE50/SdI4rIU92i4FM
X-Google-Smtp-Source: ABdhPJwDi5Igt/PJ1+N4Wr0tOacThVVjlGsiS0o0Ff/MOHowPFup9iEAeBeyvYtjm0k0PBwVZmt2Rkodc3dkY/Cvwy0=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr9788553pgn.4.1595622020840;
 Fri, 24 Jul 2020 13:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200715090400.4733-1-calvin.johnson@oss.nxp.com>
 <20200715090400.4733-2-calvin.johnson@oss.nxp.com> <1a031e62-1e87-fdc1-b672-e3ccf3530fda@arm.com>
 <20200724133931.GF1472201@lunn.ch> <97973095-5458-8ac2-890c-667f4ea6cd0e@arm.com>
 <a95f8e07-176b-7f22-1217-466205fa22e7@gmail.com> <20200724192008.GI1594328@lunn.ch>
 <CAHp75VdsGsTNc-SYRbM6-HHXSoDdLTqBrvJwyugjUR6HTxwDyA@mail.gmail.com> <2fee02c2-4404-cd2e-8889-97e512a117f4@gmail.com>
In-Reply-To: <2fee02c2-4404-cd2e-8889-97e512a117f4@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Jul 2020 23:20:04 +0300
Message-ID: <CAHp75Vf4nDX-LQr=_FCmv5rj_v-6ZHr4H8pHmAU_N2Wgy=c5ug@mail.gmail.com>
Subject: Re: [net-next PATCH v7 1/6] Documentation: ACPI: DSD: Document MDIO PHY
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jon <jon@solid-run.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        netdev <netdev@vger.kernel.org>, linux.cj@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 24, 2020 at 11:13 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 7/24/20 1:12 PM, Andy Shevchenko wrote:
> > On Fri, Jul 24, 2020 at 10:20 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> >> I think we need to NACK all attempts to add ACPI support to phylib and
> >> phylink until an authoritative ACPI Linux maintainer makes an
> >> appearance and actively steers the work. And not just this patchset,
> >> but all patchsets in the networking domain which have an ACPI
> >> component.
> >
> > It's funny, since I see ACPI mailing list and none of the maintainers
> > in the Cc here...
> > I'm not sure they pay attention to some (noise-like?) activity which
> > (from their perspective) happens on unrelated lists.
>
> If you what you describe here is their perception of what is going on
> here, that is very encouraging, we are definitively going to make progress.

I can't speak for them. As a maintainer in other areas I expect that
people Cc explicitly maintainer(s) if they want more attention.
Otherwise I look at the mails to the mailing list just from time to
time. But this is my expectation, don't take me wrong.

-- 
With Best Regards,
Andy Shevchenko
