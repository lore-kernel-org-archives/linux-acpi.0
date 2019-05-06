From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework updates for v5.2-rc1
Date: Mon, 6 May 2019 13:16:02 +0200
Message-ID: <CAJZ5v0jx12=bmcDaVkgd1=mocwPQ2MwMNHOE6KiTSyS+CdhRyQ@mail.gmail.com>
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
 devprop-5.2-rc1

with top-most commit 23583f7795025e3c783b680d906509366b0906ad

 ACPI / property: fix handling of data_nodes in acpi_get_next_subnode()

on top of commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2

 Linux 5.1-rc5

to receive device properties framework updates for 5.2-rc1.

These fix the handling of data nodes in the ACPI properties support
code, add a new helper for endpoint lookup in property graphs and
restore a comment inadvertently removed by one of previous changes.

Specifics:

 - Fix the handling of data nodes in the ACPI properties support
   code for devices with child devices and hierarchical _DSD
   properties (Pierre-Louis Bossart).

 - Add fwnode_graph_get_endpoint_by_id() helper for endpoint lookup
   in device property graphs (Sakari Ailus).

 - Restore the _DSD data subnodes GUID comment inadvertently removed
   by one of previous changes (Shunyong Yang).

Thanks!


---------------

Pierre-Louis Bossart (1):
      ACPI / property: fix handling of data_nodes in acpi_get_next_subnode()

Sakari Ailus (1):
      device property: Add fwnode_graph_get_endpoint_by_id()

Shunyong Yang (1):
      ACPI: property: restore _DSD data subnodes GUID comment

---------------

 drivers/acpi/property.c  |  9 ++++++
 drivers/base/property.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h | 18 ++++++++++++
 3 files changed, 102 insertions(+)
