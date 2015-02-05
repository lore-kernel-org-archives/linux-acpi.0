From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 6/6] ACPI / EC: Update revision due to raw handler mode.
Date: Thu,  5 Feb 2015 16:27:35 +0800
Message-ID: <5a02e7aa2d869f0abbca6209c86a4ba3792dd1bd.1423123819.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1423123818.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423123818.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The bug fixes around GPE races have been done to the EC driver by the
previous commits. This patch increases the revision to 3 to indicate the
behavior differences between the old and the new drivers. The
copyright/authorship notices are also updated.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e000cf7..5563253 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1,8 +1,8 @@
 /*
- *  ec.c - ACPI Embedded Controller Driver (v2.2)
+ *  ec.c - ACPI Embedded Controller Driver (v3)
  *
- *  Copyright (C) 2001-2014 Intel Corporation
- *    Author: 2014       Lv Zheng <lv.zheng@intel.com>
+ *  Copyright (C) 2001-2015 Intel Corporation
+ *    Author: 2014, 2015 Lv Zheng <lv.zheng@intel.com>
  *            2006, 2007 Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
  *            2006       Denis Sadykov <denis.m.sadykov@intel.com>
  *            2004       Luming Yu <luming.yu@intel.com>
-- 
1.7.10
