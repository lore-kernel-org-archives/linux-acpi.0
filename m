Return-Path: <SRS0=fqph=EF=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E773DC55178
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2122071A
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604088386;
	bh=WFFIQ24pzzmm2c2eqxDZgGw8ctn1TTn3EJWorygVggY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Mjri0HcdHZVJ3SRYKEFL07E3F0PZg5RqNSLdepd3N6XJH+iEOIS43iLqTIO4Y7miF
	 uFvf2js4ZTuvk/HEQ9hd5p27/Jonp1ZK0Z8PeQAeAbJKJn95HjvUENHn6EETMw1NeN
	 vMAf6J5QuRrwp1IdDqncJfFdrk8YFbM6VoEKM08o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJ3UGW (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 30 Oct 2020 16:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJ3UFu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 16:05:50 -0400
Subject: Re: [GIT PULL] ACPI fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604088349;
        bh=WFFIQ24pzzmm2c2eqxDZgGw8ctn1TTn3EJWorygVggY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l/XIJq4fmEIG5z81Hi0ba+7sRhRpDzK4dqpAVvIXkLw6t4OefRiGtFDh9EuaxL3KV
         H3G4uIjYttrUTpZVPxypxukxVVuy24GxZOKQ1EEP4owYju7Fqh/ElVR92eQqFa13S7
         vEOo9jJLqKUaTParqwa0S7z8Tqe2TmlzDCW/aCt4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g+mRzT6pscD0WKgTTyNqTLbXPvt9Jn27oQ7jtTVEsUdw@mail.gmail.com>
References: <CAJZ5v0g+mRzT6pscD0WKgTTyNqTLbXPvt9Jn27oQ7jtTVEsUdw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g+mRzT6pscD0WKgTTyNqTLbXPvt9Jn27oQ7jtTVEsUdw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc2
X-PR-Tracked-Commit-Id: 8f7304bb9113c95b256d3aa79a884b4c60a806e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee176906dc882ba6223d834ae61790e7550515fd
Message-Id: <160408834977.13990.14406330827043992639.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:05:49 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:30:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee176906dc882ba6223d834ae61790e7550515fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
