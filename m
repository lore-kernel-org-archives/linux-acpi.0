From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI-related Kconfig fixes for v5.0-rc5
Date: Fri, 1 Feb 2019 11:38:43 +0100
Message-ID: <CAJZ5v0hCRCMfJS4nXKnLrGJpEf3Jp6tLwkAeqtTOFOFNk4ckjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.0-rc5

with top-most commit b473406a06c49d39d6d653e9981b0bd70300485d

 Merge branch 'acpi-misc'

on top of commit f17b5f06cb92ef2250513a1e154c47b78df07d40

 Linux 5.0-rc4

to receive ACPI-related Kconfig fixes for 5.0-rc5.

These prevent invalid configurations from being created (e.g. by
randconfig) due to some ACPI-related Kconfig options' dependencies
that are not specified directly (Sinan Kaya).

Thanks!


---------------

Sinan Kaya (3):
      mfd: Fix unmet dependency warning for MFD_TPS68470
      platform/x86: Fix unmet dependency warning for ACPI_CMPC
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

---------------

 drivers/mfd/Kconfig          | 2 +-
 drivers/platform/x86/Kconfig | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
