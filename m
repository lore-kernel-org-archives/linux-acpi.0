From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/3] Rename acpi_dev_present()
Date: Thu, 24 Mar 2016 13:15:20 +0100
Message-ID: <cover.1458813034.git.lukas@wunner.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

all users of acpi_dev_present() that I'm aware of have landed in
Linus' tree, so as discussed I'm sending you herewith a patch which
renames acpi_dev_present() to acpi_dev_found(), plus two patches for
drivers/platform/x86 which replace legacy code with acpi_dev_found().
Both were previously acked by Darren:
http://www.spinics.net/lists/linux-acpi/msg61872.html
http://www.spinics.net/lists/linux-acpi/msg61873.html

Best regards,

Lukas


Lukas Wunner (3):
  ACPI / utils: Rename acpi_dev_present()
  eeepc-wmi: Use acpi_dev_found()
  acer-wmi: Use acpi_dev_found()

 drivers/acpi/utils.c                         |  6 +++---
 drivers/platform/x86/acer-wmi.c              | 16 ++++------------
 drivers/platform/x86/eeepc-wmi.c             | 24 ++----------------------
 include/acpi/acpi_bus.h                      |  2 +-
 include/linux/apple-gmux.h                   |  2 +-
 sound/pci/hda/thinkpad_helper.c              |  2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c      |  2 +-
 8 files changed, 14 insertions(+), 42 deletions(-)

-- 
2.8.0.rc3
