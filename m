From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/7] ACPICA: Update ACPICA copyrights to 2013
Date: Fri, 25 Jan 2013 13:38:56 +0800
Message-ID: <1cee345bbb7feea9efbff9c689f4edce8e29049c.1358825277.git.lv.zheng@intel.com>
References: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:40020 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3AYFjZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:39:25 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Rafael J Wysocki <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Includes all source headers and signons for the various tools.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/accommon.h   |    2 +-
 drivers/acpi/acpica/acdebug.h    |    2 +-
 drivers/acpi/acpica/acdispat.h   |    2 +-
 drivers/acpi/acpica/acevents.h   |    2 +-
 drivers/acpi/acpica/acglobal.h   |    2 +-
 drivers/acpi/acpica/achware.h    |    2 +-
 drivers/acpi/acpica/acinterp.h   |    2 +-
 drivers/acpi/acpica/aclocal.h    |    2 +-
 drivers/acpi/acpica/acmacros.h   |    2 +-
 drivers/acpi/acpica/acnamesp.h   |    2 +-
 drivers/acpi/acpica/acobject.h   |    2 +-
 drivers/acpi/acpica/acopcode.h   |    2 +-
 drivers/acpi/acpica/acparser.h   |    2 +-
 drivers/acpi/acpica/acpredef.h   |    2 +-
 drivers/acpi/acpica/acresrc.h    |    2 +-
 drivers/acpi/acpica/acstruct.h   |    2 +-
 drivers/acpi/acpica/actables.h   |    2 +-
 drivers/acpi/acpica/acutils.h    |    2 +-
 drivers/acpi/acpica/amlcode.h    |    2 +-
 drivers/acpi/acpica/amlresrc.h   |    2 +-
 drivers/acpi/acpica/dsargs.c     |    2 +-
 drivers/acpi/acpica/dscontrol.c  |    2 +-
 drivers/acpi/acpica/dsfield.c    |    2 +-
 drivers/acpi/acpica/dsinit.c     |    2 +-
 drivers/acpi/acpica/dsmethod.c   |    2 +-
 drivers/acpi/acpica/dsmthdat.c   |    2 +-
 drivers/acpi/acpica/dsobject.c   |    2 +-
 drivers/acpi/acpica/dsopcode.c   |    2 +-
 drivers/acpi/acpica/dsutils.c    |    2 +-
 drivers/acpi/acpica/dswexec.c    |    2 +-
 drivers/acpi/acpica/dswload.c    |    2 +-
 drivers/acpi/acpica/dswload2.c   |    2 +-
 drivers/acpi/acpica/dswscope.c   |    2 +-
 drivers/acpi/acpica/dswstate.c   |    2 +-
 drivers/acpi/acpica/evevent.c    |    2 +-
 drivers/acpi/acpica/evglock.c    |    2 +-
 drivers/acpi/acpica/evgpe.c      |    2 +-
 drivers/acpi/acpica/evgpeblk.c   |    2 +-
 drivers/acpi/acpica/evgpeinit.c  |    2 +-
 drivers/acpi/acpica/evgpeutil.c  |    2 +-
 drivers/acpi/acpica/evhandler.c  |    2 +-
 drivers/acpi/acpica/evmisc.c     |    2 +-
 drivers/acpi/acpica/evregion.c   |    2 +-
 drivers/acpi/acpica/evrgnini.c   |    2 +-
 drivers/acpi/acpica/evsci.c      |    2 +-
 drivers/acpi/acpica/evxface.c    |    2 +-
 drivers/acpi/acpica/evxfevnt.c   |    2 +-
 drivers/acpi/acpica/evxfgpe.c    |    2 +-
 drivers/acpi/acpica/evxfregn.c   |    2 +-
 drivers/acpi/acpica/exconfig.c   |    2 +-
 drivers/acpi/acpica/exconvrt.c   |    2 +-
 drivers/acpi/acpica/excreate.c   |    2 +-
 drivers/acpi/acpica/exdebug.c    |    2 +-
 drivers/acpi/acpica/exdump.c     |    2 +-
 drivers/acpi/acpica/exfield.c    |    2 +-
 drivers/acpi/acpica/exfldio.c    |    2 +-
 drivers/acpi/acpica/exmisc.c     |    2 +-
 drivers/acpi/acpica/exmutex.c    |    2 +-
 drivers/acpi/acpica/exnames.c    |    2 +-
 drivers/acpi/acpica/exoparg1.c   |    2 +-
 drivers/acpi/acpica/exoparg2.c   |    2 +-
 drivers/acpi/acpica/exoparg3.c   |    2 +-
 drivers/acpi/acpica/exoparg6.c   |    2 +-
 drivers/acpi/acpica/exprep.c     |    2 +-
 drivers/acpi/acpica/exregion.c   |    2 +-
 drivers/acpi/acpica/exresnte.c   |    2 +-
 drivers/acpi/acpica/exresolv.c   |    2 +-
 drivers/acpi/acpica/exresop.c    |    2 +-
 drivers/acpi/acpica/exstore.c    |    2 +-
 drivers/acpi/acpica/exstoren.c   |    2 +-
 drivers/acpi/acpica/exstorob.c   |    2 +-
 drivers/acpi/acpica/exsystem.c   |    2 +-
 drivers/acpi/acpica/exutils.c    |    2 +-
 drivers/acpi/acpica/hwacpi.c     |    2 +-
 drivers/acpi/acpica/hwesleep.c   |    2 +-
 drivers/acpi/acpica/hwgpe.c      |    2 +-
 drivers/acpi/acpica/hwpci.c      |    2 +-
 drivers/acpi/acpica/hwregs.c     |    2 +-
 drivers/acpi/acpica/hwsleep.c    |    2 +-
 drivers/acpi/acpica/hwtimer.c    |    2 +-
 drivers/acpi/acpica/hwvalid.c    |    2 +-
 drivers/acpi/acpica/hwxface.c    |    2 +-
 drivers/acpi/acpica/hwxfsleep.c  |    2 +-
 drivers/acpi/acpica/nsaccess.c   |    2 +-
 drivers/acpi/acpica/nsalloc.c    |    2 +-
 drivers/acpi/acpica/nsdump.c     |    2 +-
 drivers/acpi/acpica/nsdumpdv.c   |    2 +-
 drivers/acpi/acpica/nseval.c     |    2 +-
 drivers/acpi/acpica/nsinit.c     |    2 +-
 drivers/acpi/acpica/nsload.c     |    2 +-
 drivers/acpi/acpica/nsnames.c    |    2 +-
 drivers/acpi/acpica/nsobject.c   |    2 +-
 drivers/acpi/acpica/nsparse.c    |    2 +-
 drivers/acpi/acpica/nspredef.c   |    2 +-
 drivers/acpi/acpica/nsprepkg.c   |    2 +-
 drivers/acpi/acpica/nsrepair.c   |    2 +-
 drivers/acpi/acpica/nsrepair2.c  |    2 +-
 drivers/acpi/acpica/nssearch.c   |    2 +-
 drivers/acpi/acpica/nsutils.c    |    2 +-
 drivers/acpi/acpica/nswalk.c     |    2 +-
 drivers/acpi/acpica/nsxfeval.c   |    2 +-
 drivers/acpi/acpica/nsxfname.c   |    2 +-
 drivers/acpi/acpica/nsxfobj.c    |    2 +-
 drivers/acpi/acpica/psargs.c     |    2 +-
 drivers/acpi/acpica/psloop.c     |    2 +-
 drivers/acpi/acpica/psobject.c   |    2 +-
 drivers/acpi/acpica/psopcode.c   |    2 +-
 drivers/acpi/acpica/psopinfo.c   |    2 +-
 drivers/acpi/acpica/psparse.c    |    2 +-
 drivers/acpi/acpica/psscope.c    |    2 +-
 drivers/acpi/acpica/pstree.c     |    2 +-
 drivers/acpi/acpica/psutils.c    |    2 +-
 drivers/acpi/acpica/pswalk.c     |    2 +-
 drivers/acpi/acpica/psxface.c    |    2 +-
 drivers/acpi/acpica/rsaddr.c     |    2 +-
 drivers/acpi/acpica/rscalc.c     |    2 +-
 drivers/acpi/acpica/rscreate.c   |    2 +-
 drivers/acpi/acpica/rsdump.c     |    2 +-
 drivers/acpi/acpica/rsdumpinfo.c |    2 +-
 drivers/acpi/acpica/rsinfo.c     |    2 +-
 drivers/acpi/acpica/rsio.c       |    2 +-
 drivers/acpi/acpica/rsirq.c      |    2 +-
 drivers/acpi/acpica/rslist.c     |    2 +-
 drivers/acpi/acpica/rsmemory.c   |    2 +-
 drivers/acpi/acpica/rsmisc.c     |    2 +-
 drivers/acpi/acpica/rsserial.c   |    2 +-
 drivers/acpi/acpica/rsutils.c    |    2 +-
 drivers/acpi/acpica/rsxface.c    |    2 +-
 drivers/acpi/acpica/tbfadt.c     |    2 +-
 drivers/acpi/acpica/tbfind.c     |    2 +-
 drivers/acpi/acpica/tbinstal.c   |    2 +-
 drivers/acpi/acpica/tbutils.c    |    2 +-
 drivers/acpi/acpica/tbxface.c    |    2 +-
 drivers/acpi/acpica/tbxfload.c   |    2 +-
 drivers/acpi/acpica/tbxfroot.c   |    2 +-
 drivers/acpi/acpica/utaddress.c  |    2 +-
 drivers/acpi/acpica/utalloc.c    |    2 +-
 drivers/acpi/acpica/utcache.c    |    2 +-
 drivers/acpi/acpica/utcopy.c     |    2 +-
 drivers/acpi/acpica/utdebug.c    |    2 +-
 drivers/acpi/acpica/utdecode.c   |    2 +-
 drivers/acpi/acpica/utdelete.c   |    2 +-
 drivers/acpi/acpica/uteval.c     |    2 +-
 drivers/acpi/acpica/utexcep.c    |    2 +-
 drivers/acpi/acpica/utglobal.c   |    2 +-
 drivers/acpi/acpica/utids.c      |    2 +-
 drivers/acpi/acpica/utinit.c     |    2 +-
 drivers/acpi/acpica/utlock.c     |    2 +-
 drivers/acpi/acpica/utmath.c     |    2 +-
 drivers/acpi/acpica/utmisc.c     |    2 +-
 drivers/acpi/acpica/utmutex.c    |    2 +-
 drivers/acpi/acpica/utobject.c   |    2 +-
 drivers/acpi/acpica/utosi.c      |    2 +-
 drivers/acpi/acpica/utownerid.c  |    2 +-
 drivers/acpi/acpica/utresrc.c    |    2 +-
 drivers/acpi/acpica/utstate.c    |    2 +-
 drivers/acpi/acpica/utstring.c   |    2 +-
 drivers/acpi/acpica/uttrack.c    |    2 +-
 drivers/acpi/acpica/utxface.c    |    2 +-
 drivers/acpi/acpica/utxferror.c  |    2 +-
 drivers/acpi/acpica/utxfinit.c   |    2 +-
 drivers/acpi/acpica/utxfmutex.c  |    2 +-
 include/acpi/acbuffer.h          |    2 +-
 include/acpi/acconfig.h          |    2 +-
 include/acpi/acexcep.h           |    2 +-
 include/acpi/acnames.h           |    2 +-
 include/acpi/acoutput.h          |    2 +-
 include/acpi/acpi.h              |    2 +-
 include/acpi/acpiosxf.h          |    2 +-
 include/acpi/acpixf.h            |    2 +-
 include/acpi/acrestyp.h          |    2 +-
 include/acpi/actbl.h             |    2 +-
 include/acpi/actbl1.h            |    2 +-
 include/acpi/actbl2.h            |    2 +-
 include/acpi/actbl3.h            |    2 +-
 include/acpi/actypes.h           |    2 +-
 include/acpi/platform/acenv.h    |    2 +-
 include/acpi/platform/acgcc.h    |    2 +-
 include/acpi/platform/aclinux.h  |    2 +-
 179 files changed, 179 insertions(+), 179 deletions(-)

diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 8632d71..8a6c4a0 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index c8dea18..9feba08 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index ed33ebc..427db72 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 35a2cbc..ab0e977 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 585d364..7f6a9a9 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index d902d31..6357e93 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 16469b0..8af8c9b 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 5ce0693..805f419 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 2db0f10..ed7943b 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index bbfcd1b..02cd548 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 921262e..cc7ab6d 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index d786a51..3fc9ca7 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index e8f5726..aed3193 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 4fbc4be..c11b66d 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 89bc3aa..f691d0e 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 937e66c..7896d85 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 6712965..7755e91 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 4e95211..0082fa0 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index c26f8ff..48a3e33 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index bdbb7d0..87c2636 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index c8b5e25..fb09b08 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 57895db..7ea0f16 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index b5b904e..feadeed 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 87eff70..bc8e63f 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 4e5873a..a9ffd44 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 9a83b7e..3da8046 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 82050bc..2e6288d 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 25d1925..ee6367b 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 466f5f2..4d8c992 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 9e0d210..44f8325 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index d290740..6e17c0e 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 3798357..620a023 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index f6c4295..d67891d 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 3e65a15..ecb12e2 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index d4acfbb..b8ea0b2 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index af14a71..a621481 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 052d4c8..b9adb9a 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 78db9f5..a2d688b 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 8ac86b0..72b8f6b 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 228a0c3..b24dbb8 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 95e5258..d4f8311 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 51f5379..c986b23 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index d1fa91d..6555e35 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 1474241..3bb6167 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 6c90f15..f4b43be 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index db82060..ddffd68 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index be57f49..d6e4e42 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 36f8ad8..aff4cc2 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 96b412d..96c9e5f 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index f214dbf..d93b70b 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index d6a7b6f..d2b9613 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 66554bc..26a13f6 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index d7c9f51..7eb853c 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 8698bff..e5a3c24 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index ebc55fb..7d4bae7 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 2c2146c..ec7f569 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 8405870..72a2a13 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 02157ef..7be0205 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 2ff578a..14689de 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index cf50c6c..b60c877 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index ee5634a..e491e46 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 2c89b46..2d7491f 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 3e08695..b76b970 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 60ee5e9..d6eab81 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 28d3cd9..182abaf 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 6239956..8565b6b 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index cc176b2..e4f9dfb 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index b9ebff2..9fb9f5e 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 4ff37e8..93c6049 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 85a74b7..1cefe77 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index b5f339c..26e3710 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index c8a0ad5..6578dee 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index e624958..b205cbb 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 2613e29..deb3f61 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 6c0b1a9..5e5f762 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 095666b..d84fd83 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
index 65bc345..0889a62 100644
--- a/drivers/acpi/acpica/hwpci.c
+++ b/drivers/acpi/acpica/hwpci.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index fd4e2dc..083d655 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 675a8f8..e3828cc 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 4e741d8..0c1a8bb 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 70686cd..eab70d5 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index e835645..a4bac08 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index ca4df0f..35eebda 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index d70eaf3..8769cf8 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 15143c4..2437373 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 37b0e68..ce6e973 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 4ae9360..409ae80 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 69074be..1538f3e 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 0f8de6e..2a431ec 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 911f991..0a7badc 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 7d34641..90a0380 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index e69f7fa..7a736f4 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 233f756..35dde81 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 9095209..224c300 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index c27be70..a401554 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 8c5f292..9e83335 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index fdb818d..ba4d982 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index b7f4264..5d43efc 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index a771c8c..686420d 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 4657e75..e70911a 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 1070eee..fc69949 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 1664fad..f3a4d95 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 9d029da..c0853ef 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 9256513..f51308c 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 4261c5f..63c4554 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 2f461e4..12c4028 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 0fcee88..1b659e5 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index d870e62..9ba5301 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 2494caf..abc4c48 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 608dc20..6a4b6fb 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index fdb2e71..c1934bf 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 2bbf670..91fa73a 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index ab96cf4..abd6562 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 963e162..f682542 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 856ff07..f3a9276 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index da178b4..7816d4ee 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 55e0908..f8b55b4 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 6e8f9bd..cab5144 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index 63a68c9..46192bd 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index a9fa515..41fed78 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsio.c b/drivers/acpi/acpica/rsio.c
index f6a0810..ca18375 100644
--- a/drivers/acpi/acpica/rsio.c
+++ b/drivers/acpi/acpica/rsio.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index 9c1d74a..364decc 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 83e6158..ee2e206 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index d446103..ebc773a 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 7b094eb..d5bf05a 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 197bab0..fe49fc4 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 41b8103..a44953c 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index a4086aab..15d6eae 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 882285b..74181bf 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 77d1db2..e4f4f02 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index f540ae4..e57cd38 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index e3cc315..ce3d5db 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 2115f22..b35a5e6 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 7feaafd..67e046e 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 28f3302..7c2ecfb 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index b86ef85..698b9d3 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index ed29d47..e0ffb58 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index e1d40ed..e0e8579 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 99549ee..e4c9291 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 47857c4..c57d9cc 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 60a1584..11e2e02 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index c8bf44f..2541de4 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 45cddb8..c3f3a7e 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utexcep.c b/drivers/acpi/acpica/utexcep.c
index 23b9894..a0ab7c0 100644
--- a/drivers/acpi/acpica/utexcep.c
+++ b/drivers/acpi/acpica/utexcep.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 7b4dd21..ffecf4b 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 774c3ae..43a170a 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 246798e..c5d1ac4 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 8d1a749..5c26ad4 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 4956367..909fe66 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 7ebf4e4..785fdd0 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 5ccf57c..22feb99 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 822600b..1099f5c 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 676285d..36a7d36 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index 6b42e63..835340b 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 8f8eab9..cb7fa49 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index 26a0c23..a6b729d 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 4170265..b3e36a8 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 866f96e..62774c7 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index cb85a7b..48efb44 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index a247a22..976b6c7 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 14f5236..41ebaaf 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxfmutex.c b/drivers/acpi/acpica/utxfmutex.c
index 0a40a85..3122997 100644
--- a/drivers/acpi/acpica/utxfmutex.c
+++ b/drivers/acpi/acpica/utxfmutex.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index a1e45cd..c927a0b 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 101d5fe..14ceff7 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 6c3890e..9bf59d0 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 7665df6..ce08ef7 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index b48cb34..9885276 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index c1ea843..6187877 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index dfcedc6..7d2a9ea 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d8b2ea6..bf3e129 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index b58c3cb..cbf4bf9 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index ee050e8..9b58a8f 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 61f04c0..0bd750e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ef9dae1..77dc7a4 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index c4aae22..332b17e 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3d4e09c..845e75f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index a74afaf..ef04b36 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 7433ad1..e077ce6 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 33d05b0..68534ef 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2012, Intel Corp.
+ * Copyright (C) 2000 - 2013, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
-- 
1.7.10

