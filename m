Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35446C433ED
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Apr 2021 22:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1389D61396
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Apr 2021 22:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhDZWwO (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 26 Apr 2021 18:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235392AbhDZWwK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Apr 2021 18:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 034F8613AC;
        Mon, 26 Apr 2021 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619477488;
        bh=2E3Lg+QHWm4Jt9cAc7G2wghmqipvEKCuGb95xQoS3C8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oLQBDs4BMq9cuMTjGcAogmuWT8dbeWkoePCvdQ7mddo33xQvQm8LjrK1xDobT0NmV
         Cw+7gYYw2kPFm3flh/Nw6UFKPfwQXstzdt2naBANwi8ewGvu678uWZYp/F1fF232E6
         hvuDHMXTQNn5q1QY36i6rnWYYn3qPvFHont0Cv5SMrH0tvZuwmgXAOWyZK/4v+jIuk
         9zFJq+0+gBoFTvggZLulVB1XLZGgOZW4Zo28TwzUT9noXhDGE3myEXZCO4UTLMYAqE
         Rbk3cAT6gnNSSRC4OIUkNrwNNCS+6CEHtg6n/gRa3kaqbwENv/Kl74pBZ9zuEhLFEo
         FFFLCFJaKC9Hw==
Subject: Re: [GIT PULL] Device properties updates for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hrpjNW8ZHULfkTsLMVyti-0H7gFgSySPwXsQMpTEf8nA@mail.gmail.com>
References: <CAJZ5v0hrpjNW8ZHULfkTsLMVyti-0H7gFgSySPwXsQMpTEf8nA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hrpjNW8ZHULfkTsLMVyti-0H7gFgSySPwXsQMpTEf8nA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.13-rc1
X-PR-Tracked-Commit-Id: 46b37c6e4b072d1440e82558aadd5b678627fec6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0728bfeb21a24bbb7d5ad1828b67a359550fa17
Message-Id: <161947748797.6408.8669460157454869918.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 22:51:27 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 20:28:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0728bfeb21a24bbb7d5ad1828b67a359550fa17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
