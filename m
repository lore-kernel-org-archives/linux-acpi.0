Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA76C19F2A
	for <linux-acpi@archiver.kernel.org>; Thu, 11 Aug 2022 21:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiHKVcY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiHKVcR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Aug 2022 17:32:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B759D8E9;
        Thu, 11 Aug 2022 14:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 819C6B82076;
        Thu, 11 Aug 2022 21:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C28AC43470;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660253534;
        bh=pPvGgOtLMRNC0jNhQMXQym+B0LtsVqQZKlF/xntVwno=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WwJlnXE06B5sKB/tqaqbvHwU31N7NV+YAOGYWxDVQT93BuTt3kwXelUYztJnmL0Bb
         lCzIGfDVhWElAX/NvWMamU25+Q59OfmzLb/7dKlY0JmtG6GJAI1YVhXDz99fLHAgqk
         wzOiFmtpU3rEzTMGHoFgVQ+CP6JjUhI3j7l9pg8Huqqq3m0DMqme4exG+YLmvvU1js
         z9DGTBv0nfXrfuLNh2M7syjLjhNYSU5IiVFeA8CYl3hBsTtd371Ed/5FVHMZeOHOvr
         yoQ7uT8HOU/VPn/+nkU0nvbnKkZSx0SNvlFWm3GhEZLFuVWCkFdtVscWKkm9U/ZqKK
         C3G/GSBfratdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20D9EC43142;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hu2y0jwZ4DFxOaZzArPuaoSEH-iKHakHWRpW3e7i9x7Q@mail.gmail.com>
References: <CAJZ5v0hu2y0jwZ4DFxOaZzArPuaoSEH-iKHakHWRpW3e7i9x7Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hu2y0jwZ4DFxOaZzArPuaoSEH-iKHakHWRpW3e7i9x7Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.20-rc1-2
X-PR-Tracked-Commit-Id: da2679f26bd6ae20b06d49e53eedc2880cf5e65e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e091ba5cf82714c8691d978781696cd1fc2dec70
Message-Id: <166025353413.15191.4108360842568930556.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Aug 2022 21:32:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 11 Aug 2022 19:43:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.20-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e091ba5cf82714c8691d978781696cd1fc2dec70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
