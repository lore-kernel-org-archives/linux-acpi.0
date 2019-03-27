From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/3] device property: fwnode_is_compatible() helper
Date: Wed, 27 Mar 2019 19:43:36 +0300
Message-ID: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Biju Das <biju.das@bp.renesas.com>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Basically the helper is just a generic version of the function
of_device_is_compatible() that should work also with ACPI and
software nodes.

As the first user for the helper, I'm converting in this series the
USB role switch code to expect the "compatible" property to have the
value "usb-role-switch" instead of expecting a boolean property named
"usb-role-switch". I'm doing the same for the USB Type-C mux code.

thanks,

Heikki Krogerus (3):
  device property: Add fwnode_is_compatible() and device_is_compatible()
    helpers
  usb: roles: Use the "compatible" property instead of a boolean
    property
  usb: typec: mux: Use the "compatible" property instead of a boolean
    property

 drivers/base/property.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/usb/roles/class.c |  2 +-
 drivers/usb/typec/mux.c   |  8 ++------
 include/linux/property.h  |  3 +++
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.20.1
