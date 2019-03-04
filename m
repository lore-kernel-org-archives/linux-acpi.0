From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework updates for v5.1-rc1
Date: Mon, 4 Mar 2019 14:24:14 +0100
Message-ID: <CAJZ5v0jP3p-fnqyVLmA=Saq9MSUdhCuKpkG_NkT+0AKSNU2sOQ@mail.gmail.com>
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
 devprop-5.1-rc1

with top-most commit 344798206f171c5abea7ab1f9762fa526d7f539d

 software node: Implement get_named_child_node fwnode callback

on top of commit f17b5f06cb92ef2250513a1e154c47b78df07d40

 Linux 5.0-rc4

to receive device properties framework updates for 5.1-rc1.

These fix the length value used in the PROPERTY_ENTRY_STRING()
macro and make software nodes use the get_named_child_node()
fwnode callback (Heikki Krogerus).

Thanks!


---------------

Heikki Krogerus (2):
      device property: Fix the length used in PROPERTY_ENTRY_STRING()
      software node: Implement get_named_child_node fwnode callback

---------------

 drivers/base/swnode.c    | 23 +++++++++++++++++++++++
 include/linux/property.h |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)
