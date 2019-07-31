Return-Path: <SRS0=EhvU=V4=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0496AC433FF
	for <linux-acpi@archiver.kernel.org>; Wed, 31 Jul 2019 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C5C206A2
	for <linux-acpi@archiver.kernel.org>; Wed, 31 Jul 2019 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564580664;
	bh=iFySZK9nAc8gKANTqHzWXIeOjVqsTDqT69nmU5gh3Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kXFT9mf5+wVgQ81W2JeMVczLgSSJZA8nlgZqjaKV1KYOcUCzLxQi5gE48B3LTqR/b
	 LiJf2oMW5YS+THcYd7Pa0t/wXYN64KS6EB3CjyJctLAE151+1HGaxo62LjdLJaX6Br
	 Sm7WTwjXYo0akriiIoLoHiml/aq0fNotrYhHQtUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfGaNoY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:44:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:40070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfGaNoY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jul 2019 09:44:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8AA4ABD0;
        Wed, 31 Jul 2019 13:44:22 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:44:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Fixup "acquire
 device_hotplug_lock in acpi_scan_init()"
Message-ID: <20190731134422.GS9330@dhcp22.suse.cz>
References: <20190731123201.13893-1-david@redhat.com>
 <20190731125334.GM9330@dhcp22.suse.cz>
 <d3cc595d-7e6f-ef6f-044c-b20bd1de3fb0@redhat.com>
 <20190731131408.GP9330@dhcp22.suse.cz>
 <23f28590-7765-bcd9-15f2-94e985b64218@redhat.com>
 <20190731133344.GR9330@dhcp22.suse.cz>
 <b135e167-a0e1-0772-559b-6375ea40c9c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b135e167-a0e1-0772-559b-6375ea40c9c4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 31-07-19 15:37:56, David Hildenbrand wrote:
[...]
> The other extreme I saw: People dropping locks because they think they
> can be smart but end up making developers debug crashes for months (I am
> not lying).

Any lock removal should be accompanied with an explanation that is to be
a subject of the review. Sure people can make mistakes but there is no
way to around it I can see.
 
> As I want to move on with this patch and have other stuff to work on, I
> will adjust the comment you gave and add that instead of the lock.

Thanks!

-- 
Michal Hocko
SUSE Labs
