From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v5.1-rc2
Date: Fri, 22 Mar 2019 11:26:55 +0100
Message-ID: <CAJZ5v0g3_wWoN4Bp1+EKLuNxi3XDp2LrMq21cXCm8FFPoo6FOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc2

with top-most commit 54e3aca84e571559915998aa6cc05e5ac37c043b

 ACPI / utils: Drop reference in test for device presence

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b

 Linux 5.1-rc1

to receive an ACPI fix for 5.1-rc2.

This prevents device references acquired by bus_find_device() in
acpi_dev_present() from being leaked (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI / utils: Drop reference in test for device presence

---------------

 drivers/acpi/utils.c | 1 +
 1 file changed, 1 insertion(+)
