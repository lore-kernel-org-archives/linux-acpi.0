From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] make drivers/acpi/bay.c:drive_bays static
Date: Fri, 17 Nov 2006 02:19:33 +0100
Message-ID: <20061117011933.GQ31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1424870AbWKQBUD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-acpi.patch
>...
>  git trees
>...

This patch makes the needlessly global "drive_bays" static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/acpi/bay.c.old	2006-11-16 23:03:28.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/acpi/bay.c	2006-11-16 23:03:38.000000000 +0100
@@ -70,7 +70,7 @@
 	struct proc_dir_entry *proc;
 };
 
-LIST_HEAD(drive_bays);
+static LIST_HEAD(drive_bays);
 
 static struct proc_dir_entry *acpi_bay_dir;
 
