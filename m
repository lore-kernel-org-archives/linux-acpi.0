Return-Path: <SRS0=bNam=DJ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEDAC4363C
	for <linux-acpi@archiver.kernel.org>; Fri,  2 Oct 2020 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CE620758
	for <linux-acpi@archiver.kernel.org>; Fri,  2 Oct 2020 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601658185;
	bh=oVQTVrfFSiASO+ZaMpo/OtIhmVsL0UF5SZ+OrQNw1zY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yj+d+rB5u39N7c5zF1dQyxvElctfpA9+zR71qQepH6flzaKRTKuhJcNjCdNEQesK1
	 J+I8MEPUaRStaZnttwxPs54cQDufNaELIdJCtEARB871t8aCaMmqx5Q5T2I03Lx0IO
	 BJ3SVwsEYYCC/olV5EdVYE0jHJqXCJWbPu9mBHdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBRDF (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 2 Oct 2020 13:03:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43680 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJBRDF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 13:03:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id n61so2004157ota.10
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 10:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CIlX7BLKx3mfpWeL5R/FKBM8L55G8uLfcJXAXkNSMU=;
        b=GtTt67ub4+8QK/uw3os6yVvyI2rx8qreg9/uYmP5075OZGo6aTxuVtLpnRMHYQWAFS
         T7bOfuh5H3XY8qag+ltE+/8JZrNea72O5ZP6+QGY4QCd7rHkB2lSVPBWE1gNyZ8kKKqK
         qhNfeKFNwSisQrJwX1On5njfm5PxtYZ6XmFFsfGcQkvYen3Xdosk7o9WXdeRbaN6Xlzc
         ZiMB9QwGg8mJbmFIFSo4EyYwG9e3a6iGGezHaDFRWid92tHwnbfB77HoT5tdLUtgeLd4
         ZSxGXdhjNiZB6pS+8Z5GoVMk+5ErBk4vmoNYA/tVWTjgUZdnTr5abOzUEZ7awCCfOKkU
         F2hw==
X-Gm-Message-State: AOAM530cpIg5dQeupUALr6LuNJ40JedZD/KVzANAV3jyRF1x9fK6SsOW
        +8zxcflyp9zLh+LbKkIxw2lHjm9nz22rMXcgF8y+TMZO
X-Google-Smtp-Source: ABdhPJzs8MMeVz5XY4VlVRHpTXxYw50+pRT8sZd0UOj8UTT+BIRDpRT0ocpicMmRpAbLwp8rWUeCCiU8Vb7erpn7kaY=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr2276633otp.167.1601658182439;
 Fri, 02 Oct 2020 10:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200927215042.GA281693@decadent.org.uk>
In-Reply-To: <20200927215042.GA281693@decadent.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 19:02:51 +0200
Message-ID: <CAJZ5v0gmUQw3U2yC3tQZWaZE-7DV2LUffa=dxRrF+PK5AMPAjg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / extlog: Check for RDMSR failure
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        971058@bugs.debian.org, jim@photojim.ca
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 28, 2020 at 12:27 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> extlog_init() uses rdmsrl() to read an MSR, which on older CPUs
> provokes a error message at boot:
>
>     unchecked MSR access error: RDMSR from 0x179 at rIP: 0xcd047307 (native_read_msr+0x7/0x40)
>
> Use rdmsrl_safe() instead, and return -ENODEV if it fails.
>
> Reported-by: jim@photojim.ca
> References: https://bugs.debian.org/971058
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/acpi/acpi_extlog.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f138e12b7b82..72f1fb77abcd 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -222,9 +222,9 @@ static int __init extlog_init(void)
>         u64 cap;
>         int rc;
>
> -       rdmsrl(MSR_IA32_MCG_CAP, cap);
> -
> -       if (!(cap & MCG_ELOG_P) || !extlog_get_l1addr())
> +       if (rdmsrl_safe(MSR_IA32_MCG_CAP, &cap) ||
> +           !(cap & MCG_ELOG_P) ||
> +           !extlog_get_l1addr())
>                 return -ENODEV;
>
>         rc = -EINVAL;

Applied as 5.10 material, thanks!
