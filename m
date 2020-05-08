Return-Path: <SRS0=aZej=6W=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937CC38A2A
	for <linux-acpi@archiver.kernel.org>; Fri,  8 May 2020 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC30D20746
	for <linux-acpi@archiver.kernel.org>; Fri,  8 May 2020 07:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588924743;
	bh=oGLEQ5sAjvnz3eUh91xK8a09DsPMMmKTJ2Z6abxsvqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t0/cLcZrR2I/X1Xq9aBAeuJZjX3jcSHeypUx2HxF2GXuzklxyRGOm0i+Q8n8K+NZ2
	 Ca+Zqpwkp93EzUiezY0gg6n9X0MKb/DrkX8xKuYsOgf4suN/pD+UOV5OtjW4qkX7K0
	 lWd/pFU4nBJ0gJsPU2uB4gTue2gHUYAf8/M3Qcf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHH7C (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 8 May 2020 03:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHH7C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 03:59:02 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D7A20746
        for <linux-acpi@vger.kernel.org>; Fri,  8 May 2020 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588924741;
        bh=oGLEQ5sAjvnz3eUh91xK8a09DsPMMmKTJ2Z6abxsvqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fJ6a5/nygGEvyU53DS1Y8VM3K42UYD7C7HjbWyC04G9tCbBSmG4hC/4c6QcRVtbbe
         gOm0RU4eJ29lyPVkPOjPI4QefMVl7E/FIqKTm4r43Qb9k6ou0ObCR8OFprvMWr3Yby
         IAzSSw07c1FrZxgtyj/F/ItAoyHiItR1Vukq3MyY=
Received: by mail-io1-f50.google.com with SMTP id w11so947334iov.8
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2020 00:59:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuZjk+ZmZzA+CtUWA6KPeUPhr5vZMYmGAuoCisYq+qgPxL6aV3nk
        x6cFzAfVkWLAWsllngZTz2tZi89zypsEV6r438k=
X-Google-Smtp-Source: APiQypIdqjD5MGoadJoDKdb0EEAop2TdCCcfVbYoPrrjr50p4id0tTbt7KPkrhFZmg0fsYMjDM9rX29PFEvt6RhhNfk=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr1417623iom.171.1588924741105;
 Fri, 08 May 2020 00:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <1588910198-8348-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1588910198-8348-1-git-send-email-guohanjun@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 8 May 2020 09:58:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGoe4aar3g3Qu7LU85JSdd1QqOMYp2mGtO1p2h_KiDb7g@mail.gmail.com>
Message-ID: <CAMj1kXGoe4aar3g3Qu7LU85JSdd1QqOMYp2mGtO1p2h_KiDb7g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: IORT: Add extra message "applying workaround"
 for off-by-1 issue
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 May 2020 at 06:07, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> As we already applied a workaround for the off-by-1 issue,
> it's good to add extra message "applying workaround" to make
> people less uneasy to see FW_BUG message in the boot log.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>
> v2:
>  - Print the extra message only for rid_in == map->input_base;
>  - Still based on top of for-next/acpi branch of ARM64 repo
>
>  drivers/acpi/arm64/iort.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index b011d25..6e445bc 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -332,6 +332,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>                        map, rid_in);
>                 if (rid_in != map->input_base)
>                         return -ENXIO;
> +
> +               pr_err(FW_BUG "applying workaround.\n");
>         }
>
>         *rid_out = map->output_base + (rid_in - map->input_base);
> --
> 1.7.12.4
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
