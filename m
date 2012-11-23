From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 0/3] Add SDHCI ACPI driver
Date: Fri, 23 Nov 2012 13:35:58 +0200
Message-ID: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, mika.westerberg@linux.intel.com, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi

Here is SDHCI ACPI driver.

Changes for v2:

	Dropped "PNPACPI: exclude SDHCI devices"
	Added "PNPACPI: exclude devices already bound"
	Changed dev->acpi_handle to ACPI_HANDLE(dev)
	Added Chris' Ack for sdhci-acpi


Adrian Hunter (2):
      ACPI: add SDHCI to ACPI platform devices
      mmc: sdhci-acpi: add SDHCI ACPI driver

Mika Westerberg (1):
      PNPACPI: exclude devices already bound

 drivers/acpi/scan.c           |   2 +
 drivers/mmc/host/Kconfig      |  12 ++
 drivers/mmc/host/Makefile     |   1 +
 drivers/mmc/host/sdhci-acpi.c | 304 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpacpi/core.c    |   4 +
 5 files changed, 323 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-acpi.c


Regards
Adrian Hunter
