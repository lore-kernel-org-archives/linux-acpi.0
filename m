Return-Path: <SRS0=1DYQ=AE=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88273C433E0
	for <linux-acpi@archiver.kernel.org>; Tue, 23 Jun 2020 09:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C06020768
	for <linux-acpi@archiver.kernel.org>; Tue, 23 Jun 2020 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592903659;
	bh=TKjMTcF3Mb6Sr+/zsrwHMHOvC6Gj6PDqtkhuXVJ/fZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSNU7D2yvZWIRqCCxMzK0Bh/IScM0/JeQnvmNdFHGcogdDnce8mY6/wbNMDdX+5KS
	 eIXgOYr6NzifBJV2t9YvoNnRIGu7dy688I+a0MTM44Rzc+WdwRPGr+5FysjUd53Mpm
	 ig51e8KWBo8ZQFYRH6O59o0JcuX7c1HqasGoUXpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgFWJOS (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbgFWJOS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jun 2020 05:14:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB0920738;
        Tue, 23 Jun 2020 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592903658;
        bh=TKjMTcF3Mb6Sr+/zsrwHMHOvC6Gj6PDqtkhuXVJ/fZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpqzATd9x15l1Ll9Qprze5762QiDejHlLm6X1EXRgEn9vutEYmcTd/KlvkMq0rJLJ
         7lmQ8B5CJ6/KCdeHH+4qufTcqGbQbsjJTqaop8sG19iIhvskxJmFT+I9QMQEPZjyEJ
         r1RttWX+zpQ0bV0qknhec+otG0flV6HtHRMJ5QLU=
Date:   Tue, 23 Jun 2020 10:14:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC PATCH] arm64/acpi: disallow AML memory opregions to access
 kernel memory
Message-ID: <20200623091412.GC3743@willie-the-truck>
References: <20200622092719.1380968-1-ardb@kernel.org>
 <20200623081303.GA3531@willie-the-truck>
 <CAMj1kXFX5okSWZ8SgnOrbs7qVSS1A2kyL12UXQi8JcEWmcDb=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFX5okSWZ8SgnOrbs7qVSS1A2kyL12UXQi8JcEWmcDb=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 23, 2020 at 10:16:19AM +0200, Ard Biesheuvel wrote:
> On Tue, 23 Jun 2020 at 10:13, Will Deacon <will@kernel.org> wrote:
> > On Mon, Jun 22, 2020 at 11:27:19AM +0200, Ard Biesheuvel wrote:
> > > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > > index a45366c3909b..18dcef4e6764 100644
> > > --- a/arch/arm64/include/asm/acpi.h
> > > +++ b/arch/arm64/include/asm/acpi.h
> > > @@ -50,9 +50,9 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> > >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > >                                           acpi_size size)
> > >  {
> > > -     /* For normal memory we already have a cacheable mapping. */
> > > +     /* Don't allow access to kernel memory from AML code */
> > >       if (memblock_is_map_memory(phys))
> > > -             return (void __iomem *)__phys_to_virt(phys);
> > > +             return NULL;
> >
> > I wonder if it would be better to poison this so that if we do see reports
> > of AML crashes we'll know straight away that it tried to access memory
> > mapped by the linear region, as opposed to some other NULL dereference.
> >
> 
> We could just add a WARN_ONCE() here, no?

Yeah, or that, or a firmware taint. Just something to distinguish this
from other NULL pointer derefs.

> > Anyway, no objections to the idea. Be good for some of the usual ACPI
> > suspects to check this doesn't blow up immediately, though.
> >
> 
> Indeed, hence the RFC. Jason does have a point regarding the range
> check, so I will try to do something about that and send a v2.

Ok, I'll keep an eye out for it.

Will
