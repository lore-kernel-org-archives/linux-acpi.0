Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE1BC433FE
	for <linux-acpi@archiver.kernel.org>; Mon, 21 Nov 2022 19:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiKUTM5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKUTMd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2022 14:12:33 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC61380
        for <linux-acpi@vger.kernel.org>; Mon, 21 Nov 2022 11:12:25 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id i12so8663715qvs.2
        for <linux-acpi@vger.kernel.org>; Mon, 21 Nov 2022 11:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRW7o7ai1iK23NXW4Eo8q/ezbhbwdYsED7Bu/ByUp2Y=;
        b=YCCPD+puWz9n/T9w3J4vodrjJ7r0PZS2thuiDlLQGlPoTveqDkbEn03s1Rd0CthMRH
         bA1mXE6AwB6oEJ82NwseZ4yH3gFHcdOV4co8jcDJn1e39kZazrUZCJxZA6MPgU2IbfY+
         ljyEjRtxGxTMk+H3EPc/maBU3ZrNfqhcg4zEf1jrvAhH+GLKNS5Ql5uGbP3ozD8YadUg
         51j9iJww0tguHryLfb+qzAQAj1CHwglGW+OQ8z9Iz3wYXZaAgf57QtxiNlWT6dA57DZv
         nZrGeUUncn+VLtKhROwzwqSPPvMnFJYFCDtlJiW6P8gGdyIfh5WaV90uvhnK6H6TENVH
         fL6A==
X-Gm-Message-State: ANoB5pmSlnAdAwqdqz2EDHKUmBbIOW/9eBo5/lsgMkpidNQp+QaefhwB
        LHsAVEWPGhiGCh2K8y4JoxIDcWcfTRh0bv6MQv4=
X-Google-Smtp-Source: AA0mqf7lA3KKq21D5+rmeu7zX14D4bIzESbv7xsXb1Rb4ilO2KNqVDFSjBtOscLc4LkAFrYqmyvqTavNzGqLbYF0SOg=
X-Received: by 2002:a0c:c582:0:b0:4af:b750:b569 with SMTP id
 a2-20020a0cc582000000b004afb750b569mr1957252qvj.83.1669057944743; Mon, 21 Nov
 2022 11:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20221118140059.614302-1-sudeep.holla@arm.com>
In-Reply-To: <20221118140059.614302-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Nov 2022 20:12:13 +0100
Message-ID: <CAJZ5v0iChuAzaWBgxwk=dQmDaD0--XXG5owFP=rFn25w1MqsdA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: bus: Fix the _OSC capability check for FFH OpRegion
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 18, 2022 at 3:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> As per the ACPI specification(vide section Platform-Wide OSPM Capabilities)
> the OSPM must set this bit to indicate support for the usage of Functional
> Fixed Hardware (FFixedHW) Operation Regions rather than the firmware as
> expected in the code.
>
> Update the check accordingly to reflect the requirement as stated in the
> specification.
>
> Reported-by: Jose Marinho <jose.marinho@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/bus.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> Hi Rafael,
>
> Sorry for this, but looks like I clearly missed to noticed this change
> in the process of evolution of FFH OpRegions support. I had platform with
> buggy/prototype firmware(must be from the initial code-first proposal)
> and failed to catch this earlier. Thanks to Jose for identifying this.

Applied, thanks!

> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 245fb0828e47..2b9eac7e7777 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -300,8 +300,6 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
>
>  bool osc_sb_cppc2_support_acked;
>
> -bool osc_sb_ffh_opregion_support_confirmed;
> -
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
>  static void acpi_bus_osc_negotiate_platform_control(void)
>  {
> @@ -325,6 +323,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
>         if (IS_ENABLED(CONFIG_ACPI_PRMT))
>                 capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
> +       if (IS_ENABLED(CONFIG_ACPI_FFH))
> +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_FFH_OPR_SUPPORT;
>
>  #ifdef CONFIG_ARM64
>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
> @@ -385,8 +385,6 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>                         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
>                 osc_cpc_flexible_adr_space_confirmed =
>                         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
> -               osc_sb_ffh_opregion_support_confirmed =
> -                       capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_FFH_OPR_SUPPORT;
>         }
>
>         kfree(context.ret.pointer);
> @@ -1412,8 +1410,7 @@ static int __init acpi_init(void)
>                 disable_acpi();
>                 return result;
>         }
> -       if (osc_sb_ffh_opregion_support_confirmed)
> -               acpi_init_ffh();
> +       acpi_init_ffh();
>
>         pci_mmcfg_late_init();
>         acpi_iort_init();
> --
> 2.38.1
>
