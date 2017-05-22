From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 0/7] Constify property fwnode arguments
Date: Mon, 22 May 2017 12:07:35 +0300
Message-ID: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56117 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757656AbdEVJIx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 05:08:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Hello everyone,

This set constifies the fwnode arguments in the fwnode property API more
or less the way they are const in OF property API.

Comments are welcome.

The set depends on these patchsets:

<URL:http://www.spinics.net/lists/devicetree/msg177549.html>
<URL:http://www.spinics.net/lists/linux-media/msg114283.html>
<URL:http://marc.info/?l=linux-acpi&m=149544328528001&w=2>

The patches and their dependencies may be also found here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=fwnode-const>

(It's uploading right now, so you may need to wait a bit until it's all
up to date.)

Sakari Ailus (7):
  ACPI: Constify acpi_get_next_subnode() fwnode argument
  ACPI: Constify acpi_bus helper functions, switch to macros
  ACPI: Constify internal fwnode arguments
  device property: Constify argument to pset fwnode backend
  device property: Constify fwnode property API
  v4l: fwnode: Constify fwnode endpoints
  v4l2-async: Make fwnode const

 drivers/acpi/property.c               | 90 +++++++++++++++++++---------------
 drivers/base/property.c               | 91 +++++++++++++++++++----------------
 drivers/media/v4l2-core/v4l2-fwnode.c | 12 ++---
 drivers/of/property.c                 | 29 +++++------
 include/acpi/acpi_bus.h               | 39 +++++++++------
 include/linux/acpi.h                  | 60 ++++++++++++-----------
 include/linux/fwnode.h                | 25 +++++-----
 include/linux/property.h              | 58 +++++++++++-----------
 include/media/v4l2-async.h            |  2 +-
 include/media/v4l2-fwnode.h           |  6 +--
 10 files changed, 226 insertions(+), 186 deletions(-)

-- 
2.7.4

