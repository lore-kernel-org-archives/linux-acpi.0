Return-Path: <SRS0=vBXv=AU=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A157C433DF
	for <linux-acpi@archiver.kernel.org>; Thu,  9 Jul 2020 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715AE20672
	for <linux-acpi@archiver.kernel.org>; Thu,  9 Jul 2020 08:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGIImo (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:42:44 -0400
Received: from foss.arm.com ([217.140.110.172]:43368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgGIImn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jul 2020 04:42:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 770A231B;
        Thu,  9 Jul 2020 01:42:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74AED3F887;
        Thu,  9 Jul 2020 01:42:42 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:42:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, sudeep.holla@arm.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3 0/2] arm64/acpi: restrict AML opregion memory access
Message-ID: <20200709084236.GA18009@e121166-lin.cambridge.arm.com>
References: <20200626155832.2323789-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626155832.2323789-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 26, 2020 at 05:58:30PM +0200, Ard Biesheuvel wrote:
> v2:
> - do a more elaborate check on the region, against the EFI memory map
> 
> v3:
> - split into two patches
> - fallback to __ioremap() for ACPI reclaim memory, in case it is not covered
>   by the linear mapping (e.g., when booting a kdump kernel)
> 
> Ard Biesheuvel (2):
>   arm64/acpi: disallow AML memory opregions to access kernel memory
>   arm64/acpi: disallow writeable AML opregion mapping for EFI code
>     regions
> 
>  arch/arm64/include/asm/acpi.h | 15 +---
>  arch/arm64/kernel/acpi.c      | 75 ++++++++++++++++++++
>  2 files changed, 76 insertions(+), 14 deletions(-)

Thanks Ard for fixing this, for the series:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
