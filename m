From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] device property: post merge fixes
Date: Wed, 23 Dec 2015 15:34:41 +0200
Message-ID: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5399 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbbLWNey (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Dec 2015 08:34:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Three fixes to device property API.

Patch 1 is a simple style fix to be folded into previous Andrew's patch to
allow old gcc to build.

There is a crash in linux-next
 BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
 IP: [<ffffffff8145e8a6>] fwnode_property_present+0x16/0x30

Check for fwnode pointer before dereference (patch 2).

Patch 3 prevents to allocate buffers with 0 length (the result maybe surprising
to someone).


Andy Shevchenko (2):
  device property: add spaces to PROPERTY_ENTRY_STRING macro
  device property: avoid allocations of 0 length

Heikki Krogerus (1):
  device property: the secondary fwnode needs to depend on the primary

 drivers/base/property.c  | 14 ++++++++++----
 include/linux/property.h |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.6.4

