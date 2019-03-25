From: helgaas@kernel.org
Subject: [PATCH 0/4] ACPI: Trivial cleanups
Date: Mon, 25 Mar 2019 13:33:59 -0500
Message-ID: <20190325183403.251473-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up whitespace, fix some typos, add a couple comments, simplify the
acpi_bus_extract_wakeup_device_power_package() internal interface slightly.

Bjorn Helgaas (4):
  ACPI: Fix comment typos
  ACPI / tables: Cleanup whitespace
  ACPI / scan: Simplify acpi_bus_extract_wakeup_device_power_package()
  ACPI / scan: Add labels for PNP button devices

 drivers/acpi/acpi_dbg.c     |  2 +-
 drivers/acpi/acpi_lpat.c    |  2 +-
 drivers/acpi/cppc_acpi.c    | 34 +++++++++++++-------------
 drivers/acpi/power.c        |  4 ++--
 drivers/acpi/pptt.c         | 48 ++++++++++++++++++-------------------
 drivers/acpi/scan.c         | 19 +++++++--------
 drivers/acpi/spcr.c         |  2 +-
 drivers/acpi/tables.c       | 18 ++++----------
 drivers/acpi/video_detect.c |  2 +-
 9 files changed, 60 insertions(+), 71 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog
