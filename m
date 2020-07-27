Return-Path: <SRS0=21jG=BG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC16C433E1
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD39620714
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595853880;
	bh=tAwVUpxvJNzfqblTALKuRFp9/teEYCCPXiqtpWnP87s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kgk9zPeHYa71O77fvdazQBhoN2Q92m4ZRg3lhWSO4VHKmMaH6FL7PfYENVSuccy2b
	 oe4H7R+0/lAweuJtHD2KaXeQqNL44b+dl4cTyGWEUYzpAYJWTqCkAxL71ECeEnzhAW
	 LnYuB1IkLx2NEQZOGP07H8XR50y8Mj8FsBf1XpGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgG0Mok (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:44:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34651 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgG0Mok (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 08:44:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id q4so2458977oia.1;
        Mon, 27 Jul 2020 05:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XF+2/WB5y2btEPphDZr/2V6HkcYCLBD66OV9ty+StNI=;
        b=l+KECtoyY/DsNU58m1UtY/DmviqCAK9bNOqeETNcQ7f2KknlpuKoM0LSdm2OZWu+R4
         WLY8Z4aNQbQEtxOI1JbFqB0Vk+5MchD3YCLRf0875MToau/GFT/0BfK6o6sObPsUSgh+
         gqboQaZe4u46xyC/bOr0OVkf64yJzycmFPyCRdGtzl+qsUo8bJEOmC0fxVMuler9vIjF
         nDZRv1tfmfZMojUn9HkdpiEcqUUwi1/vPTQfni2qks62cIRiGTVsKzIVzuF+9wLKkGzz
         wTwpSz2bWFPD5hJ7FGj+WZoCHmifd53LTdImXuEbtgDvMdQloEZAl1PMckmDgoxagJOG
         KJPw==
X-Gm-Message-State: AOAM53210Z2gBkhSQ/s2sajmZHQJGkuJeH1Hcqe84fUquxMmaO7Am72K
        mQsV+12SrBJ4aiX/TgJOKQp178pVbsGjsLKcmHrryg==
X-Google-Smtp-Source: ABdhPJxbaCuZSlohbgTWhZLnfvKQNqvzBTick1y8KPp41KCYIjJEqwZwPKikdgbbscc6dbSyIgnknikZ9GS1teQKyeI=
X-Received: by 2002:aca:3646:: with SMTP id d67mr6582450oia.68.1595853879110;
 Mon, 27 Jul 2020 05:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200719002652.20155-1-rdunlap@infradead.org>
In-Reply-To: <20200719002652.20155-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 14:44:28 +0200
Message-ID: <CAJZ5v0hw2uZanO6vduyLufh926XSHVwkKRDEs0e8XWgowwqJ4g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: actypes.h: drop a duplicated word
To:     Randy Dunlap <rdunlap@infradead.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jul 19, 2020 at 2:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop the repeated word "an" in a comment.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  include/acpi/actypes.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20200717.orig/include/acpi/actypes.h
> +++ linux-next-20200717/include/acpi/actypes.h
> @@ -824,7 +824,7 @@ typedef u8 acpi_adr_space_type;
>   *
>   * Note: A Data Table region is a special type of operation region
>   * that has its own AML opcode. However, internally, the AML
> - * interpreter simply creates an operation region with an an address
> + * interpreter simply creates an operation region with an address
>   * space type of ACPI_ADR_SPACE_DATA_TABLE.
>   */
>  #define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 0x7E     /* Internal to ACPICA only */

This is an ACPICA header file, so it's better to route the change
through the upstream.

Erik, can you pick up this one, please?
