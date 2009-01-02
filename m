From: Len Brown <lenb@kernel.org>
Subject: [incremental-PATCH-for-Sam's-Review] ACPI: use ccflags-y instead of
 EXTRA_CFLAGS
Date: Fri, 02 Jan 2009 16:44:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901021636050.3590@localhost.localdomain>
References: <1230720725-9376-1-git-send-email-lenb@kernel.org>
 <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
 <20081231133901.GB2388@uranus.ravnborg.org> <87bpusv31n.fsf@basil.nowhere.org>
 <20081231153441.GA3475@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:45713 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482AbZABVoS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2009 16:44:18 -0500
In-reply-to: <20081231153441.GA3475@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile       |   11 ++---------
 kernel/acpi/Makefile        |   11 ++---------
 kernel/acpi/acpica/Makefile |   12 ++----------
 3 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5f4096d..a4c0582 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -2,15 +2,8 @@
 # Makefile for the Linux ACPI Drivers
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
 # ACPI Device Drivers
diff --git a/kernel/acpi/Makefile b/kernel/acpi/Makefile
index 92a1f94..fd0927d 100644
--- a/kernel/acpi/Makefile
+++ b/kernel/acpi/Makefile
@@ -2,15 +2,8 @@
 # Makefile for the Linux/ACPI
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
 
 obj-y				:= tables.o
 obj-$(CONFIG_X86)		+= x86/
diff --git a/kernel/acpi/acpica/Makefile b/kernel/acpi/acpica/Makefile
index 8d4e018..bad8ad8 100644
--- a/kernel/acpi/acpica/Makefile
+++ b/kernel/acpi/acpica/Makefile
@@ -2,16 +2,8 @@
 # Makefile for ACPICA Core interpreter
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
-
+ccflags-y			:= -Os
+ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 obj-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
 	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o \
-- 
1.6.1.35.g3827

