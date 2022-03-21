Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C1C433FE
	for <linux-acpi@archiver.kernel.org>; Mon, 21 Mar 2022 22:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiCUW47 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiCUW4A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Mar 2022 18:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280053AF74F;
        Mon, 21 Mar 2022 15:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B356157B;
        Mon, 21 Mar 2022 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1162C36AF2;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899628;
        bh=0D+2K3pDvtk5RwFQbQp2AVB6NUDbZ2a+esbXSCCsnoU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iKBQCLmQEu25yUNwOwFe7vWfyo6tyDD/Sdd6voAdLAL9+0ZBrSB50JixOe+YPgts+
         jdRxs82s8K44SpHAlW+SORl2nC5h44DJfj1647sRqC+Ji29RHyDEJmkvuS3O2W92Ry
         hVmUNjtXCjipJl1+5/qT4TgfwCk+SVqTHGHrnddpxSThRDey+6CklV0B3XydJlcRVG
         00d2dKP8Fnb2brgicATyS08r/ut9OAe+rkOJFmQ/qB1OHibQrUmDk0nEepTq5kycZc
         g9mYsSIJ2h+IFzwtkIHTfxy0LAlB3rTZfSIMO1Ttlnd+jxk8qDdxHW/8rwGiOV2T5m
         0kI6YZ4cI0dTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9D9BE6D44B;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
Subject: Re: [GIT PULL] PNP update for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gAGJuDF0uZTB+_JGT_5svr1xZDJLYoxLFRGCcbEF0v+Q@mail.gmail.com>
References: <CAJZ5v0gAGJuDF0uZTB+_JGT_5svr1xZDJLYoxLFRGCcbEF0v+Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gAGJuDF0uZTB+_JGT_5svr1xZDJLYoxLFRGCcbEF0v+Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.18-rc1
X-PR-Tracked-Commit-Id: ed945296bb90ce79a7ff331885dd37eafa38b551
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f400bea2d44beec76f7e7f45e5372ef790336a4d
Message-Id: <164789962869.9856.16193995775823019630.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 21:53:48 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 17:45:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f400bea2d44beec76f7e7f45e5372ef790336a4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
