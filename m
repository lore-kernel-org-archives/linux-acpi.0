From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] acpi: fix acpi/video.h error and warning when PM is not
 enabled
Date: Tue, 16 Nov 2010 16:59:54 -0800
Message-ID: <20101116165954.f7d8540b.randy.dunlap@oracle.com>
References: <AANLkTimYevUOSxDm+nGq_ctPEFp_E2zJR7rNGvUi2fWY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:26190 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636Ab0KQBBZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2010 20:01:25 -0500
In-Reply-To: <AANLkTimYevUOSxDm+nGq_ctPEFp_E2zJR7rNGvUi2fWY@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

When CONFIG_PM is not enabled, acpi/video.h causes a build error.
Also fix a longstanding warning.

include/acpi/video.h:22: warning: 'struct acpi_device' declared inside parameter list
include/acpi/video.h:22: warning: its scope is only this definition or declaration, which is probably not what you want
include/acpi/video.h: In function 'acpi_video_get_edid':
include/acpi/video.h:24: error: 'ENODEV' undeclared (first use in this function)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/acpi/video.h |    4 ++++
 1 file changed, 4 insertions(+)

--- lnx-2637-rc2.orig/include/acpi/video.h
+++ lnx-2637-rc2/include/acpi/video.h
@@ -1,6 +1,10 @@
 #ifndef __ACPI_VIDEO_H
 #define __ACPI_VIDEO_H
 
+#include <linux/errno.h>
+
+struct acpi_device;
+
 #define ACPI_VIDEO_DISPLAY_CRT  1
 #define ACPI_VIDEO_DISPLAY_TV   2
 #define ACPI_VIDEO_DISPLAY_DVI  3
