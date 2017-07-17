From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 0/3] enable ghes_edac on selected platforms
Date: Mon, 17 Jul 2017 15:59:09 -0600
Message-ID: <20170717215912.26070-1-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:44316 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdGQWI1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2017 18:08:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

The ghes_edac driver was introduced in 2013 [1], but it has not been
enabled by any distro yet.  This is because the driver obtains error
info from firmware interfaces, which are not properly implemented on
many platforms.

To get out from this situation, add a platform check to selectively
enable the driver on the platforms that are known to have proper
firmware implementation.  Platform vendors can add their platforms to
the list when they support ghes_edac.

Patch 1 moves the platform check in acpi_blacklisted() to a common
utility func, acpi_match_oemlist().
Patch 2 converts the intel_pstate driver to use acpi_match_oemlist().
Patch 3 introduces a platform check to the ghes_edac driver.

---
Toshi Kani (3):
 1/3 ACPI / blacklist: add acpi_match_oemlist() interface
 2/3 intel_pstate: convert to use acpi_match_oemlist()
 3/3 ghes_edac: add platform check to enable ghes_edac

---
 drivers/acpi/blacklist.c       | 84 ++++++++----------------------------------
 drivers/acpi/utils.c           | 40 ++++++++++++++++++++
 drivers/cpufreq/intel_pstate.c | 64 +++++++++++++-------------------
 drivers/edac/ghes_edac.c       | 28 +++++++++++---
 include/linux/acpi.h           | 19 ++++++++++
 5 files changed, 122 insertions(+), 113 deletions(-)

