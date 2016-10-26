From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH v2 0/3] ACPICA: Interpreter: Fix regressions in lock order improvement
Date: Wed, 26 Oct 2016 15:39:55 +0800
Message-ID: <cover.1477465173.git.lv.zheng@intel.com>
References: <cover.1477372449.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36751 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753880AbcJZHkJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2016 03:40:09 -0400
In-Reply-To: <cover.1477372449.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patchset fixes regressions in ACPICA intepreter lock order
improvement.

Patches tested with customized ACPI table where _PS0/_PS3 methods are
customized to invoke a serialized control method which creates named
objects. When pm_async=yes, AE_ALREADY_EXISTS can be seen in suspend/resume
process. This is an existing issue, triggered in 4.9-rc1 by ACPICA
interpreter lock order fixes, and can be fixed by [PATCH 1] in this series.

v2:
1. Remove non-regression-fixes.
2. Add "Fixes" tags.

Lv Zheng (3):
  ACPICA: Dispatcher: Fix order issue of method termination
  ACPICA: Dispatcher: Fix an unbalanced lock exit path in
    acpi_ds_auto_serialize_method()
  ACPICA: Dispatcher: Tune interpreter lock around
    acpi_ev_initialize_region()

 drivers/acpi/acpica/dsinit.c   | 11 +++-------
 drivers/acpi/acpica/dsmethod.c | 50 +++++++++++++++++++-----------------------
 drivers/acpi/acpica/dswload2.c |  2 --
 drivers/acpi/acpica/evrgnini.c |  3 +++
 drivers/acpi/acpica/nsload.c   |  2 ++
 5 files changed, 30 insertions(+), 38 deletions(-)

-- 
2.7.4

