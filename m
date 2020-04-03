Return-Path: <SRS0=YzXp=5T=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A324CC2BA17
	for <linux-acpi@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A2B206B8
	for <linux-acpi@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585905873;
	bh=pIUOt/pDMs2hH2i/2cPAyEK+71GSMZiBziLnVig1Hmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HsjmQNcVDMgnvAeG9yRhScbJe4GSU5M9MYdD6qs8++B8i4fKEK4TUbPl2qAGKhGTq
	 r50Rdk8FM4yGLVFgXayVQ8AeVZ4EmDSm0MOD7Lt3bbqWXw1lnaxPiV63Py+aBY4XQO
	 nhGDy/Sx8xo67fDDx9Ql6duQWuzqihQyJ5Dbu+1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbgDCJYc (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42317 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCJYc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2020 05:24:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id z5so6557380oth.9
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2020 02:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdFApNje4dVg6X1gfPZZooLWocDLTTaIU6KupyCadzc=;
        b=IxLm7zzSAbY2RBja1BlBTkiBPcmIMCYuVcurTFZH5UuVxf7K57Tt21r6Kr6Fb078t/
         LZckrAhMY762G9n5DCzUbwKFSEoLmiXlASBUF6JD4Km5eW7JxhTzeHj+wNmLIpyFEcjB
         kpxTPJ5tRxJ3C6uIWVwTk6c0+FxXySC9CY7azntoFJNZ5ggdaKIkUy8+jos0wMDqHB3H
         PKXEOSHLV4Hp03fXhVlPjekVtKjGfErfVxY/3tDvNu5s1buwLnuqshGIxUZalOBFf8qG
         H6JdtCnm2ha3+M8P9TsnIq5a2ywkQt1ziZobm4ukcWzwFLoCSApj8/nf9M/dogRRwX16
         pjAg==
X-Gm-Message-State: AGi0Pub0nJREEbp/PdSFomQc258SkCZUol35IMDzjxF9ohxFxu6+X+jz
        GhKLqR6RPfA+tTYcWusoG0Z8aikzYFQk0tH9NhU=
X-Google-Smtp-Source: APiQypJuXn7s2GqX4r3fjosMCpppzhRJ0zVb9uZF/5UUFNv03mouaz5qndIrJwVA2p47c5q5t3D5YwS1ivj/dDGXal8=
X-Received: by 2002:a9d:750a:: with SMTP id r10mr5371551otk.118.1585905870777;
 Fri, 03 Apr 2020 02:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200403064712.26746-1-yanaijie@huawei.com>
In-Reply-To: <20200403064712.26746-1-yanaijie@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Apr 2020 11:24:19 +0200
Message-ID: <CAJZ5v0gHsUMS+LciZnzC12=QO+hsVkeQWHDR1LC8PMCxoWvtAQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: make acpi_gbl_next_cmd_num static
To:     Jason Yan <yanaijie@huawei.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 3, 2020 at 8:48 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/acpi/acpica/dbhistry.c:30:5: warning: symbol
> 'acpi_gbl_next_cmd_num' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Bob, Erik, I'm leaving this one to you.

> ---
>  drivers/acpi/acpica/dbhistry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
> index bb9600b867ee..801b35a08174 100644
> --- a/drivers/acpi/acpica/dbhistry.c
> +++ b/drivers/acpi/acpica/dbhistry.c
> @@ -27,7 +27,7 @@ static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
>  static u16 acpi_gbl_lo_history = 0;
>  static u16 acpi_gbl_num_history = 0;
>  static u16 acpi_gbl_next_history_index = 0;
> -u32 acpi_gbl_next_cmd_num = 1;
> +static u32 acpi_gbl_next_cmd_num = 1;
>
>  /*******************************************************************************
>   *
> --
> 2.17.2
>
