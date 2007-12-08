From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/9] Hibernation: Remove unnecessary variable declaration
Date: Sat, 8 Dec 2007 02:07:40 +0100
Message-ID: <200712080207.40901.rjw@sisk.pl>
References: <200712080201.40661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38250 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbXLHAzy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 19:55:54 -0500
In-Reply-To: <200712080201.40661.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove the unnecessary extern declaration of resume_file[]
from kernel/power/swap.c .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/swap.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/kernel/power/swap.c
===================================================================
--- linux-2.6.orig/kernel/power/swap.c
+++ linux-2.6/kernel/power/swap.c
@@ -28,8 +28,6 @@
 
 #include "power.h"
 
-extern char resume_file[];
-
 #define SWSUSP_SIG	"S1SUSPEND"
 
 struct swsusp_header {

