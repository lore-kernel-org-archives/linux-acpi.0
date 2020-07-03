Return-Path: <SRS0=d3ct=AO=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6528C433E0
	for <linux-acpi@archiver.kernel.org>; Fri,  3 Jul 2020 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8929320884
	for <linux-acpi@archiver.kernel.org>; Fri,  3 Jul 2020 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593800984;
	bh=ECMWanzjxJwCk3uw9DCF25Cut3vub+RJ7Rjwaen/OBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ERHaDsbj4TrmmciYiyvNlw9tGSzAIgpzhk4ISSMkm/hlgITO/Ko6uIiRYa28nDhVu
	 gmZd4iSOImvfyw4yWbcYeG2WbY31loIODoRyXDVFjh0qC33P2Ss4XoMqADmyh0qzav
	 cF9L+tC+vHRGXWAzMreNwMUS9fvgfRUWq+jZ4ApI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGCS3o (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGCS3n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jul 2020 14:29:43 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC5B20884
        for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2020 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593800983;
        bh=ECMWanzjxJwCk3uw9DCF25Cut3vub+RJ7Rjwaen/OBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wejWeurvOl/WCDbVJfpJ+pK9CK3we+tH8nscefgoeIjqh7xLbAwtn2305r8S9ZgoG
         XGBGa5n9PXGHZNt5vcsHbEYx9tNNSYwytLyyypGwJqzrmSMvGpeEe17fg638LHBsyG
         GRsYmBgqQV+uz0IrXAUlWhUD9pGZCeNY9FHfxxtM=
Received: by mail-ot1-f48.google.com with SMTP id a21so4007374otq.8
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2020 11:29:43 -0700 (PDT)
X-Gm-Message-State: AOAM530+UR9hWBoxu31joL1M7Zaf3DcuAofJBcZHuO6uOYSTn+kMUHYp
        Cmq9oXfer2zM1y8Vu4ZGUUcTC1EQdQCaQrH2JN0=
X-Google-Smtp-Source: ABdhPJwcfH735xr65SkQu2llfmK35406ZAiqzkqCVMsSdComb4LpUkWA6JBlpFZ4+LN1mIlclwupeg+Bs70g0GjABlM=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr31030790oth.90.1593800982877;
 Fri, 03 Jul 2020 11:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200623093755.1534006-1-ardb@kernel.org> <20200623162655.GA22650@red-moon.cambridge.arm.com>
 <CAMj1kXEwnDGV=J7kdtzrPY9hT=Bp6XRCw85urK2MLXsZG3zdMw@mail.gmail.com>
 <20200703161429.GA19595@willie-the-truck> <20200703161628.GB19595@willie-the-truck>
In-Reply-To: <20200703161628.GB19595@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 3 Jul 2020 20:29:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHaOh=GH3cyAwJEWBQ6OOQboTt5Sc3vBvOaZQ9ugcHPgg@mail.gmail.com>
Message-ID: <CAMj1kXHaOh=GH3cyAwJEWBQ6OOQboTt5Sc3vBvOaZQ9ugcHPgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm64/acpi: disallow AML memory opregions to
 access kernel memory
To:     Will Deacon <will@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 3 Jul 2020 at 18:16, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 03, 2020 at 05:14:29PM +0100, Will Deacon wrote:
> > Is this 5.9 material, or do you want it to go in as a fix?
>
> Sorry, just spotted the v3, but the same question applies there!
>

This needs a bit more test coverage than we have been able to provide
so far, especially regarding kexec/kdump etc. So even though I think
this ultimately belongs in -stable, that does not necessarily mean it
should go into the next -rc right away.
