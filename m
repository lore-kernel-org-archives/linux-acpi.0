From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi regression test of the latest ACPI test branch
Date: Fri, 10 Oct 2008 14:41:13 +0200
Message-ID: <200810101441.14123.rjw@sisk.pl>
References: <1223625973.2735.142.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51868 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113AbYJJMg6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 08:36:58 -0400
In-Reply-To: <1223625973.2735.142.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>

On Friday, 10 of October 2008, Zhang Rui wrote:
> Hi, len,
>=20
> this is the ACPI regression test result based on the latest ACPI test=
 branch.
>=20
> 1. on =EF=BB=BFAcer:(AMD CPU, VIA chipset. 64 bit kernel)
> =EF=BB=BFWhen doing S3 test, after pressing the power button, the sys=
tem
> reboots instead of resuming. But if S3 is done after S4, the system c=
an
> resume very well after pressing power button or using the RTC
> alarm.
> Note that this is an upstream regression as it can be reproduced on
> linus' tree.
> Yakui is investigating this issue.

We had some reports of the second suspend (S3) failure too, where the s=
econd
attempt to suspend to RAM (or to resume from it) failed after a success=
ful
one.  I wonder if that's related.
=20
> 2. on =EF=BB=BFmost of the laptops(not all of them), we got this warn=
ing during
> boot, which is an acpi test branch regression. dmesg is attached.
>=20
> [    0.192102] ------------[ cut here ]------------
> [    0.192102] WARNING:
> at /workshop/kernel/git/my/linux/fs/sysfs/dir.c:463 sysfs_add_one
> +0x35/0x3d()
> [    0.192165] sysfs: duplicate filename 'acpi' can not be created
> [    0.192223] Modules linked in:
> [    0.192311] Pid: 1, comm: swapper Not tainted
> 2.6.27-rc7-00058-g14d31d8 #760
> [    0.192371]=20
> [    0.192372] Call Trace:
> [    0.192475]  [<ffffffff8024e2f7>] warn_slowpath+0xae/0xdd
> [    0.192535]  [<ffffffff8026cbf9>] ? trace_hardirqs_off+0xd/0xf
> [    0.192594]  [<ffffffff80271318>] ? __lock_acquire+0x70e/0x76c
> [    0.192653]  [<ffffffff8026cc2f>] ? get_lock_stats+0x34/0x5d
> [    0.192712]  [<ffffffff8026cc66>] ? put_lock_stats+0xe/0x27
> [    0.192770]  [<ffffffff8026cd20>] ? lock_release_holdtime+0xa1/0xa=
9
> [    0.192832]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
> [    0.192891]  [<ffffffff802d2a8b>] ? ifind+0xa3/0xb3
> [    0.192949]  [<ffffffff80308d4f>] ? sysfs_find_dirent+0x1c/0x31
> [    0.193008]  [<ffffffff80308d83>] ? __sysfs_add_one+0x1f/0x7c
> [    0.193067]  [<ffffffff80308e15>] sysfs_add_one+0x35/0x3d
> [    0.193125]  [<ffffffff803093ef>] create_dir+0x58/0x93
> [    0.193184]  [<ffffffff80309462>] sysfs_create_dir+0x38/0x4f
> [    0.193242]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
> [    0.193301]  [<ffffffff803a72cb>] kobject_add_internal+0xdb/0x19b
> [    0.193361]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
> [    0.193419]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
> [    0.193479]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
> [    0.193538]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
> [    0.193598]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> [    0.196021]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller
> +0xf9/0x124
> [    0.196081]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> [    0.196141]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/0x=
c6

This seems to be where the erring code path starts.  I'll have a look l=
ater
today.

> [    0.196201]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
> [    0.196260]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
> [    0.196318]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
> [    0.196378]  [<ffffffff80209047>] _stext+0x47/0x144
> [    0.196436]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
> [    0.196497]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
> [    0.196555]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a/0=
x3f
> [    0.196616]  [<ffffffff802240c9>] child_rip+0xa/0x11
> [    0.196674]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
> [    0.196733]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
> [    0.196791]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain
> +0x0/0xb2
> [    0.196852]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
> [    0.196910]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
> [    0.196966]=20
> [    0.197107] ---[ end trace 4eaa2a86a8e2da22 ]---
> [    0.197166] kobject_add_internal failed for acpi with -EEXIST, don=
't
> try to register things with the same name in the same directory.
> [    0.197248] Pid: 1, comm: swapper Tainted: G        W
> 2.6.27-rc7-00058-g14d31d8 #760
> [    0.197321]=20
> [    0.197322] Call Trace:
> [    0.197423]  [<ffffffff803a7042>] ? kobject_put+0x47/0x4b
> [    0.197481]  [<ffffffff803a7349>] kobject_add_internal+0x159/0x19b
> [    0.197540]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
> [    0.197599]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
> [    0.197658]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
> [    0.197717]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
> [    0.197777]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> [    0.197835]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller
> +0xf9/0x124
> [    0.197896]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
> [    0.197954]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/0x=
c6
> [    0.198014]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
> [    0.198073]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
> [    0.198132]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
> [    0.198190]  [<ffffffff80209047>] _stext+0x47/0x144
> [    0.198247]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
> [    0.198306]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
> [    0.198364]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a/0=
x3f
> [    0.198425]  [<ffffffff802240c9>] child_rip+0xa/0x11
> [    0.198482]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
> [    0.198541]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
> [    0.198599]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain
> +0x0/0xb2
> [    0.198659]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
> [    0.198717]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
> [    0.198774]=20
> [    0.198824] Module 'acpi' failed to be added to sysfs, error numbe=
r
> -17
> [    0.198882] The system will be unstable now.
>=20

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
