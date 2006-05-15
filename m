From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 04/16] acpi: ia64: wake on LAN fix
Date: Sun, 14 May 2006 23:22:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F4CE@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63776 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750807AbWEODW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 May 2006 23:22:57 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, takeuchi_satoru@jp.fujitsu.com, "Luck, Tony" <tony.luck@intel.com>, "Yu, Luming" <luming.yu@intel.com>

NAK.

Rather than littering the code with CONFIG_ACPI_SLEEP
and then building without it, CONFIG_ACPI should simply
always include what is now known as CONFIG_ACPI_SLEEP.

BTW. I believe Luming has done some work to enable
CONFIG_ACPI_SLEEP enabled on IA64.  When that hits the tree,
we should simply delete the build option.


-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>takeuchi_satoru@jp.fujitsu.com; Luck, Tony
>Subject: [patch 04/16] acpi: ia64: wake on LAN fix
>
>
>From: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
>
>Currently wakeup capability is available if and only if
>CONFIG_ACPI_SLEEP=y.  But S5 is not a sleep state.  This patch 
>makes ACPI
>subsystem to be able to wakeup from S5 state even if sleep mode is not
>supported.
>
>Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Cc: "Luck, Tony" <tony.luck@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/sleep/Makefile   |    3 +--
> drivers/acpi/sleep/poweroff.c |    1 +
> drivers/acpi/sleep/proc.c     |   16 ++++++++++++++++
> drivers/acpi/sleep/wakeup.c   |    2 ++
> 4 files changed, 20 insertions(+), 2 deletions(-)
>
>diff -puN 
>drivers/acpi/sleep/Makefile~acpi-ia64-wake-on-lan-fix 
>drivers/acpi/sleep/Makefile
>--- 
>devel/drivers/acpi/sleep/Makefile~acpi-ia64-wake-on-lan-fix	
>2006-04-10 23:16:20.000000000 -0700
>+++ devel-akpm/drivers/acpi/sleep/Makefile	2006-04-10 
>23:16:20.000000000 -0700
>@@ -1,5 +1,4 @@
>-obj-y					:= poweroff.o wakeup.o
>+obj-y					:= poweroff.o wakeup.o proc.o
> obj-$(CONFIG_ACPI_SLEEP)		+= main.o
>-obj-$(CONFIG_ACPI_SLEEP_PROC_FS)	+= proc.o
> 
> EXTRA_CFLAGS += $(ACPI_CFLAGS)
>diff -puN 
>drivers/acpi/sleep/poweroff.c~acpi-ia64-wake-on-lan-fix 
>drivers/acpi/sleep/poweroff.c
>--- 
>devel/drivers/acpi/sleep/poweroff.c~acpi-ia64-wake-on-lan-fix	
>2006-04-10 23:16:20.000000000 -0700
>+++ devel-akpm/drivers/acpi/sleep/poweroff.c	2006-04-10 
>23:16:20.000000000 -0700
>@@ -45,6 +45,7 @@ void acpi_power_off(void)
> 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have 
>already been called */
> 	printk("%s called\n", __FUNCTION__);
> 	local_irq_disable();
>+	acpi_enable_wakeup_device(ACPI_STATE_S5);
> 	/* Some SMP machines only can poweroff in boot CPU */
> 	acpi_enter_sleep_state(ACPI_STATE_S5);
> }
>diff -puN drivers/acpi/sleep/proc.c~acpi-ia64-wake-on-lan-fix 
>drivers/acpi/sleep/proc.c
>--- devel/drivers/acpi/sleep/proc.c~acpi-ia64-wake-on-lan-fix	
>2006-04-10 23:16:20.000000000 -0700
>+++ devel-akpm/drivers/acpi/sleep/proc.c	2006-04-10 
>23:16:20.000000000 -0700
>@@ -70,6 +70,7 @@ acpi_system_write_sleep(struct file *fil
> }
> #endif				/* 
>CONFIG_ACPI_SLEEP_PROC_SLEEP */
> 
>+#ifdef	CONFIG_ACPI_SLEEP
> static int acpi_system_alarm_seq_show(struct seq_file *seq, 
>void *offset)
> {
> 	u32 sec, min, hr;
>@@ -339,6 +340,7 @@ acpi_system_write_alarm(struct file *fil
>       end:
> 	return_VALUE(result ? result : count);
> }
>+#endif				/* CONFIG_ACPI_SLEEP */
> 
> extern struct list_head acpi_wakeup_device_list;
> extern spinlock_t acpi_device_lock;
>@@ -357,6 +359,10 @@ acpi_system_wakeup_device_seq_show(struc
> 
> 		if (!dev->wakeup.flags.valid)
> 			continue;
>+#ifndef CONFIG_ACPI_SLEEP
>+		if (dev->wakeup.sleep_state != ACPI_STATE_S5)
>+			continue;
>+#endif
> 		spin_unlock(&acpi_device_lock);
> 		seq_printf(seq, "%4s	%4d		%s%8s\n",
> 			   dev->pnp.bus_id,
>@@ -394,6 +400,10 @@ acpi_system_write_wakeup_device(struct f
> 		    container_of(node, struct acpi_device, wakeup_list);
> 		if (!dev->wakeup.flags.valid)
> 			continue;
>+#ifndef CONFIG_ACPI_SLEEP
>+		if (dev->wakeup.sleep_state != ACPI_STATE_S5)
>+			continue;
>+#endif
> 
> 		if (!strncmp(dev->pnp.bus_id, str, 4)) {
> 			dev->wakeup.state.enabled =
>@@ -452,6 +462,7 @@ static struct file_operations acpi_syste
> };
> #endif				/* 
>CONFIG_ACPI_SLEEP_PROC_SLEEP */
> 
>+#ifdef	CONFIG_ACPI_SLEEP
> static struct file_operations acpi_system_alarm_fops = {
> 	.open = acpi_system_alarm_open_fs,
> 	.read = seq_read,
>@@ -467,6 +478,7 @@ static u32 rtc_handler(void *context)
> 
> 	return ACPI_INTERRUPT_HANDLED;
> }
>+#endif				/* CONFIG_ACPI_SLEEP */
> 
> static int acpi_sleep_proc_init(void)
> {
>@@ -484,12 +496,14 @@ static int acpi_sleep_proc_init(void)
> 		entry->proc_fops = &acpi_system_sleep_fops;
> #endif
> 
>+#ifdef	CONFIG_ACPI_SLEEP
> 	/* 'alarm' [R/W] */
> 	entry =
> 	    create_proc_entry("alarm", S_IFREG | S_IRUGO | S_IWUSR,
> 			      acpi_root_dir);
> 	if (entry)
> 		entry->proc_fops = &acpi_system_alarm_fops;
>+#endif
> 
> 	/* 'wakeup device' [R/W] */
> 	entry =
>@@ -498,7 +512,9 @@ static int acpi_sleep_proc_init(void)
> 	if (entry)
> 		entry->proc_fops = &acpi_system_wakeup_device_fops;
> 
>+#ifdef	CONFIG_ACPI_SLEEP
> 	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, 
>rtc_handler, NULL);
>+#endif
> 	return 0;
> }
> 
>diff -puN 
>drivers/acpi/sleep/wakeup.c~acpi-ia64-wake-on-lan-fix 
>drivers/acpi/sleep/wakeup.c
>--- 
>devel/drivers/acpi/sleep/wakeup.c~acpi-ia64-wake-on-lan-fix	
>2006-04-10 23:16:20.000000000 -0700
>+++ devel-akpm/drivers/acpi/sleep/wakeup.c	2006-04-10 
>23:16:20.000000000 -0700
>@@ -48,6 +48,7 @@ void acpi_enable_wakeup_device_prep(u8 s
> 	}
> 	spin_unlock(&acpi_device_lock);
> }
>+#endif
> 
> /**
>  * acpi_enable_wakeup_device - enable wakeup devices
>@@ -100,6 +101,7 @@ void acpi_enable_wakeup_device(u8 sleep_
> 	spin_unlock(&acpi_device_lock);
> }
> 
>+#ifdef CONFIG_ACPI_SLEEP
> /**
>  * acpi_disable_wakeup_device - disable devices' wakeup capability
>  *	@sleep_state:	ACPI state
>_
>
