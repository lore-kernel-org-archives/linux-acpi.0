From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH RESEND v1 0/3] PCI: ACPI: Implement support for _HPX Type 3 tables
Date: Thu,  7 Mar 2019 15:38:24 -0600
Message-ID: <20190307213834.5914-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Every decade or so, give or take a decade, our ACPI overlords realize
that the table they so generously gifted us is not really that useful.
Not to be outdone, they make a betterer version of it, which seems
like a good idea at the time. This is the story of the _HPX3 (well,
most of ACPI really).

Previous _HPX versions had a fixed number of fields, and could only
describe a very narrow set of useless register settings. _HPX3 extends
that to an arbitrary number of entries, that can cover the entire PCI
config space, and will be The Last _HPX Table Ever (TM). For the
sadomasochistic, the new ACPI 6.3 spec is here [1].

For our purposes, we had to re-organize code a bit, and the first two
patches in the series do this, albeit with minimal noise.
The last patch is the actual HPX3 stuff. In case you wonder why the
ACPI enums don't match the PCI device types... nobody really thought
of it or caught it at the spec writing stage.

In _HPX3 there's also the notion of vendor-specific extensions, and
VSEC/DVSEC. They are not implemented here because there's no hardware
to test that code path.

[1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

RESEND because the first time 'git send-email' experienced an ID:10T error
originating between my keyboard and my chair. As a result of that error, it
did not send the cover letter to public mailing lists.

Alexandru Gagniuc (3):
  PCI / ACPI: Do not export pci_get_hp_params()
  PCI / ACPI: Remove the need for 'struct hotplug_params'
  PCI / ACPI: Implement Type 3 _HPX record

 drivers/pci/pci-acpi.c      | 172 +++++++++++++++++++++++++-----------
 drivers/pci/probe.c         | 130 ++++++++++++++++++++++++---
 include/linux/pci_hotplug.h |  74 +++++++++++++---
 3 files changed, 305 insertions(+), 71 deletions(-)

-- 
2.19.2
