From: Al Stone <ahs3@redhat.com>
Subject: [PATCH] Update the ASLTS
Date: Fri, 27 Jan 2017 17:47:51 -0700
Message-ID: <554d3f99-5360-f36a-f1dd-25c0a3832c52@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33012 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdA1Ar7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2017 19:47:59 -0500
Received: by mail-qt0-f178.google.com with SMTP id v23so161658011qtb.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2017 16:47:53 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Al Stone <ahs3@redhat.com>

ASLTS: without the following patch, the test suite will build iasl and acpiexec
as it needs to, but it will not run the test because it cannot build and install
them.  However, the suite will not run because it is looking for the wrong
version string from iasl.  So, fix the grep for the string.

Signed-off-by: Al Stone <ahs3@redhat.com>


diff -Naur acpica-unix2-20170119.orig/tests/aslts/Makefile.def
acpica-unix2-20170119/tests/aslts/Makefile.def
--- acpica-unix2-20170119.orig/tests/aslts/Makefile.def	2017-01-27
17:36:03.736555369 -0700
+++ acpica-unix2-20170119/tests/aslts/Makefile.def	2017-01-27 17:36:46.171389519
-0700
@@ -123,7 +123,7 @@
 			if [ x$$base != xaslts ]; then \
 				echo "Bad base name of ASLTS Test Suite: <$$base> of <$$dd>"; exit 1; \
 			else \
-				x=`"$(ASL)" -va xxx | grep "Compiler version"`; \
+				x=`"$(ASL)" -va xxx | grep "Compiler/Disassembler version"`; \
 				echo "---- iASL version: $$x"; \
 				if [ -z "$$x" ]; then \
 					echo "Bad iASL 2: bad signon <$(ASL)>"; exit 1; \


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
