From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/7] ACPI/EC: Update revision due to full asynchrnous command support.
Date: Fri, 13 Jun 2014 14:51:47 +0800
Message-ID: <fbcdf79de5a2272e0fdc2d81d5f33a28123b03f3.1402641700.git.lv.zheng@intel.com>
References: <cover.1402641700.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1402641700.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The bug fixes and asynchronous improvements have been done to the EC driver
by the previous commits. This patch increases the revision 2.2 to indicate
the difference. The copyright/authorship notices are also updated.

Authorship of Alexey is updated according to the following diff block:
  - *  ec.c - ACPI Embedded Controller Driver (v2.0)
  + *  ec.c - ACPI Embedded Controller Driver (v2.1)
  - *  Copyright (C) 2006, 2007 Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
  + *  Copyright (C) 2006-2008 Alexey Starikovskiy <astarikovskiy@suse.de>
This change is made by the following commit:
  Commit: 7c6db4e050601f359081fde418ca6dc4fc2d0011
  Subject: ACPI: EC: do transaction from interrupt context

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f1fa899..7726adc 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1,11 +1,14 @@
 /*
- *  ec.c - ACPI Embedded Controller Driver (v2.1)
+ *  ec.c - ACPI Embedded Controller Driver (v2.2)
  *
- *  Copyright (C) 2006-2008 Alexey Starikovskiy <astarikovskiy@suse.de>
- *  Copyright (C) 2006 Denis Sadykov <denis.m.sadykov@intel.com>
- *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
- *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
- *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2001-2014 Intel Corporation
+ *    Auther: 2014       Lv Zheng <lv.zheng@intel.com>
+ *            2006, 2007 Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
+ *            2006       Denis Sadykov <denis.m.sadykov@intel.com>
+ *            2004       Luming Yu <luming.yu@intel.com>
+ *            2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *            2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2008      Alexey Starikovskiy <astarikovskiy@suse.de>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
-- 
1.7.10
