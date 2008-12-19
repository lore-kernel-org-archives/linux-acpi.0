From: Len Brown <lenb@kernel.org>
Subject: Re: [patch]change a spinlock to mutex
Date: Fri, 19 Dec 2008 05:03:10 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812190500540.1988@localhost.localdomain>
References: <1228791139.13102.3.camel@sli10-desk.sh.intel.com>
 <alpine.LFD.2.00.0812152203120.16823@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64844 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbYLSKDQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 05:03:16 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KC400EW9BXCFIE0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 04:03:15 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.0812152203120.16823@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Shaohua,

This one failed b/c it put a mutex into the irqs_disabled
part of suspend:

...
CPU1 is down
Extended CMOS year: 2000
BUG: sleeping function called from invalid context at kernel/mutex.c:88
in_atomic(): 0, irqs_disabled(): 1, pid: 3872, name: bash
Pid: 3872, comm: bash Not tainted 2.6.28-rc9-09771-gbe5a7e4 #79
Call Trace:
 [<ffffffff8022c0e4>] __might_sleep+0xcf/0xd1
 [<ffffffff80584a34>] mutex_lock+0x1d/0x33
 [<ffffffff803b1f91>] acpi_enable_wakeup_device+0x19/0x9e
 [<ffffffff803b253b>] acpi_suspend_enter+0x37/0xd2
 [<ffffffff8025bedd>] suspend_devices_and_enter+0x120/0x1b3
 [<ffffffff8025c199>] enter_state+0x200/0x290
 [<ffffffff8025c2e0>] state_store+0xb7/0xd8
 [<ffffffff80371b9b>] kobj_attr_store+0x17/0x19
 [<ffffffff802d8c75>] sysfs_write_file+0xdf/0x114
 [<ffffffff8029518d>] vfs_write+0xae/0x137
 [<ffffffff802952da>] sys_write+0x47/0x70
 [<ffffffff8020b3db>] system_call_fastpath+0x16/0x1b
Back to C!

-- Len Brown, Intel Open Source Technology Center


> On Tue, 9 Dec 2008, Shaohua Li wrote:
> 
> > Change acpi_device_lock to a mutex to avoid race in wakeup device
> > read/write. Found by Linus.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
> >  drivers/acpi/scan.c         |   14 +++++++-------
> >  drivers/acpi/sleep/proc.c   |   13 ++++---------
> >  drivers/acpi/sleep/sleep.h  |    3 +++
> >  drivers/acpi/sleep/wakeup.c |   31 ++++++++-----------------------
> >  4 files changed, 22 insertions(+), 39 deletions(-)
> > 
> > Index: linux/drivers/acpi/scan.c
> > ===================================================================
> > --- linux.orig/drivers/acpi/scan.c	2008-12-09 10:34:00.000000000 +0800
> > +++ linux/drivers/acpi/scan.c	2008-12-09 10:36:07.000000000 +0800
> > @@ -23,7 +23,7 @@ extern struct acpi_device *acpi_root;
> >  
> >  static LIST_HEAD(acpi_device_list);
> >  static LIST_HEAD(acpi_bus_id_list);
> > -DEFINE_SPINLOCK(acpi_device_lock);
> > +DEFINE_MUTEX(acpi_device_lock);
> >  LIST_HEAD(acpi_wakeup_device_list);
> >  
> >  struct acpi_device_bus_id{
> > @@ -440,7 +440,7 @@ static int acpi_device_register(struct a
> >  		return -ENOMEM;
> >  	}
> >  
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	/*
> >  	 * Find suitable bus_id and instance number in acpi_bus_id_list
> >  	 * If failed, create one and link it into acpi_bus_id_list
> > @@ -468,7 +468,7 @@ static int acpi_device_register(struct a
> >  		list_add_tail(&device->g_list, &acpi_device_list);
> >  	if (device->wakeup.flags.valid)
> >  		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  
> >  	if (device->parent)
> >  		device->dev.parent = &parent->dev;
> > @@ -489,20 +489,20 @@ static int acpi_device_register(struct a
> >  	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
> >  	return 0;
> >    end:
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	if (device->parent) {
> >  		list_del(&device->node);
> >  		list_del(&device->g_list);
> >  	} else
> >  		list_del(&device->g_list);
> >  	list_del(&device->wakeup_list);
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  	return result;
> >  }
> >  
> >  static void acpi_device_unregister(struct acpi_device *device, int type)
> >  {
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	if (device->parent) {
> >  		list_del(&device->node);
> >  		list_del(&device->g_list);
> > @@ -510,7 +510,7 @@ static void acpi_device_unregister(struc
> >  		list_del(&device->g_list);
> >  
> >  	list_del(&device->wakeup_list);
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  
> >  	acpi_detach_data(device->handle, acpi_bus_data_handler);
> >  
> > Index: linux/drivers/acpi/sleep/proc.c
> > ===================================================================
> > --- linux.orig/drivers/acpi/sleep/proc.c	2008-12-09 10:34:18.000000000 +0800
> > +++ linux/drivers/acpi/sleep/proc.c	2008-12-09 10:40:10.000000000 +0800
> > @@ -338,9 +338,6 @@ acpi_system_write_alarm(struct file *fil
> >  }
> >  #endif				/* HAVE_ACPI_LEGACY_ALARM */
> >  
> > -extern struct list_head acpi_wakeup_device_list;
> > -extern spinlock_t acpi_device_lock;
> > -
> >  static int
> >  acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
> >  {
> > @@ -348,7 +345,7 @@ acpi_system_wakeup_device_seq_show(struc
> >  
> >  	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
> >  
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev =
> >  		    container_of(node, struct acpi_device, wakeup_list);
> > @@ -356,7 +353,6 @@ acpi_system_wakeup_device_seq_show(struc
> >  
> >  		if (!dev->wakeup.flags.valid)
> >  			continue;
> > -		spin_unlock(&acpi_device_lock);
> >  
> >  		ldev = acpi_get_physical_device(dev->handle);
> >  		seq_printf(seq, "%s\t  S%d\t%c%-8s  ",
> > @@ -371,9 +367,8 @@ acpi_system_wakeup_device_seq_show(struc
> >  		seq_printf(seq, "\n");
> >  		put_device(ldev);
> >  
> > -		spin_lock(&acpi_device_lock);
> >  	}
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  	return 0;
> >  }
> >  
> > @@ -404,7 +399,7 @@ acpi_system_write_wakeup_device(struct f
> >  	strbuf[len] = '\0';
> >  	sscanf(strbuf, "%s", str);
> >  
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev =
> >  		    container_of(node, struct acpi_device, wakeup_list);
> > @@ -441,7 +436,7 @@ acpi_system_write_wakeup_device(struct f
> >  			}
> >  		}
> >  	}
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  	return count;
> >  }
> >  
> > Index: linux/drivers/acpi/sleep/sleep.h
> > ===================================================================
> > --- linux.orig/drivers/acpi/sleep/sleep.h	2008-12-09 10:37:22.000000000 +0800
> > +++ linux/drivers/acpi/sleep/sleep.h	2008-12-09 10:37:50.000000000 +0800
> > @@ -5,3 +5,6 @@ extern int acpi_suspend (u32 state);
> >  extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
> >  extern void acpi_enable_wakeup_device(u8 sleep_state);
> >  extern void acpi_disable_wakeup_device(u8 sleep_state);
> > +
> > +extern struct list_head acpi_wakeup_device_list;
> > +extern struct mutex acpi_device_lock;
> > Index: linux/drivers/acpi/sleep/wakeup.c
> > ===================================================================
> > --- linux.orig/drivers/acpi/sleep/wakeup.c	2008-12-09 10:34:08.000000000 +0800
> > +++ linux/drivers/acpi/sleep/wakeup.c	2008-12-09 10:39:18.000000000 +0800
> > @@ -14,9 +14,6 @@
> >  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
> >  ACPI_MODULE_NAME("wakeup_devices")
> >  
> > -extern struct list_head acpi_wakeup_device_list;
> > -extern spinlock_t acpi_device_lock;
> > -
> >  /**
> >   * acpi_enable_wakeup_device_prep - prepare wakeup devices
> >   *	@sleep_state:	ACPI state
> > @@ -30,7 +27,7 @@ void acpi_enable_wakeup_device_prep(u8 s
> >  
> >  	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device_prep");
> >  
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev = container_of(node,
> >  						       struct acpi_device,
> > @@ -41,11 +38,9 @@ void acpi_enable_wakeup_device_prep(u8 s
> >  		    (sleep_state > (u32) dev->wakeup.sleep_state))
> >  			continue;
> >  
> > -		spin_unlock(&acpi_device_lock);
> >  		acpi_enable_wakeup_device_power(dev, sleep_state);
> > -		spin_lock(&acpi_device_lock);
> >  	}
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  }
> >  
> >  /**
> > @@ -62,7 +57,7 @@ void acpi_enable_wakeup_device(u8 sleep_
> >  	 * Refer ACPI2.0: P212
> >  	 */
> >  	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev =
> >  			container_of(node, struct acpi_device, wakeup_list);
> > @@ -76,22 +71,18 @@ void acpi_enable_wakeup_device(u8 sleep_
> >  		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
> >  		    || sleep_state > (u32) dev->wakeup.sleep_state) {
> >  			if (dev->wakeup.flags.run_wake) {
> > -				spin_unlock(&acpi_device_lock);
> >  				/* set_gpe_type will disable GPE, leave it like that */
> >  				acpi_set_gpe_type(dev->wakeup.gpe_device,
> >  						  dev->wakeup.gpe_number,
> >  						  ACPI_GPE_TYPE_RUNTIME);
> > -				spin_lock(&acpi_device_lock);
> >  			}
> >  			continue;
> >  		}
> > -		spin_unlock(&acpi_device_lock);
> >  		if (!dev->wakeup.flags.run_wake)
> >  			acpi_enable_gpe(dev->wakeup.gpe_device,
> >  					dev->wakeup.gpe_number);
> > -		spin_lock(&acpi_device_lock);
> >  	}
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  }
> >  
> >  /**
> > @@ -105,7 +96,7 @@ void acpi_disable_wakeup_device(u8 sleep
> >  
> >  	ACPI_FUNCTION_TRACE("acpi_disable_wakeup_device");
> >  
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev =
> >  			container_of(node, struct acpi_device, wakeup_list);
> > @@ -116,19 +107,16 @@ void acpi_disable_wakeup_device(u8 sleep
> >  		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
> >  		    || sleep_state > (u32) dev->wakeup.sleep_state) {
> >  			if (dev->wakeup.flags.run_wake) {
> > -				spin_unlock(&acpi_device_lock);
> >  				acpi_set_gpe_type(dev->wakeup.gpe_device,
> >  						  dev->wakeup.gpe_number,
> >  						  ACPI_GPE_TYPE_WAKE_RUN);
> >  				/* Re-enable it, since set_gpe_type will disable it */
> >  				acpi_enable_gpe(dev->wakeup.gpe_device,
> >  						dev->wakeup.gpe_number);
> > -				spin_lock(&acpi_device_lock);
> >  			}
> >  			continue;
> >  		}
> >  
> > -		spin_unlock(&acpi_device_lock);
> >  		acpi_disable_wakeup_device_power(dev);
> >  		/* Never disable run-wake GPE */
> >  		if (!dev->wakeup.flags.run_wake) {
> > @@ -137,9 +125,8 @@ void acpi_disable_wakeup_device(u8 sleep
> >  			acpi_clear_gpe(dev->wakeup.gpe_device,
> >  				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
> >  		}
> > -		spin_lock(&acpi_device_lock);
> >  	}
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  }
> >  
> >  static int __init acpi_wakeup_device_init(void)
> > @@ -149,7 +136,7 @@ static int __init acpi_wakeup_device_ini
> >  	if (acpi_disabled)
> >  		return 0;
> >  
> > -	spin_lock(&acpi_device_lock);
> > +	mutex_lock(&acpi_device_lock);
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev = container_of(node,
> >  						       struct acpi_device,
> > @@ -157,16 +144,14 @@ static int __init acpi_wakeup_device_ini
> >  		/* In case user doesn't load button driver */
> >  		if (!dev->wakeup.flags.run_wake || dev->wakeup.state.enabled)
> >  			continue;
> > -		spin_unlock(&acpi_device_lock);
> >  		acpi_set_gpe_type(dev->wakeup.gpe_device,
> >  				  dev->wakeup.gpe_number,
> >  				  ACPI_GPE_TYPE_WAKE_RUN);
> >  		acpi_enable_gpe(dev->wakeup.gpe_device,
> >  				dev->wakeup.gpe_number);
> >  		dev->wakeup.state.enabled = 1;
> > -		spin_lock(&acpi_device_lock);
> >  	}
> > -	spin_unlock(&acpi_device_lock);
> > +	mutex_unlock(&acpi_device_lock);
> >  	return 0;
> >  }
> >  
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
