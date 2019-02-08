From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v5.0-rc6
Date: Fri, 8 Feb 2019 12:22:20 +0100
Message-ID: <CAJZ5v0hX3PB6k3GCP2y9MYGJiYH6Fvg=cFdUNuDx0FB5UnVY3A@mail.gmail.com>
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
 acpi-5.0-rc6

with top-most commit ce5cbf53496bfebe1b7478a532820373342e8302

 ACPI: Set debug output flags independent of ACPICA

on top of commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5

 Linux 5.0-rc5

to receive an ACPI fix for 5.0-rc6.

This prevents excessive ACPI debug messages from being printed
to the kernel log, which has started to happen after one of the
recent ACPICA commits (Erik Schmauss).

Thanks!


---------------

Erik Schmauss (1):
      ACPI: Set debug output flags independent of ACPICA

---------------

 drivers/acpi/bus.c | 3 +++
 1 file changed, 3 insertions(+)
