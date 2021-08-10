Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC96C4338F
	for <linux-acpi@archiver.kernel.org>; Tue, 10 Aug 2021 16:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B53360C3F
	for <linux-acpi@archiver.kernel.org>; Tue, 10 Aug 2021 16:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHJQrP (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhHJQrP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Aug 2021 12:47:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA77C0613C1;
        Tue, 10 Aug 2021 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HvAkw/gWJZ3QY8CKcv5rMg/NeJiwJ1weAp+TQ0QSQA8=; b=uzTnnhsPt/hTLjj9DlvEAnAfmH
        tUB0NOMY6YhX+f6MCX2Sbs0qzeD9ZWO//eUd793IpW9850y9HyqO+72l4+eyQ0ZzJcym+BEgzL1HO
        eP70W+ozn59iemTM+eLMyrZledeerni4d/aMcv9wTReJuuPXXJRUZ5YE02NTDu8K0FvxsJv8pt6rX
        s4WYf0kPzTW6KbXQlR+u/Pfs8V82WA+DeX11NqF5Ewgal25o1Tkh2to+7rArfh9t6LG3mN/7HIB1K
        lVO9VZgcpmykWRMNjR7c5lSiZpgquXuAIp8ti0dhB185CFHrl4KqM+mfSdFD14vk23YWMaRLybzwx
        0w8Q0NCQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDUsC-00CMTk-CF; Tue, 10 Aug 2021 16:45:27 +0000
Date:   Tue, 10 Aug 2021 17:45:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
Message-ID: <YRKtEDycefrZLB3X@infradead.org>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 02, 2021 at 04:23:57PM +0100, Lorenzo Pieralisi wrote:
> Add a __force attribute to the void* cast in acpi_os_map_iomem()
> to prevent sparse warnings.

Err, no.  These annotation are there for a reason and need to
be propagated instead.  And independent of that a __force cast
without a comment explaining it is a complete no-go.
