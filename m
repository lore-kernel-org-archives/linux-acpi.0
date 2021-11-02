Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D51C433F5
	for <linux-acpi@archiver.kernel.org>; Tue,  2 Nov 2021 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9C160F56
	for <linux-acpi@archiver.kernel.org>; Tue,  2 Nov 2021 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBT6g (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 2 Nov 2021 15:58:36 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:41503 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhKBT6g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 15:58:36 -0400
Received: by mail-oo1-f44.google.com with SMTP id t201-20020a4a3ed2000000b002b8c98da3edso57095oot.8;
        Tue, 02 Nov 2021 12:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D6qcazaxzVHPjC/WUharTcf2EmpETM0fWCuJ5fZpLW8=;
        b=RDS7yGTdfitEYCX+Ke24p7r5YLQx/LLHvcucHSRic76LFy0gtEBZYUrC3qu/sFUyiK
         clx/UszFMhH6gF3omRcvRIRyPoEr8o0L2gao5Te2vAF+sfSxLcmtxfO1nwzNvpTB4FPc
         CtMjPGDVYCdgbQowoLf1nKQDjDusP3/LkBlBUQ+8Kl8PLb2ddglWuT6RA2aJpl9A4ePs
         IQCJ18YiINxb3W0Z4JZd4oahoFhaIa055G1I09oFzYfrRFeMZuXSpoN6Q+T4HknoJv76
         YuziwS6WZO3pQ4c8eKSKZyoxMFr4cpq7UMYIkwfO6iYs07VNOqggjSFcwFp9kPQjCUGQ
         i8qQ==
X-Gm-Message-State: AOAM531ZieYKdwTkxX9FSLxlU0BJsFTQAUEywTklCmvxjZVJpWlOS3OP
        uZBJsgR6f2a9sdvZ1g5FI4lC4Qq3lmDjY/1X/XtMxCNXrsQ=
X-Google-Smtp-Source: ABdhPJzQsOJRKjTZymHsuIVPVkCr14kTLsFbFyHaD8GPCyMpnFFZz6WKmOeU3dHD9vguNjy32qWSzGXNuf9g3AGCn1w=
X-Received: by 2002:a4a:e9fc:: with SMTP id w28mr7702851ooc.89.1635882960530;
 Tue, 02 Nov 2021 12:56:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Nov 2021 20:55:49 +0100
Message-ID: <CAJZ5v0g4KiDt5Ja-bnP-kJCk311wbOwwr4q7UjXTsoc3ePdbbA@mail.gmail.com>
Subject: [GIT PULL] PNP update for v5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-5.16-rc1

with top-most commit 47e9249a6cc78c2856bdc8c2f8bd495309cbc060

 PNP: system.c: unmark a comment as being kernel-doc

on top of commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896

 Linux 5.15-rc4

to receive a PNP update for 5.16-rc1.

This fixes a comment incorrectly marked as kernel-doc (Randy Dunlap).

Thanks!


---------------

Randy Dunlap (1):
      PNP: system.c: unmark a comment as being kernel-doc

---------------

 drivers/pnp/system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
