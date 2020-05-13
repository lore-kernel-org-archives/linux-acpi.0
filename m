Return-Path: <SRS0=7Mdx=63=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F2CC433E0
	for <linux-acpi@archiver.kernel.org>; Wed, 13 May 2020 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147F7205ED
	for <linux-acpi@archiver.kernel.org>; Wed, 13 May 2020 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589385725;
	bh=1DCrwT/NDlw0uuTKsF4bXhoDTKqfm27Uln6KkJ8YNbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jQwJZTZCGtqKQPsh5hf3C0ui/dBlM+UXHfvgOq9RGVBNlqzgrQYUDGA6NfYJwAls2
	 71pSFxh+uNcWp7zfff+FBcvdu+bWcHmtqUkWERye2mb1yW6MzIz5fuOFt2BAs5bLP+
	 AYbWvG7t37HHAEHWhizAH/3PMLBEs8VkzeAA9gSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbgEMQCD (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 13 May 2020 12:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbgEMQBS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 May 2020 12:01:18 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E84207DF
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2020 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589385678;
        bh=1DCrwT/NDlw0uuTKsF4bXhoDTKqfm27Uln6KkJ8YNbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=blwwIrJXdRO2MTbHNEVNVdoqPhEZedEXfGgkRG50ypFS5O/gmrdqIV8kJE7xRhWNi
         82/hhW83RJtvHNWrUt5ogzWhb2evQUXRH167YmgAgO1GMMu50lRVEb7+WCKJGB2nl/
         rrt3X4VSe3bK2jHIxtpgB589tl4YGk0tTSfnjF8w=
Received: by mail-wr1-f49.google.com with SMTP id 50so16795wrc.11
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2020 09:01:17 -0700 (PDT)
X-Gm-Message-State: AOAM531KMO3SdLD4xqwj69/ICIMLJqxuLImEOVttBl29hHceDrpwRCXU
        w4RlJE8Q+yg+ckOCImjkw+nRqjhiHEcXx8vTt3Cs1Q==
X-Google-Smtp-Source: ABdhPJxQhnLFml0LQ5CNx+hd8QPNyz2a2pbd6SvSmnZfjxvRUTYQ5OXx8AY4s1SOG5rFKf9HvCVi09jd8JzDiGbm9SY=
X-Received: by 2002:adf:a389:: with SMTP id l9mr71447wrb.18.1589385676030;
 Wed, 13 May 2020 09:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200513152137.32426-1-joro@8bytes.org>
In-Reply-To: <20200513152137.32426-1-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 09:01:04 -0700
X-Gmail-Original-Message-ID: <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
Message-ID: <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 13, 2020 at 8:21 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi,
>
> here is the next post of this series with these changes to the first
> version:
>
>         - Rebased to v5.7-rc5
>
>         - As a result of the rebase, also removed the
>           vmalloc_sync_mappings() call from tracing code
>
>         - Added a comment that we rely on the compiler optimizing calls
>           to arch_syn_kernel_mappings() away when
>           ARCH_PAGE_TABLE_SYNC_MASK is 0
>
> The first version can be found here:
>
>         https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/
>
> The cover letter of the first post also has more details on the
> motivation for this patch-set.
>
> Please review.
>

Assuming the missing cleanup at the end gets done:

Acked-by: Andy Lutomirski <luto@kernel.org>

grumpily acked, anyway.

I would love to see a followup patch that preallocates the vmalloc
region on 64-bit and compiles out pgd_list and all of the associated
gunk.
