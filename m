Return-Path: <SRS0=2yXj=TA=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0516C43219
	for <linux-acpi@archiver.kernel.org>; Tue, 30 Apr 2019 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC2B2080C
	for <linux-acpi@archiver.kernel.org>; Tue, 30 Apr 2019 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556617081;
	bh=qdi2n62mB3f8vz/g5Kf6QSOPysHMAPgmt/OH2YScPxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FSCUFQdUMivXGFZl/nHHF6AHZhx67Oa/TVO64YJ2cSp4Os9dnzHluqkiEuLLiEssx
	 SI/Uo5zWFOKySvwUeNCODYZhUYQQAZWCYJ90Ym9yiHIO+GtdUn+eu2etTAN88njkNY
	 C1/n2SbB9fxdjb3tFNIj+k2Kj4PD70/hEh0MsKwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfD3JiB (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:38:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37003 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfD3JiA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Apr 2019 05:38:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id k6so10716474oic.4;
        Tue, 30 Apr 2019 02:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G02lSv0pt7QJfrRFGxakI+OyJ7BUeTOYjdVwMTEfN0s=;
        b=IwGxDbHSz3HG7DhfvwUV8hbenZPbye7Ft+YbVBT+Wnn2jbUsXS5xfIRITESazCg34Y
         CEvoaCel8XUMAxFFjU/UKqxfsxDw0G64eez/GqSd+PGY72nh30MIJ16gYgEZBZwjLRz4
         7ggmI5XyiWySfnRmk1o46soyNiJZADyp0ZZuL4Zf1hVXt+65aloyB7d2LQdGholoU1cd
         27ZQ9TSJzDNuH9Xt25Y1nZe3iZZl0hzdYt4jUH9atiXvTGRYPntcmbYM8wKmS9N3v4CB
         NxTBNrzjFoZPahAdhG2NcfpUFxhqMZNOwV64DFGryqCl1YOycABoDqeM0anGvK+eVy+a
         KZkw==
X-Gm-Message-State: APjAAAXTaYQgyUA3hC42LgcMRIwTjHGploZztyp8RGGFRwrTVoySpCSn
        57sJvBwaBlfSs25kr6Jp5oqkc0VsrG/TB10RkOM=
X-Google-Smtp-Source: APXvYqzKBkegFmwRtDoxQY/Q7yBPBpwIw2wXGmR//XNH8g3oQwIbzhqrBpmSszrOZgg8Sea+4dv3dPeMh+VxcnqdKz8=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr2539209oif.110.1556617079642;
 Tue, 30 Apr 2019 02:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <s5hsgu0ihyg.wl-tiwai@suse.de> <EksOpJxc6GB@mike.franken.de> <20190430090021.GF26516@lahna.fi.intel.com>
In-Reply-To: <20190430090021.GF26516@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Apr 2019 11:37:48 +0200
Message-ID:
 <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and thunderbolt)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     mh@mike.franken.de, Lukas Wunner <lukas@wunner.de>,
        Takashi Iwai <tiwai@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, ckellner@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Furquan Shaikh <furquan@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190430093748.6yLKo4BGQT1ELTjXUKCbuJXr3uf5iOKcHSGgBZvBgzM@z>

On Tue, Apr 30, 2019 at 11:00 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> +Rafael, Furquan and linux-acpi
>
> (The original thread is here https://lore.kernel.org/lkml/s5hy33siofw.wl-tiwai@suse.de/T/#u)
>
> On Tue, Apr 30, 2019 at 10:39:00AM +0200, Michael Hirmke wrote:
> > Hi Takashi,
> >
> > [...]
> > >>> I also have XPS 9370 but not that particular dock. I will check tomorrow
> > >>> if I can reproduce it as well.
> > >>
> > >> There aren't too many changes between 5.0.7 and 5.0.8 that touch
> > >> PCI/ACPI. This is just a shot in the dark but could you try to revert:
> > >>
> > >>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi
> > >>   t/commit/?h=linux-5.0.y&id=da6a87fb0ad43ae811519d2e0aa325c7f792b13a
> > >>
> > >> and see if it makes any difference?
> >
> > >OK, I'm building a test kernel package with the revert in OBS
> > >home:tiwai:bsc1133486 repo.  A new kernel will be
> > >kernel-default-5.0.10-*g8edeab8:
> > >  http://download.opensuse.org/repositories/home:/tiwai:/bsc1133486/standard/
> >
> > >Michael, once when the new kernel is ready, please give it a try.
> >
> > as far as I can see, state is back to normal with this kernel.
> > No more error messages or crashing modules and all devices seem to work
> > as expected.
> > Only thing is, that the external devices connected to the Thunderbolt
> > dock are coming up a little bit slower than with 5.0.7 - but this is
> > nothing, I'd worry about.
>
> Thanks for testing.
>
> Rafael, it seems that commit c8b1917c8987 ("ACPICA: Clear status of GPEs
> before enabling them") causes problem with Thunderbolt controllers if
> you boot with device (dock) connected.
>
> I think the reason is the same that got fixed in v4.14 with commit
> ecc1165b8b74 ("ACPICA: Dispatch active GPEs at init time") which the
> above commit essentially undoes if I understand it correctly.

OK, I'll queue up a revert of that one then, thanks!

Erik, I think that commit c8b1917c8987 has been picked up by the
upstream ACPICA already.  If I'm not mistaken, it needs to be reverted
from there as well.
