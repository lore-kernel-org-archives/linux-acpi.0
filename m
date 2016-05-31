From: Roland Dreier <roland@purestorage.com>
Subject: Regression in IO resource allocation
Date: Tue, 31 May 2016 13:12:52 -0700
Message-ID: <CAL1RGDW9z1FhgQwJZTkk0kUBipT68hmW2C4--3Hbb5vzj5ta2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I recently updated one of my systems from 3.10.y to 4.4.11, and
discovered a regression that stops it from booting.  It's actually
very similar to https://bugzilla.kernel.org/show_bug.cgi?id=99831
(which I reported about the same system last year).

The problem is that commit ac212b6980d8 ("ACPI / processor: Use common
hotplug infrastructure") changes the order that the ACPI processor and
PnP initialization run.  pnp_system_init() is run at fs_initcall time,
while acpi_processor_init() is run from acpi_scan_init(), earlier at
subsys_initcall time.  Pre-ac212b6980d8, the ACPI processor
initialization all ran from acpi_processor_init() at module_init time.
So the processor driver initialization has flipped from after to
before pnp_system_init().

Just as before, the failure is that the resource allocation code puts
some AHCI IO BARs around 0x400, and reservation fails because some
other ACPI stuff is also there.  The problem is that when acpi_processor_init()
runs, it reserves a range 0x410 - 0x415 for "ACPI CPU throttle", and
if that happens before pnp_system_init(), then I get

    system 00:01: [io  0x0400-0x047f] could not be reserved

because that overlaps the already-reserved range.  Then the PCI
resource allocation code is free to put PCI resources into that range
and tons of things go south after that.

For now I've worked around it by commenting out the request_region()
in acpi_processor.c but that doesn't seem like a very good long-term
solution.  Does it make sense to resurrect the patches you had to let
ACPI and PnP coexist in resource reservation?  Or could we move the
request_region() for CPU throttle into the still-modular
initialization done from acpi_processor_driver_init()?

Thanks!
  Roland
