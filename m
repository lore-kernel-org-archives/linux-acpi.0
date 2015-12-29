From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/3] device property: post merge fixes
Date: Tue, 29 Dec 2015 13:07:47 +0200
Message-ID: <1451387271-56535-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Three fixes to device property API.

Patch 1 is a simple style fix to be folded into previous Andrew's patch to
allow old gcc to build (see commit message for the details).

There is a crash in linux-next
 BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
 IP: [<ffffffff8145e8a6>] fwnode_property_present+0x16/0x30

Check for fwnode pointer before dereference (patch 2).

Patch 3 prevents to allocate buffers with 0 length (the result maybe surprising
to someone).

Changelog v3:
- fix typo in Heikki's patch (patch 2)
- update commit message for patch 1 to explain what is the fixup for

Changelog v2:
- added patches 2 and 3

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
