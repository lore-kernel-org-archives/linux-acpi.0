From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: acpi_cpu_freq_init warning...
Date: Tue, 06 May 2008 15:29:55 +0900
Message-ID: <87k5i8hrmk.fsf@duaron.myhome.or.jp>
References: <86802c440805051951u153ebc21p15f0d73904496217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760029AbYEFGah@vger.kernel.org>
In-Reply-To: <86802c440805051951u153ebc21p15f0d73904496217@mail.gmail.com>
	(Yinghai Lu's message of "Mon, 5 May 2008 19:51:49 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> calling  acpi_cpufreq_init+0x0/0x68()
> sysdev: class cpu: driver (ffffffff80da0110) has already been
> registered to a class, something is wrong, but will forge on!
> ------------[ cut here ]------------
> WARNING: at drivers/base/sys.c:183 sysdev_driver_register+0x82/0x150()
> Modules linked in:
> Pid: 1, comm: swapper Not tainted
> 2.6.26-rc1-sched-devel.git-x86-latest.git-00485-g253148c-dirty #333

I've seen this too. The following patch seems to work for me.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


[PATCH] Fix bogus warning in sysdev_driver_register()

	if ((drv->entry.next != drv->entry.prev) ||
	    (drv->entry.next != NULL)) {

warns list_empty(&drv->entry).

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/base/sys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/base/sys.c~fix-sys-bogus-warning drivers/base/sys.c
--- linux-2.6/drivers/base/sys.c~fix-sys-bogus-warning	2008-05-06 14:30:42.000000000 +0900
+++ linux-2.6-hirofumi/drivers/base/sys.c	2008-05-06 14:30:45.000000000 +0900
@@ -175,7 +175,7 @@ int sysdev_driver_register(struct sysdev
 	}
 
 	/* Check whether this driver has already been added to a class. */
-	if ((drv->entry.next != drv->entry.prev) ||
+	if ((drv->entry.next != drv->entry.prev) &&
 	    (drv->entry.next != NULL)) {
 		printk(KERN_WARNING "sysdev: class %s: driver (%p) has already"
 			" been registered to a class, something is wrong, but "
_
