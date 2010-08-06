From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/10] PCI / Hot-plug: Query _OSC before requesting controls
Date: Fri, 6 Aug 2010 03:11:33 +0200
Message-ID: <201008060311.33359.rjw@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43668 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934289Ab0HFBRp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Aug 2010 21:17:45 -0400
In-Reply-To: <201008060303.51224.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org

From: Rafael J. Wysocki <rjw@sisk.pl>

It generally is unsafe to call acpi_pci_osc_control_set() without
checking what _OSC bits the BIOS is willing to grant control of,
because control of some _OSC bits may be granted even if
acpi_pci_osc_control_set() returns AE_SUPPORT.  Therefore make
acpi_get_hp_hw_control_from_firmware() use
acpi_pci_osc_control_query() to check if the BIOS will grant
OSC_SHPC_NATIVE_HP_CONTROL before calling acpi_pci_osc_control_set().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/hotplug/acpi_pcihp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/acpi_pcihp.c
+++ linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
@@ -358,11 +358,13 @@ int acpi_get_hp_hw_control_from_firmware
 		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
 		dbg("Trying to get hotplug control for %s\n",
 				(char *)string.pointer);
+		status = acpi_pci_osc_control_query(handle, &flags);
+		if (ACPI_FAILURE(status)
+		    || !(flags & OSC_SHPC_NATIVE_HP_CONTROL))
+			goto no_control;
 		status = acpi_pci_osc_control_set(handle, flags);
 		if (ACPI_SUCCESS(status))
 			goto got_one;
-		if (status == AE_SUPPORT)
-			goto no_control;
 		kfree(string.pointer);
 		string = (struct acpi_buffer){ ACPI_ALLOCATE_BUFFER, NULL };
 	}

