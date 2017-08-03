From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2 0/7] enable ghes_edac on selected platforms
Date: Thu,  3 Aug 2017 15:57:46 -0600
Message-ID: <20170803215753.30553-1-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:48116 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdHCWH0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 18:07:26 -0400
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
Patch 3 improves GHES check for ghes_edac.
Patch 4 optimizes ghes_edac init code.
Patch 5 introduces platform check to ghes_edac.
Patch 6-7 optimizes regular edac driver's init code when ghes_edac is used.

v2:
 - Address review comments (patch 1).
 - Add OSC APEI check (patch 3).
 - Avoid multiple dmi_walk (patch 4).
 - Add EDAC MC owner check (patch 6,7)

---
Toshi Kani (7):
 1/7 ACPI / blacklist: add acpi_match_oemlist() interface
 2/7 intel_pstate: convert to use acpi_match_oemlist()
 3/7 ACPI / APEI: add OSC APEI bit check for ghes_edac
 4/7 ghes_edac: avoid multiple calls to dmi_walk()
 5/7 ghes_edac: add platform check to enable ghes_edac
 6/7 EDAC: add edac_check_mc_owner() to check MC owner
 7/7 edac drivers: add MC owner check in init

---
 drivers/acpi/apei/ghes.c       |  8 ++--
 drivers/acpi/blacklist.c       | 83 +++++++-----------------------------------
 drivers/acpi/utils.c           | 40 ++++++++++++++++++++
 drivers/cpufreq/intel_pstate.c | 64 +++++++++++++-------------------
 drivers/edac/amd64_edac.c      |  3 ++
 drivers/edac/edac_mc.c         | 15 +++++++-
 drivers/edac/edac_mc.h         | 12 ++++++
 drivers/edac/ghes_edac.c       | 36 ++++++++++++++----
 drivers/edac/pnd2_edac.c       |  7 +++-
 drivers/edac/sb_edac.c         |  7 +++-
 drivers/edac/skx_edac.c        |  6 ++-
 include/linux/acpi.h           | 19 ++++++++++
 12 files changed, 176 insertions(+), 124 deletions(-)

