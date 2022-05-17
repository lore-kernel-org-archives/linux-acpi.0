Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3711C433F5
	for <linux-acpi@archiver.kernel.org>; Tue, 17 May 2022 14:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347734AbiEQOty convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 17 May 2022 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346978AbiEQOtx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 10:49:53 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A944F9FB;
        Tue, 17 May 2022 07:49:50 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id j4so228219ilo.12;
        Tue, 17 May 2022 07:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ZslXs9Oa1L/5bVsY6BEu0AQjOEth2behUi/2CLOaHM=;
        b=bxC7oQzuBeBHBGAk/rhHUiUsvi7KPS7vjeKYMWqixalC9o4ziqOfVv0NVbrP5jOVq/
         qSPsKIFcwe3UDBWZtPIpAPOpL/sNOdeihWKCKnnahHGTfPRDiQdMdupuWRG5RE0hdvl0
         kKSbmNyIyQ/SykmcyfniVQRYRXsOunxObr8vPoxGQ2giuzscjGspiIOtjpltnTCL3+Xp
         mpIbNMBQjAPbAXfjIBMy7nstO14/d58ofOWrvKlGRNPYXLAfzqv9NXt3r2nSCQl7x4G7
         iuw+OeoVzW6ETWhmcUnKxDCDzVhEJsBTEKDs0iLr7wyRuOWNkXfEwd4VFKalTdkBkx68
         6kiw==
X-Gm-Message-State: AOAM532xZNOuGkKQ8HGJ3zeGZ4sxPp6yzYOok/Oqv67S+VLMOP4HYhQ8
        7v1GSeiOxyYKIoeOuy0FkeKalWoYnHGukTBy9WAffqOE
X-Google-Smtp-Source: ABdhPJz/TCHRZwbAMBoZnzsvoQM2EzWQPsK6XXBS/s2f1u8KwPALfVkLFrSk4nQbpPO1OKehJPmeWq8FTDuzb60qj+o=
X-Received: by 2002:a05:6e02:1445:b0:2d1:3440:7f27 with SMTP id
 p5-20020a056e02144500b002d134407f27mr2901241ilo.106.1652798989700; Tue, 17
 May 2022 07:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <f80dfd57fdca87897f070a3ea4ee0a26b03e7831.camel@mniewoehner.de>
In-Reply-To: <f80dfd57fdca87897f070a3ea4ee0a26b03e7831.camel@mniewoehner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 16:49:38 +0200
Message-ID: <CAJZ5v0h+kKwdntGPC5PP6N0ZRbRzLxuwcwTGm-PNBH6Z3mnETg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: utils: include UUID in _DSM evaluation warning
To:     =?UTF-8?Q?Michael_Niew=C3=B6hner?= <linux@mniewoehner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 16, 2022 at 7:25 PM Michael Niewöhner <linux@mniewoehner.de> wrote:
>
> The _DSM evaluation warning in its current form is not very helpful, as
> it lacks any specific information:
>   ACPI: \: failed to evaluate _DSM (0x1001)
>
> Thus, include the UUID of the missing _DSM:
>   ACPI: \: failed to evaluate _DSM bf0212f2-... (0x1001)
>
> Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
> ---
>  drivers/acpi/utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index d5cedffeeff9..7da993f5b6c3 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -681,7 +681,8 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
> u64 rev, u64 func,
>
>         if (ret != AE_NOT_FOUND)
>                 acpi_handle_warn(handle,
> -                               "failed to evaluate _DSM (0x%x)\n", ret);
> +                               "failed to evaluate _DSM %pUb (0x%x)\n",
> +                               ret, guid);

Shouldn't this be "guid, ret" ?  Also, don't you want to print the
value of the GUID rather than the address of its location?

And I don't think you need to break the line here.

>
>         return NULL;
>  }
> --
> 2.34.1
>
>
