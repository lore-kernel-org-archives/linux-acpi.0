From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM / Hibernate: Fix snapshot error code path
Date: Thu, 1 Jul 2010 23:59:24 +0200
Message-ID: <201007012359.25051.rjw@sisk.pl>
References: <201007012356.44690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42606 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758915Ab0GAWCR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:02:17 -0400
In-Reply-To: <201007012356.44690.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

There is an inconsistency between hibernation_platform_enter()
and hibernation_snapshot(), because the latter calls
hibernation_ops->end() after failing hibernation_ops->begin(), while
the former doesn't do that.  Make hibernation_snapshot() behave in
the same way as hibernation_platform_enter() in that respect.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/hibernate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/power/hibernate.c
===================================================================
--- linux-2.6.orig/kernel/power/hibernate.c
+++ linux-2.6/kernel/power/hibernate.c
@@ -330,7 +330,7 @@ int hibernation_snapshot(int platform_mo
 
 	error = platform_begin(platform_mode);
 	if (error)
-		return error;
+		goto Close;
 
 	/* Preallocate image memory before shutting down devices. */
 	error = hibernate_preallocate_memory();

