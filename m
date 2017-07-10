From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework updates for v4.13-rc1
Date: Tue, 11 Jul 2017 00:03:06 +0200
Message-ID: <CAJZ5v0i_D089gXArcghZa6cmEfQrXP3J-zwDRfrDf8PjE3G3vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33591 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754420AbdGJWDI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jul 2017 18:03:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.13-rc1

with top-most commit 6a71d8d77795e0f7d887baa95bfc0d1d2bc74899

 device property: Add fwnode_graph_get_port_parent

on top of commit 41f1830f5a7af77cf5c86359aba3cbd706687e52

 Linux 4.12-rc6

to receive device properties framework updates for v4.13-rc1.

These mostly rearrange the device properties core code and add a few
helper functions to it as a foundation for future work.

Specifics:

 - Rearrange the core device properties code by moving the code
   specific to each supported platform configuration framework
   (ACPI, DT and build-in) into a separate file (Sakari Ailus).

 - Add helper functions for accessing device properties in a
   firmware-agnostic way (Sakari Ailus, Kieran Bingham).

This includes the dt/property-move branch pulled from the Rob's tree
at git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux to
satisfy dependencies.

Thanks!


---------------

Kieran Bingham (1):
      device property: Add fwnode_graph_get_port_parent

Sakari Ailus (8):
      of: Move OF property and graph API from base.c to property.c
      of: Make of_fwnode_handle() safer
      of: Support const and non-const use for to_of_node()
      ACPI: Constify argument to acpi_device_is_present()
      device property: Move FW type specific functionality to FW specific files
      device property: Move fwnode graph ops to firmware specific locations
      device property: Introduce fwnode_device_is_available()
      device property: Add FW type agnostic fwnode_graph_get_remote_node

---------------

 drivers/acpi/device_pm.c |   4 +-
 drivers/acpi/internal.h  |   2 +-
 drivers/acpi/property.c  | 117 ++++++
 drivers/acpi/scan.c      |  10 +-
 drivers/base/property.c  | 348 ++++++++----------
 drivers/of/Makefile      |   2 +-
 drivers/of/base.c        | 733 -------------------------------------
 drivers/of/property.c    | 914 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   4 +
 include/linux/fwnode.h   |  69 ++++
 include/linux/of.h       |  32 +-
 include/linux/property.h |   5 +
 12 files changed, 1289 insertions(+), 951 deletions(-)
