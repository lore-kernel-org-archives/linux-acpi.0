Return-Path: <SRS0=EWZn=EN=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB5C388F9
	for <linux-acpi@archiver.kernel.org>; Sat,  7 Nov 2020 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAB420872
	for <linux-acpi@archiver.kernel.org>; Sat,  7 Nov 2020 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604738241;
	bh=w4U/UL1lvYAslbUWD/fsjmoZFQx7khixAloqPEBIX+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rzeMdhrl7RvPK/7KZmpnu3WN2YKRb7WNiRN22cRw3QtZPWZ6SW3INBryibR7K2kiD
	 hwACC92zuI5G6KJgoBzVdzt6uZMLnUZAnvEuWyqStOHww8jUnp0Iz0yuJbNLnPYciW
	 faWsPas3tKkQ960OKUVZEDph7jupzQeR1foO29Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgKGIhU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 7 Nov 2020 03:37:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgKGIhU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 7 Nov 2020 03:37:20 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C064B20872;
        Sat,  7 Nov 2020 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604738239;
        bh=w4U/UL1lvYAslbUWD/fsjmoZFQx7khixAloqPEBIX+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f2vu2lwdokEHxurAhG52b0TNKg14+owYA1kauL8JiHyRFO/1uKxTX8W+DNRfQ/xRr
         O4gOYxRLRBLfktM/Mg/1QUOKIAm+ZuB7MjepJBktMJcVZCEWBU9/fuBgQUjH6YjJka
         jhEXzWDI1l8JHRfwnq1ZTcnPObYKpngiliUflQ3E=
Received: by mail-ot1-f43.google.com with SMTP id k3so3581439otp.12;
        Sat, 07 Nov 2020 00:37:19 -0800 (PST)
X-Gm-Message-State: AOAM531lPmqLfn6aKmNgsMbQ0kEF4gzU/O2SaiyznfsgZO5dtd6JUU1h
        diwZ7OQJ9BOh8NsY6GVzuz2ivgJduCNAisNEOYI=
X-Google-Smtp-Source: ABdhPJyHG0914bC2DpBc0bby7WmDT1RzD2jWXi0CvhEBt2MGBK9BJTEuw8wIfEglwO4ciIQu0rMzI3Xw+IPCn2xtWXc=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr3601691otk.108.1604738239175;
 Sat, 07 Nov 2020 00:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20201107083432.3175710-1-ndesaulniers@google.com>
In-Reply-To: <20201107083432.3175710-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 7 Nov 2020 09:37:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE=V96pJ7xK=9xMh-1Eph4FH7S4WDXDyJUH+82_Zn5DXA@mail.gmail.com>
Message-ID: <CAMj1kXE=V96pJ7xK=9xMh-1Eph4FH7S4WDXDyJUH+82_Zn5DXA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: GED: fix -Wformat
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 7 Nov 2020 at 09:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Clang is more aggressive about -Wformat warnings when the format flag
> specifies a type smaller than the parameter. It turns out that gsi is an
> int. Fixes:
>
> drivers/acpi/evged.c:105:48: warning: format specifies type 'unsigned
> char' but the argument has type 'unsigned int' [-Wformat]
> trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
>                                             ^~~
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Fixes: commit ea6f3af4c5e6 ("ACPI: GED: add support for _Exx / _Lxx handler methods")

Please drop the word 'commit' here

> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/acpi/evged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index b1a7f8d6965e..fe6b6792c8bb 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -101,7 +101,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
>
>         switch (gsi) {
>         case 0 ... 255:
> -               sprintf(ev_name, "_%c%02hhX",
> +               sprintf(ev_name, "_%c%02X",
>                         trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
>
>                 if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
