Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D8AC3526A
	for <linux-acpi@archiver.kernel.org>; Wed, 16 Dec 2020 01:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C3223750
	for <linux-acpi@archiver.kernel.org>; Wed, 16 Dec 2020 01:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgLPBB2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 15 Dec 2020 20:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgLPBB1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Dec 2020 20:01:27 -0500
Subject: Re: [GIT PULL] ACPI updates for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080408;
        bh=PWzrfgYuaSdKeNyqR5LvH3ePwusmzn5kJY461Gi6V18=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lGDN7qYGqt9SGsYOUkju6zn7+kYUedsPduglIxfCTACYpvRtADkOtZOsBzuLm9HUT
         9jItJn/7RguOZWp1SKcw9mMmO0FvkYBcoqxHXiOJKLzEIl5uS/6jsk7q/j4ZRBvZPk
         BF/C5cB6d7zn0YlaFc0MKSoZ4x2K1alUlFJYBuFE4Ync3AkBmUHQEfFZ5MGv+xdman
         Osvo8eRhsfBYXX+wvOGRIRwhmzl3vZmaiHUDqLy0ekNC51oj+9hen7/3WaO7UTMqdv
         dNJF4ThIHZKWMPJjLVyoJcjfCV39NYFipng9Mv+eK45SgsJrHnL2Udq7pvO3VfPmJI
         n36DAYWXxp0mA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gEDn2QvKwRWWtAJDCdiL4yM3_KKnAKu7pjyiT-OyF4Ag@mail.gmail.com>
References: <CAJZ5v0gEDn2QvKwRWWtAJDCdiL4yM3_KKnAKu7pjyiT-OyF4Ag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gEDn2QvKwRWWtAJDCdiL4yM3_KKnAKu7pjyiT-OyF4Ag@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc1
X-PR-Tracked-Commit-Id: 38a0925c5fc89689433f2a2ad415982397cf626e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aab7ce2b099bd9df82573cd3170acf6518fdebeb
Message-Id: <160808040880.29502.5550672632282113809.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 18:45:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aab7ce2b099bd9df82573cd3170acf6518fdebeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
