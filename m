From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] drivers/cpuidle/governors/menu.c: make a struct static
Date: Wed, 13 Jun 2007 01:03:23 +0200
Message-ID: <20070612230323.GE3588@stusta.de>
References: <20070606220313.8f7c1fab.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33088 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754005AbXFLXDL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2007 19:03:11 -0400
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

This patch makes the needlessly global struct menu_governor static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.22-rc4-mm2/drivers/cpuidle/governors/menu.c.old	2007-06-13 00:25:03.000000000 +0200
+++ linux-2.6.22-rc4-mm2/drivers/cpuidle/governors/menu.c	2007-06-13 00:25:13.000000000 +0200
@@ -123,7 +123,7 @@
 	data->deepest_bm_state = i - 1;
 }
 
-struct cpuidle_governor menu_governor = {
+static struct cpuidle_governor menu_governor = {
 	.name =		"menu",
 	.scan =		menu_scan_device,
 	.select =	menu_select,

