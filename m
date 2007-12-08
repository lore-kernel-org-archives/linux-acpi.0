From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/9] Suspend: Fix comment in main.c
Date: Sat, 8 Dec 2007 02:06:00 +0100
Message-ID: <200712080206.01182.rjw@sisk.pl>
References: <200712080201.40661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38234 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbXLHAzs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 19:55:48 -0500
In-Reply-To: <200712080201.40661.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix a comment in kernel/power/main.c so that it doesn't contain lines
longer that 80 characters.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -242,8 +242,8 @@ static int suspend_enter(suspend_state_t
 }
 
 /**
- *	suspend_devices_and_enter - suspend devices and enter the desired system sleep
- *			  state.
+ *	suspend_devices_and_enter - suspend devices and enter the desired system
+ *				    sleep state.
  *	@state:		  state to enter
  */
 int suspend_devices_and_enter(suspend_state_t state)
