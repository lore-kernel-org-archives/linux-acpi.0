From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework fix for v5.1-rc2
Date: Fri, 22 Mar 2019 11:28:08 +0100
Message-ID: <CAJZ5v0i5Jy9sAXLQX-Wap5qW6_sw+CW9JOx4t8E=hazK39_xHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.1-rc2

with top-most commit 0e3edd94448001a33ed7f8af2179cd4a280348a2

 drivers: base: swnode: Make two functions static

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b

 Linux 5.1-rc1

to receive a device properties framework fix for 5.1-rc2.

This adds missing "static" in two places (YueHaibing).

Thanks!


---------------

YueHaibing (1):
      drivers: base: swnode: Make two functions static

---------------

 drivers/base/swnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
