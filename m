Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE7C4708F
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 19:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D76A6102A
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Jun 2021 19:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFBTiN (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhFBTiL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Jun 2021 15:38:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8D9B761400;
        Wed,  2 Jun 2021 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622662588;
        bh=2CZVdQKp9rvkxeNcNmuJvAIg1NXIgsQf7TJFE75Y5mA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jh9GI1+5eWK4Sphs1lTAyBOXNj1Tm9WIO3F5TieBsQElXRhSPvA5SJ49vZMJZqKFy
         K1cBmgnW5v4RVQ5UTTeE1Qc+1rm0woIS4myNtK62UnTWu0Azfh6t0JBc+PKUfoNBA7
         k9rkOwvZAbL2JOyF5H3873pazA2qWMKb6vxqjjlULbn7BWbvXI2AKjOeALr02AyD9f
         Kh/ZRUbV4hRxU8p3lhsExkbnrXqYKwCf4lRtErJ+SbLN3rAst892FEbZMzEFdsbcz7
         gF4RNOo4uo3n1QIQUF+U3n2mdUD7mt9BgBhujRKI71C9W2TuNb432GXtaBKWGgu+Zh
         OhZrjmTFy8PIQ==
Subject: Re: [GIT PULL] ACPI fix for v5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hCofs+k5a-U=xcEwBTtTmGweAU1OkhJRmNu9TBuoJzrg@mail.gmail.com>
References: <CAJZ5v0hCofs+k5a-U=xcEwBTtTmGweAU1OkhJRmNu9TBuoJzrg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hCofs+k5a-U=xcEwBTtTmGweAU1OkhJRmNu9TBuoJzrg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc5
X-PR-Tracked-Commit-Id: e4dfe108371214500ee10c2cf19268f53acaa803
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0372b6dd6cfef9db032e0ed83a6ddfb84d9920dc
Message-Id: <162266258854.13029.1397927351250872510.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Jun 2021 19:36:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 2 Jun 2021 19:32:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0372b6dd6cfef9db032e0ed83a6ddfb84d9920dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
