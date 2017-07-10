From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v4.13-rc1
Date: Tue, 11 Jul 2017 00:01:36 +0200
Message-ID: <CAJZ5v0jPqdzMfpuOPWUfrnpbbzbeNg59F8xHh5rBkM+T8e09nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34232 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754106AbdGJWBi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jul 2017 18:01:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-extra-4.13-rc1

with top-most commit f19e80b394808ed763e2669b08aea480adcc46be

 Merge branches 'acpi-spcr', 'acpi-osi', 'acpi-bus', 'acpi-scan' and 'acpi-misc'

on top of commit eceeae414edccb07fad683011c0c65abe8a3a554

 Merge tag 'acpi-4.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for v4.13-rc1.

These fix the ACPI SPCR table handling and add a workaround for
APM X-Gene 8250 UART on top of that, fix two ACPI hotplug issues
related to hot-remove failures, add a missing "static" to one
function and constify some attribute_group structures.

Specifics:

 - Fix the ACPI code handling the SPCR table to check access
   width of MMIO regions and add a workaround for APM X-Gene
   8250 UART to use 32-bit MMIO accesses with its register
   (Loc Ho).

 - Fix two ACPI-based hotplug issues related to the handling of
   hot-remove failures on the OS side (Chun-Yi Lee).

 - Constify attribute_group structures in a few places (Arvind Yadav).

 - Make one local function static (Colin Ian King).

Thanks!


---------------

Arvind Yadav (4):
      ACPI / power: constify attribute_group structures
      ACPI: BGRT: constify attribute_group structures
      ACPI / LPSS: constify attribute_group structures
      ACPI / DPTF: constify attribute_group structures

Colin Ian King (1):
      ACPI / osi: Make local function acpi_osi_dmi_linux() static

Lee, Chun-Yi (2):
      ACPI / bus: handle ACPI hotplug schedule errors completely
      ACPI / scan: Indicate to platform when hot remove returns busy

Loc Ho (2):
      ACPI: SPCR: Use access width to determine mmio usage
      ACPI: SPCR: Workaround for APM X-Gene 8250 UART 32-alignment errata

---------------

 drivers/acpi/acpi_lpss.c       |  2 +-
 drivers/acpi/bgrt.c            |  2 +-
 drivers/acpi/bus.c             |  8 ++++++--
 drivers/acpi/dptf/dptf_power.c |  2 +-
 drivers/acpi/osi.c             |  3 ++-
 drivers/acpi/power.c           | 10 +++++-----
 drivers/acpi/scan.c            | 18 +++++++++++++-----
 drivers/acpi/spcr.c            | 40 ++++++++++++++++++++++++++++++++++++++--
 include/acpi/acrestyp.h        |  7 +++++++
 9 files changed, 74 insertions(+), 18 deletions(-)
