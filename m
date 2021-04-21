Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3768DC43470
	for <linux-acpi@archiver.kernel.org>; Wed, 21 Apr 2021 17:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC006145E
	for <linux-acpi@archiver.kernel.org>; Wed, 21 Apr 2021 17:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbhDURPa (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:15:30 -0400
Received: from foss.arm.com ([217.140.110.172]:38388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241576AbhDURP0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:15:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3549E11FB;
        Wed, 21 Apr 2021 10:14:53 -0700 (PDT)
Received: from bogus (unknown [10.57.52.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5673F694;
        Wed, 21 Apr 2021 10:14:51 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:14:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vgerlkernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] ACPI: GTDT: Don't corrupt interrupt mappings on
 watchdow probe failure
Message-ID: <20210421171449.pukjblgxfp7hcok6@bogus>
References: <20210421164317.1718831-1-maz@kernel.org>
 <20210421164317.1718831-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421164317.1718831-2-maz@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 21, 2021 at 05:43:16PM +0100, Marc Zyngier wrote:
> When failing the driver probe because of invalid firmware properties,
> the GTDT driver unmaps the interrupt that it mapped earlier.
> 
> However, it never checks whether the mapping of the interrupt actially
> succeeded. Even more, should the firmware report an illegal interrupt
> number that overlaps with the GIC SGI range, this can result in an
> IPI being unmapped, and subsequent fireworks (as reported by Dann
> Frazier).
> 
> Rework the driver to have a slightly saner behaviour and actually
> check whether the interrupt has been mapped before unmapping things.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
