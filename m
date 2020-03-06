Return-Path: <SRS0=cOf6=4X=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD80C10F25
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BF824681
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583499908;
	bh=OU+efo3JEoojfPqrg4I9k/zm/AeiMBXbyMe326sOMsY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NBgaHowbooqon2gYBvY61q/LTRDC1kYG9L9rVX76UYF0DFRe6NMR7YUg2xUBCft/I
	 speDjnD46QEBh6+kFP9GhUnZnPwdngV7rA0+M/aBTyOEJHwU3q4jvL0Bu8T3EwMntK
	 no6t/qwJTV4wubC/5Kat5d/B8cp8pU3//EO3SGAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFNFF (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCFNFF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Mar 2020 08:05:05 -0500
Subject: Re: [GIT PULL] Device properties framework fix for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583499904;
        bh=OU+efo3JEoojfPqrg4I9k/zm/AeiMBXbyMe326sOMsY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yloVDaYHS0svx2Naq62r4oe/kTIp5rbM/8AW7dqj4SRPcfKg8iCq5wCNNod8cY8/i
         vY+99Mcvyjrl6PJQuR/jQlXtgjEcQ1R02jra/rrWrScDDMXEl9oU7nYtyZRsOFTWhq
         v9HIgmNse4ACjqGHsVeR2w3aJ3FKIGhMd9vhK5SA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j8jvHpHW+BBALg9L8=hq8PjyVyMQHfUCmusMeTLDifVg@mail.gmail.com>
References: <CAJZ5v0j8jvHpHW+BBALg9L8=hq8PjyVyMQHfUCmusMeTLDifVg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j8jvHpHW+BBALg9L8=hq8PjyVyMQHfUCmusMeTLDifVg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.6-rc5
X-PR-Tracked-Commit-Id: 7589238a8cf37331607c3222a64ac3140b29532d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0b8a945ea29166706611820e609bce23e278f6b
Message-Id: <158349990476.8760.7729907131824907273.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 13:05:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 11:20:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0b8a945ea29166706611820e609bce23e278f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
