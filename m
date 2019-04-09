Return-Path: <SRS0=ifiZ=SL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB204C10F0E
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB12084C
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 13:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lxxe20yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfDINZN (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:25:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40727 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfDINZN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Apr 2019 09:25:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so19654261qts.7
        for <linux-acpi@vger.kernel.org>; Tue, 09 Apr 2019 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XoEwcZhTqY/LLjZVJPoIQSjbuU801bVJMfQEOrsSrR0=;
        b=lxxe20yuZIJ1CEhWgPj6CVXllNfw7wp5rKYlWLqpmX/F2fj4QyG46t3PaP8sxhWB/r
         +DxAfqqoZW2rNkMxCzkqThmfk/seOdNgL0gt03nZcyJEyTy1mk3DTeBXe8rh/DLx+lKh
         +IWveFXVW2OZGfn1gA34PmrNw38mr6MOPZJFqJPg1qIsl7rBGXBrhq8m36Gr1Kuh/3+/
         Z0h40H4y/LGkmST1XQLpV80jhccfX3HsIYpYeiTv7/VsOqWZdF4N8+xRQksHB8hUuVXV
         /36i+N4tlTncbyal1o0cCID2Sd649odsnAtlp7yxZEo0Uxh1pzrHA4Ymy4n9viRUF+2y
         5DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XoEwcZhTqY/LLjZVJPoIQSjbuU801bVJMfQEOrsSrR0=;
        b=HMjRAHbA3Iln5TSAL8aHYh02MkUjNKCsOTNz/Di9uvoKdkc6MQxx9dcLvHnqb5J/gZ
         9xwBrfNu31fGlRjvdbLR+tsj80Ia+k8QgKfgE9NohZEhO1X1UgM+ZbMW+PemhGZ/iEm9
         MxcG8wB3BGZymItbz5Q/+1r2HOcu8HpUpp6KP+0PQEGA4pQsdO68Tm8XZvm+M2WzZvZr
         uzsazj+8kq2SBWY+mA4JL8f/w9YN+7nMbUJhVzn3ntNH1hsu9x+1R6BweVHZjy3QR4WC
         cdxGKVVZjboOgJk4/T1RfZUzSox9qi9Pye+3E44Up13L2aCSwQkQuCLbe0cv43NRvsyB
         E7mg==
X-Gm-Message-State: APjAAAX+fhhCmfFCRjkIcp+lEampP3Kg2f761iQvWjZErpCVJTxDh5yo
        vv3BGR+seQ6fTWUFb3AuDpj1lA==
X-Google-Smtp-Source: APXvYqytyeLy/umuwVVSjUrHPFhIViwQ55Ikql4PgWPqCsZjW0PERYS5/j+86MYQ5n9Z/v94umR11Q==
X-Received: by 2002:ac8:348d:: with SMTP id w13mr31202564qtb.329.1554816311766;
        Tue, 09 Apr 2019 06:25:11 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x184sm8899444qke.35.2019.04.09.06.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 06:25:10 -0700 (PDT)
Message-ID: <1554816309.26196.46.camel@lca.pw>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
From:   Qian Cai <cai@lca.pw>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Apr 2019 09:25:09 -0400
In-Reply-To: <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
References: <20190406181704.33574-1-cai@lca.pw>
         <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190409132509.V9sZpg8e89PGGJAS12VU5wDN-YOmx8uaWEnbZ2NMd3g@z>

On Tue, 2019-04-09 at 10:25 +0200, Rafael J. Wysocki wrote:
> On Sat, Apr 6, 2019 at 8:18 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> > memory") introduced some memory leaks below due to it fails to release
> > the heap memory in an error path, and then the stack __initdata memory
> > which reference them get freed during boot renders those heap memory as
> > leaks.
> > 
> > unreferenced object 0xc8ff8008349e9400 (size 128):
> >   comm "swapper/0", pid 1, jiffies 4294709236 (age 48121.476s)
> >   hex dump (first 32 bytes):
> >     00 d0 9e 34 08 80 ff 84 d8 00 43 11 00 10 ff ff  ...4......C.....
> >     00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000869d4503>] __kmalloc+0x568/0x600
> >     [<0000000070fd6afb>] alloc_memory_target+0x50/0xd8
> >     [<00000000efa2081e>] srat_parse_mem_affinity+0x58/0x5c
> >     [<000000008bfaef74>] acpi_parse_entries_array+0x1c8/0x2c0
> >     [<0000000022804877>] acpi_table_parse_entries_array+0x11c/0x138
> >     [<00000000ffe9cd34>] acpi_table_parse_entries+0x7c/0xac
> >     [<00000000a7023afd>] hmat_init+0x90/0x174
> >     [<00000000694a86c1>] do_one_initcall+0x2d8/0x5f8
> >     [<0000000024889da9>] do_initcall_level+0x37c/0x3fc
> >     [<000000009be02908>] do_basic_setup+0x38/0x50
> >     [<0000000037b3ac0a>] kernel_init_freeable+0x194/0x258
> >     [<00000000f5741184>] kernel_init+0x18/0x334
> >     [<000000007b30f423>] ret_from_fork+0x10/0x18
> >     [<000000006c7147a8>] 0xffffffffffffffff
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Well, the catch is good, but the additional label is sort of excessive IMO.
> 
> > ---
> >  drivers/acpi/hmat/hmat.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> > index b7824a0309f7..c9b8abcf012c 100644
> > --- a/drivers/acpi/hmat/hmat.c
> > +++ b/drivers/acpi/hmat/hmat.c
> > @@ -637,7 +637,7 @@ static __init int hmat_init(void)
> > 
> >         status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> >         if (ACPI_FAILURE(status))
> 
> I would just add a hmat_free_structures() call here or rework the
> _put_table() logic which is not really straightforward.

I am not sure how adding a hmat_free_structures() call there would be better. If
the name has bee changed to something else in the future, it ends up needing to
change 2 places. It also not save the adding line-count either. I don't see how
to rework the acpi_put_table() logic to be better than adding a label here
either.

> 
> > -               return 0;
> > +               goto out_free;
> > 
> >         hmat_revision = tbl->revision;
> >         switch (hmat_revision) {
> > @@ -659,8 +659,9 @@ static __init int hmat_init(void)
> >         }
> >         hmat_register_targets();
> >  out_put:
> > -       hmat_free_structures();
> >         acpi_put_table(tbl);
> > +out_free:
> > +       hmat_free_structures();
> >         return 0;
> >  }
> >  subsys_initcall(hmat_init);
> > --
