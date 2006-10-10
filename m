From: akpm@osdl.org
Subject: [patch 09/12] Fix incorrect handling PCI-Express Root Bridge _HID
Date: Tue, 10 Oct 2006 14:20:40 -0700
Message-ID: <200610102120.k9ALKeBx024290@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:18082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030543AbWJJVuq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:50:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, eiichiro.oiwa.nm@hitachi.com

From: <eiichiro.oiwa.nm@hitachi.com>

Lifted from http://bugzilla.kernel.org/show_bug.cgi?id=7145

PCI Bus Topology:

[CPU] [CPU]        [CPU]  [CPU]
  |      |BUS        |     |   BUS
--+--+---+---      --+--+--+------
     |                  |
 [Root Bridge]*1-----[Root Bridge]*1
     |      |           \        \
 [Bridge]   |        [PCI-e slot] [PCI-e slot]
    | |    [PCI-e slot]
    | \
    | [PCI-e slot]
    |
    |
 [PCI Bridge]
    |     \
    |      [PCI-X slot]
    |
 [PCI-X slot]

*1: PCI Express Root Bridge.

I could not get correct PCI Express BUS number from the structure of
acpi_object_extra.  I always get zero as BUS number regardless of BUS
location.  I found that there is incorrect comparison with _HID (PNP0A08)
in acpi/events/evrgnini.c and PCI Express _BBN method always fail. 
Therefore, we get always get zero as PCI Express bus number.

I suggest the following patch.

Cc: "Brown, Len" <len.brown@intel.com>
Cc: <linux-acpi@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/events/evrgnini.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/events/evrgnini.c~fix-incorrect-handling-of-pci-express-root-bridge-_hid drivers/acpi/events/evrgnini.c
--- a/drivers/acpi/events/evrgnini.c~fix-incorrect-handling-of-pci-express-root-bridge-_hid
+++ a/drivers/acpi/events/evrgnini.c
@@ -225,12 +225,12 @@ acpi_ev_pci_config_region_setup(acpi_han
 				if (!
 				    (ACPI_STRNCMP
 				     (object_hID.value, PCI_ROOT_HID_STRING,
-				      sizeof(PCI_ROOT_HID_STRING))
+				      sizeof(PCI_ROOT_HID_STRING)))
 				     ||
 				     !(ACPI_STRNCMP
 				       (object_hID.value,
 					PCI_EXPRESS_ROOT_HID_STRING,
-					sizeof(PCI_EXPRESS_ROOT_HID_STRING)))))
+					sizeof(PCI_EXPRESS_ROOT_HID_STRING))))
 				{
 
 					/* Install a handler for this PCI root bridge */
_
