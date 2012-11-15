From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Fix build problem when CONFIG_ACPI or CONFIG_PM is not set
Date: Fri, 16 Nov 2012 00:18:03 +0100
Message-ID: <3296931.0HiN0R9H9b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:47177 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2KOXNj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2012 18:13:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 26F591E0110
	for <linux-acpi@vger.kernel.org>; Thu, 15 Nov 2012 23:54:27 +0100 (CET)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31503-06 for <linux-acpi@vger.kernel.org>;
 Thu, 15 Nov 2012 23:54:18 +0100 (CET)
Received: from vostro.rjw.lan (dqr158.neoplus.adsl.tpnet.pl [83.24.177.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 852301DFC9C
	for <linux-acpi@vger.kernel.org>; Thu, 15 Nov 2012 23:54:18 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit e5cc8ef (ACPI / PM: Provide ACPI PM callback routines for
subsystems) introduced a build problem occuring if CONFIG_ACPI is
unset or CONFIG_PM is unset and errno.h is not included before
acpi.h, because in that case ENODEV used in acpi.h is undefined.

Fix the issue by making acpi.h include errno.h.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the current linux-pm.git/acpi-dev-pm.

---
 include/linux/acpi.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -25,6 +25,7 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#include <linux/errno.h>
 #include <linux/ioport.h>	/* for struct resource */
 
 #ifdef	CONFIG_ACPI


