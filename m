From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v2 0/2] PCI/AER: Consistently use _OSC to determine who owns AER
Date: Tue, 26 Mar 2019 12:23:40 -0500
Message-ID: <20190326172343.28946-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, scott.faasse@hpe.com, leo.duran@amd.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

This started as a nudge from Keith, who pointed out that it doesn't make sense
to disable AER services when only one device has a FIRMWARE_FIRST HEST.

I won't re-phrase the points in the original patch [1]. The patch started a
long discussion in the ACPI Software Working Group (ASWG). The nearly unanimous
conclusion is that my original interpretation is correct.

I'd like to quote one of the tables that was produced as part of that
conversation:

(_OSC AER Control, HEST AER Structure FFS) = (0, 0)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM has no guidance on how AER errors are being handled – but it
	  does know that it is not in control of AER registers. PCI-e errors
	  that make it to the OS (via NMI, etc) would be treated as spurious
	  since access to the AER registers isn’t allowed for proper sourcing.


(_OSC AER Control, HEST AER Structure FFS) = (0, 1)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM is being given guidance that Firmware is handling AER errors and
	  those interrupts are routed to the platform. Firmware may pass along
	  error information via GHES


(_OSC AER Control, HEST AER Structure FFS) = (0, Does not exist)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM has no guidance on how AER errors are being handled – but it
	  does know that it is not in control of AER registers. PCI-e errors
	  that make it to the OS (via NMI, etc) would be treated as spurious
	  since access to the AER registers isn’t allowed for proper sourcing.

(_OSC AER Control, HEST AER Structure FFS) = (1, 0)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM is being given guidance that AER errors will interrupt the OS
	  directly and that the OS is expected to handle all AER capability
	  structure read/clears for the devices with this attribute (or all if
	  the Global Bit is set.)

(_OSC AER Control, HEST AER Structure FFS) = (1, 1)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM is being given guidance that although OS is in control of AER
	  read/writes – the actual interrupt is being routed to the platform
	  first.
	* Subsequent fields with masks/enables should be performed by the OS
	  during initialization on behalf of firmware. These are to be honoured
	  in this mode because with FF, the firmware needs to be able to handle
	  the errors it expects and not be given errors it was not expecting to
	  handle.
	* Firmware may pass along error information via GHES, or generate an OS
	  interrupt and allow the OS to interrogate AER status directly via the
	  AER capability structures.


(_OSC AER Control, HEST AER Structure FFS) = (0, Does not exist)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM has no guidance from the platform and is in complete control of
	  AER error handling.


There may be one caveat. Someone mentioned in the original discussions that
there may exist machines which make the assumption that HEST is authoritative,
but did not identify any such machine. We should keep in mind that they may
require a quirk.

Alex


[1] https://lkml.org/lkml/2018/11/16/202

Changes since v1:
 * Started 6-month conversation in ASWG
 * Re-phrased commit message to reflect some of the points in ASWG discussion

Alexandru Gagniuc (2):
  PCI/AER: Do not use APEI/HEST to disable AER services globally
  PCI/AER: Determine AER ownership based on _OSC instead of HEST

 drivers/acpi/pci_root.c  |  9 +----
 drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
 include/linux/pci-acpi.h |  6 ---
 3 files changed, 5 insertions(+), 92 deletions(-)

-- 
2.19.2
