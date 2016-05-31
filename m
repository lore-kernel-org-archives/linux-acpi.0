From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in IO resource allocation
Date: Tue, 31 May 2016 23:11:57 +0200
Message-ID: <3491327.Z9FVFNvO7z@vostro.rjw.lan>
References: <CAL1RGDW9z1FhgQwJZTkk0kUBipT68hmW2C4--3Hbb5vzj5ta2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL1RGDW9z1FhgQwJZTkk0kUBipT68hmW2C4--3Hbb5vzj5ta2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, May 31, 2016 01:12:52 PM Roland Dreier wrote:
> Hi,
> 
> I recently updated one of my systems from 3.10.y to 4.4.11, and
> discovered a regression that stops it from booting.  It's actually
> very similar to https://bugzilla.kernel.org/show_bug.cgi?id=99831
> (which I reported about the same system last year).
> 
> The problem is that commit ac212b6980d8 ("ACPI / processor: Use common
> hotplug infrastructure") changes the order that the ACPI processor and
> PnP initialization run.  pnp_system_init() is run at fs_initcall time,
> while acpi_processor_init() is run from acpi_scan_init(), earlier at
> subsys_initcall time.  Pre-ac212b6980d8, the ACPI processor
> initialization all ran from acpi_processor_init() at module_init time.
> So the processor driver initialization has flipped from after to
> before pnp_system_init().
> 
> Just as before, the failure is that the resource allocation code puts
> some AHCI IO BARs around 0x400, and reservation fails because some
> other ACPI stuff is also there.  The problem is that when acpi_processor_init()
> runs, it reserves a range 0x410 - 0x415 for "ACPI CPU throttle", and
> if that happens before pnp_system_init(), then I get
> 
>     system 00:01: [io  0x0400-0x047f] could not be reserved
> 
> because that overlaps the already-reserved range.  Then the PCI
> resource allocation code is free to put PCI resources into that range
> and tons of things go south after that.

Definitely the request_region() in acpi_processor.c is a bug as that file
should be about enumeration only (and we don't even know whether or not
the region will be actually used at that point).

> For now I've worked around it by commenting out the request_region()
> in acpi_processor.c but that doesn't seem like a very good long-term
> solution.  Does it make sense to resurrect the patches you had to let
> ACPI and PnP coexist in resource reservation?  Or could we move the
> request_region() for CPU throttle into the still-modular
> initialization done from acpi_processor_driver_init()?

In ptinciple, that can be done.

Can you please try the appended patch (untested)?

Thanks,
Rafael


---
 drivers/acpi/acpi_processor.c       |    9 ---------
 drivers/acpi/processor_throttling.c |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/acpi_processor.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_processor.c
+++ linux-pm/drivers/acpi/acpi_processor.c
@@ -331,15 +331,6 @@ static int acpi_processor_get_info(struc
 		pr->throttling.duty_width = acpi_gbl_FADT.duty_width;
 
 		pr->pblk = object.processor.pblk_address;
-
-		/*
-		 * We don't care about error returns - we just try to mark
-		 * these reserved so that nobody else is confused into thinking
-		 * that this region might be unused..
-		 *
-		 * (In particular, allocating the IO range for Cardbus)
-		 */
-		request_region(pr->throttling.address, 6, "ACPI CPU throttle");
 	}
 
 	/*
Index: linux-pm/drivers/acpi/processor_throttling.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_throttling.c
+++ linux-pm/drivers/acpi/processor_throttling.c
@@ -676,6 +676,15 @@ static int acpi_processor_get_throttling
 	if (!pr->flags.throttling)
 		return -ENODEV;
 
+	/*
+	 * We don't care about error returns - we just try to mark
+	 * these reserved so that nobody else is confused into thinking
+	 * that this region might be unused..
+	 *
+	 * (In particular, allocating the IO range for Cardbus)
+	 */
+	request_region(pr->throttling.address, 6, "ACPI CPU throttle");
+
 	pr->throttling.state = 0;
 
 	duty_mask = pr->throttling.state_count - 1;
