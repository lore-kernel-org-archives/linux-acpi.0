Return-Path: <SRS0=o6KY=UN=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF521C31E44
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Jun 2019 09:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D68620850
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Jun 2019 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560504452;
	bh=tuzZRzwxs8RISzDZynOgEgJo/fTg01mfBzD57Znd+vI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hL2HvKaw/VhbxzizuB6h/ywElxjqKPKULNzZ6Sc1UgailWxJYSfbt27IDCmW/uRCF
	 FD6M0/Z9hxomugyAVWK0hlYOcGp8CWpqfI/f8TNIQf+wI+eMRiJNAV/KmVg9qOdnSm
	 3Q1yKtrKaemCDuNJVc8yc+qIEwEtYVZYAfYuaxu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFNJ1c (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:27:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35877 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFNJ1b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jun 2019 05:27:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id w7so1488777oic.3
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2019 02:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdYxGXUquCFqp1euMGOEx2JS0RE5ejFqEhfAuaeUeig=;
        b=cy7mBWRxutN4jWSP1ltunCt6WV5L29EYBjEXEftGVF9e6UtjFHNwrxhrS5P4fdJ4Ku
         dFiXDVp7IjJcaQPmQ9qh7iEINBi1JxgfAmviHRdKcunQZs4ioWsrQdV8tdIWgQtW2zHJ
         D6NJMFzI5JzSPsxZZHPDXlZUjgfmek5HUjokk4vP6J4JpTkhVPp/nmiD8T0uj2vXUcMA
         CdMsqXoJcFCczH5eEaX/SPK7ex/hts0PkQSgWHM8z5afFp5IcYbTORLyC9e3XZ+/ONAT
         3RKULwTIqzpo130trP7wQ/VkJ1H7lJiimZlFpQNnk8uzonVzIkYnbgnvKii8qt7/8bH2
         ebyQ==
X-Gm-Message-State: APjAAAXoDXMbxjRVs0+M6iZCEx4WQ74CIbvVFUV1qLKS8Gze1E/DzXep
        XNAdp4I+OL0kyhngEmFTVoen0ErcSnnSSJ3U+1s=
X-Google-Smtp-Source: APXvYqyX6oj8Os8AVCdRlVCSC2YadlDcu2aWUpzWLlubCAVQzWLJ5bz38xnxLQCuJcW+6/8GNhWG9kSeCQfsFi0a7RY=
X-Received: by 2002:aca:f089:: with SMTP id o131mr1244389oih.103.1560504451143;
 Fri, 14 Jun 2019 02:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <1560478845-19818-1-git-send-email-zhangliguang@linux.alibaba.com>
In-Reply-To: <1560478845-19818-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jun 2019 11:27:20 +0200
Message-ID: <CAJZ5v0hsrbG0Cp6NY+45NEYCnjjibAvtD36fHEdBoTSRTspvAA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / APEI: release resources if gen_pool_add fails
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 14, 2019 at 4:20 AM luanshi <zhangliguang@linux.alibaba.com> wrote:
>
> If gen_pool_add fails, then ensure that ghes_estatus_pool and vmalloc
> resources are released to avoid memory leak.

The patch does more than this, it also destroys ghes_estatus_pool if
vmalloc() fails.

What about using this changelog:

"To avoid memory leaks, destroy ghes_estatus_pool and release memory
allocated via vmalloc() on errors in ghes_estatus_pool_init()."

> Signed-off-by: liguang.zlg <zhangliguang@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 993940d..8472c96 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -153,6 +153,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>  int ghes_estatus_pool_init(int num_ghes)
>  {
>         unsigned long addr, len;
> +       int rc = 0;
>
>         ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
>         if (!ghes_estatus_pool)
> @@ -163,8 +164,10 @@ int ghes_estatus_pool_init(int num_ghes)
>
>         ghes_estatus_pool_size_request = PAGE_ALIGN(len);
>         addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
> -       if (!addr)
> +       if (!addr) {
> +               gen_pool_destroy(ghes_estatus_pool);
>                 return -ENOMEM;
> +       }
>
>         /*
>          * New allocation must be visible in all pgd before it can be found by
> @@ -172,7 +175,12 @@ int ghes_estatus_pool_init(int num_ghes)
>          */
>         vmalloc_sync_all();
>
> -       return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
> +       rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
> +       if (rc) {
> +               vfree(addr);
> +               gen_pool_destroy(ghes_estatus_pool);
> +       }
> +       return rc;
>  }
>
>  static int map_gen_v2(struct ghes *ghes)
> --
> 1.8.3.1
>
