From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 00/11] Software fwnode references
Date: Wed,  3 Apr 2019 19:45:26 +0300
Message-ID: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

This series adds support for software fwnode reference handling. In
practice it means making fwnode_property_get_reference_args() function
usable in the drivers also with software nodes. I send the series
originally as RFC [1].

As the first user for the software node references, I'm converting
intel_cht_int33fe.c to use them as part of the series.

[1] https://lkml.org/lkml/2019/3/15/457

thanks,

Heikki Krogerus (11):
  software node: Allow node creation without properties
  software node: Simplify software_node_release() function
  software node: Add support for references
  software node: Implement .get_reference_args fwnode operation
  ACPI / property: Don't limit named child node matching to data nodes
  device connection: Find connections also by checking the references
  usb: typec: Registering real device entries for the muxes
  platform/x86: intel_cht_int33fe: Provide software nodes for the
    devices
  platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
  platform/x86: intel_cht_int33fe: Link with external dependencies using
    fwnodes
  platform/x86: intel_cht_int33fe: Replacing the old connections with
    references

 drivers/acpi/property.c                  |  26 +-
 drivers/base/devcon.c                    |  28 ++
 drivers/base/swnode.c                    | 180 +++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c | 346 ++++++++++++++++++++---
 drivers/usb/typec/bus.h                  |  15 +
 drivers/usb/typec/class.c                |  17 +-
 drivers/usb/typec/mux.c                  | 221 ++++++++++-----
 drivers/usb/typec/mux/pi3usb30532.c      |  46 +--
 include/linux/property.h                 |   8 +
 include/linux/usb/typec_mux.h            |  62 ++--
 10 files changed, 765 insertions(+), 184 deletions(-)

-- 
2.20.1
