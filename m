From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/26] ACPICA: ACPICA core: Cleanup empty lines at file start and end
Date: Wed, 31 Oct 2012 10:26:11 +0800
Message-ID: <c0f220f2ac092cfc60f76079f57ffe12aedfcfb1.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24652 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875Ab2JaC0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:26:36 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Maintenance for source code consistency.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acobject.h |    1 -
 drivers/acpi/acpica/amlresrc.h |    1 -
 drivers/acpi/acpica/exmisc.c   |    1 -
 drivers/acpi/acpica/exmutex.c  |    1 -
 drivers/acpi/acpica/exnames.c  |    1 -
 drivers/acpi/acpica/exoparg1.c |    1 -
 drivers/acpi/acpica/exoparg3.c |    1 -
 drivers/acpi/acpica/exoparg6.c |    1 -
 drivers/acpi/acpica/exprep.c   |    1 -
 drivers/acpi/acpica/exregion.c |    1 -
 drivers/acpi/acpica/exresnte.c |    1 -
 drivers/acpi/acpica/exresolv.c |    1 -
 drivers/acpi/acpica/exresop.c  |    1 -
 drivers/acpi/acpica/exstoren.c |    1 -
 drivers/acpi/acpica/exstorob.c |    1 -
 drivers/acpi/acpica/exsystem.c |    1 -
 drivers/acpi/acpica/exutils.c  |    1 -
 drivers/acpi/acpica/hwacpi.c   |    1 -
 drivers/acpi/acpica/hwgpe.c    |    1 -
 drivers/acpi/acpica/hwregs.c   |    1 -
 drivers/acpi/acpica/hwtimer.c  |    1 -
 drivers/acpi/acpica/hwvalid.c  |    1 -
 drivers/acpi/acpica/hwxface.c  |    1 -
 include/acpi/acpiosxf.h        |    1 -
 include/acpi/acpixf.h          |    1 -
 25 files changed, 25 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index ac4269f..b83e46a 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Name: acobject.h - Definition of union acpi_operand_object  (Internal object only)
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index af49479..9684496 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: amlresrc.h - AML resource descriptors
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 271c0c5..15e1abd 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exmisc - ACPI AML (p-code) execution - specific opcodes
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 9099783..4723974 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exmutex - ASL Mutex Acquire/Release functions
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 6d19bd4..a41c82f 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exnames - interpreter/scanner name load/execute
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 9ba8c73..c6490d6 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exoparg1 - AML execution - opcodes with 1 argument
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 71fcc65..00b19bf 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exoparg3 - AML execution - opcodes with 3 arguments
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index ab68dc5..9818855 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exoparg6 - AML execution - opcodes with 6 arguments
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 81eca60..9589248 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exprep - ACPI AML (p-code) execution - field prep utilities
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 1f1ce0c..b41e333 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exregion - ACPI default op_region (address space) handlers
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index fa50e77..1cb057f 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exresnte - AML Interpreter object resolution
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index bbf40ac..ae199e7 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exresolv - AML Interpreter object resolution
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 17dc218..04b70b3 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exresop - AML Interpreter operand/object resolution
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index b35bed5..6fe6eac 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exstoren - AML Interpreter object store support,
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 53c2484..b9ac30c 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exstorob - AML Interpreter object store support, store to object
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index b760641..2d6d8bc 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exsystem - Interface to OS services
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index d1ab791..ff291e6 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exutils - interpreter/scanner utilities
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index a1e71d0..bcf931c 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: hwacpi - ACPI Hardware Initialization/Mode Interface
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 3b3b5e4..6456004 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: hwgpe - Low level GPE enable/disable/clear functions
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 4af6d20..f4e5750 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -1,4 +1,3 @@
-
 /*******************************************************************************
  *
  * Module Name: hwregs - Read/write access functions for the various ACPI
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 438004a..19f6cce 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Name: hwtimer.c - ACPI Power Management Timer Interface
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index c99d546..b6aae58 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: hwvalid - I/O request validation
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 7bfd649..05a154c 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: hwxface - Public ACPICA hardware interfaces
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 1222ba9..64e2c8b 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Name: acpiosxf.h - All interfaces to the OS Services Layer (OSL).  These
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index fe84aee..2596de1 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Name: acpixf.h - External interfaces to the ACPI subsystem
-- 
1.7.10

