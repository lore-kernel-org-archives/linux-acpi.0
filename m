From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/7] ACPI / scan: Introduce common code for ACPI-based device hotplug
Date: Wed, 20 Feb 2013 22:17:44 +0100
Message-ID: <5546287.WJ6IiH7Pr1@vostro.rjw.lan>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan> <2868646.oscSukR6ks@vostro.rjw.lan> <1361391814.9542.72.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361391814.9542.72.camel@misato.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 20, 2013 01:23:34 PM Toshi Kani wrote:
> On Wed, 2013-02-20 at 14:23 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 19, 2013 03:43:08 PM Yasuaki Ishimatsu wrote:
>  :
> > > 
> > > > -	status = acpi_os_hotplug_execute(acpi_bus_hot_remove_device, ej_event);
> > > > -	if (ACPI_FAILURE(status)) {
> > > > -		put_device(&acpi_device->dev);
> > > > -		kfree(ej_event);
> > > > +	acpi_evaluate_hotplug_ost(acpi_device->handle, ost_source,
> > > > +				  ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
> > > > +	get_device(&acpi_device->dev);
> > > > +	ret = acpi_scan_hot_remove(acpi_device);
> > > 
> > > Why don't you use acpi_os_hotplug_execute()? Do you have some reason?
> > 
> > Yes, I do.  acpi_eject_store() is run in a separate thread anyway (started by
> > user space), so there's no need to use the workqueue for delayed execution here
> > and we are under acpi_scan_lock anyway, so there shouldn't be any concurrency
> > issues.
> 
> Well, there is an issue...  I just tested your patchset and hit the
> following hang when I tried to delete a container through its sysfs
> eject.  This thread got stuck in trying to delete the sysfs eject file
> of the container.  I believe this is because the shell is still opening
> this sysfs eject file.

You're right.

> PID: 1518   TASK: ffff88005f09c950  CPU: 1   COMMAND: "bash"
>  #0 [ffff88003392baf8] __schedule at ffffffff8151ba75
>  #1 [ffff88003392bb70] schedule at ffffffff8151bdc7
>  #2 [ffff88003392bb80] schedule_timeout at ffffffff8151aa55
>  #3 [ffff88003392bc00] wait_for_common at ffffffff8151bc43
>  #4 [ffff88003392bc70] wait_for_completion at ffffffff8151bd60
>  #5 [ffff88003392bc80] sysfs_addrm_finish at ffffffff811984ad
>  #6 [ffff88003392bcd0] sysfs_hash_and_remove at ffffffff81196deb
>  #7 [ffff88003392bd10] sysfs_remove_file at ffffffff81197051
>  #8 [ffff88003392bd40] device_remove_file at ffffffff81332950
>  #9 [ffff88003392bd50] acpi_device_unregister at ffffffff812a0556
> #10 [ffff88003392bd80] acpi_bus_remove at ffffffff812a0658
> #11 [ffff88003392bda0] acpi_bus_trim at ffffffff812a090e
> #12 [ffff88003392bdd0] acpi_scan_hot_remove at ffffffff812a09c9
> #13 [ffff88003392be30] acpi_eject_store at ffffffff812a0b45
> #14 [ffff88003392be70] dev_attr_store at ffffffff81332038
> #15 [ffff88003392be80] sysfs_write_file at ffffffff81197212
> #16 [ffff88003392bee0] vfs_write at ffffffff8113a3cb
> #17 [ffff88003392bf20] sys_write at ffffffff8113a5fd
> #18 [ffff88003392bf80] system_call_fastpath at ffffffff81523759
>     RIP: 00000033a16e4950  RSP: 00007fff4a5f5368  RFLAGS: 00000206
>     RAX: 0000000000000001  RBX: ffffffff81523759  RCX: ffffffffffffffff
>     RDX: 0000000000000002  RSI: 00007f2f8a3d8000  RDI: 0000000000000001
>     RBP: 00007f2f8a3d8000   R8: 000000000000000a   R9: 00007f2f8a3c4740
>     R10: 00007f2f8a3c4740  R11: 0000000000000246  R12: 00000033a19b1260
>     R13: 0000000000000002  R14: ffff880000000000  R15: ffff88003395d680
>     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

Well, admittedly, I didn't think about this situation.

Since the eject attribute is under the device we're going to remove, the
removal has to be done from a different thread (e.g. workqueue).

OK, I'll fix up the patch.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
