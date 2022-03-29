Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C71C433F5
	for <linux-acpi@archiver.kernel.org>; Tue, 29 Mar 2022 20:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiC2UU5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiC2UUz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2022 16:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F1DADD7A;
        Tue, 29 Mar 2022 13:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0919E616E0;
        Tue, 29 Mar 2022 20:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B936C340F2;
        Tue, 29 Mar 2022 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648585151;
        bh=SRjRF5m2UqVqQP0vgNWUHMUAttYyZLS6tbjNbq1jWgc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LPx+WCc577xGk5IBsLRbxZMUp5r2HOVdENA3x1pj+N0x86mjvrzOGwvCWG/YJjS1D
         XVMnVOxuXnGatRcMBuAVSONF6bnNoogYStu6prMX04kxyWyKI/NN5DKT1N4Tz8TEbA
         Wx4vk2xVXLaSAW9AZpgITdEaiTSZ7LvAToplGJ9dBnZgLQ5GFIELuFtl5mBtVhr5IV
         cqvKNuAjBVL2S7GXtONgfWuVY46YpwbtPTbaerSpXS7KszCxONd+W/e/leurwj+wjp
         fmxrO8Ywbqtp+0R6eN8IiUmOgUbsWzlubluvFYaMs+0i8V5UwlKZef8DlqN9079lkJ
         geFGmKnnOa3Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D589E6D44B;
        Tue, 29 Mar 2022 20:19:11 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties code update for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iwvLGqzv=QQcqdoH99GnVx56qjeufcKRqoOGo=FRUHdg@mail.gmail.com>
References: <CAJZ5v0iwvLGqzv=QQcqdoH99GnVx56qjeufcKRqoOGo=FRUHdg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iwvLGqzv=QQcqdoH99GnVx56qjeufcKRqoOGo=FRUHdg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.18-rc1
X-PR-Tracked-Commit-Id: b2638e56c2ced2ca258d22f939c47327b189e00c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13776ebb9964b2ea66ffb8c824c0762eed6da784
Message-Id: <164858515124.2554.6047508166893874332.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Mar 2022 20:19:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 19:21:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13776ebb9964b2ea66ffb8c824c0762eed6da784

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
