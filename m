Return-Path: <SRS0=ZHTL=VF=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F8C48BE7
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Jul 2019 08:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED62720645
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Jul 2019 08:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562572937;
	bh=lmbbLSArViQwG0sO0uk+gTmND3rXNTtlb7Kjl+P6xLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kC3NYFd4cnEu+lXgdrSpfqk0tD1NoMHPrg3HbVZs7nAM+bWS6Bb3gsl4qPJKFvKS7
	 UQADY0Pvc2gPpNInHbFgdJbhpiT0+e5lwUGSEI0PmA0vLxYPLYVIxnIeExhHdlKd1C
	 90WPkW4M9ABWInk9Fw5Y+aoFBvMtGG1AhlOSm3rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGHICQ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:02:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39821 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGHICQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jul 2019 04:02:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so10552374otq.6
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jul 2019 01:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmbbLSArViQwG0sO0uk+gTmND3rXNTtlb7Kjl+P6xLA=;
        b=JZ3b9gzyGebM+XN7eRkBa6lsj1icAJH6WqZHEot826ENaSLzXXtpp41nOOa6ER4hCN
         WnSm/kpYu9GOKD8hP55iw/cn275tonIr6hy0R1L/UPFP4vNOTy/R8oDw/UBwGZ/aRdC/
         sbqJosQwWddRP5J1h69EbLfJgIonpxtlwFoGlGtCr9jcSKRWbvci7D7vbRHYHVV+mqJK
         oezOUEDUCHRwD3SfrD/+JZTypA2264vEFMjlS4pGJpcJS4E1Ie5Dzv1DrCbKnjDVZiuX
         COp55zSC9w4kZAdTSV00lu5am6y9NWMunX57Xg9enaMvYTU42p8kU5D+bj+sCxXg+qm8
         /Lug==
X-Gm-Message-State: APjAAAUivfJUKoKptH+gdD0hBpbJCQZ2+eE29Yxw7+rPt551sFzJMHP5
        ZHxGbvu8N1aahnWAFuB/rW8QohnlW3Ie6wU2t68Ylw==
X-Google-Smtp-Source: APXvYqweVEnzj2BdIFYdRGVfL1wc7jf68rjPb7H0o28u6goBC8WJJSheudYNiN03nBwDanJmKTxkB/a33uesf1s6mgI=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr12682294oto.118.1562572935699;
 Mon, 08 Jul 2019 01:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <ks54ieh5iu58i8ig1ear1tp2ev4n57r4u4@markspace.org.uk>
In-Reply-To: <ks54ieh5iu58i8ig1ear1tp2ev4n57r4u4@markspace.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Jul 2019 10:01:59 +0200
Message-ID: <CAJZ5v0i2Jjzi9JfXWF-6f6Ys4kFyW6+Q5W5RaHTX6CtxurEeJg@mail.gmail.com>
Subject: Re: Kernel panic and ACPI errors with recent update to 4.15.53 (
 Ubuntu 18.04 LTS distro )
To:     mark@markspace.org.uk
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jul 7, 2019 at 6:33 PM Mark de Roussier <mark@markspace.org.uk> wrote:
>
>
> Hi folk,
>
> I'm running a HP Z800 dual processor workstation which has just stopped
> being able to boot properly due to a recent update. The machine has the
> latest BIOS available from HP ( this was not changed by the update ). The
> problem appears to relate to ACPI, and I've been referred here from a post
> I made to StackExchange.
>
> Attempting to boot the machine using any of the available 4.15 kernels (
> 4.15.43, 4.15.45, 4.15.47, 4.15.53 ) now gives the following ACPI errors :
>
> ---
> ACPI Error: [CAPD] Namespace lookup failure, AE_ALREADY_EXISTS
> (20170831/dsfield-212)
> ACPI Error: Method parse/execution failed \_SB.PCIO._OSC, AE_ALREADY_EXISTS
> (20170831/psparse-550)
> ---
>
> I usually end up dumped into what I believe is an 'emergency shell'.
>
> I have tried a large number of acpi related kernel switches, including
> 'acpi=ht' and 'acpi_serialize'. The only thing which appears to affect
> behaviour is 'acpi=off'. This causes a kernel panic, in which case I am not
> given an emergency shell. I don't know how to grab that info to post here
> except for taking a screenshot, and not all the info is actually on the
> screen.
>
> So if anyone can suggest a way to further this investigation, I'd be very
> grateful. What information would be useful to know, and are there any
> particular experiments I should try, anyone else it would be useful to talk
> to ?

First off, it would be useful to try a newer kernel, preferably 5.2.
That should be available from Ubuntu shortly in some form.
