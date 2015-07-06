From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/5] x86: pmc_atom: Add Cherrytrail support
Date: Mon,  6 Jul 2015 17:28:59 +0300
Message-ID: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55064 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbbGFO3J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Jul 2015 10:29:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is the next generation of the patch series which had been sent earlier [1]
to support Intel CherryTrail SoC.

The patches were tested on both BayTrail and CherryTrail SoCs.

[1] http://www.spinics.net/lists/linux-acpi/msg55213.html

Changes to v2:
 - added patch 1 that replaces previous patch 1 and exports PMC accessors
 - amended subject line for patch 4
 - added patch 5 that moves the driver under arch/x86/platform/atom hood
 - rebased on top of recent linux-next

Changes to v1:
 - rebased on top of recent pmc_atom changes
 - cleaned up, reqorked and split to few smaller patches

Andy Shevchenko (5):
  x86: pmc_atom: export accessors to PMC registers
  x86: pmc_atom: print index of device in loop
  x86: pmc_atom: supply register mappings via pmc object
  x86: pmc_atom: Add Cherrytrail PMC interface
  x86: pmc_atom: place it under arch/x86/platform/atom

 arch/x86/include/asm/pmc_atom.h               |  29 +++
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/platform/atom/Makefile               |   3 +-
 arch/x86/{kernel => platform/atom}/pmc_atom.c | 302 +++++++++++++++++---------
 4 files changed, 229 insertions(+), 106 deletions(-)
 rename arch/x86/{kernel => platform/atom}/pmc_atom.c (53%)

-- 
2.1.4

