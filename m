From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v4 0/5] enable ghes_edac on selected platforms
Date: Wed, 23 Aug 2017 16:54:42 -0600
Message-ID: <20170823225447.15608-1-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:56600 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdHWXEo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Aug 2017 19:04:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

The ghes_edac driver was introduced in 2013 [1], but it has not been
enabled by any distro yet.  This is because the driver obtains error
info from firmware interfaces, which are not properly implemented on
many platforms.

To get out from this situation, add a platform check to selectively
enable the driver on the platforms that are known to have proper
firmware implementation.  Platform vendors can add their platforms to
the list when they support ghes_edac.

Patch 1-2 introduces a common function for platform check.
Patch 3 introduces platform check to ghes_edac.
Patch 4-5 optimizes regular edac driver's init code when ghes_edac is used.

Patch-set is based on bp.git ghes branch.

v4:
 - Increase the size of oem_id[] and oem_table_id[] by 1 (patch 1)
 - Change code style to a single line (patch 1)
 - Rebase to top of bp.git ghes branch.

v3:
 - Change struct & func names to "platform" from "oem" (patch 1)
 - Drop a patch that checks OSC APEI bit (remove v2 patch 3)
 - Drop a patch that avoids multiple calls to dmi_walk() (remove v2 patch 4)
 - Change parameter name to ghes_edac.force_load (patch 3)
 - Change function to edac_get_owner() (patch 4)
 - Change edac_mc_owner to const char * (patch 4)
 - Change to call edac_get_owner() at the beginning (patch 5)
 - Remove ".c" from mod_name (patch 5)

v2:
 - Address review comments (patch 1)
 - Add OSC APEI check (patch 3)
 - Avoid multiple dmi_walk (patch 4)
 - Add EDAC MC owner check (patch 6,7)

---
Toshi Kani (5):
 1/5 ACPI / blacklist: add acpi_match_platform_list()
 2/5 intel_pstate: convert to use acpi_match_platform_list()
 3/5 ghes_edac: add platform check to enable ghes_edac
 4/5 EDAC: add edac_get_owner() to check MC owner
 5/5 edac drivers: add MC owner check in init

---
 drivers/acpi/blacklist.c       | 83 +++++++-----------------------------------
 drivers/acpi/utils.c           | 36 ++++++++++++++++++
 drivers/cpufreq/intel_pstate.c | 64 +++++++++++++-------------------
 drivers/edac/amd64_edac.c      |  5 +++
 drivers/edac/edac_mc.c         |  7 +++-
 drivers/edac/edac_mc.h         |  8 ++++
 drivers/edac/ghes_edac.c       | 29 ++++++++++++---
 drivers/edac/pnd2_edac.c       |  9 ++++-
 drivers/edac/sb_edac.c         |  9 ++++-
 drivers/edac/skx_edac.c        |  9 ++++-
 include/linux/acpi.h           | 19 ++++++++++
 11 files changed, 160 insertions(+), 118 deletions(-)
