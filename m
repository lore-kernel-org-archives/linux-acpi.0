From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH 0/4] ACPI: hotplug messages improvement
Date: Wed, 18 Jul 2012 14:40:23 -0600
Message-ID: <1342644027-19559-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

This patchset improves logging messages for ACPI CPU, Memory, and
Container hotplug notify handlers.  The patchset introduces a set of
new macro interfaces, acpi_pr_<level>(), and updates the notify
handlers to use them.  acpi_pr_<level>() appends "ACPI" prefix and
ACPI object path to the messages.  This improves diagnostics in
hotplug operations since it identifies an object that caused an
issue in a log file.

---
This patchset applies on top of the patch below.

[PATCH] ACPI: Add ACPI CPU hot-remove support
http://marc.info/?l=linux-acpi&m=134098193327362&w=2

---
Toshi Kani (4):
 ACPI: Add acpi_pr_<level>() interfaces
 ACPI: Update CPU hotplug messages
 ACPI: Update Memory hotplug messages
 ACPI: Update Container hotplug messages

---
 drivers/acpi/acpi_memhotplug.c  |   24 ++++++++++++------------
 drivers/acpi/container.c        |    6 +++---
 drivers/acpi/processor_driver.c |   36 +++++++++++++++++++++---------------
 drivers/acpi/utils.c            |   32 ++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h         |   18 ++++++++++++++++++
 5 files changed, 86 insertions(+), 30 deletions(-)
