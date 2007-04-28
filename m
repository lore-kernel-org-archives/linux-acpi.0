From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] make drivers/misc/thinkpad_acpi:fan_mutex static
Date: Sat, 28 Apr 2007 21:19:38 +0200
Message-ID: <20070428191938.GO3468@stusta.de>
References: <20070425225716.8e9b28ca.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37490 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756107AbXD1TT3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 15:19:29 -0400
Content-Disposition: inline
In-Reply-To: <20070425225716.8e9b28ca.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Apr 25, 2007 at 10:57:16PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.21-rc7-mm1:
>...
>  git-acpi.patch
>...
>  git trees
>...


This patch makes the needlessly global fan_mutex static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW: Prototypes for static versions and static variables in a header
     file are really wrong, but the mess is bigger than what I'm
     willing to clean up...

--- linux-2.6.21-rc7-mm2/drivers/misc/thinkpad_acpi.h.old	2007-04-27 00:55:58.000000000 +0200
+++ linux-2.6.21-rc7-mm2/drivers/misc/thinkpad_acpi.h	2007-04-28 01:32:54.000000000 +0200
@@ -382,7 +382,7 @@
 static u8 fan_control_desired_level;
 static int fan_watchdog_maxinterval;
 
-struct mutex fan_mutex;
+static struct mutex fan_mutex;
 
 static acpi_handle fans_handle, gfan_handle, sfan_handle;
 
