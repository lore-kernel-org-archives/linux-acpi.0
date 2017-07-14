From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework fix for v4.13-rc1
Date: Fri, 14 Jul 2017 15:06:21 +0200
Message-ID: <CAJZ5v0jSwyM+va_79KWyLFXxXvz+mNAw5dpR0FUj2pDsW41vsQ@mail.gmail.com>
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
 devprop-fix-4.13-rc1

with top-most commit e8158b486d5f3f55cf372c5a32b42f263bf7f123

 device property: Introduce fwnode_call_bool_op() for ops that return bool

on top of commit 6a71d8d77795e0f7d887baa95bfc0d1d2bc74899

 device property: Add fwnode_graph_get_port_parent

to receive a device properties framework fix for v4.13-rc1.

This fixes a problem with bool properties that could be seen as
"true" when the property was not present at all by adding a special
helper for bool properties with checks for all of the requisute
conditions (Sakari Ailus).

Thanks!


---------------

Sakari Ailus (1):
      device property: Introduce fwnode_call_bool_op() for ops that return bool

---------------

 drivers/base/property.c | 6 +++---
 include/linux/fwnode.h  | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)
