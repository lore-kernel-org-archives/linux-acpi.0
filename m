From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: ACPI/PCI _PS3 slot power management
Date: Wed, 10 May 2006 17:08:57 -0600
Message-ID: <200605101708.57416.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:30675 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S965067AbWEJXJB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 May 2006 19:09:01 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Shaohua Li <shaohua.li@intel.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>

pci_set_power_state() is a per-PCI-function interface, just like
most of the other PCI interfaces.  On ACPI systems, it ultimately
calls acpi_bus_set_power(), which evaluates the _PSx method of the
ACPI function object.

This: http://www.microsoft.com/whdc/system/pnppwr/hotadd/hotplugpci.mspx
suggests that a system that supports ACPI hotplug and power control
should supply an ACPI device for each PCI function that might exist
in the slot.  The _PSx methods exist under one or more of these devices
(the document above suggests that it's under each device; the HP systems
I've seen have _PSx only under the device for function 0).

In any case, the _PSx methods control power to the whole *slot*, not
just a single function.  The result is that calling pci_set_power_state()
on one PCI function turns off power to the entire slot, even though there
may be other independent functions that shouldn't be turned off.

Do we need to be smarter in acpi_pci_set_power_state(), and collect
up all the PCI per-function power requests, and only pass those
down to acpi_bus_set_power() when all the functions agree?

Other than the Microsoft document above, I haven't seen a good spec
that clarifies this issue.

Bjorn
