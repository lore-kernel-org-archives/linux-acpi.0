Return-Path: <SRS0=7Mdx=63=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD003C433DF
	for <linux-acpi@archiver.kernel.org>; Wed, 13 May 2020 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4466206F5
	for <linux-acpi@archiver.kernel.org>; Wed, 13 May 2020 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589384825;
	bh=nzgdwqBNsrP+73eJCjx0UH7nQXREgSbxf60tXOz/1mA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1BXMgXltaI/yDgR8rYnaAz2JpR0Uu6SgAPTW3tYBYHlAVV7+BJvcUdSTNuiIjICkx
	 wjOBClCBOwoGd40+WjJ9UK0qX2rOgyhMc4YBHyFB+vB0zWijOrU+l6dDHM3XtPD6YZ
	 40PbTuQezaXJOU7l3+fMCgJIAujTLLk7nB8hQdS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbgEMPrB (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 13 May 2020 11:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389058AbgEMPrB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 May 2020 11:47:01 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8560207BA
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2020 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589384821;
        bh=nzgdwqBNsrP+73eJCjx0UH7nQXREgSbxf60tXOz/1mA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p4Atx0aUEnifHVd3/OUWW8H+qTI/K7630hPdqjB3fUkCPrqxCpY6sUGWGNAA8GRZw
         Y4qXB4z3DbmHp+Gajo/SiOHVQZJXmkK0A6+YXCdQB+Lo3Ex5Qxn8iyrrS6owKygp7G
         G3F2iaU28QF8W9wn45cS/qXPMInbvnItP5fhW9nU=
Received: by mail-wm1-f48.google.com with SMTP id k12so27022398wmj.3
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2020 08:47:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuZZ/CIC9ZxcFz1xzt6SiYTUaXBKuA8emxNkJoXPi05XZXV+NWTM
        Dxz4+auLoQJdV8PRDiIpVOkxojW9jxZPOG6j5fFDFg==
X-Google-Smtp-Source: APiQypKuUOoHroqVE1Q2xSEZ5CJAKVmZYRRug6GQ131e/OlvUQIzVUtZ4lvV/wUI+iagtz1aPdU6tH9xKFo/pnQ17qg=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr22837779wmf.138.1589384818895;
 Wed, 13 May 2020 08:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200513152137.32426-1-joro@8bytes.org> <20200513152137.32426-8-joro@8bytes.org>
In-Reply-To: <20200513152137.32426-8-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 08:46:47 -0700
X-Gmail-Original-Message-ID: <CALCETrUq=-huvWXJpVLvPRNwTiniQg8DP6R__J33gE8iSoEGAg@mail.gmail.com>
Message-ID: <CALCETrUq=-huvWXJpVLvPRNwTiniQg8DP6R__J33gE8iSoEGAg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/mm: Remove vmalloc faulting
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
> From: Joerg Roedel <jroedel@suse.de>
>
> Remove fault handling on vmalloc areas, as the vmalloc code now takes
> care of synchronizing changes to all page-tables in the system.

You should also remove sync_current_stack_to_mm().
