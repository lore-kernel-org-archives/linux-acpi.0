From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v5.1-rc3
Date: Sat, 30 Mar 2019 01:38:42 +0100
Message-ID: <CAJZ5v0hx5EMHeJoS+OZDpg+vU3LVxX7gn3Jo4gbFB7Hyh3Kq4w@mail.gmail.com>
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
 acpi-5.1-rc3

with top-most commit aa9aaa4d61c0048d3faad056893cd7860bbc084c

 ACPI: use different default debug value than ACPICA

on top of commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00

 Linux 5.1-rc2

to receive an ACPI fix for 5.1-rc3.

This corrects a previous attempt to make Linux use its own
set of ACPI debug flags different from the upstream ACPICA's
default (Erik Schmauss).

Thanks!


---------------

Erik Schmauss (1):
      ACPI: use different default debug value than ACPICA

---------------

 drivers/acpi/bus.c              | 3 ---
 include/acpi/acoutput.h         | 3 +++
 include/acpi/platform/aclinux.h | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)
