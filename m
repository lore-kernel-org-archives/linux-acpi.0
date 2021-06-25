Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE686C49EA7
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Jun 2021 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23F56157E
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Jun 2021 17:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFYRvb (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Jun 2021 13:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFYRv3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Jun 2021 13:51:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 48A3861981;
        Fri, 25 Jun 2021 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624643348;
        bh=XGk6TRmBTXxCxl3wSCVlWjW7ejfJ90UsWlpAzbDBsw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uy9cazUykrP06mwi7oUvbIwyUvkvrem14k8Q/0p/fomqrHDQj1mIA/ZVP0vnxLSCo
         6lQq844czSn2NW/KqTNhOVOnJgI8MmKpgLK7CLFOLmU6SJoQ+Bpw8Rxkuh98uPCq3g
         APubU49P5E9Whzs67briRWoQxdkJvEMCsT9DQvsQo5Zivndn/CU4RmQXcNi7XygYtV
         K+iXtJtl1w4NHCpSeq+UV4mZ4cor9vJQja+hmQvWj6eSVuLx19LI9cbBc27aI8eZC8
         qTRm/qdnLrgn8/bkMQsWS4LO5xTV69ZtOnRKJeH88EUX4CTPMdiqxM7UQTPrmYOFsS
         sNNPvnHy7Ikig==
Subject: Re: [GIT PULL] Device properties framework fix for v5.13-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gpxRL=B_PaUDRzyiR5z17r_6omrCk-DWM+=dG5=xSJiQ@mail.gmail.com>
References: <CAJZ5v0gpxRL=B_PaUDRzyiR5z17r_6omrCk-DWM+=dG5=xSJiQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gpxRL=B_PaUDRzyiR5z17r_6omrCk-DWM+=dG5=xSJiQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.13-rc8
X-PR-Tracked-Commit-Id: 5dca69e26fe97f17d4a6cbd6872103c868577b14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7764c62f9848cd4585801019168a6272240ab4d3
Message-Id: <162464334824.2214.16455144487594443074.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jun 2021 17:49:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 25 Jun 2021 19:09:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.13-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7764c62f9848cd4585801019168a6272240ab4d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
