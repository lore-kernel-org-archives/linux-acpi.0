From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/4] x86: pmc_atom: Add Cherrytrail support
Date: Tue, 20 Jan 2015 23:49:59 +0200
Message-ID: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is the reworked patch series which had been sent earlier [1] to support
Intel CherryTrail SoC.

The patches were tested on both BayTrail and CherryTrail SoCs.

[1] https://patchwork.kernel.org/patch/5235891/

Changes to v1:
 - rebased on top of recent pmc_atom changes
 - cleaned up, reqorked and split to few smaller patches

Andy Shevchenko (4):
  x86: pmc_atom: save struct device pointer in pmc
  x86: pmc_atom: print index of device in loop
  x86: pmc_atom: supply register mappings via pmc object
  PMC driver: Add Cherrytrail PMC interface

 arch/x86/include/asm/pmc_atom.h |  25 ++++
 arch/x86/kernel/pmc_atom.c      | 270 +++++++++++++++++++++++++---------------
 2 files changed, 198 insertions(+), 97 deletions(-)

-- 
2.1.4
