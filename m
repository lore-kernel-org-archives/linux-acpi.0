From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework update for v4.18-rc1
Date: Mon, 4 Jun 2018 13:31:01 +0200
Message-ID: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
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
 dp-4.18-rc1

with top-most commit 63dcc7090137a893322432e156d66be3ce104615

 device property: Get rid of union aliasing

on top of commit 67b8d5c7081221efa252e111cd52532ec6d4266f

 Linux 4.17-rc5

to receive a device properties framework update for 4.18-rc1.

This modifies the device properties framework to remove union
aliasing from it (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      device property: Get rid of union aliasing

---------------

 drivers/base/property.c                 | 104 ++++++++++++++++++++++++++------
 drivers/firmware/efi/apple-properties.c |   8 ++-
 include/linux/property.h                |  52 ++++++++--------
 3 files changed, 117 insertions(+), 47 deletions(-)
