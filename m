From: Len Brown <lenb@kernel.org>
Subject: [PATCH 93/94] ACPICA: create acpica/ directory
Date: Fri, 09 Jan 2009 04:27:35 -0500
Message-ID: <95b482a8d31116f3f5c2a5089569393234d06385.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbZAIJ2y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:54 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004Q66BU3AYC@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:43 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

also, delete sleep/ and delete ACPI_CFLAGS from Makefile

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile                          |   22 +++++-------
 drivers/acpi/acpica/Makefile                   |   44 ++++++++++++++++++++++++
 drivers/acpi/{dispatcher => acpica}/dsfield.c  |    0 
 drivers/acpi/{dispatcher => acpica}/dsinit.c   |    0 
 drivers/acpi/{dispatcher => acpica}/dsmethod.c |    0 
 drivers/acpi/{dispatcher => acpica}/dsmthdat.c |    0 
 drivers/acpi/{dispatcher => acpica}/dsobject.c |    0 
 drivers/acpi/{dispatcher => acpica}/dsopcode.c |    0 
 drivers/acpi/{dispatcher => acpica}/dsutils.c  |    0 
 drivers/acpi/{dispatcher => acpica}/dswexec.c  |    0 
 drivers/acpi/{dispatcher => acpica}/dswload.c  |    0 
 drivers/acpi/{dispatcher => acpica}/dswscope.c |    0 
 drivers/acpi/{dispatcher => acpica}/dswstate.c |    0 
 drivers/acpi/{events => acpica}/evevent.c      |    0 
 drivers/acpi/{events => acpica}/evgpe.c        |    0 
 drivers/acpi/{events => acpica}/evgpeblk.c     |    0 
 drivers/acpi/{events => acpica}/evmisc.c       |    0 
 drivers/acpi/{events => acpica}/evregion.c     |    0 
 drivers/acpi/{events => acpica}/evrgnini.c     |    0 
 drivers/acpi/{events => acpica}/evsci.c        |    0 
 drivers/acpi/{events => acpica}/evxface.c      |    0 
 drivers/acpi/{events => acpica}/evxfevnt.c     |    0 
 drivers/acpi/{events => acpica}/evxfregn.c     |    0 
 drivers/acpi/{executer => acpica}/exconfig.c   |    0 
 drivers/acpi/{executer => acpica}/exconvrt.c   |    0 
 drivers/acpi/{executer => acpica}/excreate.c   |    0 
 drivers/acpi/{executer => acpica}/exdump.c     |    0 
 drivers/acpi/{executer => acpica}/exfield.c    |    0 
 drivers/acpi/{executer => acpica}/exfldio.c    |    0 
 drivers/acpi/{executer => acpica}/exmisc.c     |    0 
 drivers/acpi/{executer => acpica}/exmutex.c    |    0 
 drivers/acpi/{executer => acpica}/exnames.c    |    0 
 drivers/acpi/{executer => acpica}/exoparg1.c   |    0 
 drivers/acpi/{executer => acpica}/exoparg2.c   |    0 
 drivers/acpi/{executer => acpica}/exoparg3.c   |    0 
 drivers/acpi/{executer => acpica}/exoparg6.c   |    0 
 drivers/acpi/{executer => acpica}/exprep.c     |    0 
 drivers/acpi/{executer => acpica}/exregion.c   |    0 
 drivers/acpi/{executer => acpica}/exresnte.c   |    0 
 drivers/acpi/{executer => acpica}/exresolv.c   |    0 
 drivers/acpi/{executer => acpica}/exresop.c    |    0 
 drivers/acpi/{executer => acpica}/exstore.c    |    0 
 drivers/acpi/{executer => acpica}/exstoren.c   |    0 
 drivers/acpi/{executer => acpica}/exstorob.c   |    0 
 drivers/acpi/{executer => acpica}/exsystem.c   |    0 
 drivers/acpi/{executer => acpica}/exutils.c    |    0 
 drivers/acpi/{hardware => acpica}/hwacpi.c     |    0 
 drivers/acpi/{hardware => acpica}/hwgpe.c      |    0 
 drivers/acpi/{hardware => acpica}/hwregs.c     |    0 
 drivers/acpi/{hardware => acpica}/hwsleep.c    |    0 
 drivers/acpi/{hardware => acpica}/hwtimer.c    |    0 
 drivers/acpi/{hardware => acpica}/hwxface.c    |    0 
 drivers/acpi/{namespace => acpica}/nsaccess.c  |    0 
 drivers/acpi/{namespace => acpica}/nsalloc.c   |    0 
 drivers/acpi/{namespace => acpica}/nsdump.c    |    0 
 drivers/acpi/{namespace => acpica}/nsdumpdv.c  |    0 
 drivers/acpi/{namespace => acpica}/nseval.c    |    0 
 drivers/acpi/{namespace => acpica}/nsinit.c    |    0 
 drivers/acpi/{namespace => acpica}/nsload.c    |    0 
 drivers/acpi/{namespace => acpica}/nsnames.c   |    0 
 drivers/acpi/{namespace => acpica}/nsobject.c  |    0 
 drivers/acpi/{namespace => acpica}/nsparse.c   |    0 
 drivers/acpi/{namespace => acpica}/nspredef.c  |    0 
 drivers/acpi/{namespace => acpica}/nssearch.c  |    0 
 drivers/acpi/{namespace => acpica}/nsutils.c   |    0 
 drivers/acpi/{namespace => acpica}/nswalk.c    |    0 
 drivers/acpi/{namespace => acpica}/nsxfeval.c  |    0 
 drivers/acpi/{namespace => acpica}/nsxfname.c  |    0 
 drivers/acpi/{namespace => acpica}/nsxfobj.c   |    0 
 drivers/acpi/{parser => acpica}/psargs.c       |    0 
 drivers/acpi/{parser => acpica}/psloop.c       |    0 
 drivers/acpi/{parser => acpica}/psopcode.c     |    0 
 drivers/acpi/{parser => acpica}/psparse.c      |    0 
 drivers/acpi/{parser => acpica}/psscope.c      |    0 
 drivers/acpi/{parser => acpica}/pstree.c       |    0 
 drivers/acpi/{parser => acpica}/psutils.c      |    0 
 drivers/acpi/{parser => acpica}/pswalk.c       |    0 
 drivers/acpi/{parser => acpica}/psxface.c      |    0 
 drivers/acpi/{resources => acpica}/rsaddr.c    |    0 
 drivers/acpi/{resources => acpica}/rscalc.c    |    0 
 drivers/acpi/{resources => acpica}/rscreate.c  |    0 
 drivers/acpi/{resources => acpica}/rsdump.c    |    0 
 drivers/acpi/{resources => acpica}/rsinfo.c    |    0 
 drivers/acpi/{resources => acpica}/rsio.c      |    0 
 drivers/acpi/{resources => acpica}/rsirq.c     |    0 
 drivers/acpi/{resources => acpica}/rslist.c    |    0 
 drivers/acpi/{resources => acpica}/rsmemory.c  |    0 
 drivers/acpi/{resources => acpica}/rsmisc.c    |    0 
 drivers/acpi/{resources => acpica}/rsutils.c   |    0 
 drivers/acpi/{resources => acpica}/rsxface.c   |    0 
 drivers/acpi/{tables => acpica}/tbfadt.c       |    0 
 drivers/acpi/{tables => acpica}/tbfind.c       |    0 
 drivers/acpi/{tables => acpica}/tbinstal.c     |    0 
 drivers/acpi/{tables => acpica}/tbutils.c      |    0 
 drivers/acpi/{tables => acpica}/tbxface.c      |    0 
 drivers/acpi/{tables => acpica}/tbxfroot.c     |    0 
 drivers/acpi/{utilities => acpica}/utalloc.c   |    0 
 drivers/acpi/{utilities => acpica}/utcopy.c    |    0 
 drivers/acpi/{utilities => acpica}/utdebug.c   |    0 
 drivers/acpi/{utilities => acpica}/utdelete.c  |    0 
 drivers/acpi/{utilities => acpica}/uteval.c    |    0 
 drivers/acpi/{utilities => acpica}/utglobal.c  |    0 
 drivers/acpi/{utilities => acpica}/utinit.c    |    0 
 drivers/acpi/{utilities => acpica}/utmath.c    |    0 
 drivers/acpi/{utilities => acpica}/utmisc.c    |    0 
 drivers/acpi/{utilities => acpica}/utmutex.c   |    0 
 drivers/acpi/{utilities => acpica}/utobject.c  |    0 
 drivers/acpi/{utilities => acpica}/utresrc.c   |    0 
 drivers/acpi/{utilities => acpica}/utstate.c   |    0 
 drivers/acpi/{utilities => acpica}/utxface.c   |    0 
 drivers/acpi/dispatcher/Makefile               |    9 -----
 drivers/acpi/events/Makefile                   |    9 -----
 drivers/acpi/executer/Makefile                 |   10 -----
 drivers/acpi/hardware/Makefile                 |    9 -----
 drivers/acpi/{sleep => }/main.c                |    0 
 drivers/acpi/namespace/Makefile                |   12 ------
 drivers/acpi/parser/Makefile                   |    8 ----
 drivers/acpi/{sleep => }/proc.c                |    0 
 drivers/acpi/resources/Makefile                |   10 -----
 drivers/acpi/{sleep => }/sleep.h               |    0 
 drivers/acpi/sleep/Makefile                    |    5 ---
 drivers/acpi/tables/Makefile                   |    7 ----
 drivers/acpi/utilities/Makefile                |    9 -----
 drivers/acpi/{sleep => }/wakeup.c              |    0 
 124 files changed, 53 insertions(+), 101 deletions(-)
 create mode 100644 drivers/acpi/acpica/Makefile
 rename drivers/acpi/{dispatcher => acpica}/dsfield.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dsinit.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dsmethod.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dsmthdat.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dsobject.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dsopcode.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dsutils.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dswexec.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dswload.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dswscope.c (100%)
 rename drivers/acpi/{dispatcher => acpica}/dswstate.c (100%)
 rename drivers/acpi/{events => acpica}/evevent.c (100%)
 rename drivers/acpi/{events => acpica}/evgpe.c (100%)
 rename drivers/acpi/{events => acpica}/evgpeblk.c (100%)
 rename drivers/acpi/{events => acpica}/evmisc.c (100%)
 rename drivers/acpi/{events => acpica}/evregion.c (100%)
 rename drivers/acpi/{events => acpica}/evrgnini.c (100%)
 rename drivers/acpi/{events => acpica}/evsci.c (100%)
 rename drivers/acpi/{events => acpica}/evxface.c (100%)
 rename drivers/acpi/{events => acpica}/evxfevnt.c (100%)
 rename drivers/acpi/{events => acpica}/evxfregn.c (100%)
 rename drivers/acpi/{executer => acpica}/exconfig.c (100%)
 rename drivers/acpi/{executer => acpica}/exconvrt.c (100%)
 rename drivers/acpi/{executer => acpica}/excreate.c (100%)
 rename drivers/acpi/{executer => acpica}/exdump.c (100%)
 rename drivers/acpi/{executer => acpica}/exfield.c (100%)
 rename drivers/acpi/{executer => acpica}/exfldio.c (100%)
 rename drivers/acpi/{executer => acpica}/exmisc.c (100%)
 rename drivers/acpi/{executer => acpica}/exmutex.c (100%)
 rename drivers/acpi/{executer => acpica}/exnames.c (100%)
 rename drivers/acpi/{executer => acpica}/exoparg1.c (100%)
 rename drivers/acpi/{executer => acpica}/exoparg2.c (100%)
 rename drivers/acpi/{executer => acpica}/exoparg3.c (100%)
 rename drivers/acpi/{executer => acpica}/exoparg6.c (100%)
 rename drivers/acpi/{executer => acpica}/exprep.c (100%)
 rename drivers/acpi/{executer => acpica}/exregion.c (100%)
 rename drivers/acpi/{executer => acpica}/exresnte.c (100%)
 rename drivers/acpi/{executer => acpica}/exresolv.c (100%)
 rename drivers/acpi/{executer => acpica}/exresop.c (100%)
 rename drivers/acpi/{executer => acpica}/exstore.c (100%)
 rename drivers/acpi/{executer => acpica}/exstoren.c (100%)
 rename drivers/acpi/{executer => acpica}/exstorob.c (100%)
 rename drivers/acpi/{executer => acpica}/exsystem.c (100%)
 rename drivers/acpi/{executer => acpica}/exutils.c (100%)
 rename drivers/acpi/{hardware => acpica}/hwacpi.c (100%)
 rename drivers/acpi/{hardware => acpica}/hwgpe.c (100%)
 rename drivers/acpi/{hardware => acpica}/hwregs.c (100%)
 rename drivers/acpi/{hardware => acpica}/hwsleep.c (100%)
 rename drivers/acpi/{hardware => acpica}/hwtimer.c (100%)
 rename drivers/acpi/{hardware => acpica}/hwxface.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsaccess.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsalloc.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsdump.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsdumpdv.c (100%)
 rename drivers/acpi/{namespace => acpica}/nseval.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsinit.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsload.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsnames.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsobject.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsparse.c (100%)
 rename drivers/acpi/{namespace => acpica}/nspredef.c (100%)
 rename drivers/acpi/{namespace => acpica}/nssearch.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsutils.c (100%)
 rename drivers/acpi/{namespace => acpica}/nswalk.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsxfeval.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsxfname.c (100%)
 rename drivers/acpi/{namespace => acpica}/nsxfobj.c (100%)
 rename drivers/acpi/{parser => acpica}/psargs.c (100%)
 rename drivers/acpi/{parser => acpica}/psloop.c (100%)
 rename drivers/acpi/{parser => acpica}/psopcode.c (100%)
 rename drivers/acpi/{parser => acpica}/psparse.c (100%)
 rename drivers/acpi/{parser => acpica}/psscope.c (100%)
 rename drivers/acpi/{parser => acpica}/pstree.c (100%)
 rename drivers/acpi/{parser => acpica}/psutils.c (100%)
 rename drivers/acpi/{parser => acpica}/pswalk.c (100%)
 rename drivers/acpi/{parser => acpica}/psxface.c (100%)
 rename drivers/acpi/{resources => acpica}/rsaddr.c (100%)
 rename drivers/acpi/{resources => acpica}/rscalc.c (100%)
 rename drivers/acpi/{resources => acpica}/rscreate.c (100%)
 rename drivers/acpi/{resources => acpica}/rsdump.c (100%)
 rename drivers/acpi/{resources => acpica}/rsinfo.c (100%)
 rename drivers/acpi/{resources => acpica}/rsio.c (100%)
 rename drivers/acpi/{resources => acpica}/rsirq.c (100%)
 rename drivers/acpi/{resources => acpica}/rslist.c (100%)
 rename drivers/acpi/{resources => acpica}/rsmemory.c (100%)
 rename drivers/acpi/{resources => acpica}/rsmisc.c (100%)
 rename drivers/acpi/{resources => acpica}/rsutils.c (100%)
 rename drivers/acpi/{resources => acpica}/rsxface.c (100%)
 rename drivers/acpi/{tables => acpica}/tbfadt.c (100%)
 rename drivers/acpi/{tables => acpica}/tbfind.c (100%)
 rename drivers/acpi/{tables => acpica}/tbinstal.c (100%)
 rename drivers/acpi/{tables => acpica}/tbutils.c (100%)
 rename drivers/acpi/{tables => acpica}/tbxface.c (100%)
 rename drivers/acpi/{tables => acpica}/tbxfroot.c (100%)
 rename drivers/acpi/{utilities => acpica}/utalloc.c (100%)
 rename drivers/acpi/{utilities => acpica}/utcopy.c (100%)
 rename drivers/acpi/{utilities => acpica}/utdebug.c (100%)
 rename drivers/acpi/{utilities => acpica}/utdelete.c (100%)
 rename drivers/acpi/{utilities => acpica}/uteval.c (100%)
 rename drivers/acpi/{utilities => acpica}/utglobal.c (100%)
 rename drivers/acpi/{utilities => acpica}/utinit.c (100%)
 rename drivers/acpi/{utilities => acpica}/utmath.c (100%)
 rename drivers/acpi/{utilities => acpica}/utmisc.c (100%)
 rename drivers/acpi/{utilities => acpica}/utmutex.c (100%)
 rename drivers/acpi/{utilities => acpica}/utobject.c (100%)
 rename drivers/acpi/{utilities => acpica}/utresrc.c (100%)
 rename drivers/acpi/{utilities => acpica}/utstate.c (100%)
 rename drivers/acpi/{utilities => acpica}/utxface.c (100%)
 delete mode 100644 drivers/acpi/dispatcher/Makefile
 delete mode 100644 drivers/acpi/events/Makefile
 delete mode 100644 drivers/acpi/executer/Makefile
 delete mode 100644 drivers/acpi/hardware/Makefile
 rename drivers/acpi/{sleep => }/main.c (100%)
 delete mode 100644 drivers/acpi/namespace/Makefile
 delete mode 100644 drivers/acpi/parser/Makefile
 rename drivers/acpi/{sleep => }/proc.c (100%)
 delete mode 100644 drivers/acpi/resources/Makefile
 rename drivers/acpi/{sleep => }/sleep.h (100%)
 delete mode 100644 drivers/acpi/sleep/Makefile
 delete mode 100644 drivers/acpi/tables/Makefile
 delete mode 100644 drivers/acpi/utilities/Makefile
 rename drivers/acpi/{sleep => }/wakeup.c (100%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3c0c933..5d23c13 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -2,15 +2,8 @@
 # Makefile for the Linux ACPI interpreter
 #
 
-export ACPI_CFLAGS
-
-ACPI_CFLAGS	:= -Os
-
-ifdef CONFIG_ACPI_DEBUG
-  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
-endif
-
-EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
+ccflags-y			:= -Os
+ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 #
 # ACPI Boot-Time Table Parsing
@@ -22,9 +15,13 @@ obj-$(CONFIG_X86)		+= blacklist.o
 # ACPI Core Subsystem (Interpreter)
 #
 obj-y				+= osl.o utils.o reboot.o\
-				   dispatcher/ events/ executer/ hardware/ \
-				   namespace/ parser/ resources/ tables/ \
-				   utilities/
+					acpica/
+
+# sleep related files
+obj-y				+= wakeup.o
+obj-y				+= main.o
+obj-$(CONFIG_ACPI_SLEEP)	+= proc.o
+
 
 #
 # ACPI Bus and Device Drivers
@@ -35,7 +32,6 @@ ifdef CONFIG_CPU_FREQ
 processor-objs	+= processor_perflib.o
 endif
 
-obj-y				+= sleep/
 obj-y				+= bus.o glue.o
 obj-y				+= scan.o
 # Keep EC driver first. Initialization of others depend on it.
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
new file mode 100644
index 0000000..3f23298
--- /dev/null
+++ b/drivers/acpi/acpica/Makefile
@@ -0,0 +1,44 @@
+#
+# Makefile for ACPICA Core interpreter
+#
+
+ccflags-y			:= -Os
+ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
+
+obj-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
+	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o \
+	 dsinit.o
+
+obj-y += evevent.o  evregion.o  evsci.o    evxfevnt.o \
+	 evmisc.o   evrgnini.o  evxface.o  evxfregn.o \
+	 evgpe.o    evgpeblk.o
+
+obj-y += exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
+	 exconvrt.o  exfldio.o  exoparg1.o  exprep.o    exresop.o   exsystem.o\
+	 excreate.o  exmisc.o   exoparg2.o  exregion.o  exstore.o   exutils.o \
+	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o
+
+obj-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o
+
+obj-$(ACPI_FUTURE_USAGE) += hwtimer.o
+
+obj-y += nsaccess.o  nsload.o    nssearch.o  nsxfeval.o \
+	 nsalloc.o   nseval.o    nsnames.o   nsutils.o   nsxfname.o \
+	 nsdump.o    nsinit.o    nsobject.o  nswalk.o    nsxfobj.o  \
+	 nsparse.o   nspredef.o
+
+obj-$(ACPI_FUTURE_USAGE) += nsdumpdv.o
+
+obj-y += psargs.o    psparse.o  psloop.o pstree.o   pswalk.o  \
+	 psopcode.o  psscope.o  psutils.o  psxface.o
+
+obj-y += rsaddr.o rscreate.o rsinfo.o rsio.o rslist.o rsmisc.o rsxface.o \
+	 rscalc.o  rsirq.o  rsmemory.o  rsutils.o
+
+obj-$(ACPI_FUTURE_USAGE) += rsdump.o
+
+obj-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
+
+obj-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
+		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
+		utstate.o utmutex.o utobject.o utresrc.o
diff --git a/drivers/acpi/dispatcher/dsfield.c b/drivers/acpi/acpica/dsfield.c
similarity index 100%
rename from drivers/acpi/dispatcher/dsfield.c
rename to drivers/acpi/acpica/dsfield.c
diff --git a/drivers/acpi/dispatcher/dsinit.c b/drivers/acpi/acpica/dsinit.c
similarity index 100%
rename from drivers/acpi/dispatcher/dsinit.c
rename to drivers/acpi/acpica/dsinit.c
diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
similarity index 100%
rename from drivers/acpi/dispatcher/dsmethod.c
rename to drivers/acpi/acpica/dsmethod.c
diff --git a/drivers/acpi/dispatcher/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
similarity index 100%
rename from drivers/acpi/dispatcher/dsmthdat.c
rename to drivers/acpi/acpica/dsmthdat.c
diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/acpica/dsobject.c
similarity index 100%
rename from drivers/acpi/dispatcher/dsobject.c
rename to drivers/acpi/acpica/dsobject.c
diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
similarity index 100%
rename from drivers/acpi/dispatcher/dsopcode.c
rename to drivers/acpi/acpica/dsopcode.c
diff --git a/drivers/acpi/dispatcher/dsutils.c b/drivers/acpi/acpica/dsutils.c
similarity index 100%
rename from drivers/acpi/dispatcher/dsutils.c
rename to drivers/acpi/acpica/dsutils.c
diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/acpica/dswexec.c
similarity index 100%
rename from drivers/acpi/dispatcher/dswexec.c
rename to drivers/acpi/acpica/dswexec.c
diff --git a/drivers/acpi/dispatcher/dswload.c b/drivers/acpi/acpica/dswload.c
similarity index 100%
rename from drivers/acpi/dispatcher/dswload.c
rename to drivers/acpi/acpica/dswload.c
diff --git a/drivers/acpi/dispatcher/dswscope.c b/drivers/acpi/acpica/dswscope.c
similarity index 100%
rename from drivers/acpi/dispatcher/dswscope.c
rename to drivers/acpi/acpica/dswscope.c
diff --git a/drivers/acpi/dispatcher/dswstate.c b/drivers/acpi/acpica/dswstate.c
similarity index 100%
rename from drivers/acpi/dispatcher/dswstate.c
rename to drivers/acpi/acpica/dswstate.c
diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/acpica/evevent.c
similarity index 100%
rename from drivers/acpi/events/evevent.c
rename to drivers/acpi/acpica/evevent.c
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/acpica/evgpe.c
similarity index 100%
rename from drivers/acpi/events/evgpe.c
rename to drivers/acpi/acpica/evgpe.c
diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
similarity index 100%
rename from drivers/acpi/events/evgpeblk.c
rename to drivers/acpi/acpica/evgpeblk.c
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/acpica/evmisc.c
similarity index 100%
rename from drivers/acpi/events/evmisc.c
rename to drivers/acpi/acpica/evmisc.c
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/acpica/evregion.c
similarity index 100%
rename from drivers/acpi/events/evregion.c
rename to drivers/acpi/acpica/evregion.c
diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
similarity index 100%
rename from drivers/acpi/events/evrgnini.c
rename to drivers/acpi/acpica/evrgnini.c
diff --git a/drivers/acpi/events/evsci.c b/drivers/acpi/acpica/evsci.c
similarity index 100%
rename from drivers/acpi/events/evsci.c
rename to drivers/acpi/acpica/evsci.c
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/acpica/evxface.c
similarity index 100%
rename from drivers/acpi/events/evxface.c
rename to drivers/acpi/acpica/evxface.c
diff --git a/drivers/acpi/events/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
similarity index 100%
rename from drivers/acpi/events/evxfevnt.c
rename to drivers/acpi/acpica/evxfevnt.c
diff --git a/drivers/acpi/events/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
similarity index 100%
rename from drivers/acpi/events/evxfregn.c
rename to drivers/acpi/acpica/evxfregn.c
diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/acpica/exconfig.c
similarity index 100%
rename from drivers/acpi/executer/exconfig.c
rename to drivers/acpi/acpica/exconfig.c
diff --git a/drivers/acpi/executer/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
similarity index 100%
rename from drivers/acpi/executer/exconvrt.c
rename to drivers/acpi/acpica/exconvrt.c
diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/acpica/excreate.c
similarity index 100%
rename from drivers/acpi/executer/excreate.c
rename to drivers/acpi/acpica/excreate.c
diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/acpica/exdump.c
similarity index 100%
rename from drivers/acpi/executer/exdump.c
rename to drivers/acpi/acpica/exdump.c
diff --git a/drivers/acpi/executer/exfield.c b/drivers/acpi/acpica/exfield.c
similarity index 100%
rename from drivers/acpi/executer/exfield.c
rename to drivers/acpi/acpica/exfield.c
diff --git a/drivers/acpi/executer/exfldio.c b/drivers/acpi/acpica/exfldio.c
similarity index 100%
rename from drivers/acpi/executer/exfldio.c
rename to drivers/acpi/acpica/exfldio.c
diff --git a/drivers/acpi/executer/exmisc.c b/drivers/acpi/acpica/exmisc.c
similarity index 100%
rename from drivers/acpi/executer/exmisc.c
rename to drivers/acpi/acpica/exmisc.c
diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/acpica/exmutex.c
similarity index 100%
rename from drivers/acpi/executer/exmutex.c
rename to drivers/acpi/acpica/exmutex.c
diff --git a/drivers/acpi/executer/exnames.c b/drivers/acpi/acpica/exnames.c
similarity index 100%
rename from drivers/acpi/executer/exnames.c
rename to drivers/acpi/acpica/exnames.c
diff --git a/drivers/acpi/executer/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
similarity index 100%
rename from drivers/acpi/executer/exoparg1.c
rename to drivers/acpi/acpica/exoparg1.c
diff --git a/drivers/acpi/executer/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
similarity index 100%
rename from drivers/acpi/executer/exoparg2.c
rename to drivers/acpi/acpica/exoparg2.c
diff --git a/drivers/acpi/executer/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
similarity index 100%
rename from drivers/acpi/executer/exoparg3.c
rename to drivers/acpi/acpica/exoparg3.c
diff --git a/drivers/acpi/executer/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
similarity index 100%
rename from drivers/acpi/executer/exoparg6.c
rename to drivers/acpi/acpica/exoparg6.c
diff --git a/drivers/acpi/executer/exprep.c b/drivers/acpi/acpica/exprep.c
similarity index 100%
rename from drivers/acpi/executer/exprep.c
rename to drivers/acpi/acpica/exprep.c
diff --git a/drivers/acpi/executer/exregion.c b/drivers/acpi/acpica/exregion.c
similarity index 100%
rename from drivers/acpi/executer/exregion.c
rename to drivers/acpi/acpica/exregion.c
diff --git a/drivers/acpi/executer/exresnte.c b/drivers/acpi/acpica/exresnte.c
similarity index 100%
rename from drivers/acpi/executer/exresnte.c
rename to drivers/acpi/acpica/exresnte.c
diff --git a/drivers/acpi/executer/exresolv.c b/drivers/acpi/acpica/exresolv.c
similarity index 100%
rename from drivers/acpi/executer/exresolv.c
rename to drivers/acpi/acpica/exresolv.c
diff --git a/drivers/acpi/executer/exresop.c b/drivers/acpi/acpica/exresop.c
similarity index 100%
rename from drivers/acpi/executer/exresop.c
rename to drivers/acpi/acpica/exresop.c
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/acpica/exstore.c
similarity index 100%
rename from drivers/acpi/executer/exstore.c
rename to drivers/acpi/acpica/exstore.c
diff --git a/drivers/acpi/executer/exstoren.c b/drivers/acpi/acpica/exstoren.c
similarity index 100%
rename from drivers/acpi/executer/exstoren.c
rename to drivers/acpi/acpica/exstoren.c
diff --git a/drivers/acpi/executer/exstorob.c b/drivers/acpi/acpica/exstorob.c
similarity index 100%
rename from drivers/acpi/executer/exstorob.c
rename to drivers/acpi/acpica/exstorob.c
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/acpica/exsystem.c
similarity index 100%
rename from drivers/acpi/executer/exsystem.c
rename to drivers/acpi/acpica/exsystem.c
diff --git a/drivers/acpi/executer/exutils.c b/drivers/acpi/acpica/exutils.c
similarity index 100%
rename from drivers/acpi/executer/exutils.c
rename to drivers/acpi/acpica/exutils.c
diff --git a/drivers/acpi/hardware/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
similarity index 100%
rename from drivers/acpi/hardware/hwacpi.c
rename to drivers/acpi/acpica/hwacpi.c
diff --git a/drivers/acpi/hardware/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
similarity index 100%
rename from drivers/acpi/hardware/hwgpe.c
rename to drivers/acpi/acpica/hwgpe.c
diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/acpica/hwregs.c
similarity index 100%
rename from drivers/acpi/hardware/hwregs.c
rename to drivers/acpi/acpica/hwregs.c
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
similarity index 100%
rename from drivers/acpi/hardware/hwsleep.c
rename to drivers/acpi/acpica/hwsleep.c
diff --git a/drivers/acpi/hardware/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
similarity index 100%
rename from drivers/acpi/hardware/hwtimer.c
rename to drivers/acpi/acpica/hwtimer.c
diff --git a/drivers/acpi/hardware/hwxface.c b/drivers/acpi/acpica/hwxface.c
similarity index 100%
rename from drivers/acpi/hardware/hwxface.c
rename to drivers/acpi/acpica/hwxface.c
diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
similarity index 100%
rename from drivers/acpi/namespace/nsaccess.c
rename to drivers/acpi/acpica/nsaccess.c
diff --git a/drivers/acpi/namespace/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
similarity index 100%
rename from drivers/acpi/namespace/nsalloc.c
rename to drivers/acpi/acpica/nsalloc.c
diff --git a/drivers/acpi/namespace/nsdump.c b/drivers/acpi/acpica/nsdump.c
similarity index 100%
rename from drivers/acpi/namespace/nsdump.c
rename to drivers/acpi/acpica/nsdump.c
diff --git a/drivers/acpi/namespace/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
similarity index 100%
rename from drivers/acpi/namespace/nsdumpdv.c
rename to drivers/acpi/acpica/nsdumpdv.c
diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/acpica/nseval.c
similarity index 100%
rename from drivers/acpi/namespace/nseval.c
rename to drivers/acpi/acpica/nseval.c
diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/acpica/nsinit.c
similarity index 100%
rename from drivers/acpi/namespace/nsinit.c
rename to drivers/acpi/acpica/nsinit.c
diff --git a/drivers/acpi/namespace/nsload.c b/drivers/acpi/acpica/nsload.c
similarity index 100%
rename from drivers/acpi/namespace/nsload.c
rename to drivers/acpi/acpica/nsload.c
diff --git a/drivers/acpi/namespace/nsnames.c b/drivers/acpi/acpica/nsnames.c
similarity index 100%
rename from drivers/acpi/namespace/nsnames.c
rename to drivers/acpi/acpica/nsnames.c
diff --git a/drivers/acpi/namespace/nsobject.c b/drivers/acpi/acpica/nsobject.c
similarity index 100%
rename from drivers/acpi/namespace/nsobject.c
rename to drivers/acpi/acpica/nsobject.c
diff --git a/drivers/acpi/namespace/nsparse.c b/drivers/acpi/acpica/nsparse.c
similarity index 100%
rename from drivers/acpi/namespace/nsparse.c
rename to drivers/acpi/acpica/nsparse.c
diff --git a/drivers/acpi/namespace/nspredef.c b/drivers/acpi/acpica/nspredef.c
similarity index 100%
rename from drivers/acpi/namespace/nspredef.c
rename to drivers/acpi/acpica/nspredef.c
diff --git a/drivers/acpi/namespace/nssearch.c b/drivers/acpi/acpica/nssearch.c
similarity index 100%
rename from drivers/acpi/namespace/nssearch.c
rename to drivers/acpi/acpica/nssearch.c
diff --git a/drivers/acpi/namespace/nsutils.c b/drivers/acpi/acpica/nsutils.c
similarity index 100%
rename from drivers/acpi/namespace/nsutils.c
rename to drivers/acpi/acpica/nsutils.c
diff --git a/drivers/acpi/namespace/nswalk.c b/drivers/acpi/acpica/nswalk.c
similarity index 100%
rename from drivers/acpi/namespace/nswalk.c
rename to drivers/acpi/acpica/nswalk.c
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
similarity index 100%
rename from drivers/acpi/namespace/nsxfeval.c
rename to drivers/acpi/acpica/nsxfeval.c
diff --git a/drivers/acpi/namespace/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
similarity index 100%
rename from drivers/acpi/namespace/nsxfname.c
rename to drivers/acpi/acpica/nsxfname.c
diff --git a/drivers/acpi/namespace/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
similarity index 100%
rename from drivers/acpi/namespace/nsxfobj.c
rename to drivers/acpi/acpica/nsxfobj.c
diff --git a/drivers/acpi/parser/psargs.c b/drivers/acpi/acpica/psargs.c
similarity index 100%
rename from drivers/acpi/parser/psargs.c
rename to drivers/acpi/acpica/psargs.c
diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/acpica/psloop.c
similarity index 100%
rename from drivers/acpi/parser/psloop.c
rename to drivers/acpi/acpica/psloop.c
diff --git a/drivers/acpi/parser/psopcode.c b/drivers/acpi/acpica/psopcode.c
similarity index 100%
rename from drivers/acpi/parser/psopcode.c
rename to drivers/acpi/acpica/psopcode.c
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/acpica/psparse.c
similarity index 100%
rename from drivers/acpi/parser/psparse.c
rename to drivers/acpi/acpica/psparse.c
diff --git a/drivers/acpi/parser/psscope.c b/drivers/acpi/acpica/psscope.c
similarity index 100%
rename from drivers/acpi/parser/psscope.c
rename to drivers/acpi/acpica/psscope.c
diff --git a/drivers/acpi/parser/pstree.c b/drivers/acpi/acpica/pstree.c
similarity index 100%
rename from drivers/acpi/parser/pstree.c
rename to drivers/acpi/acpica/pstree.c
diff --git a/drivers/acpi/parser/psutils.c b/drivers/acpi/acpica/psutils.c
similarity index 100%
rename from drivers/acpi/parser/psutils.c
rename to drivers/acpi/acpica/psutils.c
diff --git a/drivers/acpi/parser/pswalk.c b/drivers/acpi/acpica/pswalk.c
similarity index 100%
rename from drivers/acpi/parser/pswalk.c
rename to drivers/acpi/acpica/pswalk.c
diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/acpica/psxface.c
similarity index 100%
rename from drivers/acpi/parser/psxface.c
rename to drivers/acpi/acpica/psxface.c
diff --git a/drivers/acpi/resources/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
similarity index 100%
rename from drivers/acpi/resources/rsaddr.c
rename to drivers/acpi/acpica/rsaddr.c
diff --git a/drivers/acpi/resources/rscalc.c b/drivers/acpi/acpica/rscalc.c
similarity index 100%
rename from drivers/acpi/resources/rscalc.c
rename to drivers/acpi/acpica/rscalc.c
diff --git a/drivers/acpi/resources/rscreate.c b/drivers/acpi/acpica/rscreate.c
similarity index 100%
rename from drivers/acpi/resources/rscreate.c
rename to drivers/acpi/acpica/rscreate.c
diff --git a/drivers/acpi/resources/rsdump.c b/drivers/acpi/acpica/rsdump.c
similarity index 100%
rename from drivers/acpi/resources/rsdump.c
rename to drivers/acpi/acpica/rsdump.c
diff --git a/drivers/acpi/resources/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
similarity index 100%
rename from drivers/acpi/resources/rsinfo.c
rename to drivers/acpi/acpica/rsinfo.c
diff --git a/drivers/acpi/resources/rsio.c b/drivers/acpi/acpica/rsio.c
similarity index 100%
rename from drivers/acpi/resources/rsio.c
rename to drivers/acpi/acpica/rsio.c
diff --git a/drivers/acpi/resources/rsirq.c b/drivers/acpi/acpica/rsirq.c
similarity index 100%
rename from drivers/acpi/resources/rsirq.c
rename to drivers/acpi/acpica/rsirq.c
diff --git a/drivers/acpi/resources/rslist.c b/drivers/acpi/acpica/rslist.c
similarity index 100%
rename from drivers/acpi/resources/rslist.c
rename to drivers/acpi/acpica/rslist.c
diff --git a/drivers/acpi/resources/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
similarity index 100%
rename from drivers/acpi/resources/rsmemory.c
rename to drivers/acpi/acpica/rsmemory.c
diff --git a/drivers/acpi/resources/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
similarity index 100%
rename from drivers/acpi/resources/rsmisc.c
rename to drivers/acpi/acpica/rsmisc.c
diff --git a/drivers/acpi/resources/rsutils.c b/drivers/acpi/acpica/rsutils.c
similarity index 100%
rename from drivers/acpi/resources/rsutils.c
rename to drivers/acpi/acpica/rsutils.c
diff --git a/drivers/acpi/resources/rsxface.c b/drivers/acpi/acpica/rsxface.c
similarity index 100%
rename from drivers/acpi/resources/rsxface.c
rename to drivers/acpi/acpica/rsxface.c
diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
similarity index 100%
rename from drivers/acpi/tables/tbfadt.c
rename to drivers/acpi/acpica/tbfadt.c
diff --git a/drivers/acpi/tables/tbfind.c b/drivers/acpi/acpica/tbfind.c
similarity index 100%
rename from drivers/acpi/tables/tbfind.c
rename to drivers/acpi/acpica/tbfind.c
diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
similarity index 100%
rename from drivers/acpi/tables/tbinstal.c
rename to drivers/acpi/acpica/tbinstal.c
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/acpica/tbutils.c
similarity index 100%
rename from drivers/acpi/tables/tbutils.c
rename to drivers/acpi/acpica/tbutils.c
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/acpica/tbxface.c
similarity index 100%
rename from drivers/acpi/tables/tbxface.c
rename to drivers/acpi/acpica/tbxface.c
diff --git a/drivers/acpi/tables/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
similarity index 100%
rename from drivers/acpi/tables/tbxfroot.c
rename to drivers/acpi/acpica/tbxfroot.c
diff --git a/drivers/acpi/utilities/utalloc.c b/drivers/acpi/acpica/utalloc.c
similarity index 100%
rename from drivers/acpi/utilities/utalloc.c
rename to drivers/acpi/acpica/utalloc.c
diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/acpica/utcopy.c
similarity index 100%
rename from drivers/acpi/utilities/utcopy.c
rename to drivers/acpi/acpica/utcopy.c
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/acpica/utdebug.c
similarity index 100%
rename from drivers/acpi/utilities/utdebug.c
rename to drivers/acpi/acpica/utdebug.c
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/acpica/utdelete.c
similarity index 100%
rename from drivers/acpi/utilities/utdelete.c
rename to drivers/acpi/acpica/utdelete.c
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/acpica/uteval.c
similarity index 100%
rename from drivers/acpi/utilities/uteval.c
rename to drivers/acpi/acpica/uteval.c
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/acpica/utglobal.c
similarity index 100%
rename from drivers/acpi/utilities/utglobal.c
rename to drivers/acpi/acpica/utglobal.c
diff --git a/drivers/acpi/utilities/utinit.c b/drivers/acpi/acpica/utinit.c
similarity index 100%
rename from drivers/acpi/utilities/utinit.c
rename to drivers/acpi/acpica/utinit.c
diff --git a/drivers/acpi/utilities/utmath.c b/drivers/acpi/acpica/utmath.c
similarity index 100%
rename from drivers/acpi/utilities/utmath.c
rename to drivers/acpi/acpica/utmath.c
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/acpica/utmisc.c
similarity index 100%
rename from drivers/acpi/utilities/utmisc.c
rename to drivers/acpi/acpica/utmisc.c
diff --git a/drivers/acpi/utilities/utmutex.c b/drivers/acpi/acpica/utmutex.c
similarity index 100%
rename from drivers/acpi/utilities/utmutex.c
rename to drivers/acpi/acpica/utmutex.c
diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/acpica/utobject.c
similarity index 100%
rename from drivers/acpi/utilities/utobject.c
rename to drivers/acpi/acpica/utobject.c
diff --git a/drivers/acpi/utilities/utresrc.c b/drivers/acpi/acpica/utresrc.c
similarity index 100%
rename from drivers/acpi/utilities/utresrc.c
rename to drivers/acpi/acpica/utresrc.c
diff --git a/drivers/acpi/utilities/utstate.c b/drivers/acpi/acpica/utstate.c
similarity index 100%
rename from drivers/acpi/utilities/utstate.c
rename to drivers/acpi/acpica/utstate.c
diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/acpica/utxface.c
similarity index 100%
rename from drivers/acpi/utilities/utxface.c
rename to drivers/acpi/acpica/utxface.c
diff --git a/drivers/acpi/dispatcher/Makefile b/drivers/acpi/dispatcher/Makefile
deleted file mode 100644
index eb7e602..0000000
--- a/drivers/acpi/dispatcher/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
-	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o \
-	 dsinit.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/events/Makefile b/drivers/acpi/events/Makefile
deleted file mode 100644
index d29f2ee..0000000
--- a/drivers/acpi/events/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := evevent.o  evregion.o  evsci.o    evxfevnt.o \
-	 evmisc.o   evrgnini.o  evxface.o  evxfregn.o \
-	 evgpe.o    evgpeblk.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/executer/Makefile b/drivers/acpi/executer/Makefile
deleted file mode 100644
index e09998a..0000000
--- a/drivers/acpi/executer/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
-	 exconvrt.o  exfldio.o  exoparg1.o  exprep.o    exresop.o   exsystem.o\
-	 excreate.o  exmisc.o   exoparg2.o  exregion.o  exstore.o   exutils.o \
-	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/hardware/Makefile b/drivers/acpi/hardware/Makefile
deleted file mode 100644
index 238fbe5..0000000
--- a/drivers/acpi/hardware/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o
-
-obj-$(ACPI_FUTURE_USAGE) += hwtimer.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/main.c
similarity index 100%
rename from drivers/acpi/sleep/main.c
rename to drivers/acpi/main.c
diff --git a/drivers/acpi/namespace/Makefile b/drivers/acpi/namespace/Makefile
deleted file mode 100644
index 371a2da..0000000
--- a/drivers/acpi/namespace/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := nsaccess.o  nsload.o    nssearch.o  nsxfeval.o \
-	 nsalloc.o   nseval.o    nsnames.o   nsutils.o   nsxfname.o \
-	 nsdump.o    nsinit.o    nsobject.o  nswalk.o    nsxfobj.o  \
-	 nsparse.o   nspredef.o
-
-obj-$(ACPI_FUTURE_USAGE) += nsdumpdv.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/parser/Makefile b/drivers/acpi/parser/Makefile
deleted file mode 100644
index db24ee0..0000000
--- a/drivers/acpi/parser/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := psargs.o    psparse.o  psloop.o pstree.o   pswalk.o  \
-	 psopcode.o  psscope.o  psutils.o  psxface.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/proc.c
similarity index 100%
rename from drivers/acpi/sleep/proc.c
rename to drivers/acpi/proc.c
diff --git a/drivers/acpi/resources/Makefile b/drivers/acpi/resources/Makefile
deleted file mode 100644
index 8de4f69..0000000
--- a/drivers/acpi/resources/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := rsaddr.o rscreate.o rsinfo.o rsio.o rslist.o rsmisc.o rsxface.o \
-	 rscalc.o  rsirq.o  rsmemory.o  rsutils.o
-
-obj-$(ACPI_FUTURE_USAGE) += rsdump.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/sleep/sleep.h b/drivers/acpi/sleep.h
similarity index 100%
rename from drivers/acpi/sleep/sleep.h
rename to drivers/acpi/sleep.h
diff --git a/drivers/acpi/sleep/Makefile b/drivers/acpi/sleep/Makefile
deleted file mode 100644
index f1fb888..0000000
--- a/drivers/acpi/sleep/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y					:= wakeup.o
-obj-y					+= main.o
-obj-$(CONFIG_ACPI_SLEEP)		+= proc.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/tables/Makefile b/drivers/acpi/tables/Makefile
deleted file mode 100644
index 7385efa..0000000
--- a/drivers/acpi/tables/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/utilities/Makefile b/drivers/acpi/utilities/Makefile
deleted file mode 100644
index 66a71a5..0000000
--- a/drivers/acpi/utilities/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Makefile for all Linux ACPI interpreter subdirectories
-#
-
-obj-y := utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
-		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
-		utstate.o utmutex.o utobject.o utresrc.o
-
-EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/sleep/wakeup.c b/drivers/acpi/wakeup.c
similarity index 100%
rename from drivers/acpi/sleep/wakeup.c
rename to drivers/acpi/wakeup.c
-- 
1.5.6.6

