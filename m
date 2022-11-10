Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7938C433FE
	for <linux-acpi@archiver.kernel.org>; Thu, 10 Nov 2022 19:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiKJTq1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJTq1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 14:46:27 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8A31EE9;
        Thu, 10 Nov 2022 11:46:26 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id e15so2156035qvo.4;
        Thu, 10 Nov 2022 11:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7nK7N7s7Q2I+Tzb0MtzFx5d72ayGKHaggssqwPx8ag=;
        b=qSIJHCcAiT+j+tdgCHT0jPjB0zFymcA3UgVMVN47Jv9l+Ntj2JDaeFLd+aUF3BnzV6
         g7bWvwQkcXtxhU85SAdGzeA5dS+p3jc7UyNu2cA+hv3GjyNNBjg3sVLnJ+/AzvNgEE/t
         OJ4dKlym25RyB53pNql6fflIots5FI2kSIY96GpdaQa6Cm0W2XCgtH5J/BkAQqrgm0VH
         X4O9ky35g/rQN5fEL1dOhpCvRnXc6549krIPs/psnunSKqzTTfiKmMl2FHAtPcZAvZMs
         6niwO/3OLn6A+S/BCs6j6i5rQ2TKI2Upq7DKLm7/Up7Ecoh/0lfeKvrPIaIIHOrwahry
         nmlw==
X-Gm-Message-State: ACrzQf1dNlCgL9+tWXLxdComZrMyd4zdgTk1CnSoSUx1G/Ppg/2acYuq
        THK4W3uFhxWN8ocO+Wd2dcmY/G1Km7NJIIzyWPoALtAv
X-Google-Smtp-Source: AMsMyM5+D/RGSxFl+L/hgdEMllL5z3CQ3q9CKIUa5B5pg23p1s8nrYQlNTD/AaUMvOxRRiOsIUKJLcD5bWWw58BPz9c=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr51904333qvj.3.1668109585620; Thu, 10 Nov
 2022 11:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20221110153924.18258-1-kane.chen@intel.com>
In-Reply-To: <20221110153924.18258-1-kane.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 20:46:14 +0100
Message-ID: <CAJZ5v0h6jQLvTxAKDfqvcPgkpHu963E6Me5CG8w2LzxtTN5Pnw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Print full acpi path while adding power
 resource dev
To:     Kane Chen <kane.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 10, 2022 at 4:44 PM Kane Chen <kane.chen@intel.com> wrote:
>
> While debugging boot time issue, it's hard to know what power
> resource device kernel is initializing.
>
> It's very helpful to print full path so that ppl don't
> need to guess what device is under init. Especially the system
> has more than 2 power resource have same name
>
> Before:
> [    0.194348] ACPI: PM: Power Resource [RTD3]
> [    0.274127] ACPI: PM: Power Resource [RTD3]
> [    0.275086] ACPI: PM: Power Resource [PR00]
> [    0.438261] ACPI: PM: Power Resource [PR01]
>
> After:
> [    0.204875] ACPI: \_SB_.PCI0.RP01.RTD3: [Power Resource]
> [    0.284273] ACPI: \_SB_.PCI0.RP08.RTD3: [Power Resource]
> [    0.285231] ACPI: \_SB_.PCI0.I2C3.H016.PR00: [Power Resource]
> [    0.446410] ACPI: \_SB_.PCI0.SPI1.CRFP.PR01: [Power Resource]
>
> Signed-off-by: Kane Chen <kane.chen@intel.com>
> Change-Id: I075146e574aa0d5bfd2f97e3da5f73061af6888a
> ---
>  drivers/acpi/power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index f2588aba8421e..23507d29f0006 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -967,7 +967,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
>         if (acpi_power_get_state(resource, &state_dummy))
>                 __acpi_power_on(resource);
>
> -       pr_info("%s [%s]\n", acpi_device_name(device), acpi_device_bid(device));
> +       acpi_handle_info(handle, "New power resource\n");
>
>         result = acpi_tie_acpi_dev(device);
>         if (result)
> --

Applied as 6.2 material with edits in the subject and changelog, thanks!
