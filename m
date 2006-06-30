From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 10/10] add S1N WLED control
Date: Sat, 1 Jul 2006 01:14:40 +0200
Message-ID: <20060630231440.GL31642@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:25874 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S932233AbWF3XOo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 19:14:44 -0400
Content-Disposition: inline
In-Reply-To: <20060630225905.GB31642@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch switches back the display nodes for M6R and M6N -- this happened
a while ago when a patch was misapplied (only the in-tree version was
affected).

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-07-01 00:39:12.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2006-07-01 00:51:14.000000000 +0200
@@ -310,7 +310,8 @@
 	 .brightness_set = "SPLV",
 	 .brightness_get = "GPLV",
 	 .display_set = "SDSP",
-	 .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
+	 .display_get = "\\SSTE"},
+
 	{
 	 .name = "M6R",
 	 .mt_mled = "MLED",
@@ -320,7 +321,7 @@
 	 .brightness_set = "SPLV",
 	 .brightness_get = "GPLV",
 	 .display_set = "SDSP",
-	 .display_get = "\\SSTE"},
+	 .display_get = "\\_SB.PCI0.P0P1.VGA.GETD"},
 
 	{
 	 .name = "P30",
