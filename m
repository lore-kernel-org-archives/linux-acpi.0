Return-Path: <SRS0=cOf6=4X=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72FCC10DCE
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A6022B48
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583499909;
	bh=bTNUveasFoVCQ1AMzr1w5nIDGBxs7AwE9HgXGSf+cL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1RAwanmULj/i3YQ1kTegkDOaYWXz/m8CAlXVgc3KKRCUMkCEoRUJtbQ78fFjvPf98
	 YWc0HDuzI0cfwkrq8mFbCP0JrZ3T5evjJ6BztwyoZbv8L1XD7MTvEul6/iNJr1DmM/
	 jBhVG6uPQHKx62MxrJZL88D9DAbJexNScV2oFVa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCFNFJ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgCFNFF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Mar 2020 08:05:05 -0500
Subject: Re: [GIT PULL] ACPI documentation fix for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583499904;
        bh=bTNUveasFoVCQ1AMzr1w5nIDGBxs7AwE9HgXGSf+cL4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uaHr0ddIsZJZ1pPH3YFHdcTYk9kGx66iBirgiLNLaVboMuhUhEvKgiMRBkzz7asnm
         re2B2YeR7TtjlLPupBgB0dWfLERBNsXl/MsFDeUicRC2aVWsa3AKUqMmGjxcvBpgn1
         x9mb5SibRwhaDPwqUvQbYmNU8LywXv7x59tSRk4Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g+iTke+8DL28YzCBeDbe=WNQnUhWuO8QjLhAwGy3U0=A@mail.gmail.com>
References: <CAJZ5v0g+iTke+8DL28YzCBeDbe=WNQnUhWuO8QjLhAwGy3U0=A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g+iTke+8DL28YzCBeDbe=WNQnUhWuO8QjLhAwGy3U0=A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.6-rc5
X-PR-Tracked-Commit-Id: 86dfa5bec24952f99f2cfa778975d5a914c3a1d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe67d1821fa8cd9856fc5e65d53ef73b450fa7d8
Message-Id: <158349990453.8760.7414984039450425250.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 13:05:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 11:18:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe67d1821fa8cd9856fc5e65d53ef73b450fa7d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
