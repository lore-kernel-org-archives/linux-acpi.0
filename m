From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/9] ACPICA: Update all ACPICA copyrights and signons to 2010
Date: Mon, 01 Mar 2010 01:56:11 -0500
Message-ID: <a8357b0c95484b46944728712f8810d3b37bf588.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:45261 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab0CAG4Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:25 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL00297CLW8PP0@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:56:24 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
In-reply-to: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add 2010 copyright to all module headers and signons, including
the Linux header. This affects virtually every file in the ACPICA
core subsystem, iASL compiler, and all utilities.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/accommon.h  |    2 +-
 drivers/acpi/acpica/acconfig.h  |    2 +-
 drivers/acpi/acpica/acdebug.h   |    2 +-
 drivers/acpi/acpica/acdispat.h  |    2 +-
 drivers/acpi/acpica/acevents.h  |    2 +-
 drivers/acpi/acpica/acglobal.h  |    2 +-
 drivers/acpi/acpica/achware.h   |    2 +-
 drivers/acpi/acpica/acinterp.h  |    2 +-
 drivers/acpi/acpica/aclocal.h   |    2 +-
 drivers/acpi/acpica/acmacros.h  |    2 +-
 drivers/acpi/acpica/acnamesp.h  |    2 +-
 drivers/acpi/acpica/acobject.h  |    2 +-
 drivers/acpi/acpica/acopcode.h  |    2 +-
 drivers/acpi/acpica/acparser.h  |    2 +-
 drivers/acpi/acpica/acpredef.h  |    2 +-
 drivers/acpi/acpica/acresrc.h   |    2 +-
 drivers/acpi/acpica/acstruct.h  |    2 +-
 drivers/acpi/acpica/actables.h  |    2 +-
 drivers/acpi/acpica/acutils.h   |    2 +-
 drivers/acpi/acpica/amlcode.h   |    2 +-
 drivers/acpi/acpica/amlresrc.h  |    2 +-
 drivers/acpi/acpica/dsfield.c   |    2 +-
 drivers/acpi/acpica/dsinit.c    |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    2 +-
 drivers/acpi/acpica/dsmthdat.c  |    2 +-
 drivers/acpi/acpica/dsobject.c  |    2 +-
 drivers/acpi/acpica/dsopcode.c  |    2 +-
 drivers/acpi/acpica/dsutils.c   |    2 +-
 drivers/acpi/acpica/dswexec.c   |    2 +-
 drivers/acpi/acpica/dswload.c   |    2 +-
 drivers/acpi/acpica/dswscope.c  |    2 +-
 drivers/acpi/acpica/dswstate.c  |    2 +-
 drivers/acpi/acpica/evevent.c   |    2 +-
 drivers/acpi/acpica/evgpe.c     |    2 +-
 drivers/acpi/acpica/evgpeblk.c  |    2 +-
 drivers/acpi/acpica/evmisc.c    |    2 +-
 drivers/acpi/acpica/evregion.c  |    2 +-
 drivers/acpi/acpica/evrgnini.c  |    2 +-
 drivers/acpi/acpica/evsci.c     |    2 +-
 drivers/acpi/acpica/evxface.c   |    2 +-
 drivers/acpi/acpica/evxfevnt.c  |    2 +-
 drivers/acpi/acpica/evxfregn.c  |    2 +-
 drivers/acpi/acpica/exconfig.c  |    2 +-
 drivers/acpi/acpica/exconvrt.c  |    2 +-
 drivers/acpi/acpica/excreate.c  |    2 +-
 drivers/acpi/acpica/exdump.c    |    2 +-
 drivers/acpi/acpica/exfield.c   |    2 +-
 drivers/acpi/acpica/exfldio.c   |    2 +-
 drivers/acpi/acpica/exmisc.c    |    2 +-
 drivers/acpi/acpica/exmutex.c   |    2 +-
 drivers/acpi/acpica/exnames.c   |    2 +-
 drivers/acpi/acpica/exoparg1.c  |    2 +-
 drivers/acpi/acpica/exoparg2.c  |    2 +-
 drivers/acpi/acpica/exoparg3.c  |    2 +-
 drivers/acpi/acpica/exoparg6.c  |    2 +-
 drivers/acpi/acpica/exprep.c    |    2 +-
 drivers/acpi/acpica/exregion.c  |    2 +-
 drivers/acpi/acpica/exresnte.c  |    2 +-
 drivers/acpi/acpica/exresolv.c  |    2 +-
 drivers/acpi/acpica/exresop.c   |    2 +-
 drivers/acpi/acpica/exstore.c   |    2 +-
 drivers/acpi/acpica/exstoren.c  |    2 +-
 drivers/acpi/acpica/exstorob.c  |    2 +-
 drivers/acpi/acpica/exsystem.c  |    2 +-
 drivers/acpi/acpica/exutils.c   |    2 +-
 drivers/acpi/acpica/hwacpi.c    |    2 +-
 drivers/acpi/acpica/hwgpe.c     |    2 +-
 drivers/acpi/acpica/hwregs.c    |    2 +-
 drivers/acpi/acpica/hwsleep.c   |    2 +-
 drivers/acpi/acpica/hwtimer.c   |    2 +-
 drivers/acpi/acpica/hwvalid.c   |    2 +-
 drivers/acpi/acpica/hwxface.c   |    2 +-
 drivers/acpi/acpica/nsaccess.c  |    2 +-
 drivers/acpi/acpica/nsalloc.c   |    2 +-
 drivers/acpi/acpica/nsdump.c    |    2 +-
 drivers/acpi/acpica/nsdumpdv.c  |    2 +-
 drivers/acpi/acpica/nseval.c    |    2 +-
 drivers/acpi/acpica/nsinit.c    |    2 +-
 drivers/acpi/acpica/nsload.c    |    2 +-
 drivers/acpi/acpica/nsnames.c   |    2 +-
 drivers/acpi/acpica/nsobject.c  |    2 +-
 drivers/acpi/acpica/nsparse.c   |    2 +-
 drivers/acpi/acpica/nspredef.c  |    2 +-
 drivers/acpi/acpica/nsrepair.c  |    2 +-
 drivers/acpi/acpica/nsrepair2.c |    2 +-
 drivers/acpi/acpica/nssearch.c  |    2 +-
 drivers/acpi/acpica/nsutils.c   |    2 +-
 drivers/acpi/acpica/nswalk.c    |    2 +-
 drivers/acpi/acpica/nsxfeval.c  |    2 +-
 drivers/acpi/acpica/nsxfname.c  |    2 +-
 drivers/acpi/acpica/nsxfobj.c   |    2 +-
 drivers/acpi/acpica/psargs.c    |    2 +-
 drivers/acpi/acpica/psloop.c    |    2 +-
 drivers/acpi/acpica/psopcode.c  |    2 +-
 drivers/acpi/acpica/psparse.c   |    2 +-
 drivers/acpi/acpica/psscope.c   |    2 +-
 drivers/acpi/acpica/pstree.c    |    2 +-
 drivers/acpi/acpica/psutils.c   |    2 +-
 drivers/acpi/acpica/pswalk.c    |    2 +-
 drivers/acpi/acpica/psxface.c   |    2 +-
 drivers/acpi/acpica/rsaddr.c    |    2 +-
 drivers/acpi/acpica/rscalc.c    |    2 +-
 drivers/acpi/acpica/rscreate.c  |    2 +-
 drivers/acpi/acpica/rsdump.c    |    2 +-
 drivers/acpi/acpica/rsinfo.c    |    2 +-
 drivers/acpi/acpica/rsio.c      |    2 +-
 drivers/acpi/acpica/rsirq.c     |    2 +-
 drivers/acpi/acpica/rslist.c    |    2 +-
 drivers/acpi/acpica/rsmemory.c  |    2 +-
 drivers/acpi/acpica/rsmisc.c    |    2 +-
 drivers/acpi/acpica/rsutils.c   |    2 +-
 drivers/acpi/acpica/rsxface.c   |    2 +-
 drivers/acpi/acpica/tbfadt.c    |    2 +-
 drivers/acpi/acpica/tbfind.c    |    2 +-
 drivers/acpi/acpica/tbinstal.c  |    2 +-
 drivers/acpi/acpica/tbutils.c   |    2 +-
 drivers/acpi/acpica/tbxface.c   |    2 +-
 drivers/acpi/acpica/tbxfroot.c  |    2 +-
 drivers/acpi/acpica/utalloc.c   |    2 +-
 drivers/acpi/acpica/utcopy.c    |    2 +-
 drivers/acpi/acpica/utdebug.c   |    2 +-
 drivers/acpi/acpica/utdelete.c  |    2 +-
 drivers/acpi/acpica/uteval.c    |    2 +-
 drivers/acpi/acpica/utglobal.c  |    2 +-
 drivers/acpi/acpica/utids.c     |    2 +-
 drivers/acpi/acpica/utinit.c    |    2 +-
 drivers/acpi/acpica/utlock.c    |    2 +-
 drivers/acpi/acpica/utmath.c    |    2 +-
 drivers/acpi/acpica/utmisc.c    |    2 +-
 drivers/acpi/acpica/utmutex.c   |    2 +-
 drivers/acpi/acpica/utobject.c  |    2 +-
 drivers/acpi/acpica/utresrc.c   |    2 +-
 drivers/acpi/acpica/utstate.c   |    2 +-
 drivers/acpi/acpica/utxface.c   |    2 +-
 include/acpi/acexcep.h          |    2 +-
 include/acpi/acnames.h          |    2 +-
 include/acpi/acoutput.h         |    2 +-
 include/acpi/acpi.h             |    2 +-
 include/acpi/acpiosxf.h         |    2 +-
 include/acpi/acpixf.h           |    2 +-
 include/acpi/acrestyp.h         |    2 +-
 include/acpi/actbl.h            |    2 +-
 include/acpi/actbl1.h           |    2 +-
 include/acpi/actbl2.h           |   43 +++++++++++++++++++++++++++++++++++++++
 include/acpi/actypes.h          |    2 +-
 include/acpi/platform/acenv.h   |    2 +-
 include/acpi/platform/acgcc.h   |    2 +-
 include/acpi/platform/aclinux.h |    2 +-
 148 files changed, 190 insertions(+), 147 deletions(-)

diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 3b20786..3e50c74 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index a4471e3..33181ad 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index a4fb001..48faf3e 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 6291904..894a0ff 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 0bba148..13d2b0b 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 29ba66d..f8dd8f2 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 36192f1..5900f13 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 5db9f29..c9d7802 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 81e64f4..2caf141 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 7d9ba6e..a4a9519 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 61edb15..73f9b0c 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 64062b1..6d0b4de 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index dfdf633..8c15ff4 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 22881e8..d0bb0fd 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 57bdaf6..9711608 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index eef5bd7..528bcba 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 7980a26..161bc0e 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 01c76b8..8ff3b74 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 3a451a2..d3ae626 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 4940249..1f484ba 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 7b070e4..0e5798f 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 54a225e..effbf15 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index f23fa0b..abe1403 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index e786f9f..7210392 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 0ba19f8..cc343b9 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 9bc1ba0..edd7aa2 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index b79978f..bf980ca 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index dfa1041..306c62a 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index f028085..6b76c48 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index b40513d..140a9d0 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 908645e..d1e7017 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index e46c821..050df81 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index cd55c77..c1e6f47 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index afacf44..1685ce3 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 2479209..77670e0 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index ce224e1..e77374d 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 5336d91..654b283 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index ff16805..86bd5a7 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 567b356..8dfbaa9 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 2fe0809..292c363 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index eed7a38..8bbde62 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index c98aa7c..541cbc1 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 2ea8dac..cee2bce 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 51d5f22..adcaf3b 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 02b25d2..0aa57d9 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index de34463..d39d438 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 1588a2d..c9190c7 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index d7b3b41..dc2f9e8 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 998eac3..d29e542 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 3c456bd..cc8a102 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index ffdae12..679f308 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 752fe48..2b2128e 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 85d95c9..ea11502 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 253f9e1..25d1cd3 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 295542e..580abbd 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 52fec07..edf62bf 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 2bd83ac..0cd88f6 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 607958f..fdc1b27 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index c93b54c..fdd6a70 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 5c729a9..c5ecd61 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 6efd07a..702b9ec 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 608e838..d4af684 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 257706e..e972b66 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 3d00b93..c6cb604 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 7d41f99..0f2ce9c 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 9af361a..679a112 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 55c4507..bd72319 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 15c9ed2..ec7fc22 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -7,7 +7,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index cc22f9a..5e6d4db 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 6b282e8..ce0cbbc 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index ec33f27..e26c17d 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2009, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 647c7b6..50cc3be 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index d622ba7..aa2b801 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 8a58a1b..982269c 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index e37836e..0689d36 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 36be7f0..d2a9792 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index af9fe91..f52829c 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 4f8abac..9bd6f05 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index a7234e6..df18be9 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 8f9a487..9593724 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 60f3af0..41a9213 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 662a4bd..27cda52 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 309586f..ba1072f 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 4fd1bdb..c82060f 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2009, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 6d69264..29ff5d1 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2009, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 7e86563..08f8b3f 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 47d91e6..24d05a8 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index d7e6b52..00e79fb 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index f0c0892..c5a5357 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index e611dd9..b01e45a 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 0cc6ba0..eafef24 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index b161f35..6aa6a1a 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 0988e4a..59aabae 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 3bc3a60..2b0c3be 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 4df8f13..8d81542 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 2feca5c..40e2b27 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 4d33891..d4b970c 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index e636e07..fe29eee 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index 78b8b79..8abb962 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index d0c1b91..6064dd4 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 1e437bf..226c806 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 3c4dcc3..d6ebf7e 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index a3c23d6..61a038d 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 3f0ca5a..f859b03 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index 77b25fd..1fd868b 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsio.c b/drivers/acpi/acpica/rsio.c
index 35a49aa..33bff17 100644
--- a/drivers/acpi/acpica/rsio.c
+++ b/drivers/acpi/acpica/rsio.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index 2e02569..545da40 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 1b1dbc6..fd057c7 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index ddc76ce..887b8ba 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 5bc49a5..07de352 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index bc03d59..22cfcfb 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index f27feb4..9f6a6e7 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index c016335..f43fbe0 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1054dfd..e252180 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 63e8232..7ec02b0 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 1f15497..02723a9 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index a88f02b..5217a61 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 85ea834..dda6e8c 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 7580f6b..3d706b8 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index f857c5e..97ec362 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 527d729..e156915 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 96e26e7..16b51c6 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 5d54e36..f4c5ee8 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 3f2c68f..49286a3 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 52eaae4..1397fad 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2009, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 9d0919e..a39c93d 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 25e0312..b081cd4 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2009, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index c9f682d..7cfa1d8 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 6c6a513..fb55924 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 1f58a88..55d014e 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 42e658b..3356f0c 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 91b7c00..7965919 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index 0440c95..d35d109 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index b1f5f68..db9d8ca 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 473d584..5b2e5e8 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index c1343a9..9cf736e 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index d814da4..d772668 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index 472b7bf..a091cab 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index eb0e718..c7e9431 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -8,7 +8,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 86e9735..2bf965a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 9ffe00f..dc6302e 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 1b65879..ad20016 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 0b9b430..c637b75 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 6f3dce9..5b02e30 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1,3 +1,46 @@
+/******************************************************************************
+ *
+ * Name: actbl2.h - ACPI Specification Revision 2.0 Tables
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2010, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
 #ifndef __ACTBL2_H__
 #define __ACTBL2_H__
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 153f12d..4e65c20 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index fa7689a..c05aeba 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 6aadbf8..0cd53e3 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2008, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 0946997..e5039a2 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2009, Intel Corp.
+ * Copyright (C) 2000 - 2010, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
-- 
1.6.0.6

