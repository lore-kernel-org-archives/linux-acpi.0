From: Joe Perches <joe@perches.com>
Subject: MAINTAINERS acpi file patterns?
Date: Tue, 21 Jul 2009 10:57:49 -0700
Message-ID: <1248199069.31365.260.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1947 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbZGUR6t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jul 2009 13:58:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len.

Should the ACPI file patterns be extended to include
any of these or any other additional patterns?

diff --git a/MAINTAINERS b/MAINTAINERS
index 5befb1c..fc13a0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -248,16 +248,19 @@ F:	drivers/platform/x86/acer-wmi.c
 ACPI
 P:	Len Brown
 M:	lenb@kernel.org
 L:	linux-acpi@vger.kernel.org
 W:	http://www.lesswatts.org/projects/acpi/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
 S:	Supported
+F:	Documentation/acpi/
+F:	arch/x86/kernel/acpi/
 F:	drivers/acpi/
 F:	drivers/pnp/pnpacpi/
+F:	include/acpi/
 F:	include/linux/acpi.h
 
 ACPI BATTERY DRIVERS
 P:	Alexey Starikovskiy
 M:	astarikovskiy@suse.de
 L:	linux-acpi@vger.kernel.org
 W:	http://www.lesswatts.org/projects/acpi/


