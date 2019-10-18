Return-Path: <SRS0=O2C7=YL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C74ACA9EA9
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Oct 2019 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62C22064B
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Oct 2019 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571413819;
	bh=2a/Xg4OpHPTqx8cCt3EyKzP3kIwmvW4xg9TiZyeYqoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ev6DWgtTniPC5Nid2WasVrFdIV869BFEI2D6qJpfQ4AYpN1iZmUe8ZxkJy8pxdRRF
	 rQ9e3Bv/qoljgDizrpoXdshjouRhuvRBU4lq8BTRrKP4/rYH4g66xhrsm7JkVMNw50
	 9Chwkfi3abOeOoLzmi1uLCBlLzbQOWoauWUtjEAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409217AbfJRPuL (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391515AbfJRPuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 11:50:06 -0400
Subject: Re: [GIT PULL] ACPI fixes for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571413805;
        bh=2a/Xg4OpHPTqx8cCt3EyKzP3kIwmvW4xg9TiZyeYqoY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SGUzLSHhn0zKImi2WN7oXgV7RSUW8/VyzzwqgOWnXcpNojsxGJAWKFcQSbHmlFEEA
         tpOQMFb04nwchkQGxUJQxppIUQo3grYZhiC6tr3J6mVtBrZSgoWR5XFr3CdgxWDYwI
         bGHCpkn41M9bcWHFgFStLqoZDVnNfYDMyMCmTQmU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gG82GLvm45hvwuZGVVhD4cSLpOREaK6Y-QwYs-ymstqA@mail.gmail.com>
References: <CAJZ5v0gG82GLvm45hvwuZGVVhD4cSLpOREaK6Y-QwYs-ymstqA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gG82GLvm45hvwuZGVVhD4cSLpOREaK6Y-QwYs-ymstqA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.4-rc4
X-PR-Tracked-Commit-Id: ffba17bb335d6598de613791f8997a5774455068
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adca4ce32f4aebe65d817901cf27ede58fa2d143
Message-Id: <157141380578.28894.12338281025124214125.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 15:50:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 11:18:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adca4ce32f4aebe65d817901cf27ede58fa2d143

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
