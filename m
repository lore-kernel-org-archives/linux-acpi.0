Return-Path: <SRS0=nFll=33=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AFCC2BA83
	for <linux-acpi@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094C522522
	for <linux-acpi@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581112521;
	bh=GmfHsAi2L8vVRWBdqdTqIK2X5WyLyDBPcOXaUgGhuG4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hW9bR41oRkzQlivGdN7oH9ZrQZcXx5WBGLTKzbZATcqL0t8Da2/xNX4FHwJmwVoQp
	 1EUudYYZOLAdIo3BwnmZc+RBlyE1JIyLm3U7OF2v/CbgIptDDZMRasF8iN5oxjEjaI
	 /KdAUqO2o11L6G5+8HeXEspKBJjFXVnLLmiP9m3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBGVzU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbgBGVzU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:20 -0500
Subject: Re: [GIT PULL] Additional ACPI updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112519;
        bh=GmfHsAi2L8vVRWBdqdTqIK2X5WyLyDBPcOXaUgGhuG4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zhKjYnu7QePq2lyNj55j7gHMURu8nb50O4v3dCHdVdAaBsdfiOZSC7PepRtqMLPL9
         +QepvPY3XkDmri/ASsKJbk/c3ymVZuOPTO1J8iohH7oll1soIKXvNgtz2gV06Xl1Hj
         +wr4cqUEd41y1QihOfPNUI27dRfoHOKvaBatsjvI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iWhN=pxnedntPn5kriN-uEULvTjHADtJj59a5W14a4sQ@mail.gmail.com>
References: <CAJZ5v0iWhN=pxnedntPn5kriN-uEULvTjHADtJj59a5W14a4sQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iWhN=pxnedntPn5kriN-uEULvTjHADtJj59a5W14a4sQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.6-rc1-3
X-PR-Tracked-Commit-Id: dec0a81a7814c8a876e663e0627468e6b1a7d2fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed39ba0ec1156407040e7509cb19299b5dda3815
Message-Id: <158111251949.9631.11774276832242457428.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:19 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 11:36:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.6-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed39ba0ec1156407040e7509cb19299b5dda3815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
