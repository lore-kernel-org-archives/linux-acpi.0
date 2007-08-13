From: joe@perches.com
Subject: [PATCH] [446/2many] MAINTAINERS - SONY VAIO CONTROL DEVICE DRIVER
Date: Sun, 12 Aug 2007 23:36:11 -0700
Message-ID: <46bffbdb.CiCc1bB4g9HMdx0f%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:1879 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967236AbXHMGg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 02:36:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org, malattia@linux.it, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 6175c77..ea4d9d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4241,6 +4241,8 @@ M:	malattia@linux.it
 L:	linux-acpi@vger.kernel.org
 W:	http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
 S:	Maintained
+F:	drivers/char/sonypi.c
+F:	drivers/misc/sony-laptop.c
 
 SOUND
 P:	Jaroslav Kysela
