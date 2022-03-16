Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09243C433FE
	for <linux-acpi@archiver.kernel.org>; Wed, 16 Mar 2022 10:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355135AbiCPKau (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 16 Mar 2022 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243190AbiCPKat (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 06:30:49 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48505D1A7;
        Wed, 16 Mar 2022 03:29:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id f38so3593328ybi.3;
        Wed, 16 Mar 2022 03:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Btxl7qpJXA3o+3gIq90h3ZOSmA502ZFbiCPKabXuDLI=;
        b=zUA9yzYYH7o/DVn/noxxKH1nZyhSCQbJ+b6ctr4zHbcUkFg1ABS10piH0/R09geTon
         jJAhUbe89RWWjtPDbowX9VVuuqQYS2pCNBJpinLNmYGH4oYC/9uAOeDpC5FIvO7ePquA
         o8mqqwSP5qxSsHqVUSX2wWDjHlFxuLVFa+sbWK4ZpKJjIy/q0HX39bKaH1/TcqWgUFZc
         APCriyfkPoPUwVwJ/ZGshn7lUNvASdYB/mZfvrwcf5IaMpcYE7aJ5xqPBxVuSPdK4xTT
         8FeJS1Qm1E8ywaOGbTtZ+Yf23zKW7ypxD8gyA0bCMYAHY6pkCC5RIIZYNrxFg4LU/2sZ
         onIw==
X-Gm-Message-State: AOAM533MTzOXiDRy1AlhvuRsFPOehPrYFYa5Zmx8Q67/eqX3sEUOmNFz
        EoscqbvHsanbdnn8uXoyjQSKl1aefx7zmGoQEnE=
X-Google-Smtp-Source: ABdhPJyixlCbVy3dwdI1grQxN+OkJ6ndMdB1dQ1bY+8VcXQr/iZJxbllzLUh0NAqXBEV5D/4kgHhfpwABXXJAID0cpw=
X-Received: by 2002:a25:4052:0:b0:628:cdca:afb7 with SMTP id
 n79-20020a254052000000b00628cdcaafb7mr27567345yba.81.1647426574982; Wed, 16
 Mar 2022 03:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <thesofproject/linux/pull/3521@github.com> <thesofproject/linux/pull/3521/c1068656236@github.com>
 <CAJZ5v0j9j9Ecg0uZs+is5VFFBM2P6KQq3nUunc4dTN0=-jU7iA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j9j9Ecg0uZs+is5VFFBM2P6KQq3nUunc4dTN0=-jU7iA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 11:29:22 +0100
Message-ID: <CAJZ5v0gPRq6p2vbiMEnSkdJ4s_LKU4aXUpD8_djdRNke-w6TNA@mail.gmail.com>
Subject: Re: [thesofproject/linux] [TEST] double-check impact of ACPI patch on
 suspend-resume (PR #3521)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "thesofproject/linux" 
        <reply+AOCP6N2SZMNVCWT4POMEGTOAHZ4GDEVBNHHELOSH2A@reply.github.com>,
        Mention <mention@noreply.github.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For the information of everyone on the mailing lists:

Commit e38f9ff ("ACPI: scan: Do not add device IDs from _CID if _HID
is not valid") is going to be reverted, because it caused multiple
systems to misbehave as per the below.

On Wed, Mar 16, 2022 at 11:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 16, 2022 at 3:05 AM Pierre-Louis Bossart <notifications@github.com> wrote:
>>
>> @rafaeljw @andy-shev @ujfalusi I think the results speak for themselves, we have two confirmed regressions with commit e38f9ff, so somehow filtering out the pnp_cid list has a very large impact.
>>
>> I was able to fix the SoundWire regression by using the DPM_FLAG_SMART_SUSPEND to prevent a spurious pm_runtime resume, the other regression on a Chromebook is not clear at all.
>
>
> OK, I'll revert that commit, but this pretty much means widespread firmware breakage.
>
