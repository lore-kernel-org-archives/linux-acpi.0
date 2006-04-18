From: Patrick Mochel <mochel@linux.intel.com>
Subject: [patch 00/24] Remove unneeded debugging info from ACPI drivers
Date: Mon, 17 Apr 2006 18:21:30 -0700
Message-ID: <20060418012130.GD23261@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:23942 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932104AbWDRBZC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:02 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1P16X013932
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:02 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Hi there,


Following are a series of patches that remove a whole lot of unneeded 
debugging macros from the ACPI drivers. 

Currently, most of the ACPI code has the entry/exit macros in every
function. e.g.:

	ACPI_FUNCTION_TRACE("acpi_do_something")

	return_VALUE(result);

This is fine for the ACPI-CA, but unnecessary for the Linux-specific 
code, since it is most easily debugged using means other than the ACPI
debugger (usually developer-specific, but also with kgdb/kdb). This
has created an unnecessary dependency of the Linux-specific code on 
ACPI CA headers, and caused a lot of eye-sore and confusion when
reading the code (i.e. "What is this doing? Hmm, must be magic..").
It seems that we're better off using Linux-specific methods of
debugging for these components, since it's all Linux-specific code.


This set of patches is the first in a series to convert the ACPI
drivers over to a better driver model, which will pave the way to
doing many great things, like

  - exporting ACPI controls via sysfs rather than procfs
  - implementing proper suspend/resume methods for all ACPI devices
  - cleanly dealing with the hotplug of ACPI objects and the devices
    they represent

These patches are mostly cosmetic, so they will serve to work out the
kinks of the patch flow; basically to "prime the pump" for the goodness
to come later. 

I will send the patches to the list (provided the scripts workout Ok),
or you can pull from the git tree at:

  git://git.org/pub/scm/linux/kernel/git/mochel/linux-2.6-acpi.git/ test-driver


The diffstat and changelog are appended below. 

Thanks,


	Patrick


 drivers/acpi/ac.c                   |   60 +++--------
 drivers/acpi/acpi_memhotplug.c      |   94 +++++------------
 drivers/acpi/battery.c              |  110 +++++++-------------
 drivers/acpi/bus.c                  |  115 +++++++--------------
 drivers/acpi/button.c               |   64 +++--------
 drivers/acpi/container.c            |   38 ++-----
 drivers/acpi/debug.c                |   16 +-
 drivers/acpi/ec.c                   |  165 +++++++++++-------------------
 drivers/acpi/event.c                |   16 +-
 drivers/acpi/fan.c                  |   53 +++------
 drivers/acpi/hotkey.c               |  115 ++++++---------------
 drivers/acpi/motherboard.c          |    6 -
 drivers/acpi/pci_bind.c             |   41 ++-----
 drivers/acpi/pci_irq.c              |   72 ++++---------
 drivers/acpi/pci_link.c             |  120 ++++++++--------------
 drivers/acpi/pci_root.c             |   28 +----
 drivers/acpi/power.c                |  140 ++++++++++---------------
 drivers/acpi/processor_core.c       |  125 ++++++++---------------
 drivers/acpi/processor_idle.c       |   80 +++++---------
 drivers/acpi/processor_perflib.c    |  105 +++++++------------
 drivers/acpi/processor_thermal.c    |   42 ++-----
 drivers/acpi/processor_throttling.c |   48 +++-----
 drivers/acpi/system.c               |   22 +---
 drivers/acpi/thermal.c              |  195 ++++++++++++------------------------
 24 files changed, 665 insertions(+), 1205 deletions(-)


--------


Patrick Mochel:
      [acpi] Remove unneeded debugging macros in drivers/acpi/ac.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/acpi_memhotplug.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/battery.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/bus.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/button.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/container.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/debug.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/ec.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/event.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/fan.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/hotkey.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/motherboard.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/pci_bind.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/pci_irq.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/pci_link.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/pci_root.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/power.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/processor_core.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/processor_idle.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/processor_perflib.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/processor_thermal.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/processor_throttling.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/system.c
      [acpi] Remove unneeded debugging macros in drivers/acpi/thermal.c

