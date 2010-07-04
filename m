From: malattia@linux.it
Subject: [patch 1/5] allow overriding only some of the CFLAGS
Date: Sun, 04 Jul 2010 13:43:33 +0900
Message-ID: <20100704044450.507083526@linux.it>
References: <20100704044332.573836359@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:45891
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0GDE4B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jul 2010 00:56:01 -0400
Content-Disposition: inline; filename=overridable_cflags.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <Robert.Moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 compiler/Makefile         |    6 +++++-
 tools/acpiexec/Makefile   |    6 +++++-
 tools/acpisrc/Makefile    |    5 ++++-
 tools/acpixtract/Makefile |    5 ++++-
 4 files changed, 18 insertions(+), 4 deletions(-)

Index: b/compiler/Makefile
===================================================================
--- a/compiler/Makefile	2010-07-02 21:42:26.849349488 +0900
+++ b/compiler/Makefile	2010-07-04 11:18:15.830519370 +0900
@@ -125,7 +125,8 @@
 	../osunixxf.c
 
 NOMAN=	YES
-CFLAGS+= -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../include -I../compiler
+MK_CFLAGS = -DACPI_ASL_COMPILER -I../include -I../compiler
+CFLAGS= -Wall -Wstrict-prototypes -O2
 
 #YACC=	yacc
 YACC=	bison
@@ -141,6 +142,9 @@
 
 LDLIBS = -lpthread -lrt
 
+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
+
 aslmain : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) \
 		$(LOADLIBES) $(LDLIBS) -o iasl
Index: b/tools/acpiexec/Makefile
===================================================================
--- a/tools/acpiexec/Makefile	2010-07-02 21:42:26.893349116 +0900
+++ b/tools/acpiexec/Makefile	2010-07-04 11:18:15.830519370 +0900
@@ -139,8 +139,12 @@
 	../../osunixxf.c
 
 
-CFLAGS+= -Wall -g -D_LINUX -DNDEBUG -D_CONSOLE -DACPI_EXEC_APP -D_MULTI_THREADED -Wstrict-prototypes -I../../include 
+MK_CFLAGS = -DNDEBUG -D_CONSOLE -DACPI_EXEC_APP -D_MULTI_THREADED \
+            -I../../include
+CFLAGS = -Wall -Wstrict-prototypes -O2 -g
 
+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
 
 acpiexec : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) -lrt -lpthread -o $(PROG)
Index: b/tools/acpisrc/Makefile
===================================================================
--- a/tools/acpisrc/Makefile	2010-07-02 21:42:26.877349353 +0900
+++ b/tools/acpisrc/Makefile	2010-07-04 11:18:15.838518967 +0900
@@ -4,8 +4,11 @@
 SRCS=	ascase.c asconvrt.c asfile.c asmain.c asremove.c astable.c \
         asutils.c osunixdir.c ../../common/getopt.c
 
-CFLAGS+= -Wall -O2 -D_LINUX -DACPI_APPLICATION -Wstrict-prototypes -I../../include 
+MK_CFLAGS= -DACPI_APPLICATION -I../../include
+CFLAGS= -Wall -Wstrict-prototypes -O2
 
+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
 
 aslmain : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) -o $(PROG)
Index: b/tools/acpixtract/Makefile
===================================================================
--- a/tools/acpixtract/Makefile	2010-07-02 21:42:26.861349031 +0900
+++ b/tools/acpixtract/Makefile	2010-07-04 11:18:15.838518967 +0900
@@ -3,8 +3,11 @@
 PROG=	acpixtract
 SRCS=	acpixtract.c
 
-CFLAGS+= -Wall -O2 -D_LINUX -DACPI_APPLICATION -Wstrict-prototypes -I../../include 
+MK_CFLAGS= -DACPI_APPLICATION -I../../include
+CFLAGS= -Wall -Wstrict-prototypes -O2
 
+%.o: %.c
+	$(CC) $(MK_CFLAGS) $(CFLAGS) -c -o $@ $<
 
 acpixtract : $(patsubst %.c,%.o, $(SRCS))
 	$(CC) $(LDFLAGS) $(patsubst %.c,%.o, $(SRCS)) -o $(PROG)

