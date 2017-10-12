From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework fixes for v4.14-rc5
Date: Fri, 13 Oct 2017 01:03:48 +0200
Message-ID: <CAJZ5v0iOmf2CAo-i6echk3pBkFh2XzEDnVT5YAdfnr7_tHOi+w@mail.gmail.com>
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
 devprop-4.14-rc5

with top-most commit 51858a2777f025333c5ac3b3484263bba56461b3

 ACPI: properties: Fix __acpi_node_get_property_reference() return codes

on top of commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f

 Linux 4.14-rc4

to receive device properties framework fixes for v4.14-rc5.

These fix an issue related to device removal introduced during the
4.9 cycle and fix up new functionality added recently.

Specifics:

 - Fix a device properties management issue, introduced during the
   4.9 cycle, that causes device properties associated with a
   parent device to go away on a removal of its child in some
   cases (Jarkko Nikula).

 - Fix inconsistencies in error codes returned by a new function
   helper in the device properties framework depending on the
   underlying low-level firmware interface, DT or ACPI, by making the
   meaning of error codes returned in the ACPI case agree with the
   meaning of DT error codes in analogous situations (Sakari Ailus).

Thanks!


---------------

Jarkko Nikula (1):
      device property: Track owner device of device property

Sakari Ailus (2):
      ACPI: properties: Align return codes of
__acpi_node_get_property_reference()
      ACPI: properties: Fix __acpi_node_get_property_reference() return codes

---------------

 drivers/acpi/property.c | 29 +++++++++++++++--------------
 drivers/base/property.c | 19 +++++++++++++------
 2 files changed, 28 insertions(+), 20 deletions(-)
