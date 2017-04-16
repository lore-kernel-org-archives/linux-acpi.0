From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI: Device enumeration udates
Date: Mon, 17 Apr 2017 01:18:51 +0200
Message-ID: <20731969.imAyuWkf7P@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

These two patches change a couple of things related to the ACPI enumeration of
devices.

[1/2] causes the default enumeration to also be used for device objects with
ACPI drivers bound for consistency.

[2/2] makes acpi_bus_attach() look at the "visited" flag of device objects as
it should really.

Please let me know if you see any potential problems with these patches.

Thanks,
Rafael
