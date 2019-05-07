Return-Path: <SRS0=qBNj=TH=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395DDC04A6B
	for <linux-acpi@archiver.kernel.org>; Tue,  7 May 2019 02:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFB520835
	for <linux-acpi@archiver.kernel.org>; Tue,  7 May 2019 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557197720;
	bh=Y2FkhGgE1w4YteJRJs4vtHEcnFdDaNELYViYROZqNiw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bfFOq4FfyWpcqP7+jJo+cveVUPaYRUJn7NZMhK+WrDR/pDhe3gGXJX4dB361sSC9j
	 n+W3Avce2GSXQY2KCMmMjxL32HjvMtQXiMMcId30ewOEsURRfHJr1s17n9khbWCUVU
	 QsDcOkXnqIcrFYhsd8t+Ccigg9WHLU5tKL4dCKLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfEGCzE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 6 May 2019 22:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbfEGCzD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 May 2019 22:55:03 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557197703;
        bh=Y2FkhGgE1w4YteJRJs4vtHEcnFdDaNELYViYROZqNiw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0TjEVvomeTnpg8d5Nsr5cAwdkkH5xJMd4q2y0mGXiv3nVekyULtJMZKcSDf49YWsx
         0PG35EDqCmDjZCmns8hBcP1Xk2g5uv9QlUBVm6Y7M0ePvMNFldXy64ViU7BFWugzpP
         Jfmt8ZAYxxsZkwbQXDhAZSuApBwkD92g3d2COe4U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hW+jd7r5J5=XyMM2rk5oHQrrP70_LBEVdSMTGsd=zxNw@mail.gmail.com>
References: <CAJZ5v0hW+jd7r5J5=XyMM2rk5oHQrrP70_LBEVdSMTGsd=zxNw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hW+jd7r5J5=XyMM2rk5oHQrrP70_LBEVdSMTGsd=zxNw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.2-rc1
X-PR-Tracked-Commit-Id: 10b4768b27a0b8f9459570723ecb1809f4d707e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59df1c2bdecb0d1aaadfb8533df4bea528ee4952
Message-Id:
 <155719770324.24898.13259466001772450447.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 02:55:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190507025503.R0V_awrUvd-pr5kR1KOdqjWpp6R-Rd71Jg0L9D6KetQ@z>

The pull request you sent on Mon, 6 May 2019 13:12:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59df1c2bdecb0d1aaadfb8533df4bea528ee4952

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
