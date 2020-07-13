Return-Path: <SRS0=lV+M=AY=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2215BC433E5
	for <linux-acpi@archiver.kernel.org>; Mon, 13 Jul 2020 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E3C2082F
	for <linux-acpi@archiver.kernel.org>; Mon, 13 Jul 2020 15:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="shNHxqlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgGMPmz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgGMPmx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2020 11:42:53 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04639C08C5DF
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 08:42:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so17719140ejc.8
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2020 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYHsayQ+qnaeJrGEqb3AbWD3OCs6eDEgmK0sEjz5stk=;
        b=shNHxqlEshcLM+d6HS5/rUuF/G7IfTpZe/gUMK2OQCtYZavKPmFx9lPmSy+8XWB0KK
         35jBVVrUdNO+Jfvrrp+eIP/JvR08WY9U0DdkU6T89bTgCxQCuK1PVuWJIjGMTLjE8rE3
         XTJ5PHCfIDj2m3E204SFtns5sNa6dcgofuJWbiwgwOmwi0NipOUB6QrkLZ+DoEueqmMB
         PgWCgNO4So36JTX6IgokxC3NYAKVD194ZFfivEOk1MU5Ch8Hq+JnhQK68aoXqc58zKh0
         6H4qLbRrffd4vFYKWrXDmxbjRxZ7jEpY4zZCg4XrAX2YN8jpDHcMkBByyN832GpItPwM
         QGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYHsayQ+qnaeJrGEqb3AbWD3OCs6eDEgmK0sEjz5stk=;
        b=e5ZnS/lZpemTADY+S7lNIC/ReQTgDgBmmM5+XR22pn9mZrWMtGx/MIS2csFXy1nvKB
         goaHKG9QjhJ6xmBLgWe+uJoEcw9LoqHYS/hiwFK62eVAxxoVdS2og8Uh4+rP9h4qbxcW
         dT5upEOyOnk78WFFzKYEDmXyDUECpVaujs8MS5uTYCal8MMXZAWBzoX/j4M/CTEA+nQf
         taklrk8MkFJanFsELZshEIUMKZd+VUNmMUG6tk96beqYKrxauSif4mMxL/vs+WUHYHPS
         76E3plDLPdrcCi3CcPKgc70PLCa8tBGZJUChZN+i2jYk7TZYcGOz46l6565H+YGfEOjM
         sufg==
X-Gm-Message-State: AOAM530677lgkvUSzXpgNIbKvMYgCS9cdgvTBOH/fEFEcpNsftRVGh+7
        jVmoevZWuB8fs9bG6NspnkpyGO8Y1mqaBoQslRmA4w==
X-Google-Smtp-Source: ABdhPJxUImaKchQhePlG2M01YtnBmwJfKXSrMtOhR08dhoQCgRWcxaVYGh90/4tQIBcAr8wpwsrZSqeoZAyg7POGAfM=
X-Received: by 2002:a17:907:20af:: with SMTP id pw15mr393528ejb.204.1594654971733;
 Mon, 13 Jul 2020 08:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457120334.754248.12908401960465408733.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200713065801.GB11000@linux.ibm.com>
In-Reply-To: <20200713065801.GB11000@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 08:42:41 -0700
Message-ID: <CAPcyv4gBgCptZupxhzbDN3qscnuJ9HNWHHvfhH6z+z84VE1cPg@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] numa: Introduce a generic memory_add_physaddr_to_nid()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jul 12, 2020 at 11:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Sun, Jul 12, 2020 at 09:26:43AM -0700, Dan Williams wrote:
> > For architectures that opt into storing their numa data in memblock
> > (only ARM64 currently), add a memblock generic way to interrogate that
> > data for memory_add_physaddr_to_nid(). This requires ARCH_KEEP_MEMBLOCK
> > to keep memblock text and data around after boot.
>
> I afraid we are too far from using memblock as a generic placeholder for
> numa data. Although all architectures now have the numa info in
> memblock, only arm64 uses memblock as the primary source of that data.
>
> I'd rather prefer Jia's solution [1] to have a weak default for
> memory_add_physaddr_to_nid() and let architectures override it.

I'm ok with that as long as we do the same for phys_to_target_node().

Will had the concern about adding a generic numa-info facility the
last I tried this. I just don't see a practical way to get there in
the near term.
