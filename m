Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C181CC4707A
	for <linux-acpi@archiver.kernel.org>; Fri, 21 May 2021 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9208361163
	for <linux-acpi@archiver.kernel.org>; Fri, 21 May 2021 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhEURSD (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 21 May 2021 13:18:03 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46866 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhEURSC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 13:18:02 -0400
Received: by mail-oi1-f176.google.com with SMTP id x15so20260095oic.13
        for <linux-acpi@vger.kernel.org>; Fri, 21 May 2021 10:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ks6/436sU89anEeGPFpg1RE/aEPcJjlgsG/vRrJbOUw=;
        b=ioUtZmA1Dsfq/oLZRagM0XJ2Hy+VnzAU6SlulDMmYpM90J/CPs7W2pVxQipMx+rpf8
         +t+mMlkfhhC7IdHxhLM+JC+yyzvUD0It/JK9YIk2/PapD1NuI0Itev8BroOlY8PuXUV0
         9JgRswSAJeTv67AzXAfWAFYFksptoCu7WK3YTAc6i2DM+rKpnMkqabnqTusUn5nNPAZC
         Cv33aB4zyDXZ8ZsAvbtaZw1YtKXipxf1uL+laOTG9mKOy6D778+WNfqPggBv1DJTCKyN
         +ncH5tR+L4lYbTc+28YsyC7E454idHQbcTPm7CU3BHDdHtWsiZtYn6abN/U+XdHUnNr2
         WmcA==
X-Gm-Message-State: AOAM532blEmpCFYZ4NqMendQd2o9u1jpPhaTR0vd/SAAE7cDhukEBiXs
        O0L1EpgEx57lNPY0tj0EgVmne06bkh5cDhgeFaC8K88M
X-Google-Smtp-Source: ABdhPJyf6L0NbmqicOPo7rNsPc4tBHNUlvk5cRDmokHLDY3V+6N+l1Zk174KuBTAYwq62MH9o9w0N3uYONcEfgtF5oM=
X-Received: by 2002:aca:1910:: with SMTP id l16mr2817154oii.69.1621617399046;
 Fri, 21 May 2021 10:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <1621478348-33757-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1621478348-33757-1-git-send-email-zhangshaokun@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 19:16:28 +0200
Message-ID: <CAJZ5v0jxG1khtfLHNDPPySZkMRyasVvW53XX1Z+k2S4n0rwjNA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove redundant assignment of error
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 20, 2021 at 4:39 AM Shaokun Zhang
<zhangshaokun@hisilicon.com> wrote:
>
> 'error' will be initialized and cleanup the redundant initialization.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/acpi/event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
> index 92e59f45329b..bfb16cf8f807 100644
> --- a/drivers/acpi/event.c
> +++ b/drivers/acpi/event.c
> @@ -165,7 +165,7 @@ static int acpi_event_genetlink_init(void)
>
>  static int __init acpi_event_init(void)
>  {
> -       int error = 0;
> +       int error;
>
>         if (acpi_disabled)
>                 return 0;
> --

Applied as 5.14 material with edited subject and changelog, thanks!
