From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] make drivers/acpi/osl.c:osi_linux static
Date: Wed, 13 Jun 2007 01:03:15 +0200
Message-ID: <20070612230315.GA3588@stusta.de>
References: <20070606220313.8f7c1fab.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33075 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753373AbXFLXDD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2007 19:03:03 -0400
Content-Disposition: inline
In-Reply-To: <20070606220313.8f7c1fab.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Jun 06, 2007 at 10:03:13PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.22-rc4-mm1:
> 
>  git-acpi.patch
>...
>  git trees
>...


This patch makes the needlessly global osi_linux static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.22-rc4-mm2/drivers/acpi/osl.c.old	2007-06-12 23:55:27.000000000 +0200
+++ linux-2.6.22-rc4-mm2/drivers/acpi/osl.c	2007-06-12 23:55:37.000000000 +0200
@@ -78,9 +78,9 @@
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
 #ifdef	OSI_LINUX_ENABLED
-int osi_linux = 1;	/* enable _OSI(Linux) by default */
+static int osi_linux = 1;	/* enable _OSI(Linux) by default */
 #else
-int osi_linux;		/* disable _OSI(Linux) by default */
+static int osi_linux;		/* disable _OSI(Linux) by default */
 #endif
 
 

