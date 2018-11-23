From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.20-rc4
Date: Fri, 23 Nov 2018 11:12:02 +0100
Message-ID: <CAJZ5v0i5P6fEocXaOTRjBEW=NM5zYeHxrOB-KzxPpEXTq75esg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.20-rc4

with top-most commit 2bbb5fa37475d7aa5fa62f34db1623f3da2dfdfa

 ACPI / platform: Add SMB0001 HID to forbidden_id_list

on top of commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6

 Linux 4.20-rc3

to receive an ACPI fix for 4.20-rc4.

This prevents the ACPI core from registering a platform device for
the SMB0001 HID to avoid IRQ allocation issues (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPI / platform: Add SMB0001 HID to forbidden_id_list

---------------

 drivers/acpi/acpi_platform.c | 1 +
 1 file changed, 1 insertion(+)
