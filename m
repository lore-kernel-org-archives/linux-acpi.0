From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI / PCI: Post-merge fixes
Date: Sun, 16 Jan 2011 20:41:02 +0100
Message-ID: <201101162041.02419.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andres Salomon <dilinger@queued.net>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Jesse, Len,

The following two patches fix issues introduced by the last PCI merge.
The both of them have been tested by the respective reporters.  Please push
them to Linus or let me know if I should push.

[1/2] - Fix build problem in the PCIe AER driver for !CONFIG_ACPI

[2/2] - Fix boot crash on XO-1 related to APEI

Thanks,
Rafael
