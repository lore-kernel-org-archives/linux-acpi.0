From: Linda Knippers <linda.knippers@hpe.com>
Subject: [PATCH 0/3] fix NVDIMM hotplug changes
Date: Fri, 20 Nov 2015 19:05:46 -0500
Message-ID: <cover.1448045168.git.linda.knippers@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4620.austin.hp.com ([15.73.212.81]:45993 "EHLO
	g2t4620.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759822AbbKUAGL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2015 19:06:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, toshi.kani@hpe.com, elliott@hpe.com, rafael.j.wysocki@intel.com

Since commit 209851649dc4f7900a6bfe1de5e2640ab2c7d931 
("acpi: nfit: Add support for hot-add"), we no longer see 
NVDIMM devices on our NVDIMM-N systems.  The NFIT/_FIT processing 
at initialization gets a table from _FIT but thinks it is 
malformed and exits, leaving us with no NFIT at all.

This series fixes the problem caused by a difference in ACPI
spec interpretation regarding the layout of the _FIT vs. NFIT
tables.  In addition to changing the code, we are proposing
wording changes to the ACPI spec.

While testing the notify code path, I discovered that the 
way the old and new tables were compared didn't take into account
that there is some variation in table length.  I also determined
that the check for whether the NFIT merge was successful was
backwards.

I couldn't find a generic way to invoke the notify function
so my testing was done with a change to the the revision_show()
function that calls acpi_nfit_notify() any time the sysfs
nfit/revision file is read.  That change is not included here.

These patches were tested on a system with NVDIMM-N hardware
so changes related to NFIT tables not provided on a NVDIMM-N
system have only been compile-tested.  

Linda Knippers (3):
  nfit: Account for table size length variation
  nfit: Fix the check for a successful NFIT merge
  nfit: Adjust for different _FIT and NFIT headers

 drivers/acpi/nfit.c | 83 +++++++++++++++++++++++++++++++++++++++++------------
 drivers/acpi/nfit.h |  3 +-
 2 files changed, 67 insertions(+), 19 deletions(-)

-- 
1.8.3.1

