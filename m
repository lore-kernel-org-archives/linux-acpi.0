From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix gcc 4 compilation in ACPI
Date: Mon, 10 Jan 2005 03:51:12 +0100
Message-ID: <20050110025112.GA5672@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262057AbVAJCv4@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Fix gcc 4 compilation in ACPI processor driver

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/acpi/processor.h
===================================================================
--- linux.orig/include/acpi/processor.h	2005-01-04 18:48:48.%N +0100
+++ linux/include/acpi/processor.h	2005-01-09 01:34:55.%N +0100
@@ -177,7 +177,6 @@
 /* for communication between multiple parts of the processor kernel module */
 extern struct acpi_processor	*processors[NR_CPUS];
 extern struct acpi_processor_errata errata;
-extern void (*pm_idle_save)(void);
 
 /* in processor_perflib.c */
 #ifdef CONFIG_CPU_FREQ
