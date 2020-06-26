Return-Path: <SRS0=hPtF=AH=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051DAC433E1
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D578E206C0
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200415;
	bh=kElnDE6C6jzwH97BZEfkiPFYGGRw875DbsH31Dz8CfQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l5lYTD9foDWnPcCKV50gLPx62u4T7Zesj67a11IFPwpksF9O9V+BwQfnCTcv+yH6+
	 Y3a1eeRC3zudWGMdCofLiiS+IWPpYqHqFdy02v167RqE79GjJSvwLEU0V5fGv1g6dW
	 +39z9LKJGAO8QmIUsveYI4WO3Lo74K/RHiBLvCCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgFZTkP (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFZTkO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jun 2020 15:40:14 -0400
Subject: Re: [GIT PULL] ACPI fixes for v5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593200414;
        bh=kElnDE6C6jzwH97BZEfkiPFYGGRw875DbsH31Dz8CfQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u+NVsDsur4rYnboEK+wO/K1Y/41AD9t4MgGsRIrF/uhSFFrXGLAK1Anhpvrse0lQu
         K6nxrJ5RkHJ33frw7AiFFpP+x1nbf+vJ5COHHJ7zlchTedE+fMRgkC0V+0uMBc9Cvn
         p5PIiQ8HsL7yEHV55Gdb+g+NMpLCLfuEv7CXSlrU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iCm=bku-rKaOLveA-Kr0NbJ0Wp3mvQGTv2G9mpjJZpxg@mail.gmail.com>
References: <CAJZ5v0iCm=bku-rKaOLveA-Kr0NbJ0Wp3mvQGTv2G9mpjJZpxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iCm=bku-rKaOLveA-Kr0NbJ0Wp3mvQGTv2G9mpjJZpxg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.8-rc3
X-PR-Tracked-Commit-Id: 0f29c20bf4342c7757d9f4bf81159b02498b1b0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1590a2e1c681b0991bd42c992cabfd380e0338f2
Message-Id: <159320041441.11855.5823032730660572788.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jun 2020 19:40:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 17:40:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1590a2e1c681b0991bd42c992cabfd380e0338f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
