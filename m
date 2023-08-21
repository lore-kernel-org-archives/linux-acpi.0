Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A02EE4993
	for <linux-acpi@archiver.kernel.org>; Mon, 21 Aug 2023 17:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbjHURJn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 21 Aug 2023 13:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjHURJn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 13:09:43 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52615EE;
        Mon, 21 Aug 2023 10:09:41 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-570b3ebb3faso141849eaf.0;
        Mon, 21 Aug 2023 10:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637780; x=1693242580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm4Ipsg5yV7yja9Qt512E2Zpfwp/tmVXD3JB9eDdRtM=;
        b=gvsCTmQwabxwqo+mp3DDOA6rD07cQLDDy36eOyYEua621N53f5foqrKQHbfpSJx5sb
         TIUCrjc8YW3edJia1N8uROEqgkD3CJR8YBysoHkmolGxJfE/WU3xFcjBa1HgJd1rlGdC
         U32ENUQmG0eAxc7vEnYDR9Cf2ieNYIGx8K+1rAYyX8gW8ZOyUsQYL4Gycn3F/XmeTpRr
         fQ0hMIV2Mc0CAkv4zyO8LZ86TbgCOqJKJR/vM0s7hX074/9O4cU8wXPFszBW9A8wWgwV
         qZ7guslny6umXzAMqYoHs8/lzFfL8BkUvRh0fXOWLpWoBw1A0TRxFeiOoQiY8hifRvhD
         ibyw==
X-Gm-Message-State: AOJu0YyJ27oZ6eExfZ0DvKlTRyUNOHgX1WOusluGgBpG3hQM7aL6XNlE
        ELVLxPcRa7Ih3d+Cqo52L+eBkZ5FDv9jDOaKtfb+1ehl
X-Google-Smtp-Source: AGHT+IE902EKqQ6/KFVUskQerK7Q6wIl/GATD1ZcWipKPf9EgmCin8swRebdIjmE5FmI77UpUWRDsO+9snkNx1j70kE=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr6813280oov.0.1692637780546; Mon, 21 Aug
 2023 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230817093011.1378-1-sumitg@nvidia.com> <20230817093011.1378-3-sumitg@nvidia.com>
 <CAJZ5v0hkm6eou9E+CVwasURjPG3RtVH+TMvvzGqVwQnDDrBocA@mail.gmail.com> <63eea3ac-4714-2c54-c740-84f9f9e7fd64@nvidia.com>
In-Reply-To: <63eea3ac-4714-2c54-c740-84f9f9e7fd64@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 19:09:24 +0200
Message-ID: <CAJZ5v0hBmOh3gOa71sAV1kbzCzoJO-gphr4CEgyA6+-+FquvOQ@mail.gmail.com>
Subject: Re: [Patch 2/2] ACPI: processor: Add support to configure CPUFREQ
 reduction pctg
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        lenb@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, srikars@nvidia.com,
        jbrasen@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 21, 2023 at 3:24 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>
>
>
> On 19/08/23 00:10, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Aug 17, 2023 at 11:31 AM Sumit Gupta <sumitg@nvidia.com> wrote:
> >>
> >> From: Srikar Srimath Tirumala <srikars@nvidia.com>
> >>
> >> Add support to configure the CPUFREQ reduction percentage and set the
> >> maximum number of throttling steps accordingly. Current implementation
> >> of processor_thermal performs software throttling in fixed steps of
> >> "20%" which can be too coarse for some platforms. Change that by adding
> >> new config to provide the reduction percentage.
> >>
> >> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> ---
> >>   drivers/acpi/Kconfig             | 15 +++++++++++++++
> >>   drivers/acpi/processor_thermal.c | 19 ++++++++++++++++---
> >>   2 files changed, 31 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >> index 00dd309b6682..287cf58defbf 100644
> >> --- a/drivers/acpi/Kconfig
> >> +++ b/drivers/acpi/Kconfig
> >> @@ -254,6 +254,21 @@ config ACPI_DOCK
> >>   config ACPI_CPU_FREQ_PSS
> >>          bool
> >>
> >> +config ACPI_CPU_FREQ_THERM_HAS_PARAMS
> >> +       bool "CPU frequency throttling control"
> >> +       depends on ACPI_PROCESSOR
> >> +
> >> +config ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
> >> +       int "Minimum throttle percentage for processor_thermal cooling device"
> >> +       depends on ACPI_CPU_FREQ_THERM_HAS_PARAMS
> >> +       default 20
> >> +       help
> >> +         The processor_thermal driver uses this config to calculate the
> >> +         percentage amount by which cpu frequency must be reduced for each
> >> +         cooling state. The config is also used to calculate the maximum number
> >> +         of throttling steps or cooling states supported by the driver. Value
> >> +         must be an unsigned integer in the range [1, 50].
> >> +
> >
> > I don't think that the new Kconfig symbols are particularly useful.
> > At least they don't help the distro vendors that each would need to
> > pick up a specific value for their kernel anyway.
> >
> > I also wonder how the users building their own kernels are supposed to
> > determine the values suitable for the target systems.
> >
>
> We observed some perf gain after reducing the throttle percentage.
> Currently, kept the default to '20%' as before.

So you should add this information to the patch changelog, ideally
along with the description of the hardware configuration in which the
improvement has been observed.

> Based on need, a vendor can overwrite the default value with macro
> 'CONFIG_ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG'. Otherwise, the behavior
> will remain same.

Yes, that's how it works.

What I'm saying is that the way it works does not appear to be
particularly useful.

For example, how exactly is a distribution supposed to guess the
"right" value for their general-purpose kernel?
