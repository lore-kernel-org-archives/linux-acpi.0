From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] ACPI / ACPICA: Avoid executing _PRW twice for all devices
Date: Mon, 5 Jul 2010 00:56:22 +0200
Message-ID: <201007050056.22705.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50849 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab0GDXDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Jul 2010 19:03:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>, Linux PM <linux-pm@lists.linux-foundation.org>

Hi,

Following our recent IRC discussion I thought I'd bite the bullet and prepare
a patch to remove the execution of _PRW from ACPICA and there it goes.

The series is on top of the patch I sent a couple of days ago:
https://patchwork.kernel.org/patch/110076/

[1/3] - Drops the code to walk the namespace in search of _PRW and adds
        acpi_gpe_can_wake() so that the host OS can disable wakeup GPEs
        previously enabled unconditionally by the ACPICA initialization code.
        This basically reproduces the current behavior except that the GPEs
        are temporarily enabled before acpi_bus_extract_wakeup_device_power_package()
        runs for all devices with _PRW referring to them.

[2/3] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
        cosmetic thing, but worth doing IMO.

[3/3] - Changes acpi_gpe_wakeup() to return error code for the GPEs whose
        ACPI_GPE_CAN_WAKE flags are not set.

Please apply.

Rafael

