Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6636C433FE
	for <linux-acpi@archiver.kernel.org>; Fri, 24 Sep 2021 18:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF32C61263
	for <linux-acpi@archiver.kernel.org>; Fri, 24 Sep 2021 18:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbhIXSCK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:02:10 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36722 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbhIXSCJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 14:02:09 -0400
Received: by mail-oi1-f169.google.com with SMTP id y201so15575355oie.3;
        Fri, 24 Sep 2021 11:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=h1NtlTiZy6ayHV+iS5R5lx5yE7zPiiaIupfYhP7Z+ro=;
        b=tmf1PK4oBQLHKEh++3lEO151WsoC34x/B+O8yPr4c0PXSzNgAezQWO/d/Jx4UVoDno
         F3QMgwz0ki0b9j7grS3orneqo4jWj6ubegi0+62f48YUtwrADqMD5vud02NaYVLY0WEQ
         cwZJJ8I3yCqiAPIcWM8c9Twa6aaH+fo5nuo5ptUb7T+EJ8QgNtDLcm0bKnoUhB80qsFH
         WJdFptiEEm4z8PtcXjTBrLavqJChg4PpJnWY93Jjh20FX8riY+SWmI69LW9SHLp0Ph9e
         6ViCHeOEW0Yhinr4FxWPYxnuRJTqOAYnUKTkPi2k3kQF4aDfc6956Oq5cXR+XNr47H2D
         T6NA==
X-Gm-Message-State: AOAM533ZLyN5Vjyc5P70TRx+Ru7s/9VmFFU8Dr/YSDjMWI7HRXAM9EKF
        fNhz1/kxyDUQEAMNRsZcTp15wIIYUM29OUpkEJR0YvCmXz0=
X-Google-Smtp-Source: ABdhPJz7TfCATXdxY6RCb/IDohxyBUtA8QbORH8fdTQbEMfgzahSCP+HASsRrIFMbKVPep5bmtLm7HW3oVdyVnE/bII=
X-Received: by 2002:a54:4f15:: with SMTP id e21mr2546573oiy.71.1632506436180;
 Fri, 24 Sep 2021 11:00:36 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 20:00:25 +0200
Message-ID: <CAJZ5v0j+VDWvzoH1iuTqYm6epwhBf6R6JdxkoCZvzs6835AcWQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.15-rc3
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
 acpi-5.15-rc3

with top-most commit 12064c1768439fa0882547010afae6b52aafa7af

 Revert "ACPI: Add memory semantics to acpi_os_map_memory()"

on top of commit e4e737bb5c170df6135a127739a9e6148ee3da82

 Linux 5.15-rc2

to receive an ACPI fix for 5.15-rc3.

This reverts a recent commit related to memory management that
turned out to be problematic (Jia He).

Thanks!


---------------

Jia He (1):
      Revert "ACPI: Add memory semantics to acpi_os_map_memory()"

---------------

 arch/arm64/include/asm/acpi.h |  3 ---
 arch/arm64/kernel/acpi.c      | 19 +++----------------
 drivers/acpi/osl.c            | 23 +++++++----------------
 include/acpi/acpi_io.h        |  8 --------
 4 files changed, 10 insertions(+), 43 deletions(-)
