From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/19] ACPICA: use acpi.* modparam namespace
Date: Sat, 16 May 2009 02:01:59 -0400
Message-ID: <51991763416251f259efbfe459c16f331f31d01f.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:28158 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZEPGCe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:34 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ0017H3FVNBAC@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:25 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Add acpi/acpica/*.c to the acpi.* modparam namespace
so that any modparams we stick into ACPICA do not
expose ACPICA filenames to users.

There are currently only two modparams in ACPICA,
just recently added for
http://bugzilla.kernel.org/show_bug.cgi?id=13041

With this change, they become

acpi.gts=1
acpi.bfs=1

rather than

hwsleep.gts=1
hwsleep.bfs=1

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/Makefile |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 17e5082..72ac28d 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -5,40 +5,43 @@
 ccflags-y			:= -Os
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
-obj-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
+# use acpi.o to put all files here into acpi.o modparam namespace
+obj-y	+= acpi.o
+
+acpi-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
 	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o \
 	 dsinit.o
 
-obj-y += evevent.o  evregion.o  evsci.o    evxfevnt.o \
+acpi-y += evevent.o  evregion.o  evsci.o    evxfevnt.o \
 	 evmisc.o   evrgnini.o  evxface.o  evxfregn.o \
 	 evgpe.o    evgpeblk.o
 
-obj-y += exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
+acpi-y += exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
 	 exconvrt.o  exfldio.o  exoparg1.o  exprep.o    exresop.o   exsystem.o\
 	 excreate.o  exmisc.o   exoparg2.o  exregion.o  exstore.o   exutils.o \
 	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o
 
-obj-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o hwvalid.o
+acpi-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o hwvalid.o
 
-obj-$(ACPI_FUTURE_USAGE) += hwtimer.o
+acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
-obj-y += nsaccess.o  nsload.o    nssearch.o  nsxfeval.o \
+acpi-y += nsaccess.o  nsload.o    nssearch.o  nsxfeval.o \
 	 nsalloc.o   nseval.o    nsnames.o   nsutils.o   nsxfname.o \
 	 nsdump.o    nsinit.o    nsobject.o  nswalk.o    nsxfobj.o  \
 	 nsparse.o   nspredef.o
 
-obj-$(ACPI_FUTURE_USAGE) += nsdumpdv.o
+acpi-$(ACPI_FUTURE_USAGE) += nsdumpdv.o
 
-obj-y += psargs.o    psparse.o  psloop.o pstree.o   pswalk.o  \
+acpi-y += psargs.o    psparse.o  psloop.o pstree.o   pswalk.o  \
 	 psopcode.o  psscope.o  psutils.o  psxface.o
 
-obj-y += rsaddr.o rscreate.o rsinfo.o rsio.o rslist.o rsmisc.o rsxface.o \
+acpi-y += rsaddr.o rscreate.o rsinfo.o rsio.o rslist.o rsmisc.o rsxface.o \
 	 rscalc.o  rsirq.o  rsmemory.o  rsutils.o
 
-obj-$(ACPI_FUTURE_USAGE) += rsdump.o
+acpi-$(ACPI_FUTURE_USAGE) += rsdump.o
 
-obj-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
+acpi-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 
-obj-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
+acpi-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
 		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
 		utstate.o utmutex.o utobject.o utresrc.o utlock.o
-- 
1.6.0.6

