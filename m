From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.14-rc3
Date: Thu, 28 Sep 2017 23:33:02 +0200
Message-ID: <CAJZ5v0idHaUYxhxwDYmYSVDU17joP=aLce_vcm14yhX8D1UZVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:53199 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbdI1VdD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Sep 2017 17:33:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.14-rc3

with top-most commit 333d1774224de9d1d9cedf11218e297d5421044b

 Merge branch 'acpi-apei'

on top of commit e19b205be43d11bff638cad4487008c48d21c103

 Linux 4.14-rc2

to receive an ACPI fix for v4.14-rc3.

This fixes an APEI problem that may cause a reported error to be
missed due to a race condition.

Thanks!


---------------

Tyler Baicar (1):
      ACPI / APEI: clear error status before acknowledging the error

---------------

 drivers/acpi/apei/ghes.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
