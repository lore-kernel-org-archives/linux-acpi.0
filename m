Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E8C433F5
	for <linux-acpi@archiver.kernel.org>; Thu,  5 May 2022 19:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384840AbiEETHn (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 5 May 2022 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384766AbiEETHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 15:07:38 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31454B848;
        Thu,  5 May 2022 12:03:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ec42eae76bso58989917b3.10;
        Thu, 05 May 2022 12:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d8jggKU6mOKErS+3k+HsyBKNRPIov5SQeHSvQ1qwKo=;
        b=fQGIewobS+NxJ3Q/9NPbYOQk4TeZTNA/GC2OYM9xhYU/2oWAU3pkTbCqnshLMi3A7F
         ZhUHvbn+1tSAuPBGojUo2y+Eo/rVpU5bQ4bbBD0Gg33XSd2mEqmmp6rBhPRCTFIYXAdy
         dQihFlLpWqUyslwQa9Ei0IG7wJ+AWlMpCyN1lwedboTJ0+RAi7vt++phfaSy19yGRv+f
         T4cqsyj++/t51GV47dlrv5EGvPCz/pwwLkfAx7diNj+p6UeIGqenEdQhLLdxtqI09Xo7
         OzCG/9M4IEIkBuyeQoNbGRxZhT0vGZOBX4OKFmXMje0pZ80wRKbvDnZhC36Kavf+aGXS
         rPmw==
X-Gm-Message-State: AOAM533sZJcVeecEtNtt9cQL519r8V6cVE655pikWQ+mtJJ9/0NLRrDV
        ZvxJDyufkSsEjxqg2nvYO2jdHj08SljWzExxzFA=
X-Google-Smtp-Source: ABdhPJw0KSCRp0CU4bSgUXmkXfGzcdWqfUroHgnRsTqE2GhIvIoHR9UIMvNgJwnp/08BKbH/c/lEqwZnq5cmCr50vNA=
X-Received: by 2002:a81:8493:0:b0:2f7:d7c3:15f8 with SMTP id
 u141-20020a818493000000b002f7d7c315f8mr26060015ywf.196.1651777435904; Thu, 05
 May 2022 12:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220428062430.31010-1-paul.gortmaker@windriver.com> <20220428062430.31010-3-paul.gortmaker@windriver.com>
In-Reply-To: <20220428062430.31010-3-paul.gortmaker@windriver.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 May 2022 21:03:45 +0200
Message-ID: <CAJZ5v0gkQqb-R1y_ZaPKTTiBNJYeNZd1csX=x_FkM9QxrR=pxA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: LPSS: make the Kconfig dependency on PMC_ATOM explicit
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 28, 2022 at 8:25 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> The code in acpi_lpss.c has been unconditionally using pmc_atom_read()
> for about the past six years.  This hasn't been a problem since you
> currently can't disable PMC_ATOM short of disabling PCI entirely.
>
> But it doesn't need to be that way, and so that we can change Kconfigs
> in a subsequent commit, we make sure LPSS selects PMC_ATOM in advance,
> so that existing .config files can live on with "make oldconfig".
>
> In theory, one could make LPSS build w/o PMC_ATOM, similar to what it
> did six years ago, but I doubt there is any demand for that now.

You probably are right and it will get some more build test coverage
with respect to the other option, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2ee26f10a814..163c198ec8ec 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -654,6 +654,7 @@ config X86_INTEL_LPSS
>         select COMMON_CLK
>         select PINCTRL
>         select IOSF_MBI
> +       select PMC_ATOM
>         help
>           Select to build support for Intel Low Power Subsystem such as
>           found on Intel Lynxpoint PCH. Selecting this option enables
> --
> 2.17.1
>
