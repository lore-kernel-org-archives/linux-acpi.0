From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/10] ACPICA: Update ACPICA copyrights to 2014.
Date: Sat,  8 Feb 2014 09:42:25 +0800
Message-ID: <4f1eba1c3871e2e62688f7f7fe3cfb9d7b045060.1390438466.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39447 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaBHBmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:38 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Update ACPICA copyrights to 2014. Includes all source headers and
signons for the various tools.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/accommon.h    |    2 +-
 drivers/acpi/acpica/acdebug.h     |    2 +-
 drivers/acpi/acpica/acdispat.h    |    2 +-
 drivers/acpi/acpica/acevents.h    |    2 +-
 drivers/acpi/acpica/acglobal.h    |    2 +-
 drivers/acpi/acpica/achware.h     |    2 +-
 drivers/acpi/acpica/acinterp.h    |    2 +-
 drivers/acpi/acpica/aclocal.h     |    2 +-
 drivers/acpi/acpica/acmacros.h    |    2 +-
 drivers/acpi/acpica/acnamesp.h    |    2 +-
 drivers/acpi/acpica/acobject.h    |    2 +-
 drivers/acpi/acpica/acopcode.h    |    2 +-
 drivers/acpi/acpica/acparser.h    |    2 +-
 drivers/acpi/acpica/acpredef.h    |    2 +-
 drivers/acpi/acpica/acresrc.h     |    2 +-
 drivers/acpi/acpica/acstruct.h    |    2 +-
 drivers/acpi/acpica/actables.h    |    2 +-
 drivers/acpi/acpica/acutils.h     |    2 +-
 drivers/acpi/acpica/amlcode.h     |    2 +-
 drivers/acpi/acpica/amlresrc.h    |    2 +-
 drivers/acpi/acpica/dsargs.c      |    2 +-
 drivers/acpi/acpica/dscontrol.c   |    2 +-
 drivers/acpi/acpica/dsfield.c     |    2 +-
 drivers/acpi/acpica/dsinit.c      |    2 +-
 drivers/acpi/acpica/dsmethod.c    |    2 +-
 drivers/acpi/acpica/dsmthdat.c    |    2 +-
 drivers/acpi/acpica/dsobject.c    |    2 +-
 drivers/acpi/acpica/dsopcode.c    |    2 +-
 drivers/acpi/acpica/dsutils.c     |    2 +-
 drivers/acpi/acpica/dswexec.c     |    2 +-
 drivers/acpi/acpica/dswload.c     |    2 +-
 drivers/acpi/acpica/dswload2.c    |    2 +-
 drivers/acpi/acpica/dswscope.c    |    2 +-
 drivers/acpi/acpica/dswstate.c    |    2 +-
 drivers/acpi/acpica/evevent.c     |    2 +-
 drivers/acpi/acpica/evglock.c     |    2 +-
 drivers/acpi/acpica/evgpe.c       |    2 +-
 drivers/acpi/acpica/evgpeblk.c    |    2 +-
 drivers/acpi/acpica/evgpeinit.c   |    2 +-
 drivers/acpi/acpica/evgpeutil.c   |    2 +-
 drivers/acpi/acpica/evhandler.c   |    2 +-
 drivers/acpi/acpica/evmisc.c      |    2 +-
 drivers/acpi/acpica/evregion.c    |    2 +-
 drivers/acpi/acpica/evrgnini.c    |    2 +-
 drivers/acpi/acpica/evsci.c       |    2 +-
 drivers/acpi/acpica/evxface.c     |    2 +-
 drivers/acpi/acpica/evxfevnt.c    |    2 +-
 drivers/acpi/acpica/evxfgpe.c     |    2 +-
 drivers/acpi/acpica/evxfregn.c    |    2 +-
 drivers/acpi/acpica/exconfig.c    |    2 +-
 drivers/acpi/acpica/exconvrt.c    |    2 +-
 drivers/acpi/acpica/excreate.c    |    2 +-
 drivers/acpi/acpica/exdebug.c     |    2 +-
 drivers/acpi/acpica/exdump.c      |    2 +-
 drivers/acpi/acpica/exfield.c     |    2 +-
 drivers/acpi/acpica/exfldio.c     |    2 +-
 drivers/acpi/acpica/exmisc.c      |    2 +-
 drivers/acpi/acpica/exmutex.c     |    2 +-
 drivers/acpi/acpica/exnames.c     |    2 +-
 drivers/acpi/acpica/exoparg1.c    |    2 +-
 drivers/acpi/acpica/exoparg2.c    |    2 +-
 drivers/acpi/acpica/exoparg3.c    |    2 +-
 drivers/acpi/acpica/exoparg6.c    |    2 +-
 drivers/acpi/acpica/exprep.c      |    2 +-
 drivers/acpi/acpica/exregion.c    |    2 +-
 drivers/acpi/acpica/exresnte.c    |    2 +-
 drivers/acpi/acpica/exresolv.c    |    2 +-
 drivers/acpi/acpica/exresop.c     |    2 +-
 drivers/acpi/acpica/exstore.c     |    2 +-
 drivers/acpi/acpica/exstoren.c    |    2 +-
 drivers/acpi/acpica/exstorob.c    |    2 +-
 drivers/acpi/acpica/exsystem.c    |    2 +-
 drivers/acpi/acpica/exutils.c     |    2 +-
 drivers/acpi/acpica/hwacpi.c      |    2 +-
 drivers/acpi/acpica/hwesleep.c    |    2 +-
 drivers/acpi/acpica/hwgpe.c       |    2 +-
 drivers/acpi/acpica/hwpci.c       |    2 +-
 drivers/acpi/acpica/hwregs.c      |    2 +-
 drivers/acpi/acpica/hwsleep.c     |    2 +-
 drivers/acpi/acpica/hwtimer.c     |    2 +-
 drivers/acpi/acpica/hwvalid.c     |    2 +-
 drivers/acpi/acpica/hwxface.c     |    2 +-
 drivers/acpi/acpica/hwxfsleep.c   |    2 +-
 drivers/acpi/acpica/nsaccess.c    |    2 +-
 drivers/acpi/acpica/nsalloc.c     |    2 +-
 drivers/acpi/acpica/nsarguments.c |    2 +-
 drivers/acpi/acpica/nsconvert.c   |    2 +-
 drivers/acpi/acpica/nsdump.c      |    2 +-
 drivers/acpi/acpica/nsdumpdv.c    |    2 +-
 drivers/acpi/acpica/nseval.c      |    2 +-
 drivers/acpi/acpica/nsinit.c      |    2 +-
 drivers/acpi/acpica/nsload.c      |    2 +-
 drivers/acpi/acpica/nsnames.c     |    2 +-
 drivers/acpi/acpica/nsobject.c    |    2 +-
 drivers/acpi/acpica/nsparse.c     |    2 +-
 drivers/acpi/acpica/nspredef.c    |    2 +-
 drivers/acpi/acpica/nsprepkg.c    |    2 +-
 drivers/acpi/acpica/nsrepair.c    |    2 +-
 drivers/acpi/acpica/nsrepair2.c   |    2 +-
 drivers/acpi/acpica/nssearch.c    |    2 +-
 drivers/acpi/acpica/nsutils.c     |    2 +-
 drivers/acpi/acpica/nswalk.c      |    2 +-
 drivers/acpi/acpica/nsxfeval.c    |    2 +-
 drivers/acpi/acpica/nsxfname.c    |    2 +-
 drivers/acpi/acpica/nsxfobj.c     |    2 +-
 drivers/acpi/acpica/psargs.c      |    2 +-
 drivers/acpi/acpica/psloop.c      |    2 +-
 drivers/acpi/acpica/psobject.c    |    2 +-
 drivers/acpi/acpica/psopcode.c    |    2 +-
 drivers/acpi/acpica/psopinfo.c    |    2 +-
 drivers/acpi/acpica/psparse.c     |    2 +-
 drivers/acpi/acpica/psscope.c     |    2 +-
 drivers/acpi/acpica/pstree.c      |    2 +-
 drivers/acpi/acpica/psutils.c     |    2 +-
 drivers/acpi/acpica/pswalk.c      |    2 +-
 drivers/acpi/acpica/psxface.c     |    2 +-
 drivers/acpi/acpica/rsaddr.c      |    2 +-
 drivers/acpi/acpica/rscalc.c      |    2 +-
 drivers/acpi/acpica/rscreate.c    |    2 +-
 drivers/acpi/acpica/rsdump.c      |    2 +-
 drivers/acpi/acpica/rsdumpinfo.c  |    2 +-
 drivers/acpi/acpica/rsinfo.c      |    2 +-
 drivers/acpi/acpica/rsio.c        |    2 +-
 drivers/acpi/acpica/rsirq.c       |    2 +-
 drivers/acpi/acpica/rslist.c      |    2 +-
 drivers/acpi/acpica/rsmemory.c    |    2 +-
 drivers/acpi/acpica/rsmisc.c      |    2 +-
 drivers/acpi/acpica/rsserial.c    |    2 +-
 drivers/acpi/acpica/rsutils.c     |    2 +-
 drivers/acpi/acpica/rsxface.c     |    2 +-
 drivers/acpi/acpica/tbfadt.c      |    2 +-
 drivers/acpi/acpica/tbfind.c      |    2 +-
 drivers/acpi/acpica/tbinstal.c    |    2 +-
 drivers/acpi/acpica/tbprint.c     |    2 +-
 drivers/acpi/acpica/tbutils.c     |    2 +-
 drivers/acpi/acpica/tbxface.c     |    2 +-
 drivers/acpi/acpica/tbxfload.c    |    2 +-
 drivers/acpi/acpica/tbxfroot.c    |    2 +-
 drivers/acpi/acpica/utaddress.c   |    2 +-
 drivers/acpi/acpica/utalloc.c     |    2 +-
 drivers/acpi/acpica/utbuffer.c    |    2 +-
 drivers/acpi/acpica/utcache.c     |    2 +-
 drivers/acpi/acpica/utcopy.c      |    2 +-
 drivers/acpi/acpica/utdebug.c     |    2 +-
 drivers/acpi/acpica/utdecode.c    |    2 +-
 drivers/acpi/acpica/utdelete.c    |    2 +-
 drivers/acpi/acpica/uterror.c     |    2 +-
 drivers/acpi/acpica/uteval.c      |    2 +-
 drivers/acpi/acpica/utexcep.c     |    2 +-
 drivers/acpi/acpica/utglobal.c    |    2 +-
 drivers/acpi/acpica/utids.c       |    2 +-
 drivers/acpi/acpica/utinit.c      |    2 +-
 drivers/acpi/acpica/utlock.c      |    2 +-
 drivers/acpi/acpica/utmath.c      |    2 +-
 drivers/acpi/acpica/utmisc.c      |    2 +-
 drivers/acpi/acpica/utmutex.c     |    2 +-
 drivers/acpi/acpica/utobject.c    |    2 +-
 drivers/acpi/acpica/utosi.c       |    2 +-
 drivers/acpi/acpica/utownerid.c   |    2 +-
 drivers/acpi/acpica/utpredef.c    |    2 +-
 drivers/acpi/acpica/utresrc.c     |    2 +-
 drivers/acpi/acpica/utstate.c     |    2 +-
 drivers/acpi/acpica/utstring.c    |    2 +-
 drivers/acpi/acpica/uttrack.c     |    2 +-
 drivers/acpi/acpica/utxface.c     |    2 +-
 drivers/acpi/acpica/utxferror.c   |    2 +-
 drivers/acpi/acpica/utxfinit.c    |    2 +-
 drivers/acpi/acpica/utxfmutex.c   |    2 +-
 include/acpi/acbuffer.h           |    2 +-
 include/acpi/acconfig.h           |    2 +-
 include/acpi/acexcep.h            |    2 +-
 include/acpi/acnames.h            |    2 +-
 include/acpi/acoutput.h           |    2 +-
 include/acpi/acpi.h               |    2 +-
 include/acpi/acpiosxf.h           |    2 +-
 include/acpi/acpixf.h             |    2 +-
 include/acpi/acrestyp.h           |    2 +-
 include/acpi/actbl.h              |    2 +-
 include/acpi/actbl1.h             |    2 +-
 include/acpi/actbl2.h             |    2 +-
 include/acpi/actbl3.h             |    2 +-
 include/acpi/actypes.h            |    2 +-
 include/acpi/platform/acenv.h     |    2 +-
 include/acpi/platform/acgcc.h     |    2 +-
 include/acpi/platform/aclinux.h   |    2 +-
 185 files changed, 185 insertions(+), 185 deletions(-)

diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 8a6c4a0..6f1c616 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 2bf3ca2..7db70ae 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 427db72..5b472c4 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 0fb0adf..68ec61f 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 24db8e1..ad23dc2 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 6357e93..2ad2351 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 8af8c9b..948a680 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index d95ca54..52a21da 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 2546782..4bceb11 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index e6138ac..ee1c040 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index cc7ab6d..1a4d618 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index 3fc9ca7..dda0e6a 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index aed3193..6168b85 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index f600ade..9c73d6c 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index ff97430..4b008e8 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index fc83c0a..5d2989a 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index c54f42c..5fa4b20 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index be8180c..24735eb 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 48a3e33..5908cce 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 87c2636..f3f8344 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index afdc6df..720b1cd 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index eb56b66..8daf9de 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index e7a57c5..3661c8e 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 1442420..96644d5 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 81a78ba..2c6d42c 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index c4b0b36..b67522d 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index b1746a6..a1e7e6b 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 5205edc..6c0759c 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index d7f53fb..9f74795 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 1bbb22f..f7f5107 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 2dbe109..bd7811c 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 7f569d5..2ac28d2 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index d67891d..9d6e2c1 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index ecb12e2..24f7d5e 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 83cd45f..c7bffff 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 4c67193..3393a73 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index a9cb4a1..955f83d 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index a31e549..caaed3c 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index a3e2f38..ae779c1 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 4d764e8..17e4bbf 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index e315731..78ac293 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index a568754..5d594eb 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 144cbb9..e31049b 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 8354c4f..1b148a4 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 9e9e345..4d8a709 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 23a7fad..a734b27 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 39d06af..e286640 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index b84f8e2..20a1392 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 02ed75a..2d6f187 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 06d216c..8ba1464 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 69e4a8c..c545386 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 3c2e6dc..95d23da 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index 81c72a4..4cfc3d3 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 4d046fa..c3e419c 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index cfd8752..68d9744 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 49fb742..1d1b27a 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 65d9360..2207e62 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 7be0205..b49ea2a 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 14689de..dbb03b5 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index d74cea4..1b8e941 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index d6fa0fc..2ede656 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index bc042ad..363767c 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 4459e32..29e9e99 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 5a58861..ee3f872 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 9d28867e..cd5288a 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 7ca6925..ab06026 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 1606524..3cde553 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index be3f669..3af8de3 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index f0b09bf..daf49f7 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 20d809d..04bd16c 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 26e3710..fd11018 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 6578dee..841caed 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 99dc7b2..5b16c54 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 3d36df8..1e66d96 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 4140768..858fdd6 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 9654050..2e6caab 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
index 0889a62..e701d8c 100644
--- a/drivers/acpi/acpica/hwpci.c
+++ b/drivers/acpi/acpica/hwpci.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 12e6cff..e0fd9b4 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index e3828cc..d590693 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 3c498dc..76ab5c1 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index eab70d5..6b91912 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index b4b47db..96d007df 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 15dddc1..6921c7f 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 14f65f6..f1249e3 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index fd1ff54..607eb9e 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index 74b24c8..80fcfc8 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index acd2964..b55642c 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 48b9c6f..3d88ef4 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 2837625..42d3710 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 963ceef..e634a05 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 3a0423a..5b74677 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 89ec645..7ae521c 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 90a0380..7eee0a6 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 7a736f4..32845b1 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 1778573..e83cff3 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index d2855d9..392910f 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 3d5391f..61faf77 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index a05afff..904f7c3 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 6a25d32..53b4b42 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 47420fa..af1cc42 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 4a0665b..4a5e3f5 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index e81f15e..4758a1f 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 1f0c28b..c76956b 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 3a4bd3f..8c6c11c 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 0e6d79e..dae9401 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 91a5a69..314d314 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 065b44a..646d1a3 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 95dc608..af1f46c 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 1b659e59..1755d2a 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index b0c9787..0d8d37f 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 79d9a28..6d27b59 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 6a4b6fb..32d250f 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 877dc0d..0b64181 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 91fa73a..3cd4880 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index abd6562..9cb07e1 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index fcb7a84..e135aca 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index f3a9276..916fd09 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index b60c9cf..ae9a9cf 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 3a2ace9..ca62804 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 8a2d498..7e84008 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index 46192bd..60a852e 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index 41fed78..d984d45 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsio.c b/drivers/acpi/acpica/rsio.c
index ca18375..19d6487 100644
--- a/drivers/acpi/acpica/rsio.c
+++ b/drivers/acpi/acpica/rsio.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index 364decc..3461f7d 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 6053aa1..7729129 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index ebc773a..eab4483 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index c99cec9..41eea4b 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index fe49fc4..9e84072 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 14a7982..897a5ce 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 01e4769..877ab92 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 8f89263..ec14588 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index e4f4f02..c120039 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index c1a8cf7..e304094 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 05ded33..df3bb20 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 6412d3c..a4702ee 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index db826ea..a159315 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 60b5a87..0909420 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index e4e1468..65ab8fe 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index 2c2b6ae..a1acec9 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 1851762..efac83c 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 11fde93..3c16997 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index cacd2fd..78fde0a 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index edff4e6..95e55f5 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index d971c86..21a20ac 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index b3f31dd..fbfa9ec 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index c07d222..ed4cb86 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
index 154fdca..8e544d4 100644
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 16fb905..8fed148 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utexcep.c b/drivers/acpi/acpica/utexcep.c
index 3cf7b59..0403dca 100644
--- a/drivers/acpi/acpica/utexcep.c
+++ b/drivers/acpi/acpica/utexcep.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 030cb0d..21785da 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index bfca7b4..4b12880 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index c5d1ac4..5f56fc4 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 5c26ad4..dc6e965 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 909fe66..d44dee6 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 02f9101..2e2bb14 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 08c3232..82717ff 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 517af70..dfa9009b 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 8856bd3..e210e51 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index eb3aca7..36bec57 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 2b1ce4c..db30caf 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 2c2accb..e71a4d8 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index 03c4c2f..1cc97a7 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 45c0eb2..7721933 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 4e36738..7d0ee96 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index be322c8..502a849 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index f7edb88..edd8611 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 246ef68..13380d8 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxfmutex.c b/drivers/acpi/acpica/utxfmutex.c
index 3122997..2a0f9e0 100644
--- a/drivers/acpi/acpica/utxfmutex.c
+++ b/drivers/acpi/acpica/utxfmutex.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index c927a0b..88cb477 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 3ea214c..932a60d 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 4e280bd..8b06e4c 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 1f36777..3dd6e83 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 4607b02..1baae6e 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index 6187877..a544d3e 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 01e6c6d..f6f5f8a 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d2f16f1..abb74a2 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index cbf4bf9..eb760ca 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 325aeae..3b30e36 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 4ec8c19..212c65d 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 094a906..f337244 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 01c2a90..c2295cc 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 68a3ada..0bdf5c7 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index b402eb6..e863dd5 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index e077ce6..a476b91 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 008aa28..587b1e2 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2013, Intel Corp.
+ * Copyright (C) 2000 - 2014, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
-- 
1.7.10

