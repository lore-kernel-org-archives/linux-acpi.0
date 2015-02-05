From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/10] ACPICA: Update Copyright headers to 2015.
Date: Thu,  5 Feb 2015 15:20:45 +0800
Message-ID: <c770e6c36c0eb79ad227c830d1a2d3fef669e9a1.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit 8990e73ab2aa15d6a0068b860ab54feff25bee36

Link: https://github.com/acpica/acpica/commit/8990e73a
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h                             |    4 ++--
 drivers/acpi/acpica/accommon.h                           |    2 +-
 drivers/acpi/acpica/acdebug.h                            |    2 +-
 drivers/acpi/acpica/acdispat.h                           |    2 +-
 drivers/acpi/acpica/acevents.h                           |    2 +-
 drivers/acpi/acpica/acglobal.h                           |    2 +-
 drivers/acpi/acpica/achware.h                            |    2 +-
 drivers/acpi/acpica/acinterp.h                           |    2 +-
 drivers/acpi/acpica/aclocal.h                            |    2 +-
 drivers/acpi/acpica/acmacros.h                           |    2 +-
 drivers/acpi/acpica/acnamesp.h                           |    2 +-
 drivers/acpi/acpica/acobject.h                           |    2 +-
 drivers/acpi/acpica/acopcode.h                           |    2 +-
 drivers/acpi/acpica/acparser.h                           |    2 +-
 drivers/acpi/acpica/acpredef.h                           |    2 +-
 drivers/acpi/acpica/acresrc.h                            |    2 +-
 drivers/acpi/acpica/acstruct.h                           |    2 +-
 drivers/acpi/acpica/actables.h                           |    2 +-
 drivers/acpi/acpica/acutils.h                            |    2 +-
 drivers/acpi/acpica/amlcode.h                            |    2 +-
 drivers/acpi/acpica/amlresrc.h                           |    2 +-
 drivers/acpi/acpica/dsargs.c                             |    2 +-
 drivers/acpi/acpica/dscontrol.c                          |    2 +-
 drivers/acpi/acpica/dsfield.c                            |    2 +-
 drivers/acpi/acpica/dsinit.c                             |    2 +-
 drivers/acpi/acpica/dsmethod.c                           |    2 +-
 drivers/acpi/acpica/dsmthdat.c                           |    2 +-
 drivers/acpi/acpica/dsobject.c                           |    2 +-
 drivers/acpi/acpica/dsopcode.c                           |    2 +-
 drivers/acpi/acpica/dsutils.c                            |    2 +-
 drivers/acpi/acpica/dswexec.c                            |    2 +-
 drivers/acpi/acpica/dswload.c                            |    2 +-
 drivers/acpi/acpica/dswload2.c                           |    2 +-
 drivers/acpi/acpica/dswscope.c                           |    2 +-
 drivers/acpi/acpica/dswstate.c                           |    2 +-
 drivers/acpi/acpica/evevent.c                            |    2 +-
 drivers/acpi/acpica/evglock.c                            |    2 +-
 drivers/acpi/acpica/evgpe.c                              |    2 +-
 drivers/acpi/acpica/evgpeblk.c                           |    2 +-
 drivers/acpi/acpica/evgpeinit.c                          |    2 +-
 drivers/acpi/acpica/evgpeutil.c                          |    2 +-
 drivers/acpi/acpica/evhandler.c                          |    2 +-
 drivers/acpi/acpica/evmisc.c                             |    2 +-
 drivers/acpi/acpica/evregion.c                           |    2 +-
 drivers/acpi/acpica/evrgnini.c                           |    2 +-
 drivers/acpi/acpica/evsci.c                              |    2 +-
 drivers/acpi/acpica/evxface.c                            |    2 +-
 drivers/acpi/acpica/evxfevnt.c                           |    2 +-
 drivers/acpi/acpica/evxfgpe.c                            |    2 +-
 drivers/acpi/acpica/evxfregn.c                           |    2 +-
 drivers/acpi/acpica/exconfig.c                           |    2 +-
 drivers/acpi/acpica/exconvrt.c                           |    2 +-
 drivers/acpi/acpica/excreate.c                           |    2 +-
 drivers/acpi/acpica/exdebug.c                            |    2 +-
 drivers/acpi/acpica/exdump.c                             |    2 +-
 drivers/acpi/acpica/exfield.c                            |    2 +-
 drivers/acpi/acpica/exfldio.c                            |    2 +-
 drivers/acpi/acpica/exmisc.c                             |    2 +-
 drivers/acpi/acpica/exmutex.c                            |    2 +-
 drivers/acpi/acpica/exnames.c                            |    2 +-
 drivers/acpi/acpica/exoparg1.c                           |    2 +-
 drivers/acpi/acpica/exoparg2.c                           |    2 +-
 drivers/acpi/acpica/exoparg3.c                           |    2 +-
 drivers/acpi/acpica/exoparg6.c                           |    2 +-
 drivers/acpi/acpica/exprep.c                             |    2 +-
 drivers/acpi/acpica/exregion.c                           |    2 +-
 drivers/acpi/acpica/exresnte.c                           |    2 +-
 drivers/acpi/acpica/exresolv.c                           |    2 +-
 drivers/acpi/acpica/exresop.c                            |    2 +-
 drivers/acpi/acpica/exstore.c                            |    2 +-
 drivers/acpi/acpica/exstoren.c                           |    2 +-
 drivers/acpi/acpica/exstorob.c                           |    2 +-
 drivers/acpi/acpica/exsystem.c                           |    2 +-
 drivers/acpi/acpica/exutils.c                            |    2 +-
 drivers/acpi/acpica/hwacpi.c                             |    2 +-
 drivers/acpi/acpica/hwesleep.c                           |    2 +-
 drivers/acpi/acpica/hwgpe.c                              |    2 +-
 drivers/acpi/acpica/hwpci.c                              |    2 +-
 drivers/acpi/acpica/hwregs.c                             |    2 +-
 drivers/acpi/acpica/hwsleep.c                            |    2 +-
 drivers/acpi/acpica/hwtimer.c                            |    2 +-
 drivers/acpi/acpica/hwvalid.c                            |    2 +-
 drivers/acpi/acpica/hwxface.c                            |    2 +-
 drivers/acpi/acpica/hwxfsleep.c                          |    2 +-
 drivers/acpi/acpica/nsaccess.c                           |    2 +-
 drivers/acpi/acpica/nsalloc.c                            |    2 +-
 drivers/acpi/acpica/nsarguments.c                        |    2 +-
 drivers/acpi/acpica/nsconvert.c                          |    2 +-
 drivers/acpi/acpica/nsdump.c                             |    2 +-
 drivers/acpi/acpica/nsdumpdv.c                           |    2 +-
 drivers/acpi/acpica/nseval.c                             |    2 +-
 drivers/acpi/acpica/nsinit.c                             |    2 +-
 drivers/acpi/acpica/nsload.c                             |    2 +-
 drivers/acpi/acpica/nsnames.c                            |    2 +-
 drivers/acpi/acpica/nsobject.c                           |    2 +-
 drivers/acpi/acpica/nsparse.c                            |    2 +-
 drivers/acpi/acpica/nspredef.c                           |    2 +-
 drivers/acpi/acpica/nsprepkg.c                           |    2 +-
 drivers/acpi/acpica/nsrepair.c                           |    2 +-
 drivers/acpi/acpica/nsrepair2.c                          |    2 +-
 drivers/acpi/acpica/nssearch.c                           |    2 +-
 drivers/acpi/acpica/nsutils.c                            |    2 +-
 drivers/acpi/acpica/nswalk.c                             |    2 +-
 drivers/acpi/acpica/nsxfeval.c                           |    2 +-
 drivers/acpi/acpica/nsxfname.c                           |    2 +-
 drivers/acpi/acpica/nsxfobj.c                            |    2 +-
 drivers/acpi/acpica/psargs.c                             |    2 +-
 drivers/acpi/acpica/psloop.c                             |    2 +-
 drivers/acpi/acpica/psobject.c                           |    2 +-
 drivers/acpi/acpica/psopcode.c                           |    2 +-
 drivers/acpi/acpica/psopinfo.c                           |    2 +-
 drivers/acpi/acpica/psparse.c                            |    2 +-
 drivers/acpi/acpica/psscope.c                            |    2 +-
 drivers/acpi/acpica/pstree.c                             |    2 +-
 drivers/acpi/acpica/psutils.c                            |    2 +-
 drivers/acpi/acpica/pswalk.c                             |    2 +-
 drivers/acpi/acpica/psxface.c                            |    2 +-
 drivers/acpi/acpica/rsaddr.c                             |    2 +-
 drivers/acpi/acpica/rscalc.c                             |    2 +-
 drivers/acpi/acpica/rscreate.c                           |    2 +-
 drivers/acpi/acpica/rsdump.c                             |    2 +-
 drivers/acpi/acpica/rsdumpinfo.c                         |    2 +-
 drivers/acpi/acpica/rsinfo.c                             |    2 +-
 drivers/acpi/acpica/rsio.c                               |    2 +-
 drivers/acpi/acpica/rsirq.c                              |    2 +-
 drivers/acpi/acpica/rslist.c                             |    2 +-
 drivers/acpi/acpica/rsmemory.c                           |    2 +-
 drivers/acpi/acpica/rsmisc.c                             |    2 +-
 drivers/acpi/acpica/rsserial.c                           |    2 +-
 drivers/acpi/acpica/rsutils.c                            |    2 +-
 drivers/acpi/acpica/rsxface.c                            |    2 +-
 drivers/acpi/acpica/tbdata.c                             |    2 +-
 drivers/acpi/acpica/tbfadt.c                             |    2 +-
 drivers/acpi/acpica/tbfind.c                             |    2 +-
 drivers/acpi/acpica/tbinstal.c                           |    2 +-
 drivers/acpi/acpica/tbprint.c                            |    2 +-
 drivers/acpi/acpica/tbutils.c                            |    2 +-
 drivers/acpi/acpica/tbxface.c                            |    2 +-
 drivers/acpi/acpica/tbxfload.c                           |    2 +-
 drivers/acpi/acpica/tbxfroot.c                           |    2 +-
 drivers/acpi/acpica/utaddress.c                          |    2 +-
 drivers/acpi/acpica/utalloc.c                            |    2 +-
 drivers/acpi/acpica/utbuffer.c                           |    2 +-
 drivers/acpi/acpica/utcache.c                            |    2 +-
 drivers/acpi/acpica/utcopy.c                             |    2 +-
 drivers/acpi/acpica/utdebug.c                            |    2 +-
 drivers/acpi/acpica/utdecode.c                           |    2 +-
 drivers/acpi/acpica/utdelete.c                           |    2 +-
 drivers/acpi/acpica/uterror.c                            |    2 +-
 drivers/acpi/acpica/uteval.c                             |    2 +-
 drivers/acpi/acpica/utexcep.c                            |    2 +-
 drivers/acpi/acpica/utfileio.c                           |    2 +-
 drivers/acpi/acpica/utglobal.c                           |    2 +-
 drivers/acpi/acpica/uthex.c                              |    2 +-
 drivers/acpi/acpica/utids.c                              |    2 +-
 drivers/acpi/acpica/utinit.c                             |    2 +-
 drivers/acpi/acpica/utlock.c                             |    2 +-
 drivers/acpi/acpica/utmath.c                             |    2 +-
 drivers/acpi/acpica/utmisc.c                             |    2 +-
 drivers/acpi/acpica/utmutex.c                            |    2 +-
 drivers/acpi/acpica/utobject.c                           |    2 +-
 drivers/acpi/acpica/utosi.c                              |    2 +-
 drivers/acpi/acpica/utownerid.c                          |    2 +-
 drivers/acpi/acpica/utpredef.c                           |    2 +-
 drivers/acpi/acpica/utprint.c                            |    2 +-
 drivers/acpi/acpica/utresrc.c                            |    2 +-
 drivers/acpi/acpica/utstate.c                            |    2 +-
 drivers/acpi/acpica/utstring.c                           |    2 +-
 drivers/acpi/acpica/uttrack.c                            |    2 +-
 drivers/acpi/acpica/utuuid.c                             |    2 +-
 drivers/acpi/acpica/utxface.c                            |    2 +-
 drivers/acpi/acpica/utxferror.c                          |    2 +-
 drivers/acpi/acpica/utxfinit.c                           |    2 +-
 drivers/acpi/acpica/utxfmutex.c                          |    2 +-
 include/acpi/acbuffer.h                                  |    2 +-
 include/acpi/acconfig.h                                  |    2 +-
 include/acpi/acexcep.h                                   |    2 +-
 include/acpi/acnames.h                                   |    2 +-
 include/acpi/acoutput.h                                  |    2 +-
 include/acpi/acpi.h                                      |    2 +-
 include/acpi/acpiosxf.h                                  |    2 +-
 include/acpi/acpixf.h                                    |    2 +-
 include/acpi/acrestyp.h                                  |    2 +-
 include/acpi/actbl.h                                     |    2 +-
 include/acpi/actbl1.h                                    |    2 +-
 include/acpi/actbl2.h                                    |    2 +-
 include/acpi/actbl3.h                                    |    2 +-
 include/acpi/actypes.h                                   |    2 +-
 include/acpi/platform/acenv.h                            |    2 +-
 include/acpi/platform/acenvex.h                          |    2 +-
 include/acpi/platform/acgcc.h                            |    2 +-
 include/acpi/platform/aclinux.h                          |    2 +-
 include/acpi/platform/aclinuxex.h                        |    2 +-
 tools/power/acpi/common/cmfsize.c                        |    2 +-
 tools/power/acpi/common/getopt.c                         |    2 +-
 tools/power/acpi/os_specific/service_layers/oslibcfs.c   |    2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c |    2 +-
 tools/power/acpi/os_specific/service_layers/osunixdir.c  |    2 +-
 tools/power/acpi/os_specific/service_layers/osunixmap.c  |    2 +-
 tools/power/acpi/os_specific/service_layers/osunixxf.c   |    2 +-
 tools/power/acpi/tools/acpidump/acpidump.h               |    2 +-
 tools/power/acpi/tools/acpidump/apdump.c                 |    2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                |    2 +-
 tools/power/acpi/tools/acpidump/apmain.c                 |    2 +-
 204 files changed, 205 insertions(+), 205 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 3d2c882..d863016 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -47,7 +47,7 @@
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
-#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2014 Intel Corporation"
+#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2015 Intel Corporation"
 
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_WIDTH          "-64"
diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 6f1c616..853aa2d 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 1d026ff..4169bb8 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index d3e2cc3..408f04b 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 38b94a1..228704b7 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 7f60582..a165d25 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index c318d3e..196a552 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index b01f71c..1886bde 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 680d23b..7add32e 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 4bceb11..cf607fe 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index ee1c040..952fbe0 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 8abb393..3e9720e 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index dda0e6a..a5f17de 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 6168b85..74a390c 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index bd3908d..a972d11 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 4b008e8..efc4c71 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index cf73461..d14b547 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 1afe46e..1c127a4 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 486d342..c2f03e8 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 5908cce..3a95068 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 3a0beeb..ee0cdd6 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 720b1cd..3e69897 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 8daf9de..39da9da 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index c576661..43b40de 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index aee5e45..bbe74bc 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 3c7f737..d72565a 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index b67522d..2e4c42b 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index a1e7e6b..8a7b07b 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 6c0759c..7724418 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 9f74795..e5ff89b 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index f7f5107..df54d46 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 15623da..843942f 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 2ac28d2..fcaa30c 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 9d6e2c1..43b3ea4 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 24f7d5e..89ac202 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index c7bffff..bf6873f 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 3393a73..b78dc7c 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index fccdfb2..836c79b 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index d0a6024..ce2a7cf 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index ebfd40d..7670508 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index b197812..c369b19 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 78ac293..74e8595 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 24ea342..f7c9dfe 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 8eb8575..9abace3 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 1b148a4..da32339 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 29630e3..0366703 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 61b0261..6d04ae9 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index bb8cbf5..df06a23 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index b836139..b8af53b 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 2d6f187..f21afba 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 7d29494..6e0df2b 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index c545386..89a976b 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 95d23da..aaeea48 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index 6fbfad47..e67d0ac 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 0f23c3f..7c213b6 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index b994845..c161dd9 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 1d1b27a..4947992 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 2207e62..b56fc9d 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index b49ea2a..472030f 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index dbb03b5..453b00c 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 1b8e941..7793068 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 2ede656..fcc618a 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 363767c..b813fed 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 29e9e99..c930edd 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 118e942..4c2836d 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index cd5288a..0fe188e2 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index ab06026..c7e3b92 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 3cde553..b6b7f3a 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 3af8de3..d2964af 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index daf49f7..a7eee24 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 04bd16c..3101607 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index fd11018..6fa3c8d 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index f7da641..0545065 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index d9d72df..3f4225e 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 1e66d96..e5c5949 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 858fdd6..e5599f6 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index b7fb00d..84bc550 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
index 6aade8e..c5214de 100644
--- a/drivers/acpi/acpica/hwpci.c
+++ b/drivers/acpi/acpica/hwpci.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index a4c34d2..3cf77af 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index d590693..7d21cae 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 76ab5c1..675c709 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 6b91912..2bd33fe 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 96d007df..5f97468 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 6921c7f..3b37676 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index f1249e3..24fa19a 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 607eb9e..e107f92 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index 80fcfc8..5d347a7 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index b55642c..1a8b39c 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 3d88ef4..80f097e 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 42d3710..7dc367e 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index e634a05..7bcc68f 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index a3fb7e4..4a85c45 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 7c9d018..bd6cd4a 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 7eee0a6..d293d97 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index a42ee9d..677bc93 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index e83cff3..c95a119 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 392910f..0eb5431 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 1b13b92..8b79958 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 7e417aa..151fcd9 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index b09e6be..c30672d 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index af1cc42..4a9d4a6 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 4a5e3f5..6ad0200 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 4758a1f..c68609a 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 4bd558b..b6030a2 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 8c6c11c..d66c326 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -6,7 +6,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 51a8329..7933835 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -6,7 +6,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 314d314..6d03877 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index b058e23..9043722 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index a688507..2f5ddd8 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 1755d2a..1af4a40 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 0d8d37f..e18e7c4 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 6d27b59..a555f7f 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 32d250f..9d669cc 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 0b64181..89984f3 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 3cd4880..960505a 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index 9cb07e1..ba5f691 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index e135aca..841a5ea 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 94a3a05..66d406e 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 6895567..cb739a6 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 049d9c2..15434e4 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index c3c56b5..1539394 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index 6ba7ad5..b29d9ec 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index 9d3f8a9..edecfc6 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsio.c b/drivers/acpi/acpica/rsio.c
index 19d6487..5adba01 100644
--- a/drivers/acpi/acpica/rsio.c
+++ b/drivers/acpi/acpica/rsio.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index 3461f7d..07cfa70 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 7729129..50d5be2 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index eab4483..c6b8086 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 41eea4b..1fe49d2 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 9e84072..4c8c6fe 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 897a5ce..ece3cd6 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 2952878..8e6276d 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index f499c10..6a14495 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 41519a9..7d24860 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index cb94770..0b879fc 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 755b90c..9bad45e 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index df3bb20..ef16c06 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 6b1ca99..6559a58 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 0f9dd80..60e94f8 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index ab5308b..aadb300 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 43a54af..eac52cf 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index a1acec9..1279f50 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index efac83c..61d8f6d 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 038ea88..242bd07 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 78fde0a..eacc5ee 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index ff601c0..c37ec50 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index e516254..57078e3 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 40e923e..988e23b 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index a3516de..71fce38 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
index 8e544d4..9ef80f2 100644
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 8fed148..6c738fa 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utexcep.c b/drivers/acpi/acpica/utexcep.c
index 0403dca..743a0ae 100644
--- a/drivers/acpi/acpica/utexcep.c
+++ b/drivers/acpi/acpica/utexcep.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utfileio.c b/drivers/acpi/acpica/utfileio.c
index 4e263a8..7e1168b 100644
--- a/drivers/acpi/acpica/utfileio.c
+++ b/drivers/acpi/acpica/utfileio.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 77ceac7..5e8df91 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index 9afa944..aa44827 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 4b12880..27431cf 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 77120ec..e402e07 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index dc6e965..089f78b 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index d44dee6..f9ff100 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 2e2bb14..56bbacd 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 82717ff..37b8b58 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index dfa9009b..7d83efe 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 685766f..574cd31 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index 36bec57..2959217 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index db30caf..29e4499 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 0ce3f5a..82ca914 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index bc1ff82..b3505db 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index 1cc97a7..8274cc1 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 6dc54b3..83b6c52 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 7d0ee96..130dd9f 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index 4dc3313..c6149a2 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 49c873c..0929187 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 88ef77f..306e785 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index b1fd688..083a768 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/acpi/acpica/utxfmutex.c b/drivers/acpi/acpica/utxfmutex.c
index 2a0f9e0..f2606af 100644
--- a/drivers/acpi/acpica/utxfmutex.c
+++ b/drivers/acpi/acpica/utxfmutex.c
@@ -5,7 +5,7 @@
  ******************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index d5ec6c8..6b040f4 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 5a0a3e5..03aacfb 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 8b06e4c..11c3a01 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 7461327..273de70 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 1baae6e..9318a87 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index a08e55a..b0bb30e 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 03b3e6d..0bc78df 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -7,7 +7,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 5dd21bc..f81e530 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 0b75e01..ebe2426 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index bee19d8..d4081fe 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 29e7937..b80b0e6 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ecff624..f06d75e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 5480cb2..440ca81 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 401705d..453cebb 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 5f8cc1f..ad74dc5 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 2b61238..71e5ec5 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 384875d..f54de0a 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 1ba7c19..74ba46c 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 568d4b8..acedc3f 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index f4b9533..eec6880 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 2f0f34a..5da129e 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/os_specific/service_layers/oslibcfs.c b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
index c13ff9c..b51e40a 100644
--- a/tools/power/acpi/os_specific/service_layers/oslibcfs.c
+++ b/tools/power/acpi/os_specific/service_layers/oslibcfs.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 0dc2485..92f1fd7 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index 733f9e4..e153fcb 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index 99b47b6..3853a73 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 7ccb073..6858c08 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index a2d37d6..84bdef0 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 24d32968..c736adf 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index d470046..8f2fe16 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 853b4da..d0ba653 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -5,7 +5,7 @@
  *****************************************************************************/
 
 /*
- * Copyright (C) 2000 - 2014, Intel Corp.
+ * Copyright (C) 2000 - 2015, Intel Corp.
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
-- 
1.7.10
