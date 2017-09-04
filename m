From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework updates for v4.14-rc1
Date: Mon, 4 Sep 2017 23:41:09 +0200
Message-ID: <CAJZ5v0iJoeVMPxknHirWC0=AeVpGQE-Np+s+QwZc3GhgHp1jOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34207 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdIDVlK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Sep 2017 17:41:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.14-rc1

with top-most commit 3689d3d6907271b5737de5bff584cb50cb29ebc2

 ACPI: device property: Switch to use new generic UUID API

on top of commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877

 Linux v4.13-rc1

to receive device properties framework updates for v4.14-rc1.

These introduce fwnode operations for all of the separate types of
"firmware nodes" that can be handled by the device properties
framework, make the framework use const fwnode arguments all over,
add a helper for the consolidated handling of node references
and switch over the framework to the new UUID API.

Specifics:

 - Introduce fwnode operations for all of the separate types of
   "firmware nodes" that can be handled by the device properties
   framework and drop the type field from struct fwnode_handle
   (Sakari Ailus, Arnd Bergmann).

 - Make the device properties framework use const fwnode arguments
   where possible (Sakari Ailus).

 - Add a helper for the consolidated handling of node references
   to the device properties framework (Sakari Ailus).

 - Switch over the ACPI part of the device properties framework
   to the new UUID API (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: device property: Switch to use new generic UUID API

Arnd Bergmann (1):
      device property: export irqchip_fwnode_ops

Sakari Ailus (8):
      ACPI: Use IS_ERR_OR_NULL() instead of non-NULL check in
is_acpi_data_node()
      device property: Get rid of struct fwnode_handle type field
      ACPI: Prepare for constifying acpi_get_next_subnode() fwnode argument
      ACPI: Constify acpi_bus helper functions, switch to macros
      ACPI: Constify internal fwnode arguments
      device property: Constify argument to pset fwnode backend
      device property: Constify fwnode property API
      device property: Introduce fwnode_property_get_reference_args

---------------

 drivers/acpi/property.c   | 231 ++++++++++++++++++++++++++++------------------
 drivers/acpi/scan.c       |   3 +-
 drivers/base/property.c   | 131 +++++++++++++++++---------
 drivers/of/property.c     |  66 +++++++++----
 include/acpi/acpi_bus.h   |  52 +++++++----
 include/linux/acpi.h      |  68 +++++++-------
 include/linux/fwnode.h    |  56 ++++++-----
 include/linux/irqdomain.h |   4 +-
 include/linux/of.h        |   3 +-
 include/linux/property.h  |  67 ++++++++------
 kernel/irq/irqdomain.c    |  11 ++-
 11 files changed, 428 insertions(+), 264 deletions(-)
