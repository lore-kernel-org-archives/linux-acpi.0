Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C33C433E9
	for <linux-acpi@archiver.kernel.org>; Tue, 26 Jan 2021 16:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB9522EBD
	for <linux-acpi@archiver.kernel.org>; Tue, 26 Jan 2021 16:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbhAZQTv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391113AbhAZQTp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 11:19:45 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C276FC061797;
        Tue, 26 Jan 2021 08:19:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c6so20483255ede.0;
        Tue, 26 Jan 2021 08:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QipIjt+uBCsYaw/A90Tt+IbpJbpCFCsG7g/7AL0vBWI=;
        b=miaxiC+WS/vBt9/lVPQ0ut9jTmA2iv5gqIP3Q/NYBIXmsRDk5eGDNvWKAyc7E34xuV
         j3aj630ZiG2HOVR73dvzQUz323UkzNHvd2x9WXmEAabGaylX/gNz20PiWIS8y/3ffeIB
         EHkre64MNOKYEYdhtltL4iNQL4hRBMSlvhldmH0pWmwT3sHBPdrkBetb8DZMQPnHEUIn
         YwdtXEmEFD9LGGpB87BIvucwXwrENgO41Xi+o4ZvVm+ixf2tJxGXwQ0qSBV1nHazueE7
         RvOyVLjSYG2PHwfwLnJTuqDV4UaiSH6nXHwo/wTsNrijhguzXrWHFcUxrcA4FvqqcH/y
         hs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QipIjt+uBCsYaw/A90Tt+IbpJbpCFCsG7g/7AL0vBWI=;
        b=mAdztDPADYxXfaj1MjnVqliCxQrYSsVWZs8+rWkfzdpy8vjqyV+NhznxubINHNnVbb
         N1Xl4VzhJPGfYgJPE/oFClPrL1F3BALDKrxRmA5zTO1z4/Phua3ePNhmQJ+l10GuPI/X
         6FJHYlpta+ogMfyjKwM68EaepVY26cQHJqn4rCBYPv8XHtntEkC+PXJcOiSRiOqqMSj8
         w5Nex2HXbpPfkzvD11lRYo4/zP7Q1CXPINhOJ9MVsxsRKmP4gfxETMfxgs9E3S0CqNK2
         vN+z5eWIZDFKbOcpkktgHp6iavOyB6bmcKjvufVvhGtDmnPwze8mErBI/jHaIgnDcYx4
         qPNA==
X-Gm-Message-State: AOAM531+OoWES+pEXbuVh3biGfS53rxPqu6MJ3iBkmrbenJZMr+Xflf/
        Z3q+cZTglmKSIB6dgRox5speLr7CO3qtqd9u6CQ=
X-Google-Smtp-Source: ABdhPJxLSLsYfO08q1+h9uOTF6V9AnF7nUi2K4AFp1Ly6GzB9D2wpTUHj5mJVALJ2sYC9m93Fx9CkAdOQDO6+QnHMso=
X-Received: by 2002:a50:b223:: with SMTP id o32mr5236582edd.79.1611677943482;
 Tue, 26 Jan 2021 08:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com> <20210126155723.9388-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20210126155723.9388-3-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 26 Jan 2021 18:18:47 +0200
Message-ID: <CA+CmpXscOVjn20ffw37GRLBWhQDRJ9J8svYvU1-VWg5eA-Bm4A@mail.gmail.com>
Subject: Re: [PATCH 2/6] thunderbolt: Add support for PCIe tunneling disabled (SL5)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 5:57 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Recent Intel Thunderbolt firmware connection manager has support for
> another security level, SL5, that disables PCIe tunneling. This option
> can be turned on from the BIOS.
>
> When this is set the driver exposes a new security level "nopcie" to the
> userspace and hides the authorized attribute under connected devices.
>
> While there we also hide it when "dponly" security level is enabled
> since it is not really usable in that case anyway.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Looks good to me, I'm just not sure I understand how this is different from
dponly mode. Is this just because it comes from the new _OSC?
