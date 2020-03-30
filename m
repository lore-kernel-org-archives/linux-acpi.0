Return-Path: <SRS0=3ipo=5P=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E3EC2D0F2
	for <linux-acpi@archiver.kernel.org>; Mon, 30 Mar 2020 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EF120771
	for <linux-acpi@archiver.kernel.org>; Mon, 30 Mar 2020 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585607716;
	bh=CMny1i/AhWbyQKPRSx7PRQJ/pNZUa5hoKx0mfl8HdCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oPrd34rNkggxk+uSZJDo+E1gM1b87pA1F98xAcuK+PiK5Ld2kmdoZQAAp3lgrSlwm
	 tn7Lzqt/kEq+BgZ7+6up34Vda3wxhwZDBIJ6VFemQ2fIfeul/Rt/dMhGqEBaoAhSHZ
	 pHfUshsgWwbOhQVExQlKtTXpkk7/sOW/SmfxWoj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgC3WfP (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgC3WfK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Mar 2020 18:35:10 -0400
Subject: Re: [GIT PULL] PNP subsystems updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585607710;
        bh=CMny1i/AhWbyQKPRSx7PRQJ/pNZUa5hoKx0mfl8HdCQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PZrzSL+cITct1yh/nR53TCEwxXWi6CoWQ9NklL4yFFzsbq555Fbitp2Rh+7frcp5R
         9pXa0NmTkGL0JFj0sCq7VsZF/PsHAI9KVld9WZH/NuYmsafsuH5XVmJxdtkEksjQsP
         PmDtlDCFYln6BL3vAjEKcRT7nUI4ssf6P89ZjUew=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jLoTcE5WhFiJ_z6tUcuPrJs2SBe5id-7OWAd8AYw3n9Q@mail.gmail.com>
References: <CAJZ5v0jLoTcE5WhFiJ_z6tUcuPrJs2SBe5id-7OWAd8AYw3n9Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jLoTcE5WhFiJ_z6tUcuPrJs2SBe5id-7OWAd8AYw3n9Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.7-rc1
X-PR-Tracked-Commit-Id: eaec20c7362c68176369f11e26dc0f6f994ae2d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ce94bc4e056d3e48291aac87a95ebd2a86348ba
Message-Id: <158560771040.3567.12399153102806438137.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:35:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 17:26:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ce94bc4e056d3e48291aac87a95ebd2a86348ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
