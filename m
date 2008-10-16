From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: acpi regression test of the latest ACPI test branch
Date: Thu, 16 Oct 2008 16:31:48 +0800
Message-ID: <1224145908.3944.103.camel@yakui_zhao.sh.intel.com>
References: <1223625973.2735.142.camel@rzhang-dt>
	 <200810101441.14123.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51183 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbYJPI0S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Oct 2008 04:26:18 -0400
In-Reply-To: <200810101441.14123.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Fri, 2008-10-10 at 14:41 +0200, Rafael J. Wysocki wrote:
> On Friday, 10 of October 2008, Zhang Rui wrote:
> > Hi, len,
> >=20
> > this is the ACPI regression test result based on the latest ACPI te=
st branch.
> >=20
> > 1. on =EF=BB=BFAcer:(AMD CPU, VIA chipset. 64 bit kernel)
> > =EF=BB=BFWhen doing S3 test, after pressing the power button, the s=
ystem
> > reboots instead of resuming. But if S3 is done after S4, the system=
 can
> > resume very well after pressing power button or using the RTC
> > alarm.
> > Note that this is an upstream regression as it can be reproduced on
> > linus' tree.
> > Yakui is investigating this issue.

After using git-bisect we find that it is a regression between 2.6.26
and 2.6.27-rc1.=20
  The commit (736f12bff9d9e7b4e895c64f73b190c8383fc2a1) is good. And th=
e
commit(55f262391a2365d657a00ed68edd1a51bca66af5) is bad.
   The patches between the above two commits are related with X86. And
when using the git-bisect between the above two commits, we will get th=
e
compile errors or kernel panic. So we can't continue to identify which
commit causes the regression.

> We had some reports of the second suspend (S3) failure too, where the=
 second
> attempt to suspend to RAM (or to resume from it) failed after a succe=
ssful
> one.  I wonder if that's related.
> =20
> > 2. on =EF=BB=BFmost of the laptops(not all of them), we got this wa=
rning during
> > boot, which is an acpi test branch regression. dmesg is attached.
> >
Now it is confirmed that the warning message will appear after the
following commit is merged.
   >commit f2e969acd6d5981e6b1272810002558650d0736e
   >Author: Zhao Yakui <yakui.zhao@intel.com>
   >Date:   Mon Aug 11 14:57:50 2008 +0800
    >ACPI: Add "acpi.power_nocheck=3D1" to disable power state check in
power transition:
   =20
    In this patch the "acpi.power_nocheck" module parameter is defined
in drivers/acpi/power.c file. As several module parameters using the
same ACPI prefix are defined in the different files(for example:
power_nocheck is defined in drivers/acpi/power.c,
debug_layer/debug_level are defined in drivers/acpi/debug.c) and there
exists another module between them, the following warning message will
be printed when using the current generic param code.(param_sysfs_init)
   >WARNING: at /home/ykzhao/study/git_tree/linux-2.6/fs/sysfs/dir.c:46=
3
>sysfs_add_one+0x33/0x39()
>sysfs: duplicate filename 'acpi' can not be created

   In fact there exist the corresponding discussions in ACPI mailing
list about this issue.=20
   >http://marc.info/?l=3Dlinux-acpi&m=3D121872830921823&w=3D2

This issue can be fixed by the following two approaches:
   a. fix it in generic param code related with sysfs=20
   b. workaround it in drivers/acpi/Makefile (Adjust the module order i=
n
Makefile)
    For example;
-obj-$(CONFIG_ACPI_POWER)       +=3D power.o
 obj-$(CONFIG_ACPI_PROCESSOR)   +=3D processor.o
 obj-$(CONFIG_ACPI_CONTAINER)   +=3D container.o
 obj-$(CONFIG_ACPI_THERMAL)     +=3D thermal.o
+obj-$(CONFIG_ACPI_POWER)       +=3D power.o
 obj-$(CONFIG_ACPI_SYSTEM)      +=3D system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)       +=3D debug.o


It is easy to workaround this issue in drivers/acpi/Makefile. But maybe
it will be better to fix it in generic parameter sysfs code.

Best regards.
  Yakui
> > [    0.192102] ------------[ cut here ]------------
> > [    0.192102] WARNING:
> > at /workshop/kernel/git/my/linux/fs/sysfs/dir.c:463 sysfs_add_one
> > +0x35/0x3d()
> > [    0.192165] sysfs: duplicate filename 'acpi' can not be created
> > [    0.192223] Modules linked in:
> > [    0.192311] Pid: 1, comm: swapper Not tainted
> > 2.6.27-rc7-00058-g14d31d8 #760
> > [    0.192371]=20
> > [    0.192372] Call Trace:
> > [    0.192475]  [<ffffffff8024e2f7>] warn_slowpath+0xae/0xdd
> > [    0.192535]  [<ffffffff8026cbf9>] ? trace_hardirqs_off+0xd/0xf
> > [    0.192594]  [<ffffffff80271318>] ? __lock_acquire+0x70e/0x76c
> > [    0.192653]  [<ffffffff8026cc2f>] ? get_lock_stats+0x34/0x5d
> > [    0.192712]  [<ffffffff8026cc66>] ? put_lock_stats+0xe/0x27
> > [    0.192770]  [<ffffffff8026cd20>] ? lock_release_holdtime+0xa1/0=
xa9
> > [    0.192832]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
> > [    0.192891]  [<ffffffff802d2a8b>] ? ifind+0xa3/0xb3
> > [    0.192949]  [<ffffffff80308d4f>] ? sysfs_find_dirent+0x1c/0x31
> > [    0.193008]  [<ffffffff80308d83>] ? __sysfs_add_one+0x1f/0x7c
> > [    0.193067]  [<ffffffff80308e15>] sysfs_add_one+0x35/0x3d
> > [    0.193125]  [<ffffffff803093ef>] create_dir+0x58/0x93
> > [    0.193184]  [<ffffffff80309462>] sysfs_create_dir+0x38/0x4f
> > [    0.193242]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
> > [    0.193301]  [<ffffffff803a72cb>] kobject_add_internal+0xdb/0x19=
b
> > [    0.193361]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
> > [    0.193419]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
> > [    0.193479]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x3=
8a
> > [    0.193538]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x3=
8a
> > [    0.193598]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> > [    0.196021]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller
> > +0xf9/0x124
> > [    0.196081]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> > [    0.196141]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/=
0xc6
>=20
> This seems to be where the erring code path starts.  I'll have a look=
 later
> today.
>=20
> > [    0.196201]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
> > [    0.196260]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
> > [    0.196318]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
> > [    0.196378]  [<ffffffff80209047>] _stext+0x47/0x144
> > [    0.196436]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
> > [    0.196497]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
> > [    0.196555]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a=
/0x3f
> > [    0.196616]  [<ffffffff802240c9>] child_rip+0xa/0x11
> > [    0.196674]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
> > [    0.196733]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
> > [    0.196791]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain
> > +0x0/0xb2
> > [    0.196852]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
> > [    0.196910]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
> > [    0.196966]=20
> > [    0.197107] ---[ end trace 4eaa2a86a8e2da22 ]---
> > [    0.197166] kobject_add_internal failed for acpi with -EEXIST, d=
on't
> > try to register things with the same name in the same directory.
> > [    0.197248] Pid: 1, comm: swapper Tainted: G        W
> > 2.6.27-rc7-00058-g14d31d8 #760
> > [    0.197321]=20
> > [    0.197322] Call Trace:
> > [    0.197423]  [<ffffffff803a7042>] ? kobject_put+0x47/0x4b
> > [    0.197481]  [<ffffffff803a7349>] kobject_add_internal+0x159/0x1=
9b
> > [    0.197540]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
> > [    0.197599]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
> > [    0.197658]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x3=
8a
> > [    0.197717]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x3=
8a
> > [    0.197777]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> > [    0.197835]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller
> > +0xf9/0x124
> > [    0.197896]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> > [    0.197954]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/=
0xc6
> > [    0.198014]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
> > [    0.198073]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
> > [    0.198132]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
> > [    0.198190]  [<ffffffff80209047>] _stext+0x47/0x144
> > [    0.198247]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
> > [    0.198306]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
> > [    0.198364]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a=
/0x3f
> > [    0.198425]  [<ffffffff802240c9>] child_rip+0xa/0x11
> > [    0.198482]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
> > [    0.198541]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
> > [    0.198599]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain
> > +0x0/0xb2
> > [    0.198659]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
> > [    0.198717]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
> > [    0.198774]=20
> > [    0.198824] Module 'acpi' failed to be added to sysfs, error num=
ber
> > -17
> > [    0.198882] The system will be unstable now.
> >=20
>=20
> Thanks,
> Rafael
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
