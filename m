From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v5 RESEND 0/5] ACPI: hotplug messages improvement
Date: Tue,  6 Nov 2012 08:02:05 -0700
Message-ID: <1352214130-12055-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:46195 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab2KFPKK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Nov 2012 10:10:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, joe@perches.com, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, vijaymohan.pandarathil@hp.com, imammedo@redhat.com, prarit@redhat.com, Toshi Kani <toshi.kani@hp.com>

This patchset improves logging messages for ACPI CPU, Memory, 
Container and Dock hotplug notify handlers.  The patchset 
introduces a set of new macro interfaces, acpi_pr_<level>(),
and uses them to update the notify handlers.  acpi_pr_<level>()
appends "ACPI" prefix and ACPI object path to the messages,
which has similar usage model as dev_<level>().  This improves
diagnosis of hotplug operations since an error message in 
a log file now identifies an object that caused an issue.

The patchset is based on the linux-next branch of linux-pm.git
tree.

v5:
 - Added update for ACPI Dock hotplug error messages.
 - Added error status / ID info to the messages where needed.

v4:
 - Changed to use dev_<level>() where it is appropriate.

v3:
 - Changed acpi_pr_debug() to NOP when !DEBUG and !DYNAMIC_DEBUG.
   DYNAMIC_DEBUG will be supported later when necessary.
 - Added const to a path variable in acpi_printk().
 - Added more descriptions to the change log of patch 1/4.

v2:
 - Set buffer.pointer to NULL in acpi_printk().
 - Added acpi_pr_debug().

---
Toshi Kani (5):
 ACPI: Add acpi_pr_<level>() interfaces
 ACPI: Update CPU hotplug error messages
 ACPI: Update Memory hotplug error messages
 ACPI: Update Container hotplug error messages
 ACPI: Update Dock hotplug error messages

---
 drivers/acpi/acpi_memhotplug.c  | 25 +++++++++++++------------
 drivers/acpi/container.c        | 10 ++--------
 drivers/acpi/dock.c             | 29 +++++++++++++----------------
 drivers/acpi/processor_driver.c | 38 +++++++++++++++++++++++---------------
 drivers/acpi/utils.c            | 34 ++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h         | 31 +++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 51 deletions(-)
