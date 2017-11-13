From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework updates for v4.15-rc1
Date: Mon, 13 Nov 2017 23:08:14 +0100
Message-ID: <CAJZ5v0gwU-v66hCcxXUQ8Q8AeXtgb3Oxf-RwgvNSrH+bLhLqRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:48830 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdKMWIP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Nov 2017 17:08:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.15-rc1

with top-most commit 5e4b1b707b7ed795585b8ee28c44ce692aa8dfef

 device property: Add a macro for interating over graph endpoints

on top of commit 39dae59d66acd86d1de24294bd2f343fd5e7a625

 Linux 4.14-rc8

to receive device properties framework updates for 4.15-rc1.

These make the fwnode_handle_get() function return a pointer to the
target fwnode object, which reflects the of_node_get() behavior, and
add a macro for iterating over graph endpoints (Sakari Ailus).

Thanks!


---------------

Sakari Ailus (2):
      device property: Make fwnode_handle_get() return the fwnode
      device property: Add a macro for interating over graph endpoints

---------------

 drivers/base/property.c  | 9 +++++++--
 drivers/of/property.c    | 4 ++--
 include/linux/fwnode.h   | 2 +-
 include/linux/property.h | 6 +++++-
 4 files changed, 15 insertions(+), 6 deletions(-)
