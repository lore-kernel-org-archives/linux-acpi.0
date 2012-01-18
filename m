From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3 0/4] toshiba_acpi: Expanded hotkey support
Date: Wed, 18 Jan 2012 13:44:07 -0600
Message-ID: <1326915852-19896-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Azael Avalos <coproscefalo@gmail.com>, Thomas Renninger <trenn@suse.de>, Seth Forshee <seth.forshee@canonical.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Here's another round of the patches for expanded hotkey support for
Toshibas addressing the problems raised in the last round. Changes since
v2:

 * Use WMI GUID instead of DMI data to identify models with buggy INFO
   implementations
 * Add comment in makefile regarding link order requirement necessary
   for the above

Thanks,
Seth


Azael Avalos (1):
  toshiba_acpi: Support additional hotkey scancodes

Seth Forshee (3):
  ACPI: EC: Add ec_get_handle()
  toshiba_acpi: Support alternate hotkey interfaces
  toshiba_acpi: Refuse to load on machines with buggy INFO
    implementations

 drivers/acpi/ec.c                   |   10 ++
 drivers/platform/x86/Kconfig        |    1 +
 drivers/platform/x86/Makefile       |    4 +
 drivers/platform/x86/toshiba_acpi.c |  246 +++++++++++++++++++++++++++++-----
 include/linux/acpi.h                |    1 +
 5 files changed, 225 insertions(+), 37 deletions(-)
