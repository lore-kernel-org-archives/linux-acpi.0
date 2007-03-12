From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH] sony-laptop: MAINTAINERS fix entry, add L: and W:
Date: Mon, 12 Mar 2007 21:43:57 +0100
Message-ID: <20070312204357.GJ3071@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:45696 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbXCLUpS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Mar 2007 16:45:18 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Probably the wrong MAINTAINERS patch has been picked up (sorry for not
checking earlier), the following fix that and adds WWW and list contacts
for the Sony drivers.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---

Sorry for the inconvenience Len.

diff --git a/MAINTAINERS b/MAINTAINERS
index 17555bb..f3a79d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3066,11 +3066,10 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 
 SONY VAIO CONTROL DEVICE DRIVER
-P:	Stelian Pop
-M:	stelian@popies.net
 P:	Mattia Dongili
 M:	malattia@linux.it
-W:	http://popies.net/sonypi/
+L:	linux-acpi@vger.kernel.org
+W:	http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
 S:	Maintained
 
 SOUND
