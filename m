From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/4] ACPI: Reorganize the core device management/enumeration code
Date: Tue, 14 Jul 2015 01:16:12 +0200
Message-ID: <4521894.N8pXmo8fxI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

The size and complexity of drivers/acpi/scan.c has bothered me for quite
a while and since I'm working on a feature that will benefit from exposing
some additional information under ACPI device objects in sysfs, I've decided
to reorganize the code to move some things out of scan.c.

[1/4] Move all ACPI device code related to sysfs into a separate (new) file.
[2/4] Move device matching code to bus.c.
[3/4] Mode device notification, bus operations and driver management code to bus.c.
[4/4] Register the ACPI bus type in acpi_bus_init().

No functional changes except for the [4/4] that will case ACPI to be disabled if
the ACPI bus type cannot be registered.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
