Return-Path: <SRS0=fYCx=UQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C4AC31E5B
	for <linux-acpi@archiver.kernel.org>; Mon, 17 Jun 2019 17:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E5B208C4
	for <linux-acpi@archiver.kernel.org>; Mon, 17 Jun 2019 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560792896;
	bh=symDztE4rIf+yOC4zerykBnJwFfFwn0B0J9cXzcdILQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PTSuCWDVAgcoYReRlY2Mz0inkwmiYFDQiVHA8f4y4TI4N1ZBjWjaFn5q9Y22FQ9eR
	 Fx+lcUTwFwnNpOll8SaLoIZShYavGxvqkFfZUGNM4od4RVwTgM+V1N8o8beAYaJ38p
	 RGIA0LMmu/cwCXab9POVIjmcX1jQUo09sLScbHHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfFQRez (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFQRez (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jun 2019 13:34:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBB3208C0;
        Mon, 17 Jun 2019 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560792895;
        bh=symDztE4rIf+yOC4zerykBnJwFfFwn0B0J9cXzcdILQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Er8LhWad0kevwkXsZpw2EEET+RGTimdxdJQgp2o70QLJbTadmVEKBOlsb0iza0otu
         twwbMdZVMGf8J+okxBSfvXdqavW4vmOtNB3gcjoDaPtNMqH5c4H5MwubkacRCsIWjs
         qnllQNIugWRZiacwBWvaGE4UZP/x5J6d6efd2/cE=
Date:   Mon, 17 Jun 2019 18:34:50 +0100
From:   Will Deacon <will@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update my email address
Message-ID: <20190617173449.4vhgdvllwxo24ovj@willie-the-truck>
References: <1560769335-62944-1-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0jyi-ZkcDU=+GJm5LxMGX36ce=a_j169A_7Ph2AG8_C+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jyi-ZkcDU=+GJm5LxMGX36ce=a_j169A_7Ph2AG8_C+w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 17, 2019 at 01:11:40PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 17, 2019 at 1:04 PM Hanjun Guo <guohanjun@huawei.com> wrote:
> >
> > The @linaro.org address is not working and bonucing, so update the
> > references.
> >
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> 
> How do you want this to go it, via ARM or ACPI?

I've already got a MAINTAINERS update queued to send out later this week, so
I can easily pick this up if you're ok with it?

Will
