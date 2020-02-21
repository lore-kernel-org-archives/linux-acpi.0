Return-Path: <SRS0=QmRt=4J=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6792FC3565A
	for <linux-acpi@archiver.kernel.org>; Fri, 21 Feb 2020 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4089524650
	for <linux-acpi@archiver.kernel.org>; Fri, 21 Feb 2020 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582308150;
	bh=2iqlsfCU2xzdvKiMFOxsJfrFK/WCC507GMR5NHeQJ/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gQZI5o3x08MjQ1I9khwrQ4/SOgKym0JvmNPNbLGQo0D9M3K0ahDFijea+psIbJWSk
	 LwTWmTAh1DdXRG/TXi7sfJ7Z1/M9/bgVvNgGiwxLoxJW3KSlo2yhm/M7rlEkw6SAfV
	 R8d0grH3o85t/2OLHCAdeu51wI9pJBvv6lY8tl9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgBUSC2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:02:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36692 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUSC2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Feb 2020 13:02:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so3114096ljg.3
        for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2020 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG9TJKXnTeZzyHlgjHVGK5jDlYOlKtakbHNOYDpKW9E=;
        b=LtuqrNdxX93Kes55M7/V1nmMoOY/Am5rxlDligc40iz1+GEbCmeM7TuGyB0tTEcegn
         UDZiT2MxYZWEAGTE0LovTMS1jqfnFBkPD3xPTU2e30E6da/H/mQbYfgawXH18yg2Guvv
         l3o1EYHUu3z2m8B4mLtmpaElvsWWhBoRfpDBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG9TJKXnTeZzyHlgjHVGK5jDlYOlKtakbHNOYDpKW9E=;
        b=nkcbz0JOJBM0jCichUegBsOMH0zZ7e5Y4NR3jcEHXmiP6OFnpAFMDkybOlHEfKNT1s
         bjsj2vJwk/3XHsLf7tqo8dCkPtP84QxaL3HSoP5Ft39bj3LUWV13tPHthhA0VW0GKqUG
         qcuFa42EIGicWyJGw4PARseAy1tm+E/GRW7DUbqecUZMEuAC0Urc520PeG34FAsrVNOH
         QZy0rhhW5QQG3zQOltbmdgVbMFnUX07T6pcsOD2MIZ04qygl/7NwnTqOWWKRdue3W7fG
         9RC+Bm0LiOKiF9aIcBudfUZfL8iPd3nPfCgJo7zafKahJqoLCmXVI3kQLlv9ZNH5e3hH
         3Jww==
X-Gm-Message-State: APjAAAUiwKrWKNkPvdXUEXTqV9Bl5IyOvuQ7OD/W0lgZXE/7y357IJBx
        xlB0x0JUjNFL0n26SP7hk6VSyWRydoo=
X-Google-Smtp-Source: APXvYqw+A3T6Q4d26mZM0criHlJbop/o7tNM+r4jJ2yBoS1iOSYBevu2u9+BPVwL/GQsb8yAYwEW7A==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr22578807ljo.153.1582308146094;
        Fri, 21 Feb 2020 10:02:26 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v16sm2000408lfp.92.2020.02.21.10.02.24
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:02:25 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id y6so3141042lji.0
        for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2020 10:02:24 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr22906965ljb.150.1582308144004;
 Fri, 21 Feb 2020 10:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
 <10791544.HYfhKnFLvn@kreacher> <4974198.mf5Me8BlfX@kreacher>
 <158227678951.3099.15076882205129643027@skylake-alporthouse-com> <CAJZ5v0h07em8y5bXcnUTBcjie8pCttADK9QX9W_cB0WQRcDfGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h07em8y5bXcnUTBcjie8pCttADK9QX9W_cB0WQRcDfGQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 10:02:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
Message-ID: <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 21, 2020 at 2:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Please pick up this patch directly if you can.

Done. Added Chris' tested-by too.

            Linus
