From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.15-rc1
Date: Fri, 17 Nov 2017 15:38:38 +0100
Message-ID: <CAJZ5v0hVwY7CjYJoREGhTR1VQYdDKkFqAdnTSWSYmBOL1wWtgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:44348 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934029AbdKQOij (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Nov 2017 09:38:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-fix-4.15-rc1

with top-most commit 09e15086936e01d7588020be37ea724116bcefec

 ACPI / utils: Fix memory leak in acpi_evaluate_reference() error path

on top of commit 04ed510988f278a69872b4cdb426e565e3236215

 Merge tag 'acpi-4.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an ACPI fix for 4.15-rc1.

This fixes a possible memory leak in an error code path in one of
the utility routines (Xiongfeng Wang).

Thanks!


---------------

Xiongfeng Wang (1):
      ACPI / utils: Fix memory leak in acpi_evaluate_reference() error path

---------------

 drivers/acpi/utils.c | 1 +
 1 file changed, 1 insertion(+)
