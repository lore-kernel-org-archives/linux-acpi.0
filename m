Return-Path: <SRS0=21jG=BG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D9C433E3
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B181A2074F
	for <linux-acpi@archiver.kernel.org>; Mon, 27 Jul 2020 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595856045;
	bh=SgS5gYaRAomFrxaGw34uigZGK/M6mbt1iMAwPQCOMTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hYiCNGdAyfTiYf3Zve5ytgDMR1YntdT6gpNHkZQDPL6gSin1TCOh7IgeXRff6a4vu
	 +BsrnLHfdYmhVQvUuM2l2uewBIUqLX9f25aRfZPHnr1nRrOSxy7f+qPRs0IuY6jLNh
	 mnQSmJLzyyfYiKRa9HTMyZW5S5bR+QGecviFs4fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgG0NUp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:20:45 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:41046 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0NUp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 09:20:45 -0400
Received: by mail-oo1-f65.google.com with SMTP id z23so3137362ood.8
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2020 06:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d28RhC5d1nJKDEVRoGOssHvzGZOdQJnjXeVf62R8D88=;
        b=DN3wEVyQrw73bSsAbzHlALtGz+LZPfKq6oRk2R/GHDCrEN57cLhfdi+p5qbrHlNx3N
         lJj8m4aMRhbYVPn7m85+U7Z3t0GwXBzwGkHipQSU64sdntlANcwNH5rOjoQ7gBB/EFau
         1Id4QZu/JFB6jgGTb64RvzmOrhMTFwKsQlsbSxEtfpWzPDzOR83RGmhssUZOb3eJNsiD
         EGtmlgWVJH4K8oeMmhwjwaUf47LR9zKKaZVQlHnBNR7IQ3XR/2EwTC2rPBXDR89/3F9C
         O6efVu0Kt/VeXqoLL+Le1MVb2byKmSu295syidxZ3ceaHDUv4pJq/dWWGXkglaAhe7Pj
         HWrw==
X-Gm-Message-State: AOAM530xtqdQ5SoV9uJqSeYoz28zG+BWJyNvyOIvj6HrTeeY3dVTi0C5
        ziuXSYUeTbDeceOFalCZiuF8hRIysa1+aUOBZJM=
X-Google-Smtp-Source: ABdhPJzdgNMZnB1P0I+XUJxBOeXPXbq8Z3k9MH1V6UxFEnRgwYejer/QrnYA7XxtroyogOjjlu2ijSYctPRb2pnodIw=
X-Received: by 2002:a4a:e618:: with SMTP id f24mr4597543oot.75.1595856044471;
 Mon, 27 Jul 2020 06:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 15:20:33 +0200
Message-ID: <CAJZ5v0gYYDr+QNUpDqPgBQrWaN8h3oanRh8_osCkTSQRrpHHSQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Minor cleanups
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 21, 2020 at 12:06 PM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> When reviewing patchset "[PATCH v2 0/6] ACPI: Only create NUMA nodes
> from entries in SRAT or SRAT emulation." [0] from Jonathan, I found some
> code can be improved, here are some cleanup patches.
>
> [0]: https://www.spinics.net/lists/linux-mm/msg220777.html
>
> Hanjun Guo (3):
>   ACPI: tables: Remove the duplicated checks for
>     acpi_parse_entries_array()
>   ACPI: NUMA: Remove the useless sub table pointer check
>   ACPI: NUMA: Remove the useless 'node >= MAX_NUMNODES' check
>
>  drivers/acpi/numa/srat.c | 10 +---------
>  drivers/acpi/tables.c    | 17 +++--------------
>  2 files changed, 4 insertions(+), 23 deletions(-)
>
> --

All three patches applied as 5.9 material, thanks!
