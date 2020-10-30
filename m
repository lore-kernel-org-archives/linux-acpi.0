Return-Path: <SRS0=fqph=EF=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE8C4741F
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805C020739
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604088362;
	bh=NFPQXUJkgY4qruWuQhfZ/5zPgvl8Ew7+xHmnXURbgIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TnZ663aCXrZqKQ6bPp4I5mt1pfEgjjEueu5DqNulGqfuNSCB9uMH0ZVS56rBFX0Tu
	 pjBitFfQfoqv/c1iVtqCD6CEsrd7UH1zIDMB3AM6+KKNDXttxFNBt0DEhfU+yTsXy9
	 xSk7gTirzvjbUyA34knj0YKE3Y5DjEsknpQ92g9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgJ3UF4 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 30 Oct 2020 16:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgJ3UFu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 16:05:50 -0400
Subject: Re: [GIT PULL] PNP fix for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604088350;
        bh=NFPQXUJkgY4qruWuQhfZ/5zPgvl8Ew7+xHmnXURbgIQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DsNyx+41562yli7rnIIYhyBx3Y6R0iL/25dNJSJiaIFNguCEwWqo3hKIuuge4pjmP
         FjgRuFR87q3Nsnk0I8ghLykptbX0LRYoN1qfMmhs6ZRcpA2sW1OwuWYKvnxfc4QRFH
         pSIiICaS4HARZBc8AY0zZpLgFlwxSPuyXEhYCtPs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gYkVwz1HvMUDPcLya+okWSNiMPkuStGxAjkxcAJXcBsQ@mail.gmail.com>
References: <CAJZ5v0gYkVwz1HvMUDPcLya+okWSNiMPkuStGxAjkxcAJXcBsQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gYkVwz1HvMUDPcLya+okWSNiMPkuStGxAjkxcAJXcBsQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.10-rc2
X-PR-Tracked-Commit-Id: e510785f8aca4a7346497edd4d5aceefe5370960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2c4d6e8acc6548a3ddae0f2e8d8120ead09ad80
Message-Id: <160408835012.13990.1772967253106302433.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:05:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:32:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2c4d6e8acc6548a3ddae0f2e8d8120ead09ad80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
