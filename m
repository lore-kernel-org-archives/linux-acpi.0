Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C54ECAAD8
	for <linux-acpi@archiver.kernel.org>; Wed, 21 Sep 2022 18:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIUSlN (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUSlM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 14:41:12 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B56597B09;
        Wed, 21 Sep 2022 11:41:11 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id b23so4730793qtr.13;
        Wed, 21 Sep 2022 11:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DeGp/xWaAFa+QdM9cm9tQykvze2r9Dy8om4s4mjTC5M=;
        b=12fqQzuN2IrRMPylH2GuiE+uljedNupVX+SDCuOV726vlrl56N+Asyoj3MCMt4HUUP
         pBK9feu98i1XleE5jwKcfh3P4M6kDJCUwpv+jpbK1TZF0MIp59GGOhkxC5W+Isa7Kw37
         PF+LzaBhG7mfOU4aD7kVXrjGso5OQm6DPX8n/VYf8VBtTA9go1Qxnyj+Dsl0Km7B4s9q
         ugp8jPh4okkk/YVgmgsD/s0qE2QIEE4UAFqBgoM0q+e2QwWAL+Yp9LvwPyB64/Gl+RUa
         Fu2XTnV3HKl0CStxWPeVUAeXSkWF6hU9oMQeJGP+erDSoPlgqIPyLJ64gXBzq2jGrCYJ
         0SSA==
X-Gm-Message-State: ACrzQf1Rwc0e6XIPFc2ERgKzoTdl3DeZaai00352ywTxiOjmw8MpNjJv
        wxfh4eg8qGCgkFAIX/tjDpGu9dp3CgZ3UyZo+h8=
X-Google-Smtp-Source: AMsMyM7hX1ZEi2vGpQSesBjQRkAJQb4crYhc3s97ordcPx5xPHcEtKmCzDnnoYdYaLBF6AW8WG19qJRNTcLhQWm+A/E=
X-Received: by 2002:a05:622a:451:b0:35d:57:e1c9 with SMTP id
 o17-20020a05622a045100b0035d0057e1c9mr6607162qtx.49.1663785670570; Wed, 21
 Sep 2022 11:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220916182609.3039-1-mario.limonciello@amd.com> <20220916182609.3039-4-mario.limonciello@amd.com>
In-Reply-To: <20220916182609.3039-4-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Sep 2022 20:40:59 +0200
Message-ID: <CAJZ5v0h-4q2bXUdPRHkhTjnM2etx=98PVRaVn7jdeW=kFdGBpw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] acpi/x86: s2idle: Add module parameter to prefer
 Microsoft GUID
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        travisghansen@yahoo.com, catalin@antebit.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 16, 2022 at 8:26 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> OEMs have made some mistakes in the past for the AMD GUID support
> and not populated the method properly.  To add an escape hatch for
> this problem introduce a module parameter that can force using
> the Microsoft GUID.
>
> This is intentionally introduced to both Intel and AMD codepaths
> to allow using the parameter as a debugging tactic on either.
>
> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
> Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Add tags
> ---
>  drivers/acpi/x86/s2idle.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2c5931d247a2..127215150b84 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -27,6 +27,10 @@ static bool sleep_no_lps0 __read_mostly;
>  module_param(sleep_no_lps0, bool, 0644);
>  MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
>
> +static bool prefer_microsoft_guid __read_mostly;

I would call this prefer_microsoft_dsm_guid and make changes below analogously.

> +module_param(prefer_microsoft_guid, bool, 0644);
> +MODULE_PARM_DESC(prefer_microsoft_guid, "Prefer selecting Microsoft GUID for LPS0 device");

And here: "Prefer using Microsoft GUID in LPS0 device _DSM evaluation".

> +
>  static const struct acpi_device_id lps0_device_ids[] = {
>         {"PNP0D80", },
>         {"", },
> @@ -402,6 +406,9 @@ static int lps0_device_attach(struct acpi_device *adev,
>         if (lps0_device_handle)
>                 return 0;
>
> +       lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
> +                                                   ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
> +                                                   &lps0_dsm_guid_microsoft);
>         if (acpi_s2idle_vendor_amd()) {
>                 static const struct acpi_device_id *dev_id;
>                 const struct amd_lps0_hid_device_data *data;
> @@ -416,16 +423,12 @@ static int lps0_device_attach(struct acpi_device *adev,
>                 rev_id = data->rev_id;
>                 lps0_dsm_func_mask = validate_dsm(adev->handle,
>                                         ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
> -               lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
> -                                       ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
> -                                       &lps0_dsm_guid_microsoft);
>                 if (lps0_dsm_func_mask > 0x3 && data->check_off_by_one) {
>                         lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
>                         acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
>                                           ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
>                 } else if (lps0_dsm_func_mask_microsoft > 0 && data->prefer_amd_guid &&
> -                               (!strcmp(hid, "AMDI0007") ||
> -                                !strcmp(hid, "AMDI0008"))) {
> +                               !prefer_microsoft_guid) {
>                         lps0_dsm_func_mask_microsoft = -EINVAL;
>                         acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
>                 }
> @@ -433,7 +436,8 @@ static int lps0_device_attach(struct acpi_device *adev,
>                 rev_id = 1;
>                 lps0_dsm_func_mask = validate_dsm(adev->handle,
>                                         ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
> -               lps0_dsm_func_mask_microsoft = -EINVAL;
> +               if (!prefer_microsoft_guid)
> +                       lps0_dsm_func_mask_microsoft = -EINVAL;
>         }
>
>         if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
> --
> 2.34.1
>
