From: Corentin Chary <corentin.chary@gmail.com>
Subject: [PATCH 0/3] platform-x86 updates for next 3.6 rc
Date: Mon, 20 Aug 2012 23:01:49 +0200
Message-ID: <1345496512-11780-1-git-send-email-corentin.chary@gmail.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi Matthew,

Some patches for platform x86 drivers that should be merged ASAP.
The CONFIG_ACPI_VIDEO patch is especially important since new demote/promote
mechanism is currently broken when ACPI_VIDEO=m

Thanks,

Corentin Chary (2):
  drivers-platform-x86: remove useless #ifdef CONFIG_ACPI_VIDEO
  asus-laptop: HRWS/HWRS typo

Maxim Nikulin (1):
  platform/x86: fix asus_laptop.wled_type description

 drivers/platform/x86/acer-wmi.c       |    2 --
 drivers/platform/x86/apple-gmux.c     |    4 ----
 drivers/platform/x86/asus-laptop.c    |   10 +++++-----
 drivers/platform/x86/asus-wmi.c       |    4 ----
 drivers/platform/x86/samsung-laptop.c |    4 ----
 5 files changed, 5 insertions(+), 19 deletions(-)

-- 
1.7.9.5
