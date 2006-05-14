From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 15/16] acpi idle __read_mostly and de-init static var
Date: Sat, 13 May 2006 22:25:16 -0700
Message-ID: <20060513222516.7cf42113.akpm@osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F33D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:37528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751041AbWENF22 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 May 2006 01:28:28 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670F33D@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, andi@rhlx01.fht-esslingen.de, andi@lisas.de

"Brown, Len" <len.brown@intel.com> wrote:
>
> 
> >From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
> >
> >- make pm_idle_save, nocst and bm_history __read_mostly
> >- static first_run is initialized to 0 by default already
> 
> so far, so good.
> 
> >- don't remove static init value of nocst and bm_history
> >  since __read_mostly may be special
> >  (see e.g. 
> >http://www.ussg.iu.edu/hypermail/linux/kernel/0010.0/0771.html)
> 
> bm_history has a no-zero init value, so if that value
> were removed, the code wouldn't work as designed.
> 
> the comment appears backwards re: nocst, where the zero
> init value was actually removed.
> 
> So, I'm fine with the patch, but the description seems
> scrambled, and the URL above doesn't seem to un-scramble
> the relationship with __read_mostly vs initialization.
> 

Yes, the third entry in the changelog is all irrenevant and/or wrong.  I
deleted it all:



From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>

- make pm_idle_save, nocst and bm_history __read_mostly
- static first_run is initialized to 0 by default already

Signed-off-by: Andreas Mohr <andi@lisas.de>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-idle-__read_mostly-and-de-init-static-var drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-idle-__read_mostly-and-de-init-static-var	2006-05-13 22:24:06.000000000 -0700
+++ devel-akpm/drivers/acpi/processor_idle.c	2006-05-13 22:24:06.000000000 -0700
@@ -54,10 +54,10 @@ ACPI_MODULE_NAME("acpi_processor")
 #define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
 #define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 #define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
-static void (*pm_idle_save) (void);
+static void (*pm_idle_save) (void) __read_mostly;
 module_param(max_cstate, uint, 0644);
 
-static unsigned int nocst = 0;
+static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
 
 /*
@@ -67,7 +67,7 @@ module_param(nocst, uint, 0000);
  * 100 HZ: 0x0000000F: 4 jiffies = 40ms
  * reduce history for more aggressive entry into C3
  */
-static unsigned int bm_history =
+static unsigned int bm_history __read_mostly =
     (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
 module_param(bm_history, uint, 0644);
 /* --------------------------------------------------------------------------
@@ -1059,7 +1059,7 @@ int acpi_processor_power_init(struct acp
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
-	static int first_run = 0;
+	static int first_run;
 	struct proc_dir_entry *entry = NULL;
 	unsigned int i;
 
_

