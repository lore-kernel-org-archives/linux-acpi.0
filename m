From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns AER
Date: Thu, 15 Nov 2018 17:16:01 -0600
Message-ID: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, Alexandru Gagniuc <mr.nuke.me@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

Thanks to Keith for pointing out that it doesn't make sense to disable
AER services when only one device has a FIRMWARE_FIRST HEST.

AER ownership is an interesting issue brought in by FFS (firmware-first)
model. In a nutshell if FFS handles AER, then OS should not touch any
of the AER bits. FW might set things up so that it receives AER
notifications via SMI. It's theoretically possible to receive SCIs,
but the exact mechanism is platform-dependent. OS touching AER bits
when firmware owns them may interfere with these notifications.

The ACPI mechanism for negotiating control of AER is _OSC, and is
described in detail in ACPI 6.2 Ch. 6.2.11.3. _OSC is negotiated at
the root bus level. Any root port, switch, or endpoint under the bus
would have its AER ownership negotiated in one _OSC call.

Then there is HEST, which is part of ACPI Platform Error Interfaces
(APEI). HEST tables describe the errors that FW may report to the OS.
A types 6,7 and 7 HEST tables describe AER errors from PCIe devices.
As part of this description, we're told if the error source is FFS.

Information in HEST seems to be redundant, as each error reported by
FW will have a CPER table that describes it in detail.

Because HEST describes an error source as firmware-first or not, we've
taken this to mean ownership of AER. Because AER ownership and error
reporting are coupled, _OSC and HEST usually agree on the matter of
ownership. However, that doesn't seem to be required by ACPI.

I've asked around a few people at Dell and they unanimously agree that
_OSC is the correct way to determine ownership of AER. In linux, we
use the result of _OSC to enable AER services, but we use HEST to
determine AER ownership. That's inconsistent. This series drops the
use of HEST in favor of _OSC.

[1] https://lkml.org/lkml/2018/11/15/62

Alexandru Gagniuc (2):
  PCI/AER: Do not use APEI/HEST to disable AER services globally
  PCI/AER: Determine AER ownership based on _OSC instead of HEST

 drivers/acpi/pci_root.c  |  9 +----
 drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
 include/linux/pci-acpi.h |  6 ---
 3 files changed, 5 insertions(+), 92 deletions(-)

-- 
2.17.1
