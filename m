From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 15/16] acpi idle __read_mostly and de-init static var
Date: Sat, 13 May 2006 23:57:37 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F33D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2912 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964797AbWEND5m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 23:57:42 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, andi@rhlx01.fht-esslingen.de, andi@lisas.de


>From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
>
>- make pm_idle_save, nocst and bm_history __read_mostly
>- static first_run is initialized to 0 by default already

so far, so good.

>- don't remove static init value of nocst and bm_history
>  since __read_mostly may be special
>  (see e.g. 
>http://www.ussg.iu.edu/hypermail/linux/kernel/0010.0/0771.html)

bm_history has a no-zero init value, so if that value
were removed, the code wouldn't work as designed.

the comment appears backwards re: nocst, where the zero
init value was actually removed.

So, I'm fine with the patch, but the description seems
scrambled, and the URL above doesn't seem to un-scramble
the relationship with __read_mostly vs initialization.

-Len


>Signed-off-by: Andreas Mohr <andi@lisas.de>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/processor_idle.c |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
>
>diff -puN 
>drivers/acpi/processor_idle.c~acpi-idle-__read_mostly-and-de-in
>it-static-var drivers/acpi/processor_idle.c
>--- 
>devel/drivers/acpi/processor_idle.c~acpi-idle-__read_mostly-and
>-de-init-static-var	2006-04-18 23:18:01.000000000 -0700
>+++ devel-akpm/drivers/acpi/processor_idle.c	2006-04-18 
>23:18:01.000000000 -0700
>@@ -54,10 +54,10 @@ ACPI_MODULE_NAME("acpi_processor")
> #define US_TO_PM_TIMER_TICKS(t)		((t * 
>(PM_TIMER_FREQUENCY/1000)) / 1000)
> #define C2_OVERHEAD			4	/* 1us (3.579 
>ticks per us) */
> #define C3_OVERHEAD			4	/* 1us (3.579 
>ticks per us) */
>-static void (*pm_idle_save) (void);
>+static void (*pm_idle_save) (void) __read_mostly;
> module_param(max_cstate, uint, 0644);
> 
>-static unsigned int nocst = 0;
>+static unsigned int nocst __read_mostly;

dunno what the compiler does differently with __read_mostly,
but I agree this applied to this boot-time parameter.

> module_param(nocst, uint, 0000);
> 
> /*
>@@ -67,7 +67,7 @@ module_param(nocst, uint, 0000);
>  * 100 HZ: 0x0000000F: 4 jiffies = 40ms
>  * reduce history for more aggressive entry into C3
>  */
>-static unsigned int bm_history =
>+static unsigned int bm_history __read_mostly =
>     (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
> module_param(bm_history, uint, 0644);

same here -- we don't write to this except when
a user scribbles on the modules parameter.

> /* 
>---------------------------------------------------------------
>-----------
>@@ -1079,7 +1079,7 @@ int acpi_processor_power_init(struct acp
> 			      struct acpi_device *device)
> {
> 	acpi_status status = 0;
>-	static int first_run = 0;
>+	static int first_run;
> 	struct proc_dir_entry *entry = NULL;
> 	unsigned int i;
> 
>_
>
