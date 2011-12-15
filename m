From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 0/4] toshiba_acpi: Expanded hotkey support
Date: Thu, 15 Dec 2011 12:06:07 -0600
Message-ID: <1323972371-13189-1-git-send-email-seth.forshee@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Azael Avalos <coproscefalo@gmail.com>, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>
List-Id: linux-acpi@vger.kernel.org

Hi Matthew,

The following patches expand toshiba_acpi's hotkey support to include
many additional models. Here's the high-level summary:

 * Add support for reading scancodes using the INFO method when
   avaialable and for generating hotkey notifications by filtering Fn
   key presses from the keyboard
 * Adds a new EC interface allowing toshiba_acpi to get a handle to the
   EC, which is needed because the NTFY method used to generate the
   hotkey notifications is in the EC namespace
 * Support some additional hotkey scancodes
 * Blacklist hotkey support for the Satellite C670-10V due to a buggy
   implementation of the INFO method on this model

More details can be found in the individual patch descriptions.

Cc-ing the ACPI folks on the full series to provide context regarding
how toshiba_acpi will use the new EC interface.

Thanks,
Seth


Azael Avalos (1):
  toshiba_acpi: Support additional hotkey scancodes

Seth Forshee (3):
  ACPI: EC: Add ec_get_handle()
  toshiba_acpi: Support alternate hotkey interfaces
  toshiba_acpi: Add blacklist for devices with hotkey problems

 drivers/acpi/ec.c                   |   10 ++
 drivers/platform/x86/toshiba_acpi.c |  254 ++++++++++++++++++++++++++++++-----
 include/linux/acpi.h                |    1 +
 3 files changed, 228 insertions(+), 37 deletions(-)
