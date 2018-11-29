From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.20-rc5
Date: Thu, 29 Nov 2018 21:53:03 +0100
Message-ID: <CAJZ5v0hn4+dHqFh0LnUzuU76+8py=fYh8ERg5V+XpZu1xbdb_g@mail.gmail.com>
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
 acpi-4.20-rc5

with top-most commit c4f784268210ae5e6749d4ba30d117bd301a70a6

 Merge branch 'acpica-fixes'

on top of commit 2bbb5fa37475d7aa5fa62f34db1623f3da2dfdfa

 ACPI / platform: Add SMB0001 HID to forbidden_id_list

to receive an ACPI fix for 4.20-rc5.

This fixes a recent regression in ACPICA releted to the Generic
Serial Bus protocol handling and causing it to read or write too
little or too much data in some cases, so incorrect data may be
written to hardware as a result (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPICA: Fix handling of buffer-size in acpi_ex_write_data_to_field()

---------------

 drivers/acpi/acpica/exserial.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)
