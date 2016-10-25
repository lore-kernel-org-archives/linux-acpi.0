From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 0/6] ACPICA: Interpreter: Improve lock order fixes
Date: Tue, 25 Oct 2016 13:20:50 +0800
Message-ID: <cover.1477372449.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patchset improves ACPICA intepreter lock order fixes. Including
several urgent regression fixes [PATCH 0-3].

Patches tested with customized ACPI table where _PS0/_PS3 methods are
customized to invoke a serialized control method which creates named
objects. When pm_async=yes, AE_ALREADY_EXISTS can be seen in suspend/resume
process. This is an existing issue, triggered in 4.9-rc1 by ACPICA
interpreter lock order fixes, and can be fixed by [PATCH 1] in this series.

Lv Zheng (6):
  ACPICA: Dispatcher: Fix order issue of method termination
  ACPICA: Dispatcher: Fix an unbalanced lock exit path in
    acpi_ds_auto_serialize_method()
  ACPICA: Dispatcher: Tune interpreter lock around
    acpi_ev_initialize_region()
  ACPICA: Events: Cleanup acpi_ev_initialize_region()
  ACPICA: Tables: Cleanup acpi_tb_install_and_load_table()
  ACPICA: Tables: Add acpi_tb_unload_table()

 drivers/acpi/acpica/acevents.h |  4 +--
 drivers/acpi/acpica/actables.h |  5 +--
 drivers/acpi/acpica/dsinit.c   | 11 ++----
 drivers/acpi/acpica/dsmethod.c | 50 ++++++++++++--------------
 drivers/acpi/acpica/dsopcode.c |  2 +-
 drivers/acpi/acpica/dswload2.c | 15 +-------
 drivers/acpi/acpica/evrgnini.c | 62 ++++++++++++++------------------
 drivers/acpi/acpica/exconfig.c | 42 +++-------------------
 drivers/acpi/acpica/nsload.c   |  2 ++
 drivers/acpi/acpica/tbdata.c   | 81 ++++++++++++++++++++++++------------------
 drivers/acpi/acpica/tbxfload.c | 38 +++-----------------
 11 files changed, 115 insertions(+), 197 deletions(-)

-- 
2.7.4
