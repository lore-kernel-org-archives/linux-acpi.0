From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Generic device properties framework updates for v4.12-rc1
Date: Mon, 1 May 2017 22:51:53 +0200
Message-ID: <CAJZ5v0j5AY-Jp4XQ8VW9y30NTXtKaDsPU-g6iqp0zew3tNayHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36068 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdEAUv4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 May 2017 16:51:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.12-rc1

with top-most commit e48174779440c79ff5dd75f0e6b169d4e184262d

 device property: Read strings using string array reading functions

on top of commit c02ed2e75ef4c74e41e421acb4ef1494671585e8

 Linux 4.11-rc4

to receive generic device properties framework updates for v4.12-rc1.

These add support for the ports and endpoints concepts, based on the
existing DT support for them, to the generic device properties
framework and update the ACPI _DSD properties code to recognize
ports and endpoints accordingly.

Specifics:

 - Extend the ACPI _DSD properties code and the generic device
   properties framework to support the concept of remote endponts
   (Mika Westerberg, Sakari Ailus).

 - Document the support for ports and endpoints in _DSD properties
   and extend the generic device properties framework to make it
   more suitable for the handling of ports and endpoints (Sakari
   Ailus).

Thanks!

---------------

Mika Westerberg (6):
      ACPI / property: Add possiblity to retrieve parent firmware node
      device property: Add fwnode_get_parent()
      ACPI / property: Add fwnode_get_next_child_node()
      device property: Add fwnode_get_named_child_node()
      ACPI / property: Add support for remote endpoints
      device property: Add support for remote endpoints

Sakari Ailus (10):
      device property: Add fwnode_handle_get()
      of: Add of_fwnode_handle() to convert device nodes to fwnode_handle
      device property: Make dev_fwnode() public
      device property: Add support for fwnode endpoints
      device property: Add fwnode_get_next_parent()
      ACPI / DSD: Document references, ports and endpoints
      device property: fwnode_property_read_string_array() may return -EILSEQ
      device property: Fix reading pset strings using array access functions
      device property: fwnode_property_read_string_array() returns nr of strings
      device property: Read strings using string array reading functions

---------------

 Documentation/acpi/dsd/graph.txt | 162 +++++++++++++++++
 drivers/acpi/property.c          | 259 ++++++++++++++++++++++++----
 drivers/base/property.c          | 364 +++++++++++++++++++++++++++++++--------
 include/acpi/acpi_bus.h          |   1 +
 include/linux/acpi.h             |  38 +++-
 include/linux/fwnode.h           |  12 ++
 include/linux/of.h               |   4 +
 include/linux/property.h         |  26 +++
 8 files changed, 761 insertions(+), 105 deletions(-)
