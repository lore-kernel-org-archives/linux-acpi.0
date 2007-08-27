From: Adrian Bunk <bunk@kernel.org>
Subject: [-mm patch] make "struct menu_governor" static (again)
Date: Mon, 27 Aug 2007 23:27:03 +0200
Message-ID: <20070827212703.GI4121@stusta.de>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765092AbXH0V1k@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070822020648.5ea3a612.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Adam Belay <abelay@novell.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 22, 2007 at 02:06:48AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.23-rc2-mm2:
>...
>  git-acpi.patch
>...
>  git trees
>...

"struct menu_governor" needlessly again became global.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
cb33b296204127cf50df54b84b2d79e152fb924b 
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index f5a8865..8d3fdc5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -117,7 +117,7 @@ static int menu_enable_device(struct cpuidle_device *dev)
 	return 0;
 }
 
-struct cpuidle_governor menu_governor = {
+static struct cpuidle_governor menu_governor = {
 	.name =		"menu",
 	.rating =	20,
 	.enable =	menu_enable_device,
