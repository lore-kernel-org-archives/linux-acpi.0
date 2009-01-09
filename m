From: Len Brown <lenb@kernel.org>
Subject: [PATCH 94/94] ACPICA: hide private headers
Date: Fri, 09 Jan 2009 04:27:36 -0500
Message-ID: <e2f7a7772880458edff1b1cc5a988947229fac26.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbZAIJ2w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:52 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700E3I6BUOYS2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:44 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 {include/acpi => drivers/acpi/acpica}/accommon.h |    0 
 {include/acpi => drivers/acpi/acpica}/acconfig.h |    0 
 {include/acpi => drivers/acpi/acpica}/acdebug.h  |    0 
 {include/acpi => drivers/acpi/acpica}/acdispat.h |    0 
 {include/acpi => drivers/acpi/acpica}/acevents.h |    0 
 {include/acpi => drivers/acpi/acpica}/acglobal.h |    0 
 {include/acpi => drivers/acpi/acpica}/achware.h  |    0 
 {include/acpi => drivers/acpi/acpica}/acinterp.h |    0 
 {include/acpi => drivers/acpi/acpica}/aclocal.h  |    0 
 {include/acpi => drivers/acpi/acpica}/acmacros.h |    0 
 {include/acpi => drivers/acpi/acpica}/acnamesp.h |    0 
 {include/acpi => drivers/acpi/acpica}/acobject.h |    0 
 {include/acpi => drivers/acpi/acpica}/acopcode.h |    0 
 {include/acpi => drivers/acpi/acpica}/acparser.h |    0 
 {include/acpi => drivers/acpi/acpica}/acpredef.h |    0 
 {include/acpi => drivers/acpi/acpica}/acresrc.h  |    0 
 {include/acpi => drivers/acpi/acpica}/acstruct.h |    0 
 {include/acpi => drivers/acpi/acpica}/actables.h |    0 
 {include/acpi => drivers/acpi/acpica}/acutils.h  |    0 
 {include/acpi => drivers/acpi/acpica}/amlcode.h  |    0 
 {include/acpi => drivers/acpi/acpica}/amlresrc.h |    0 
 drivers/acpi/acpica/dsfield.c                    |   12 ++++++------
 drivers/acpi/acpica/dsinit.c                     |    8 ++++----
 drivers/acpi/acpica/dsmethod.c                   |   10 +++++-----
 drivers/acpi/acpica/dsmthdat.c                   |    8 ++++----
 drivers/acpi/acpica/dsobject.c                   |   12 ++++++------
 drivers/acpi/acpica/dsopcode.c                   |   16 ++++++++--------
 drivers/acpi/acpica/dsutils.c                    |   14 +++++++-------
 drivers/acpi/acpica/dswexec.c                    |   14 +++++++-------
 drivers/acpi/acpica/dswload.c                    |   14 +++++++-------
 drivers/acpi/acpica/dswscope.c                   |    4 ++--
 drivers/acpi/acpica/dswstate.c                   |    8 ++++----
 drivers/acpi/acpica/evevent.c                    |    4 ++--
 drivers/acpi/acpica/evgpe.c                      |    6 +++---
 drivers/acpi/acpica/evgpeblk.c                   |    6 +++---
 drivers/acpi/acpica/evmisc.c                     |    8 ++++----
 drivers/acpi/acpica/evregion.c                   |    8 ++++----
 drivers/acpi/acpica/evrgnini.c                   |    6 +++---
 drivers/acpi/acpica/evsci.c                      |    4 ++--
 drivers/acpi/acpica/evxface.c                    |    8 ++++----
 drivers/acpi/acpica/evxfevnt.c                   |    8 ++++----
 drivers/acpi/acpica/evxfregn.c                   |    6 +++---
 drivers/acpi/acpica/exconfig.c                   |   10 +++++-----
 drivers/acpi/acpica/exconvrt.c                   |    6 +++---
 drivers/acpi/acpica/excreate.c                   |    8 ++++----
 drivers/acpi/acpica/exdump.c                     |    8 ++++----
 drivers/acpi/acpica/exfield.c                    |    6 +++---
 drivers/acpi/acpica/exfldio.c                    |   10 +++++-----
 drivers/acpi/acpica/exmisc.c                     |    8 ++++----
 drivers/acpi/acpica/exmutex.c                    |    6 +++---
 drivers/acpi/acpica/exnames.c                    |    6 +++---
 drivers/acpi/acpica/exoparg1.c                   |   12 ++++++------
 drivers/acpi/acpica/exoparg2.c                   |   10 +++++-----
 drivers/acpi/acpica/exoparg3.c                   |    8 ++++----
 drivers/acpi/acpica/exoparg6.c                   |    8 ++++----
 drivers/acpi/acpica/exprep.c                     |    8 ++++----
 drivers/acpi/acpica/exregion.c                   |    4 ++--
 drivers/acpi/acpica/exresnte.c                   |    8 ++++----
 drivers/acpi/acpica/exresolv.c                   |   10 +++++-----
 drivers/acpi/acpica/exresop.c                    |   10 +++++-----
 drivers/acpi/acpica/exstore.c                    |   10 +++++-----
 drivers/acpi/acpica/exstoren.c                   |    6 +++---
 drivers/acpi/acpica/exstorob.c                   |    4 ++--
 drivers/acpi/acpica/exsystem.c                   |    4 ++--
 drivers/acpi/acpica/exutils.c                    |    6 +++---
 drivers/acpi/acpica/hwacpi.c                     |    2 +-
 drivers/acpi/acpica/hwgpe.c                      |    4 ++--
 drivers/acpi/acpica/hwregs.c                     |    6 +++---
 drivers/acpi/acpica/hwsleep.c                    |    4 ++--
 drivers/acpi/acpica/hwtimer.c                    |    2 +-
 drivers/acpi/acpica/hwxface.c                    |    4 ++--
 drivers/acpi/acpica/nsaccess.c                   |    8 ++++----
 drivers/acpi/acpica/nsalloc.c                    |    4 ++--
 drivers/acpi/acpica/nsdump.c                     |    4 ++--
 drivers/acpi/acpica/nsdumpdv.c                   |    4 ++--
 drivers/acpi/acpica/nseval.c                     |    8 ++++----
 drivers/acpi/acpica/nsinit.c                     |    8 ++++----
 drivers/acpi/acpica/nsload.c                     |    8 ++++----
 drivers/acpi/acpica/nsnames.c                    |    6 +++---
 drivers/acpi/acpica/nsobject.c                   |    4 ++--
 drivers/acpi/acpica/nsparse.c                    |   10 +++++-----
 drivers/acpi/acpica/nspredef.c                   |    6 +++---
 drivers/acpi/acpica/nssearch.c                   |    4 ++--
 drivers/acpi/acpica/nsutils.c                    |    8 ++++----
 drivers/acpi/acpica/nswalk.c                     |    4 ++--
 drivers/acpi/acpica/nsxfeval.c                   |    6 +++---
 drivers/acpi/acpica/nsxfname.c                   |    4 ++--
 drivers/acpi/acpica/nsxfobj.c                    |    4 ++--
 drivers/acpi/acpica/psargs.c                     |   10 +++++-----
 drivers/acpi/acpica/psloop.c                     |    8 ++++----
 drivers/acpi/acpica/psopcode.c                   |    8 ++++----
 drivers/acpi/acpica/psparse.c                    |   12 ++++++------
 drivers/acpi/acpica/psscope.c                    |    4 ++--
 drivers/acpi/acpica/pstree.c                     |    6 +++---
 drivers/acpi/acpica/psutils.c                    |    6 +++---
 drivers/acpi/acpica/pswalk.c                     |    4 ++--
 drivers/acpi/acpica/psxface.c                    |   10 +++++-----
 drivers/acpi/acpica/rsaddr.c                     |    4 ++--
 drivers/acpi/acpica/rscalc.c                     |    6 +++---
 drivers/acpi/acpica/rscreate.c                   |    6 +++---
 drivers/acpi/acpica/rsdump.c                     |    4 ++--
 drivers/acpi/acpica/rsinfo.c                     |    4 ++--
 drivers/acpi/acpica/rsio.c                       |    4 ++--
 drivers/acpi/acpica/rsirq.c                      |    4 ++--
 drivers/acpi/acpica/rslist.c                     |    4 ++--
 drivers/acpi/acpica/rsmemory.c                   |    4 ++--
 drivers/acpi/acpica/rsmisc.c                     |    4 ++--
 drivers/acpi/acpica/rsutils.c                    |    6 +++---
 drivers/acpi/acpica/rsxface.c                    |    6 +++---
 drivers/acpi/acpica/tbfadt.c                     |    4 ++--
 drivers/acpi/acpica/tbfind.c                     |    4 ++--
 drivers/acpi/acpica/tbinstal.c                   |    6 +++---
 drivers/acpi/acpica/tbutils.c                    |    4 ++--
 drivers/acpi/acpica/tbxface.c                    |    6 +++---
 drivers/acpi/acpica/tbxfroot.c                   |    4 ++--
 drivers/acpi/acpica/utalloc.c                    |    4 ++--
 drivers/acpi/acpica/utcopy.c                     |    4 ++--
 drivers/acpi/acpica/utdebug.c                    |    2 +-
 drivers/acpi/acpica/utdelete.c                   |    8 ++++----
 drivers/acpi/acpica/uteval.c                     |    6 +++---
 drivers/acpi/acpica/utglobal.c                   |    4 ++--
 drivers/acpi/acpica/utinit.c                     |    8 ++++----
 drivers/acpi/acpica/utmath.c                     |    2 +-
 drivers/acpi/acpica/utmisc.c                     |    4 ++--
 drivers/acpi/acpica/utmutex.c                    |    2 +-
 drivers/acpi/acpica/utobject.c                   |    4 ++--
 drivers/acpi/acpica/utresrc.c                    |    4 ++--
 drivers/acpi/acpica/utstate.c                    |    2 +-
 drivers/acpi/acpica/utxface.c                    |   10 +++++-----
 129 files changed, 349 insertions(+), 349 deletions(-)
 rename {include/acpi => drivers/acpi/acpica}/accommon.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acconfig.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acdebug.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acdispat.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acevents.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acglobal.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/achware.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acinterp.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/aclocal.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acmacros.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acnamesp.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acobject.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acopcode.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acparser.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acpredef.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acresrc.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acstruct.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/actables.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/acutils.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/amlcode.h (100%)
 rename {include/acpi => drivers/acpi/acpica}/amlresrc.h (100%)

diff --git a/include/acpi/accommon.h b/drivers/acpi/acpica/accommon.h
similarity index 100%
rename from include/acpi/accommon.h
rename to drivers/acpi/acpica/accommon.h
diff --git a/include/acpi/acconfig.h b/drivers/acpi/acpica/acconfig.h
similarity index 100%
rename from include/acpi/acconfig.h
rename to drivers/acpi/acpica/acconfig.h
diff --git a/include/acpi/acdebug.h b/drivers/acpi/acpica/acdebug.h
similarity index 100%
rename from include/acpi/acdebug.h
rename to drivers/acpi/acpica/acdebug.h
diff --git a/include/acpi/acdispat.h b/drivers/acpi/acpica/acdispat.h
similarity index 100%
rename from include/acpi/acdispat.h
rename to drivers/acpi/acpica/acdispat.h
diff --git a/include/acpi/acevents.h b/drivers/acpi/acpica/acevents.h
similarity index 100%
rename from include/acpi/acevents.h
rename to drivers/acpi/acpica/acevents.h
diff --git a/include/acpi/acglobal.h b/drivers/acpi/acpica/acglobal.h
similarity index 100%
rename from include/acpi/acglobal.h
rename to drivers/acpi/acpica/acglobal.h
diff --git a/include/acpi/achware.h b/drivers/acpi/acpica/achware.h
similarity index 100%
rename from include/acpi/achware.h
rename to drivers/acpi/acpica/achware.h
diff --git a/include/acpi/acinterp.h b/drivers/acpi/acpica/acinterp.h
similarity index 100%
rename from include/acpi/acinterp.h
rename to drivers/acpi/acpica/acinterp.h
diff --git a/include/acpi/aclocal.h b/drivers/acpi/acpica/aclocal.h
similarity index 100%
rename from include/acpi/aclocal.h
rename to drivers/acpi/acpica/aclocal.h
diff --git a/include/acpi/acmacros.h b/drivers/acpi/acpica/acmacros.h
similarity index 100%
rename from include/acpi/acmacros.h
rename to drivers/acpi/acpica/acmacros.h
diff --git a/include/acpi/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
similarity index 100%
rename from include/acpi/acnamesp.h
rename to drivers/acpi/acpica/acnamesp.h
diff --git a/include/acpi/acobject.h b/drivers/acpi/acpica/acobject.h
similarity index 100%
rename from include/acpi/acobject.h
rename to drivers/acpi/acpica/acobject.h
diff --git a/include/acpi/acopcode.h b/drivers/acpi/acpica/acopcode.h
similarity index 100%
rename from include/acpi/acopcode.h
rename to drivers/acpi/acpica/acopcode.h
diff --git a/include/acpi/acparser.h b/drivers/acpi/acpica/acparser.h
similarity index 100%
rename from include/acpi/acparser.h
rename to drivers/acpi/acpica/acparser.h
diff --git a/include/acpi/acpredef.h b/drivers/acpi/acpica/acpredef.h
similarity index 100%
rename from include/acpi/acpredef.h
rename to drivers/acpi/acpica/acpredef.h
diff --git a/include/acpi/acresrc.h b/drivers/acpi/acpica/acresrc.h
similarity index 100%
rename from include/acpi/acresrc.h
rename to drivers/acpi/acpica/acresrc.h
diff --git a/include/acpi/acstruct.h b/drivers/acpi/acpica/acstruct.h
similarity index 100%
rename from include/acpi/acstruct.h
rename to drivers/acpi/acpica/acstruct.h
diff --git a/include/acpi/actables.h b/drivers/acpi/acpica/actables.h
similarity index 100%
rename from include/acpi/actables.h
rename to drivers/acpi/acpica/actables.h
diff --git a/include/acpi/acutils.h b/drivers/acpi/acpica/acutils.h
similarity index 100%
rename from include/acpi/acutils.h
rename to drivers/acpi/acpica/acutils.h
diff --git a/include/acpi/amlcode.h b/drivers/acpi/acpica/amlcode.h
similarity index 100%
rename from include/acpi/amlcode.h
rename to drivers/acpi/acpica/amlcode.h
diff --git a/include/acpi/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
similarity index 100%
rename from include/acpi/amlresrc.h
rename to drivers/acpi/acpica/amlresrc.h
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 5fbc240..53e27bc 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -42,12 +42,12 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "acparser.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsfield")
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 4f1cdd8..eb144b1 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acdispat.h>
-#include <acpi/acnamesp.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acdispat.h"
+#include "acnamesp.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsinit")
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 333c856..14b8b8e 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
 #ifdef	ACPI_DISASSEMBLER
 #include <acpi/acdisasm.h>
 #endif
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index a1a1199..da0f546 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acdispat.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acdispat.h"
+#include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsmthdat")
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 6e6c73c..15c628e 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -42,12 +42,12 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsobject")
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index cb8a0d3..0c3b4dd 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -43,14 +43,14 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "acevents.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsopcode")
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 9c88846..dabc23a 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -42,13 +42,13 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acdebug.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "acdebug.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsutils")
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 2482cbd..350e665 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -43,13 +43,13 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acdebug.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "acdebug.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dswexec")
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 2d71ced..3023cea 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -42,13 +42,13 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "acevents.h"
 
 #ifdef ACPI_ASL_COMPILER
 #include <acpi/acdisasm.h>
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 8030541..908645e 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acdispat.h>
+#include "accommon.h"
+#include "acdispat.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dswscope")
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index a7543c4..40f92bf 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acdispat.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acdispat.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dswstate")
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 86bf083..803edd9 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evevent")
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index d977960..f345ced 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evgpe")
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 2a8d185..484cc05 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evgpeblk")
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 16f2c1a..5f89305 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evmisc")
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 7346093..665c088 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evregion")
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 1b7f9fd..f3f1fb4 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evrgnini")
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 18dce10..567b356 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evsci")
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 3b6a069..3aca901 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acevents.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evxface")
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index f33cc30..35485e4 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
-#include <acpi/acnamesp.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acnamesp.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evxfevnt")
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index b863394..479e7a3 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -43,9 +43,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evxfregn")
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index be32d01..932bbc2 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
-#include <acpi/actables.h>
-#include <acpi/acdispat.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "actables.h"
+#include "acdispat.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exconfig")
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index caeead4..0be1018 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exconvrt")
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 5aa65a2..a57ad25 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("excreate")
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 8241b9e..aa31357 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exdump")
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 7b6df03..a352d02 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acdispat.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exfield")
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 33cd17a..ef58ac4 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
-#include <acpi/acevents.h>
-#include <acpi/acdispat.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
+#include "acevents.h"
+#include "acdispat.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exfldio")
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index e445463..6b0747a 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -43,10 +43,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
-#include <acpi/amlresrc.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
+#include "amlresrc.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exmisc")
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index f86bcee..d301c1f 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -43,9 +43,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exmutex")
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 12d3513..ffdae12 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -43,9 +43,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exnames")
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 52d78b8..b530480 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -43,12 +43,12 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "amlcode.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exoparg1")
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index b01980d..0b4f513 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acinterp.h>
-#include <acpi/acevents.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acinterp.h"
+#include "acevents.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exoparg2")
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 26dbd5c..c6520bb 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -43,10 +43,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "acparser.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exoparg3")
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index bbbba50..ae43f76 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -43,10 +43,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "acparser.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exoparg6")
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 8f2baa9..33c66eb 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -43,10 +43,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exprep")
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index ceb269e..76ec8ff 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exregion")
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 77df6e4..a063a74 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -43,10 +43,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exresnte")
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 42adde0..3673d2b 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -43,11 +43,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/amlcode.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exresolv")
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 7602eaf..3c38027 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -43,11 +43,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/amlcode.h>
-#include <acpi/acparser.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acparser.h"
+#include "acinterp.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exresop")
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 6f5647f..7c6d7e5 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -43,11 +43,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "amlcode.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exstore")
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index ad2047a..145d153 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -44,9 +44,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exstoren")
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index a48d580..67340cc 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exstorob")
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index a25b2c5..3d00b93 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exsystem")
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 0ecdb70..32b85d6 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -59,9 +59,9 @@
 #define DEFINE_AML_GLOBALS
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exutils")
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index c76e3cd..a9d4fea 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -43,7 +43,7 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
+#include "accommon.h"
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwacpi")
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 2b4a85a..2013b66 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwgpe")
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 4bc3bbb..4dc43b0 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -44,9 +44,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwregs")
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 54dd3ee..a2af2a4 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwsleep")
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index d1eac2a..b7f522c 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -43,7 +43,7 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
+#include "accommon.h"
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwtimer")
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index a4456fc..ae597c0 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwxface")
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 7954640..88303eb 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acdispat.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acnamesp.h"
+#include "acdispat.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsaccess")
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index cb2afbf..f976d84 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsalloc")
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 48f02e6..0da33c8 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsdump")
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index cc3df78..41994fe 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -42,7 +42,7 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
+#include "accommon.h"
 
 /* TBD: This entire module is apparently obsolete and should be removed */
 
@@ -50,7 +50,7 @@
 ACPI_MODULE_NAME("nsdumpdv")
 #ifdef ACPI_OBSOLETE_FUNCTIONS
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
-#include <acpi/acnamesp.h>
+#include "acnamesp.h"
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_one_device
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index a8d7764..0f3d5f9 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acinterp.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nseval")
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index fe470c4..13501cb 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acdispat.h"
+#include "acinterp.h"
 #include <linux/nmi.h>
 
 #define _COMPONENT          ACPI_NAMESPACE
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index a6e92b3..a0ba9e1 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acdispat.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acdispat.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsload")
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index b7e3018..ae3dc10 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsnames")
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index ca9edee..08a97a5 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsobject")
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index bcfcf42..b9e8d00 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
-#include <acpi/acdispat.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acparser.h"
+#include "acdispat.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsparse")
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 1e682d0..4527032 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -43,9 +43,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acpredef.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acpredef.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nspredef")
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index a76c731..6fea13f 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nssearch")
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index a443d28..3e1149b 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -43,10 +43,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/amlcode.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "amlcode.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsutils")
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 71b83e9..200895f 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nswalk")
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 598393a..22a7171 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -43,9 +43,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfeval")
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 7d5bfa9..9589fea 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfname")
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 80e6322..1c7efc1 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -43,8 +43,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfobj")
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 852f3a8..b161f35 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acdispat.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acnamesp.h"
+#include "acdispat.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psargs")
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index fd6648f..c5f6ce1 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -50,10 +50,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acdispat.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acdispat.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psloop")
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 3693a12..3bc3a60 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acopcode.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acopcode.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psopcode")
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 9da48fd..70838e9 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -51,12 +51,12 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acdispat.h>
-#include <acpi/amlcode.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acdispat.h"
+#include "amlcode.h"
+#include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psparse")
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index 22929ca..2feca5c 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
+#include "accommon.h"
+#include "acparser.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psscope")
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 8e73fbf..4d33891 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("pstree")
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index eec7d62..e636e07 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psutils")
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index dacc422..78b8b79 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
+#include "accommon.h"
+#include "acparser.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("pswalk")
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 98c31a8..ff06032 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acparser.h>
-#include <acpi/acdispat.h>
-#include <acpi/acinterp.h>
-#include <acpi/amlcode.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "amlcode.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psxface")
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index b4aba3a..1e437bf 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsaddr")
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 4f2b186..52865ee 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acresrc.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rscalc")
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 3ca6069..9eb3a2a 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acresrc.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rscreate")
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 936a59b..3f0ca5a 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsdump")
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index aac41cc..77b25fd 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsinfo")
diff --git a/drivers/acpi/acpica/rsio.c b/drivers/acpi/acpica/rsio.c
index d31129a..35a49aa 100644
--- a/drivers/acpi/acpica/rsio.c
+++ b/drivers/acpi/acpica/rsio.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsio")
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index 9a5a08d..2e02569 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsirq")
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 4833898..1b1dbc6 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rslist")
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index 5fd3746..ddc76ce 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsmemory")
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 2cd6e8c..5bc49a5 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsmisc")
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 7450105..bc03d59 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acresrc.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsutils")
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 0a27435..69a2aa5 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acresrc.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acresrc.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsxface")
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 87f22e6..3636e4f 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbfadt")
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 9d20cb6..1054dfd 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbfind")
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 019b0d8..37374b2 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbinstal")
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 4eb7189..3a8d8d2 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbutils")
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 1157966..c3e841f 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -43,9 +43,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbxface")
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 3495dca..b7fc8dd 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbxfroot")
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 2a017b2..7580f6b 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acdebug.h>
+#include "accommon.h"
+#include "acdebug.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utalloc")
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index e6f3002..b0dcfd3 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 
 #define _COMPONENT          ACPI_UTILITIES
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 9a3538c..38821f5 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -42,7 +42,7 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
+#include "accommon.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utdebug")
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 5b4e3b1..a0be9e3 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acinterp.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
+#include "accommon.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utdelete")
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index e1e438c..da9450b 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -42,9 +42,9 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acinterp.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("uteval")
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 3e28d8c..a3ab9d9 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -44,8 +44,8 @@
 #define DEFINE_ACPI_GLOBALS
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utglobal")
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 9316ec3..a54ca84 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -42,10 +42,10 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acevents.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acevents.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utinit")
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 616d7b2..c9f682d 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -42,7 +42,7 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
+#include "accommon.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utmath")
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 8f8b407..c1f7f4e 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -44,8 +44,8 @@
 #include <linux/module.h>
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utmisc")
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 7b48ba3..14eb52c 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -42,7 +42,7 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
+#include "accommon.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utmutex")
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 964b23c..4279ed3 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acnamesp.h>
+#include "accommon.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utobject")
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 0755c5c..91b7c00 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -42,8 +42,8 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/amlresrc.h>
+#include "accommon.h"
+#include "amlresrc.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utresrc")
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index 54c3461..0440c95 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -42,7 +42,7 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
+#include "accommon.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utstate")
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 5b27724..078a227 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -42,11 +42,11 @@
  */
 
 #include <acpi/acpi.h>
-#include <acpi/accommon.h>
-#include <acpi/acevents.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acdebug.h>
-#include <acpi/actables.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acnamesp.h"
+#include "acdebug.h"
+#include "actables.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utxface")
-- 
1.5.6.6

