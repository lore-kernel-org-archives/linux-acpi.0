Return-Path: <SRS0=5qVQ=C3=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DEC43463
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Sep 2020 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE742388B
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Sep 2020 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600436107;
	bh=zT8ZYf6HAY8CT+9OanHLVNB/5V6UrbKfcIDiuma43YM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0I9Z+wO+t5KwcpqGVyKS6lS2Mp5d/A9DKpx3NwSDIGWcVfVqPybnZ7Eq9e8C9sqRl
	 HNCEInFO99aaAucOVtO6HHLlrNX/pgh4NvBzqkVRLDaW1XKyGdWmzrze7abu7+Hq1C
	 donWRn9xo7WEAoiMpOKLrMaMkGkH21B61rP1OR9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIRNfG (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:35:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41093 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRNfF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Sep 2020 09:35:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id q21so5368554ota.8
        for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2020 06:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+0kkhU8gsRY+Vrl8rc76bI/5mC1y5tv6JjBptgH/Uw=;
        b=IiO/cgABjkgN+GhpYYNbYzA0KES+kdRWnuNvBRZ6JWjSJTMEz9JY0PoKmsdoG35UC5
         Y7H5RuxvwzxTXtjQFGtD0j+h/FIF5/ghCOmPpx/C91M/FwtZAnue+YnptzvkpC3DCA2R
         U7Mc3i+S6QKjSe19CwmDioQmXnoYaZ3hdZJMQOr24xJ0reGgDDcU0v0EMQbH2td/0Kdn
         WNPF3sUT6VEKgFYdjdceRjw8Ka5ZtJ/y4MXVUCbSbmyZH26lq9GeYSushx3dvANI54hd
         SfZkwdg2oqsnPIDOsYmCvwIHKcy/0flV48CFEtkXjq7Bmb8VbaPNICT+SK+nud7L6L+D
         WkNw==
X-Gm-Message-State: AOAM5312Y7D3mujlRQPWKIjUraUtOWp6vxHqC7yQgTPifrHhGNCE6Jju
        zzd1s4Q5l5ZdUrjrcd3o+PbfYGCGMuB/uUWwXoYwO9wz
X-Google-Smtp-Source: ABdhPJws7clcbZajPMCJOYUZBD0S6quICoLIHwcEToO89m7cL2w2s2Iow05mlgiFbwPXHqi3W2AfaJxpcteLnYwzZac=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr21769944otp.167.1600436104404;
 Fri, 18 Sep 2020 06:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0hukTBCyNO0Tj=FyOzh4uM=f8bLTToOT4zG3Tn_1KjO0g@mail.gmail.com> <28154b60-b07b-24e7-748f-88359d5343cb@huawei.com>
In-Reply-To: <28154b60-b07b-24e7-748f-88359d5343cb@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Sep 2020 15:34:52 +0200
Message-ID: <CAJZ5v0jfxESXKJDV_JimG-ao58GjfvX6ZT2Sch+qn24ptVOx4w@mail.gmail.com>
Subject: Re: [PATCH 00/25] ACPI: First step to decouple ACPICA debug
 functionality from ACPI driver
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 18, 2020 at 3:55 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> Hi Rafael,
>
> On 2020/9/17 23:08, Rafael J. Wysocki wrote:
> > Hi Hanjun,
> >
> > On Thu, Sep 17, 2020 at 10:34 AM Hanjun Guo <guohanjun@huawei.com> wrote:
> >>
> >> For now, ACPI driver debug functionality is mixed of pr_* functions and
> >> ACPI_DEBUG_PRINT() which is provided ACPICA core directly, ACPICA debug
> >> functions are not friendly for users and also make ACPICA core deeply
> >> coupled with ACPI drivers.
> >>
> >> With the evolution of the ACPI driver code, lots of the ACPICA debug
> >> functions used in ACPI drivers were removed away, this makes the ACPICA
> >> debug in ACPI driver to be fragile, for example, some of the COMPONENT
> >> such as ACPI_CONTAINER_COMPONENT and ACPI_MEMORY_DEVICE_COMPONENT are not
> >> used anymore, they leaved as dead code.
> >>
> >>  From another aspert, removing the ACPICA debug functions didn't raise
> >> concerns in the past, so I believe the ACPICA debug in ACPI driver can be
> >> removed and replace with equivalent pr_* debug functions, then decouple
> >> ACPICA debug functionality from ACPI driver.
> >
> > This is a worthy goal, but the patch series appears to be a mixed bag
> > of changes some of which are not directly related to this goal.
>
> Sorry for that, I sent this patch set in a hurry, I will update
> as you suggested.
>
> >
> >> In order to decouple ACPICA debug functionality from ACPI driver, I do it
> >> in two steps:
> >>   - Remove the dead ACPICA functionality code, and remove the not used
> >>     COMPONENT;
> >>   - Remove all the ACPICA debug code from ACPI drivers.
> >>
> >> This patch set is the first step to decouple ACPICA debug functionality
> >> from ACPI driver, just remove the dead ACPICA functionality code and
> >> some cleanups for ACPI drivers, should no functional change if you don't
> >> apply the last two patches.
> >>
> >> Patch 1/25 ~ patch 23/25 are removing the dead code and cleanups;
> >> Patch 24/25 ~ patch 25/25 are the actual ABI change.
> >>
> >> If the ABI change is making sense, I will go further to remove the
> >> ACPICA debug functionality from ACPI driver, just keep it inside
> >> the ACPICA core.
> >>
> >> Hanjun Guo (25):
> >>    ACPI: cmos_rtc: Remove the ACPI_MODULE_NAME()
> >
> > This, for example, should be a separate cleanup patch.
>
> ACPI_MODULE_NAME() and _COMPONENT are both used for ACPICA
> debug functionality, so I will put them in the decouple
> patch set.

So if the ACPICA debug functionality is not used in the given C file,
you can drop these macros from there right away without any side
effects.

Why don't you do that in a separate series of patches then?

Thanks!
