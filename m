From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 0/4] Export APIs to copy device properties & more
Date: Wed,  1 Feb 2017 09:31:21 -0800
Message-ID: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33986 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbdBARb2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2017 12:31:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

Hi,

Here is the refreshed series exporting APIs to copy statically declared
device properties. The reason is that we want to augment ACPI-based devices
with properties, and drivers usually have a largish DMI table for multiple
models, so it is desirable to mark everything as __initdata/__initconst,
and then copy only the entry matching the device we are running on and
discard the rest.

The last patch is not really about device property APIs, but rather
allowing users to attach properties to i2c_board_info, and have them
attached to instantiated device(s). The reason it is included is because it
depends on device_add_properties() taking const pointer, which is patch #2.

If it seems useful I hope Rafael and Wolfram would figure a way to merge it
:).

v3:
- fix memory leak in property_copy_string_array() pointed out by Mika
  Westerberg

v2:
- addressed Andy's comments
- added property_entries_free()
- added patch to allow constify values of property arrays
- added i2c patch allowing to attach property to devices via board info

v1:
- initial posting


Dmitry Torokhov (4):
  device property: export code duplicating array of property entries
  device property: allow to constify properties
  driver property: constify property arrays values
  i2c: allow specify device properties in i2c_board_info

 drivers/base/property.c  | 222 ++++++++++++++++++++++++++++++-----------------
 drivers/i2c/i2c-core.c   |  16 +++-
 include/linux/i2c.h      |   3 +
 include/linux/property.h |  19 ++--
 4 files changed, 171 insertions(+), 89 deletions(-)

Thanks.

-- 
Dmitry

