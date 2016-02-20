From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/2] nfit, libnvdimm: ars fixups for acpi6.1 compatibility
Date: Sat, 20 Feb 2016 14:46:37 -0800
Message-ID: <20160220224637.20667.84618.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20567 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756950AbcBTWrC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Feb 2016 17:47:02 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Linda Knippers <linda.knippers@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org

The address range scrub format is formalized in acpi6.1 and the existing
Linux implementation needs to be updated accordingly.  In the course of
testing this update a bug in how Linux handles the buffer size for
ars_status commands was discovered/fixed.

---

Dan Williams (2):
      libnvdimm, tools/testing/nvdimm: fix 'ars_status' output buffer sizing
      nfit: update address range scrub commands to the acpi 6.1 format


 drivers/acpi/nfit.c              |    6 +++---
 drivers/nvdimm/bus.c             |   20 ++++++++++----------
 include/linux/libnvdimm.h        |    3 +--
 include/uapi/linux/ndctl.h       |   11 +++++++++--
 tools/testing/nvdimm/test/nfit.c |    8 ++++++--
 5 files changed, 29 insertions(+), 19 deletions(-)
