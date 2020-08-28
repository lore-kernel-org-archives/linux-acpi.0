Return-Path: <SRS0=cE/9=CG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12178C433E2
	for <linux-acpi@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E061820872
	for <linux-acpi@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598646563;
	bh=oobALYKizrnp4yGCZqf8dPuqBEmv6/w8VufHaQsCFXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZIPLJgGGvpCwAdZUHQpbjKwSb9o+6oXjLzN90sDJikTstPPqrqNgeMhXMCI3JDxsN
	 XHIf+ikiuTSDlXPfH9QITuTZ7ZOiPov87ip/1NZjHJulmQlCXCfenOWwmSbxNqBoQ5
	 ETD7aFChfaq0xOc8qPokHPfNaFlzQ5ibwt1XE8uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgH1U3R (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgH1U3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Aug 2020 16:29:12 -0400
Subject: Re: [GIT PULL] ACPI fixes for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598646552;
        bh=oobALYKizrnp4yGCZqf8dPuqBEmv6/w8VufHaQsCFXQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E/qBHg2uEhfv0osfYlRAQGfVhChpxNKINvQVhdH12Wd05lWMN6NBlc/zL6QkVtzkO
         FFRQoslGTUGtO2VJWK4Iw7znWn+J3MBNW+gzXhMuWazam/+L+Qdkm3Gg2ODG5fmHLn
         qxjl9aE9lKltJWGZ1OB0R/zx+txuDst6JFtRO87I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hZPb+qOAZFd1vknZ4S0ay=WpJSQECML88fsRGQOWoQSQ@mail.gmail.com>
References: <CAJZ5v0hZPb+qOAZFd1vknZ4S0ay=WpJSQECML88fsRGQOWoQSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hZPb+qOAZFd1vknZ4S0ay=WpJSQECML88fsRGQOWoQSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.9-rc3
X-PR-Tracked-Commit-Id: 4f31d53c21ec98a2c8973cff759804bd1c217c93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b2f18e7aeef86f966bbfccec8d698e05ccc4631
Message-Id: <159864655213.14109.1487829125294451597.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 20:29:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 21:51:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b2f18e7aeef86f966bbfccec8d698e05ccc4631

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
