Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1203CC636CA
	for <linux-acpi@archiver.kernel.org>; Fri, 16 Jul 2021 12:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A1A61411
	for <linux-acpi@archiver.kernel.org>; Fri, 16 Jul 2021 12:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhGPMKs (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 16 Jul 2021 08:10:48 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45621 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhGPMKk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 08:10:40 -0400
Received: by mail-oi1-f180.google.com with SMTP id w127so10585521oig.12
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 05:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTgQ2LC1GEAhiEUeKlteWL4No1D7RLUuBKI/Hj7iVMA=;
        b=UAigmoZf8AqNv88HX+i6a8jXkJKX7HUyGQkI+TZHq0bWKh8wbLMfheYkMUSGaRlLjq
         17lZwW3ct+gXPmm2lKqgFirK3+f8IVRbj3Cu9pbwUorOyJ/ElT+lNpCrEMoUV9BV5xTh
         R8yG6qqa9YTBtmN9V1vDCiE7w2+m4BwNykncPEM/MjBd9MAJ68n7sls6q6tlbyQhuk+p
         7CD3IaBqIAniSWKgFavGXqqYyzvJTR8OntW7mA98NTpv+GvDYSdyh18vPZKzZyqZwzf7
         fMnRmI3IkCyIEJU9EnuSusOE/S7YkC9cRz8Oa5uPHhpenay7xYOFsDAUo49mmWdD5zN7
         QnAw==
X-Gm-Message-State: AOAM5304i8n87LzCDI6hPaImaSCvBB0RIocHvKC6DCG9W0Dse2dbaAco
        JGcNEJOGr/qwfbkOvwTy222V4jyNylobz1XaznM=
X-Google-Smtp-Source: ABdhPJx2WJHv+3/aMRiADtvtuiFVuW15RMzbN07PQUZ7xPDRUdFCgI4Nr3jtxKf5SLVIuNBK/6rgzKtbZ+Ya31UwQiU=
X-Received: by 2002:aca:4f57:: with SMTP id d84mr7784974oib.71.1626437263743;
 Fri, 16 Jul 2021 05:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210630194606.530-1-mario.limonciello@amd.com> <704855e5-fad4-a002-a16a-1f3fbddbf5f0@fris.de>
In-Reply-To: <704855e5-fad4-a002-a16a-1f3fbddbf5f0@fris.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jul 2021 14:07:32 +0200
Message-ID: <CAJZ5v0hSZcNf4Cy3fSA4jRjw1J5r5T36NOs9yCTiRksFLmjzFA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Only mark EC GPE for wakeup on Intel systems
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Julian Sikorski <belegdol@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 16, 2021 at 1:13 PM Frieder Schrempf <frieder@fris.de> wrote:
>
> On 30.06.21 21:46, Mario Limonciello wrote:
> > When using s2idle on a variety of AMD notebook systems, they are
> > experiencing spurious events that the EC or SMU are in the wrong
> > state leading to a hard time waking up or higher than expected
> > power consumption.
> >
> > These events only occur when the EC GPE is inadvertently set as a wakeup
> > source. Originally the EC GPE was only set as a wakeup source when using
> > the intel-vbtn or intel-hid drivers in commit 10a08fd65ec1 ("ACPI: PM:
> > Set up EC GPE for system wakeup from drivers that need it") but during
> > testing a reporter discovered that this was not enough for their ASUS
> > Zenbook UX430UNR/i7-8550U to wakeup by lid event or keypress.
> > Marking the EC GPE for wakeup universally resolved this for that
> > reporter in commit b90ff3554aa3 ("ACPI: PM: s2idle: Always set up EC GPE
> > for system wakeup").
> >
> > However this behavior has lead to a number of problems:
> >
> > * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
> > sometimes the power button event doesn't work.
> > * On HP 635 G7 detaching or attaching AC during suspend will cause
> > the system not to wakeup
> > * On Asus vivobook to prevent detaching AC causing resume problems
> > * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
> > * On HP ENVY x360  to prevent detaching AC causing resume problems
> >
> > As there may be other Intel systems besides ASUS Zenbook UX430UNR/i7-8550U
> > that don't use intel-vbtn or intel-hid avoid these problems by only
> > universally marking the EC GPE wakesource on non-AMD systems.
> >
> > Link: https://patchwork.kernel.org/project/linux-pm/cover/5997740.FPbUVk04hV@kreacher/#22825489
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1629
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> As this seems to fix quite some issues for the AMD systems, is there any
> reason why this is not tagged as fix for stable? Are there any plans for
> backporting?

If you need it in stable kernels, please send a request to
stable@vger.kernel.org to include it.
