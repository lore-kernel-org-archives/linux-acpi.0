Return-Path: <SRS0=EjMF=DC=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF6C4727C
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Sep 2020 11:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272F7221EB
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Sep 2020 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601031634;
	bh=KrW0g03djIcPLlxgnDlTruSHe3Cu7TGyUi0qn4ROk1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=voLRuzUNdhynFat/hBI2RSk+SaMG5lEvdKV1W4lVskW7J4T27pvEX15SIpO/GmXap
	 M6AzaHTOG2wHXBD1vS5121yp7Ochfl9r3/py5roRk6oPqSs4QdEgveXM2VVHd1uNw2
	 YZFhIWUarHdmTtO5RHumP5rqrPmUv9lulYlsvtgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgIYLAd (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Sep 2020 07:00:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37485 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYLAc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 07:00:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id o8so1892609otl.4;
        Fri, 25 Sep 2020 04:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6a1lgzCizgypHaz6ViKZR7Okd3xqX1EIgWjVLFJSdI=;
        b=BLnwAs8+q1kBgi00sC9RS+bu0DzRpB8JqNSBz2Kg/fzQ1qCQ0hFVZ72N1MfKJB/oJi
         NWfgtLfaF09CehdCVIk0gOAkDz5QZnHyLXqC35t7cnJfgxAe09zyWT9rNw2bEgOa95I+
         17f/wGFOHLCCoZqxLu7q8JiuJYlafFCdt8gIPIh/kih5OqV9EXOzwwqRFWXBefUnWQxc
         DV/N1kyIR3OAH18v7XUnzUpUZYPaWFeQXfqmC28lvsjSoXrElyY8qJXHd4GauHyCkwLt
         nfxe0oKHjqEo0Ozy2qcXfw7DIrA+dLnHoJfGMmRNurqqPuwZ4xArSsVk56A73SKgprm9
         q6Wg==
X-Gm-Message-State: AOAM530Cr2ZDyHooxv9Q0bfQOnVPCLebKkn5A2AVKZgXrYsiNgZiNI+u
        DvZOsY/T5FTEEVnLsZmDPNGFXIm2V6TTsuSjQXRJsJdO
X-Google-Smtp-Source: ABdhPJwoJMoYw5QP1bHK1gX/+M8dxaaaRmbUU6t31+WvNBVHnWkKECelMHMb1PaSIYFzdPpNULW1u3u0j0WspqIgIKc=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr2457303otj.262.1601031632042;
 Fri, 25 Sep 2020 04:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200913223403.59175-1-alex.hung@canonical.com>
In-Reply-To: <20200913223403.59175-1-alex.hung@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 13:00:21 +0200
Message-ID: <CAJZ5v0jU_E5M0QmG-cr5zQxt99Tr562A8k1fLG=q=DpqmdB+_g@mail.gmail.com>
Subject: Re: [PATCH][V2] ACPI: video: use ACPI backlight for HP 635 Notebook
To:     Alex Hung <alex.hung@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 14, 2020 at 12:34 AM Alex Hung <alex.hung@canonical.com> wrote:
>
> Default backlight interface is AMD's radeon_bl0 which does not work on
> this system. As a result, let's for ACPI backlight interface for this
> system.
>
> BugLink: https://bugs.launchpad.net/bugs/1894667
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>
> V2: correct Cc to stable
>
>  drivers/acpi/video_detect.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 2499d7e..05047a3 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -282,6 +282,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
>                 },
>         },
> +       /* https://bugs.launchpad.net/bugs/1894667 */
> +       {
> +        .callback = video_detect_force_video,
> +        .ident = "HP 635 Notebook",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "HP 635 Notebook PC"),
> +               },
> +       },
>
>         /* Non win8 machines which need native backlight nevertheless */
>         {
> --

Applied as 5.10 material, thanks!
