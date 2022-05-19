Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D008C433F5
	for <linux-acpi@archiver.kernel.org>; Thu, 19 May 2022 18:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiESSKJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 19 May 2022 14:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiESSKI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2022 14:10:08 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A71FD9E95;
        Thu, 19 May 2022 11:10:07 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id f16so10407687ybk.2;
        Thu, 19 May 2022 11:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z81b8Srtp7QZyPM16Uw+wUtgxjFIb94YlV53dwZltco=;
        b=GSk1s6X7kLOEYgFQpfjapT+XIAZTVyMyyke0K5bdx9ZJ9vA7yrwrEOC8EjoOV5wgkP
         TfSeQKEVHohqpnBesD5K1MFIVL4tZ/Effb9D9GkMYk0fT+8j7bkEigQEghJ9IqYPwaKb
         7P40qOsU6MV9KAYGrF+ERD1LGc7cgzZEm4ZdzDjIa+umKU4nAjeMM+C2FMcdjotJ0vuD
         STSt+QNqVONquPuMnMbMQtFShJMmVgeYpJ1N+fFl1ZrzZYJVAB/blw1QP8qpI0H6vyp7
         sNnKA5t8revz+ROfVxxfgNZ0BolZ/0btvRXYKWBw3RAM72sl9RuzkywAmtEfNZlt8D7s
         hXfQ==
X-Gm-Message-State: AOAM533AaOW+REOqqn1dpVvml8ckvVwnkQtttG7wjDSK+keHdkEG5jEa
        U1EBFM08xtYngEgelAsEQ0oxSgsj0ffMl8mOXZk=
X-Google-Smtp-Source: ABdhPJx2uP0FlVua99VrwYYH36cc0i7y/DoDp8ZykDa+o7I8fmUv2+3BU+2izdvKG9nePuMmpKv825pGXxHXYrRuOcA=
X-Received: by 2002:a25:e7ce:0:b0:64d:6028:96b9 with SMTP id
 e197-20020a25e7ce000000b0064d602896b9mr5535107ybh.365.1652983806601; Thu, 19
 May 2022 11:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <f80dfd57fdca87897f070a3ea4ee0a26b03e7831.camel@mniewoehner.de>
 <CAJZ5v0h+kKwdntGPC5PP6N0ZRbRzLxuwcwTGm-PNBH6Z3mnETg@mail.gmail.com>
 <28686e8d994c297a78fb816805cd3652a8f8c90a.camel@mniewoehner.de>
 <CAJZ5v0hWxhn9WM3ciQgbZpa7x8JwpHK=Bz4kefB_3VnAM0gB9Q@mail.gmail.com> <c766b4d9758b9fd1e15af89643093c595404a665.camel@mniewoehner.de>
In-Reply-To: <c766b4d9758b9fd1e15af89643093c595404a665.camel@mniewoehner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 20:09:55 +0200
Message-ID: <CAJZ5v0ip7-6CUys88y8ydABJQsUUONAzyCa91qOiRsj2FCwMEg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: utils: include UUID in _DSM evaluation warning
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

On Tue, May 17, 2022 at 8:40 PM Michael Niewöhner <linux@mniewoehner.de> wrote:
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
> Changes in v2:
>  - fix arguments order
>  - fix indentation
>  - drop line break
>
>  drivers/acpi/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index d5cedffeeff9..3a9773a09e19 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -681,7 +681,7 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
>
>         if (ret != AE_NOT_FOUND)
>                 acpi_handle_warn(handle,
> -                               "failed to evaluate _DSM (0x%x)\n", ret);
> +                                "failed to evaluate _DSM %pUb (0x%x)\n", guid, ret);
>
>         return NULL;
>  }
> --

Applied as 5.19 material, thanks!
