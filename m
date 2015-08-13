From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [Intel-gfx] [4.2-rc4] acpi|drm|i915: circular locking
 dependency: acpi_video_get_backlight_type
Date: Thu, 13 Aug 2015 03:30:26 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E881EF2ED4F@SHSMSX101.ccr.corp.intel.com>
References: <CA+icZUWh+qH0KuF7dcc0gJxM9myssapbPbOboeMoc-WjU-TK+A@mail.gmail.com>
 <CA+icZUWitjMzjhLKs+NLAaUdxQxkW7PNZ19HQfmi8oy2qmC1rA@mail.gmail.com>
 <CA+icZUVoUx3qMp7oChVyo8yN6D+Juf3VHqs25aCKShN1czkROw@mail.gmail.com>
 <20150812192620.GN5176@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64119 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbbHMDae convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Aug 2015 23:30:34 -0400
In-Reply-To: <20150812192620.GN5176@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, Sedat Dilek <sedat.dilek@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Hi, Ville

Have you reported this to the owner of the backlight core?
This looks like a bug that the backlight core should handle.
What intel backlight driver and acpi backlight driver have done here ar=
e just invoking APIs provided by the backlight core.
So it is the duty of the backlight core to handle such kind of circular=
 locking.

Thanks
-Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Ville Syrj?l?
> Sent: Thursday, August 13, 2015 3:26 AM
>=20
> On Mon, Aug 10, 2015 at 08:29:00PM +0200, Sedat Dilek wrote:
> > On Sat, Aug 1, 2015 at 2:23 PM, Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
> > > On Mon, Jul 27, 2015 at 12:33 AM, Sedat Dilek <sedat.dilek@gmail.=
com> wrote:
> > >> Hi,
> > >>
> > >> this my first build of a 4.2-rcN Linux-kernel and I see this...
> > >>
> > >
> > > Just FYI:
> > >
> > > I am *not* seeing this with drm-intel-nightly from below url.
> > >
> > > Also, I plan to test Linux v4.2-rc5.
> > >
> >
> > [ CC Linus ]
> >
> > Knock Knock Knock.
> >
> > This issue still remains here (with CONFIG_DRM_I915=3Dm)...
> >
> > [   18.269792] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   18.269798] [ INFO: possible circular locking dependency detecte=
d ]
> > [   18.269805] 4.2.0-rc6-1-iniza-small #1 Not tainted
> > [   18.269810] ----------------------------------------------------=
---
> > [   18.269816] modprobe/727 is trying to acquire lock:
> > [   18.269822]  (init_mutex){+.+.+.}, at: [<ffffffffa0090f2d>]
> > acpi_video_get_backlight_type+0x17/0x164 [video]
> > [   18.269840]
> > [   18.269840] but task is already holding lock:
> > [   18.269848]  (&(&backlight_notifier)->rwsem){++++..}, at:
> > [<ffffffff810a6519>] __blocking_notifier_call_chain+0x39/0x70
> > [   18.269864]
> > [   18.269864] which lock already depends on the new lock.
> > [   18.269864]
> > [   18.269875]
> > [   18.269875] the existing dependency chain (in reverse order) is:
> > [   18.269884]
> > ...
> >
> > Full dmesg log and kernel-config attached.
> >
> > Shall I add Rusty and modules/modprobe folks?
>=20
> Just got back from vacation and was greeted by this same lockdep spla=
t.
>=20
> On a hunch I reverted
>=20
> commit 93a291dfaf9c328ca5a9cea1733af1a128efe890
> Author: Hans de Goede <hdegoede@redhat.com>
> Date:   Tue Jun 16 16:27:52 2015 +0200
>=20
>     ACPI / video: Move backlight notifier to video_detect.c
>=20
> and the problem seems to be gone. Hans, any thoughts?
>=20
> >
> > - Sedat -
> >
> > > - Sedat -
> > >
> > > [1] http://kernel.ubuntu.com/~kernel-ppa/mainline/drm-intel-night=
ly/2015-08-01-unstable/
> > > [2] http://kernel.ubuntu.com/~kernel-ppa/mainline/drm-intel-night=
ly/2015-08-01-unstable/linux-image-4.2.0-994-generic_4.2.0-
> 994.201508010158_amd64.deb
> > >
> > >> [   24.001043] [drm] Memory usable by graphics device =3D 2048M
> > >> [   24.001118] [drm] Replacing VGA console driver
> > >> [   24.011642] [drm] Supports vblank timestamp caching Rev 2 (21=
=2E10.2013).
> > >> [   24.011646] [drm] Driver supports precise vblank timestamp qu=
ery.
> > >> [   24.012480] vgaarb: device changed decodes:
> > >> PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+=
mem
> > >> [   24.028005]
> > >> [   24.028014] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> [   24.028020] [ INFO: possible circular locking dependency dete=
cted ]
> > >> [   24.028027] 4.2.0-rc4-1-iniza-small #1 Not tainted
> > >> [   24.028032] -------------------------------------------------=
------
> > >> [   24.028038] modprobe/740 is trying to acquire lock:
> > >> [   24.028043]  (init_mutex){+.+.+.}, at: [<ffffffffa006af2d>]
> > >> acpi_video_get_backlight_type+0x17/0x164 [video]
> > >> [   24.028060]
> > >> [   24.028060] but task is already holding lock:
> > >> [   24.028068]  (&(&backlight_notifier)->rwsem){++++..}, at:
> > >> [<ffffffff810a6499>] __blocking_notifier_call_chain+0x39/0x70
> > >> [   24.028083]
> > >> [   24.028083] which lock already depends on the new lock.
> > >> [   24.028083]
> > >> [   24.028095]
> > >> [   24.028095] the existing dependency chain (in reverse order) =
is:
> > >> [   24.028103]
> > >> [   24.028103] -> #1 (&(&backlight_notifier)->rwsem){++++..}:
> > >> [   24.028113]        [<ffffffff810da56f>] lock_acquire+0xcf/0x2=
80
> > >> [   24.028121]        [<ffffffff817d6269>] down_write+0x49/0x80
> > >> [   24.028129]        [<ffffffff810a6611>]
> > >> blocking_notifier_chain_register+0x21/0xb0
> > >> [   24.028138]        [<ffffffff814619f8>] backlight_register_no=
tifier+0x18/0x20
> > >> [   24.028147]        [<ffffffffa006b010>]
> > >> acpi_video_get_backlight_type+0xfa/0x164 [video]
> > >> [   24.028158]        [<ffffffffa00a20e9>] 0xffffffffa00a20e9
> > >> [   24.028164]        [<ffffffff810020f8>] do_one_initcall+0x88/=
0x1c0
> > >> [   24.028172]        [<ffffffff817cc9d2>] do_init_module+0x61/0=
x1ec
> > >> [   24.028179]        [<ffffffff8111fb78>] load_module+0x2008/0x=
25c0
> > >> [   24.028187]        [<ffffffff81120256>] SyS_init_module+0x126=
/0x140
> > >> [   24.028194]        [<ffffffff817d8e32>] entry_SYSCALL_64_fast=
path+0x16/0x7a
> > >> [   24.028202]
> > >> [   24.028202] -> #0 (init_mutex){+.+.+.}:
> > >> [   24.028211]        [<ffffffff810d989d>] __lock_acquire+0x1f5d=
/0x21c0
> > >> [   24.028218]        [<ffffffff810da56f>] lock_acquire+0xcf/0x2=
80
> > >> [   24.028225]        [<ffffffff817d4275>] mutex_lock_nested+0x6=
5/0x3c0
> > >> [   24.028233]        [<ffffffffa006af2d>]
> > >> acpi_video_get_backlight_type+0x17/0x164 [video]
> > >> [   24.028243]        [<ffffffffa006b0b2>]
> > >> acpi_video_backlight_notify+0x19/0x2f [video]
> > >> [   24.028253]        [<ffffffff810a629d>] notifier_call_chain+0=
x5d/0x80
> > >> [   24.028260]        [<ffffffff810a64b1>]
> > >> __blocking_notifier_call_chain+0x51/0x70
> > >> [   24.028269]        [<ffffffff810a64e6>]
> > >> blocking_notifier_call_chain+0x16/0x20
> > >> [   24.028278]        [<ffffffff81461d37>] backlight_device_regi=
ster+0x197/0x240
> > >> [   24.028286]        [<ffffffffa062bb23>]
> > >> intel_backlight_register+0xb3/0x180 [i915]
> > >> [   24.028336]        [<ffffffffa05fe136>]
> > >> intel_modeset_gem_init+0x176/0x190 [i915]
> > >> [   24.028371]        [<ffffffffa0633112>] i915_driver_load+0xf1=
2/0x14d0 [i915]
> > >> [   24.028406]        [<ffffffffa00ec861>] drm_dev_register+0xb1=
/0x100 [drm]
> > >> [   24.028425]        [<ffffffffa00ef62d>] drm_get_pci_dev+0x8d/=
0x1e0 [drm]
> > >> [   24.028439]        [<ffffffffa057e1fb>] i915_pci_probe+0x3b/0=
x60 [i915]
> > >> [   24.028463]        [<ffffffff814317e5>] local_pci_probe+0x45/=
0xa0
> > >> [   24.028470]        [<ffffffff81432bad>] pci_device_probe+0xcd=
/0x120
> > >> [   24.028477]        [<ffffffff8152d3a6>] driver_probe_device+0=
x136/0x2e0
> > >> [   24.028485]        [<ffffffff8152d5e4>] __driver_attach+0x94/=
0xa0
> > >> [   24.028491]        [<ffffffff8152b336>] bus_for_each_dev+0x66=
/0xa0
> > >> [   24.028499]        [<ffffffff8152cede>] driver_attach+0x1e/0x=
20
> > >> [   24.028506]        [<ffffffff8152cad8>] bus_add_driver+0x1b8/=
0x230
> > >> [   24.028513]        [<ffffffff8152e580>] driver_register+0x60/=
0xe0
> > >> [   24.028520]        [<ffffffff814310a4>] __pci_register_driver=
+0x64/0x70
> > >> [   24.028527]        [<ffffffffa00ef860>] drm_pci_init+0xe0/0x1=
10 [drm]
> > >> [   24.028540]        [<ffffffffa069a0a0>] i915_init+0xa0/0xa8 [=
i915]
> > >> [   24.028563]        [<ffffffff810020f8>] do_one_initcall+0x88/=
0x1c0
> > >> [   24.028570]        [<ffffffff817cc9d2>] do_init_module+0x61/0=
x1ec
> > >> [   24.028577]        [<ffffffff8111fb78>] load_module+0x2008/0x=
25c0
> > >> [   24.028584]        [<ffffffff81120256>] SyS_init_module+0x126=
/0x140
> > >> [   24.028591]        [<ffffffff817d8e32>] entry_SYSCALL_64_fast=
path+0x16/0x7a
> > >> [   24.028598]
> > >> [   24.028598] other info that might help us debug this:
> > >> [   24.028598]
> > >> [   24.028609]  Possible unsafe locking scenario:
> > >> [   24.028609]
> > >> [   24.028617]        CPU0                    CPU1
> > >> [   24.028622]        ----                    ----
> > >> [   24.028627]   lock(&(&backlight_notifier)->rwsem);
> > >> [   24.028633]                                lock(init_mutex);
> > >> [   24.028639]
> > >> lock(&(&backlight_notifier)->rwsem);
> > >> [   24.028648]   lock(init_mutex);
> > >> [   24.028654]
> > >> [   24.028654]  *** DEADLOCK ***
> > >> [   24.028654]
> > >> [   24.028664] 4 locks held by modprobe/740:
> > >> [   24.028669]  #0:  (&dev->mutex){......}, at: [<ffffffff8152d5=
9b>]
> > >> __driver_attach+0x4b/0xa0
> > >> [   24.028681]  #1:  (&dev->mutex){......}, at: [<ffffffff8152d5=
a9>]
> > >> __driver_attach+0x59/0xa0
> > >> [   24.028693]  #2:  (drm_global_mutex){+.+.+.}, at:
> > >> [<ffffffffa00ec7d6>] drm_dev_register+0x26/0x100 [drm]
> > >> [   24.028711]  #3:  (&(&backlight_notifier)->rwsem){++++..}, at=
:
> > >> [<ffffffff810a6499>] __blocking_notifier_call_chain+0x39/0x70
> > >> [   24.028725]
> > >> [   24.028725] stack backtrace:
> > >> [   24.028734] CPU: 1 PID: 740 Comm: modprobe Not tainted
> > >> 4.2.0-rc4-1-iniza-small #1
> > >> [   24.028742] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
> > >> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28=
/2013
> > >> [   24.028753]  ffffffff8269fc40 ffff8801188134b8 ffffffff817cea=
9b
> > >> 0000000000000011
> > >> [   24.028763]  ffffffff8269fc40 ffff880118813508 ffffffff817cbf=
c4
> > >> ffff8800d3a00b40
> > >> [   24.028774]  ffff880118813578 ffff8800d3a01410 00000000000000=
04
> > >> ffff8800d3a01410
> > >> [   24.028784] Call Trace:
> > >> [   24.028791]  [<ffffffff817cea9b>] dump_stack+0x4c/0x65
> > >> [   24.028797]  [<ffffffff817cbfc4>] print_circular_bug+0x20b/0x=
21c
> > >> [   24.028804]  [<ffffffff810d989d>] __lock_acquire+0x1f5d/0x21c=
0
> > >> [   24.028812]  [<ffffffff810da56f>] lock_acquire+0xcf/0x280
> > >> [   24.028819]  [<ffffffffa006af2d>] ?
> > >> acpi_video_get_backlight_type+0x17/0x164 [video]
> > >> [   24.028830]  [<ffffffff817d4275>] mutex_lock_nested+0x65/0x3c=
0
> > >> [   24.028837]  [<ffffffffa006af2d>] ?
> > >> acpi_video_get_backlight_type+0x17/0x164 [video]
> > >> [   24.028847]  [<ffffffffa006af2d>]
> > >> acpi_video_get_backlight_type+0x17/0x164 [video]
> > >> [   24.028857]  [<ffffffffa006b0b2>]
> > >> acpi_video_backlight_notify+0x19/0x2f [video]
> > >> [   24.028866]  [<ffffffff810a629d>] notifier_call_chain+0x5d/0x=
80
> > >> [   24.028873]  [<ffffffff810a64b1>] __blocking_notifier_call_ch=
ain+0x51/0x70
> > >> [   24.028880]  [<ffffffff810a64e6>] blocking_notifier_call_chai=
n+0x16/0x20
> > >> [   24.028887]  [<ffffffff81461d37>] backlight_device_register+0=
x197/0x240
> > >> [   24.028920]  [<ffffffffa062bb23>] intel_backlight_register+0x=
b3/0x180 [i915]
> > >> [   24.028952]  [<ffffffffa05fe136>] intel_modeset_gem_init+0x17=
6/0x190 [i915]
> > >> [   24.028984]  [<ffffffffa0633112>] i915_driver_load+0xf12/0x14=
d0 [i915]
> > >> [   24.028991]  [<ffffffff810d73e9>] ? mark_held_locks+0x69/0x90
> > >> [   24.028997]  [<ffffffff817d5cd0>] ? __mutex_unlock_slowpath+0=
xc0/0x180
> > >> [   24.029004]  [<ffffffff810d73e9>] ? mark_held_locks+0x69/0x90
> > >> [   24.029011]  [<ffffffff817d84d6>] ? _raw_spin_unlock_irqresto=
re+0x36/0x60
> > >> [   24.029018]  [<ffffffff810d7561>] ? trace_hardirqs_on_caller+=
0x151/0x1e0
> > >> [   24.029025]  [<ffffffff810d75fd>] ? trace_hardirqs_on+0xd/0x1=
0
> > >> [   24.029039]  [<ffffffffa00ec861>] drm_dev_register+0xb1/0x100=
 [drm]
> > >> [   24.029052]  [<ffffffffa00ef62d>] drm_get_pci_dev+0x8d/0x1e0 =
[drm]
> > >> [   24.029076]  [<ffffffffa057e1fb>] i915_pci_probe+0x3b/0x60 [i=
915]
> > >> [   24.029082]  [<ffffffff814317e5>] local_pci_probe+0x45/0xa0
> > >> [   24.029089]  [<ffffffff81432a70>] ? pci_match_device+0xe0/0x1=
10
> > >> [   24.029095]  [<ffffffff81432bad>] pci_device_probe+0xcd/0x120
> > >> [   24.029102]  [<ffffffff8152d3a6>] driver_probe_device+0x136/0=
x2e0
> > >> [   24.029109]  [<ffffffff8152d5e4>] __driver_attach+0x94/0xa0
> > >> [   24.029115]  [<ffffffff8152d550>] ? driver_probe_device+0x2e0=
/0x2e0
> > >> [   24.029124]  [<ffffffff8152b336>] bus_for_each_dev+0x66/0xa0
> > >> [   24.029134]  [<ffffffff8152cede>] driver_attach+0x1e/0x20
> > >> [   24.029144]  [<ffffffff8152cad8>] bus_add_driver+0x1b8/0x230
> > >> [   24.029153]  [<ffffffff8152e580>] driver_register+0x60/0xe0
> > >> [   24.029163]  [<ffffffff814310a4>] __pci_register_driver+0x64/=
0x70
> > >> [   24.029180]  [<ffffffffa00ef860>] drm_pci_init+0xe0/0x110 [dr=
m]
> > >> [   24.029190]  [<ffffffffa069a000>] ? 0xffffffffa069a000
> > >> [   24.029218]  [<ffffffffa069a0a0>] i915_init+0xa0/0xa8 [i915]
> > >> [   24.029228]  [<ffffffff810020f8>] do_one_initcall+0x88/0x1c0
> > >> [   24.029238]  [<ffffffff817cc999>] ? do_init_module+0x28/0x1ec
> > >> [   24.029248]  [<ffffffff817cc9d2>] do_init_module+0x61/0x1ec
> > >> [   24.029257]  [<ffffffff8111fb78>] load_module+0x2008/0x25c0
> > >> [   24.029266]  [<ffffffff8111b6c0>] ? m_show+0x1a0/0x1a0
> > >> [   24.029278]  [<ffffffff817d9a73>] ? retint_kernel+0x10/0x10
> > >> [   24.029290]  [<ffffffff81120256>] SyS_init_module+0x126/0x140
> > >> [   24.029297]  [<ffffffff817d8e32>] entry_SYSCALL_64_fastpath+0=
x16/0x7a
> > >> [   24.030969] ACPI: Video Device [GFX0] (multi-head: yes  rom: =
no  post: no)
> > >> [   24.031157] input: Video Bus as
> > >> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/in=
put11
> > >> [   24.031353] [drm] Initialized i915 1.6.0 20150522 for 0000:00=
:02.0 on minor 0
> > >> [   24.041224] fbcon: inteldrmfb (fb0) is primary device
> > >>
> > >> Not sure which area is the root cause, so I added acpi and drm/i=
915 folks.
> > >>
> > >> dmesg and kernel-config are attached.
> > >> More infos?
> > >> Please let me know what you need.
> > >>
> > >> Regards,
> > >> - sed@ -
>=20
> > [    0.000000] Initializing cgroup subsys cpuset
> > [    0.000000] Initializing cgroup subsys cpu
> > [    0.000000] Initializing cgroup subsys cpuacct
> > [    0.000000] Linux version 4.2.0-rc6-1-iniza-small (sedat.dilek@g=
mail.com@fambox) (gcc version 4.9.2 (Ubuntu 4.9.2-
> 0ubuntu1~12.04) ) #1 SMP Mon Aug 10 19:35:16 CEST 2015
> > [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-4.2.0-rc6-1=
-iniza-small root=3DUUID=3D001AADA61AAD9964
> loop=3D/ubuntu/disks/root.disk ro
> > [    0.000000] KERNEL supported cpus:
> > [    0.000000]   Intel GenuineIntel
> > [    0.000000]   AMD AuthenticAMD
> > [    0.000000]   Centaur CentaurHauls
> > [    0.000000] Disabled fast string operations
> > [    0.000000] x86/fpu: xstate_offset[2]: 0240, xstate_sizes[2]: 01=
00
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floatin=
g point registers'
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registe=
rs'
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registe=
rs'
> > [    0.000000] x86/fpu: Enabled xstate features 0x7, context size i=
s 0x340 bytes, using 'standard' format.
> > [    0.000000] x86/fpu: Using 'eager' FPU context switches.
> > [    0.000000] e820: BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7f=
f] usable
> > [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009fff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000ffff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffffff=
f] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201ffff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003ffffff=
f] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401ffff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000d9c9eff=
f] usable
> > [    0.000000] BIOS-e820: [mem 0x00000000d9c9f000-0x00000000dae7eff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000dae7f000-0x00000000daf9eff=
f] ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x00000000daf9f000-0x00000000daffeff=
f] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x00000000dafff000-0x00000000dafffff=
f] usable
> > [    0.000000] BIOS-e820: [mem 0x00000000db000000-0x00000000df9ffff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbfffff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00ff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08ff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19ff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1fff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00ff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000ffd80000-0x00000000fffffff=
f] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000011fdffff=
f] usable
> > [    0.000000] NX (Execute Disable) protection: active
> > [    0.000000] SMBIOS 2.6 present.
> > [    0.000000] DMI: SAMSUNG ELECTRONICS CO., LTD. 530U3BI/530U4BI/5=
30U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
> > [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D=
> reserved
> > [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> > [    0.000000] e820: last_pfn =3D 0x11fe00 max_arch_pfn =3D 0x40000=
0000
> > [    0.000000] MTRR default type: uncachable
> > [    0.000000] MTRR fixed ranges enabled:
> > [    0.000000]   00000-9FFFF write-back
> > [    0.000000]   A0000-BFFFF uncachable
> > [    0.000000]   C0000-FFFFF write-protect
> > [    0.000000] MTRR variable ranges enabled:
> > [    0.000000]   0 base 000000000 mask F80000000 write-back
> > [    0.000000]   1 base 080000000 mask FC0000000 write-back
> > [    0.000000]   2 base 0C0000000 mask FE0000000 write-back
> > [    0.000000]   3 base 0DC000000 mask FFC000000 uncachable
> > [    0.000000]   4 base 0DB000000 mask FFF000000 uncachable
> > [    0.000000]   5 base 100000000 mask FE0000000 write-back
> > [    0.000000]   6 base 11FE00000 mask FFFE00000 uncachable
> > [    0.000000]   7 base 0FFC00000 mask FFFC00000 write-protect
> > [    0.000000]   8 disabled
> > [    0.000000]   9 disabled
> > [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC=
  UC- WT
> > [    0.000000] e820: last_pfn =3D 0xdb000 max_arch_pfn =3D 0x400000=
000
> > [    0.000000] found SMP MP-table at [mem 0x000f00e0-0x000f00ef] ma=
pped at [ffff8800000f00e0]
> > [    0.000000] Scanning 1 areas for low memory corruption
> > [    0.000000] Base memory trampoline at [ffff880000097000] 97000 s=
ize 24576
> > [    0.000000] reserving inaccessible SNB gfx pages
> > [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> > [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> > [    0.000000] BRK [0x02ccd000, 0x02ccdfff] PGTABLE
> > [    0.000000] BRK [0x02cce000, 0x02ccefff] PGTABLE
> > [    0.000000] BRK [0x02ccf000, 0x02ccffff] PGTABLE
> > [    0.000000] init_memory_mapping: [mem 0x11fc00000-0x11fdfffff]
> > [    0.000000]  [mem 0x11fc00000-0x11fdfffff] page 2M
> > [    0.000000] BRK [0x02cd0000, 0x02cd0fff] PGTABLE
> > [    0.000000] init_memory_mapping: [mem 0x100000000-0x11fbfffff]
> > [    0.000000]  [mem 0x100000000-0x11fbfffff] page 2M
> > [    0.000000] init_memory_mapping: [mem 0xc0000000-0xd9c9efff]
> > [    0.000000]  [mem 0xc0000000-0xd9bfffff] page 2M
> > [    0.000000]  [mem 0xd9c00000-0xd9c9efff] page 4k
> > [    0.000000] BRK [0x02cd1000, 0x02cd1fff] PGTABLE
> > [    0.000000] BRK [0x02cd2000, 0x02cd2fff] PGTABLE
> > [    0.000000] init_memory_mapping: [mem 0xdafff000-0xdaffffff]
> > [    0.000000]  [mem 0xdafff000-0xdaffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
> > [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> > [    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
> > [    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
> > [    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
> > [    0.000000] init_memory_mapping: [mem 0x40200000-0xbfffffff]
> > [    0.000000]  [mem 0x40200000-0xbfffffff] page 2M
> > [    0.000000] RAMDISK: [mem 0x378f8000-0x37c73fff]
> > [    0.000000] ACPI: Early table checksum verification disabled
> > [    0.000000] ACPI: RSDP 0x00000000000F0100 000024 (v02 SECCSD)
> > [    0.000000] ACPI: XSDT 0x00000000DAFFE170 00008C (v01 SECCSD LH4=
3STAR 00000002 PTEC 00000002)
> > [    0.000000] ACPI: FACP 0x00000000DAFEF000 00010C (v05 SECCSD LH4=
3STAR 00000002 PTL  00000002)
> > [    0.000000] ACPI: DSDT 0x00000000DAFF2000 0083AC (v02 SECCSD SNB=
-CPT  00000000 INTL 20061109)
> > [    0.000000] ACPI: FACS 0x00000000DAF47000 000040
> > [    0.000000] ACPI: SLIC 0x00000000DAFFD000 000176 (v01 SECCSD LH4=
3STAR 00000002 PTEC 00000001)
> > [    0.000000] ACPI: SSDT 0x00000000DAFFB000 001068 (v01 SECCSD Pti=
dDevc 00001000 INTL 20061109)
> > [    0.000000] ACPI: ASF! 0x00000000DAFF1000 0000A5 (v32 SECCSD LH4=
3STAR 00000002 PTL  00000002)
> > [    0.000000] ACPI: HPET 0x00000000DAFEE000 000038 (v01 SECCSD LH4=
3STAR 00000002 PTL  00000002)
> > [    0.000000] ACPI: APIC 0x00000000DAFED000 000098 (v03 SECCSD LH4=
3STAR 00000002 PTL  00000002)
> > [    0.000000] ACPI: MCFG 0x00000000DAFEC000 00003C (v01 SECCSD LH4=
3STAR 00000002 PTL  00000002)
> > [    0.000000] ACPI: SSDT 0x00000000DAFEB000 000804 (v01 PmRef  Cpu=
0Ist  00003000 INTL 20061109)
> > [    0.000000] ACPI: SSDT 0x00000000DAFEA000 000996 (v01 PmRef  Cpu=
Pm    00003000 INTL 20061109)
> > [    0.000000] ACPI: UEFI 0x00000000DAFE9000 00003E (v01 SECCSD LH4=
3STAR 00000002 PTL  00000002)
> > [    0.000000] ACPI: UEFI 0x00000000DAFE8000 000042 (v01 PTL    COM=
BUF   00000001 PTL  00000001)
> > [    0.000000] ACPI: UEFI 0x00000000DAFE7000 00026A (v01 SECCSD LH4=
3STAR 00000002 PTL  00000002)
> > [    0.000000] ACPI: SSDT 0x00000000DAFE6000 0000D0 (v01 Iffs   Iff=
sAsl  00003000 INTL 20061109)
> > [    0.000000] ACPI: Local APIC address 0xfee00000
> > [    0.000000] No NUMA configuration found
> > [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000011=
fdfffff]
> > [    0.000000] NODE_DATA(0) allocated [mem 0x11fdf8000-0x11fdfcfff]
> > [    0.000000]  [ffffea0000000000-ffffea00047fffff] PMD -> [ffff880=
11b400000-ffff88011f3fffff] on node 0
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
> > [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
> > [    0.000000]   Normal   [mem 0x0000000100000000-0x000000011fdffff=
f]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cf=
ff]
> > [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffff=
ff]
> > [    0.000000]   node   0: [mem 0x0000000020200000-0x000000003fffff=
ff]
> > [    0.000000]   node   0: [mem 0x0000000040200000-0x00000000d9c9ef=
ff]
> > [    0.000000]   node   0: [mem 0x00000000dafff000-0x00000000daffff=
ff]
> > [    0.000000]   node   0: [mem 0x0000000100000000-0x000000011fdfff=
ff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0011fdfffff]
> > [    0.000000] On node 0 totalpages: 1021500
> > [    0.000000]   DMA zone: 64 pages used for memmap
> > [    0.000000]   DMA zone: 156 pages reserved
> > [    0.000000]   DMA zone: 3996 pages, LIFO batch:0
> > [    0.000000]   DMA32 zone: 13859 pages used for memmap
> > [    0.000000]   DMA32 zone: 886944 pages, LIFO batch:31
> > [    0.000000]   Normal zone: 2040 pages used for memmap
> > [    0.000000]   Normal zone: 130560 pages, LIFO batch:31
> > [    0.000000] Reserving Intel graphics stolen memory at 0xdba00000=
-0xdf9fffff
> > [    0.000000] ACPI: PM-Timer IO Port: 0x408
> > [    0.000000] ACPI: Local APIC address 0xfee00000
> > [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> > [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> > [    0.000000] IOAPIC[0]: apic_id 14, version 32, address 0xfec0000=
0, GSI 0-23
> > [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)
> > [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
> > [    0.000000] ACPI: IRQ0 used by override.
> > [    0.000000] ACPI: IRQ9 used by override.
> > [    0.000000] Using ACPI (MADT) for SMP configuration information
> > [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
> > [    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
> > [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x0000=
0fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009=
dfff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000d=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000f=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201f=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x40000000-0x401f=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xd9c9f000-0xdae7=
efff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xdae7f000-0xdaf9=
efff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xdaf9f000-0xdaff=
efff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xdb000000-0xdf9f=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xdfa00000-0xf7ff=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbff=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebf=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec0=
0fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed0=
7fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfed08000-0xfed0=
8fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfed09000-0xfed0=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed1=
9fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1=
bfff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedf=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee0=
0fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffd7=
ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0xffd80000-0xffff=
ffff]
> > [    0.000000] e820: [mem 0xdfa00000-0xf7ffffff] available for PCI =
devices
> > [    0.000000] Booting paravirtualized kernel on bare hardware
> > [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> > [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu=
_ids:8 nr_node_ids:1
> > [    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88011fa00000 s100=
680 r8192 d30392 u262144
> > [    0.000000] pcpu-alloc: s100680 r8192 d30392 u262144 alloc=3D1*2=
097152
> > [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
> > [    0.000000] Built 1 zonelists in Node order, mobility grouping o=
n.  Total pages: 1005381
> > [    0.000000] Policy zone: Normal
> > [    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-4.2.=
0-rc6-1-iniza-small root=3DUUID=3D001AADA61AAD9964
> loop=3D/ubuntu/disks/root.disk ro
> > [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> > [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> > [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA -=
 bailing!
> > [    0.000000] Memory: 3918756K/4086000K available (8058K kernel co=
de, 1369K rwdata, 3456K rodata, 1428K init, 14368K bss, 167244K
> reserved, 0K cma-reserved)
> > [    0.000000] Running RCU self tests
> > [    0.000000] Hierarchical RCU implementation.
> > [    0.000000] 	RCU lockdep checking is enabled.
> > [    0.000000] 	Build-time adjustment of leaf fanout to 64.
> > [    0.000000] 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_i=
ds=3D8.
> > [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr=
_cpu_ids=3D8
> > [    0.000000] NR_IRQS:16640 nr_irqs:488 16
> > [    0.000000] Console: colour dummy device 80x25
> > [    0.000000] console [tty0] enabled
> > [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Ha=
t, Inc., Ingo Molnar
> > [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> > [    0.000000] ... MAX_LOCK_DEPTH:          48
> > [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> > [    0.000000] ... CLASSHASH_SIZE:          4096
> > [    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
> > [    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
> > [    0.000000] ... CHAINHASH_SIZE:          32768
> > [    0.000000]  memory used by lock dependency info: 8159 kB
> > [    0.000000]  per task-struct memory footprint: 1920 bytes
> > [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 133484882848 ns
> > [    0.000000] hpet clockevent registered
> > [    0.000000] tsc: Fast TSC calibration using PIT
> > [    0.000000] tsc: Detected 1596.448 MHz processor
> > [    0.000077] Calibrating delay loop (skipped), value calculated u=
sing timer frequency.. 3192.89 BogoMIPS (lpj=3D6385792)
> > [    0.000090] pid_max: default: 32768 minimum: 301
> > [    0.000115] ACPI: Core revision 20150619
> > [    0.018881] ACPI: All ACPI Tables successfully acquired
> > [    0.018997] Security Framework initialized
> > [    0.019010] AppArmor: AppArmor initialized
> > [    0.019015] Yama: becoming mindful.
> > [    0.019954] Dentry cache hash table entries: 524288 (order: 10, =
4194304 bytes)
> > [    0.021291] Inode-cache hash table entries: 262144 (order: 9, 20=
97152 bytes)
> > [    0.021771] Mount-cache hash table entries: 8192 (order: 4, 6553=
6 bytes)
> > [    0.021793] Mountpoint-cache hash table entries: 8192 (order: 4,=
 65536 bytes)
> > [    0.022978] Initializing cgroup subsys blkio
> > [    0.023013] Initializing cgroup subsys memory
> > [    0.023040] Initializing cgroup subsys devices
> > [    0.023074] Initializing cgroup subsys freezer
> > [    0.023106] Initializing cgroup subsys perf_event
> > [    0.023118] Initializing cgroup subsys hugetlb
> > [    0.023167] Disabled fast string operations
> > [    0.023174] CPU: Physical Processor ID: 0
> > [    0.023179] CPU: Processor Core ID: 0
> > [    0.023189] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> > [    0.023195] ENERGY_PERF_BIAS: View and update with x86_energy_pe=
rf_policy(8)
> > [    0.023203] mce: CPU supports 7 MCE banks
> > [    0.023222] CPU0: Thermal monitoring enabled (TM1)
> > [    0.023243] process: using mwait in idle threads
> > [    0.023251] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> > [    0.023258] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1G=
B 0
> > [    0.023488] Freeing SMP alternatives memory: 24K (ffffffff81ebd0=
00 - ffffffff81ec3000)
> > [    0.037153] ftrace: allocating 29005 entries in 114 pages
> > [    0.053480] x2apic: IRQ remapping doesn't support X2APIC mode
> > [    0.054112] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1=
 pin2=3D-1
> > [    0.093783] TSC deadline timer enabled
> > [    0.093788] smpboot: CPU0: Intel(R) Core(TM) i5-2467M CPU @ 1.60=
GHz (fam: 06, model: 2a, stepping: 07)
> > [    0.093843] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBr=
idge events, full-width counters, Intel PMU driver.
> > [    0.093887] ... version:                3
> > [    0.093892] ... bit width:              48
> > [    0.093897] ... generic registers:      4
> > [    0.093902] ... value mask:             0000ffffffffffff
> > [    0.093907] ... max period:             0000ffffffffffff
> > [    0.093913] ... fixed-purpose events:   3
> > [    0.093917] ... event mask:             000000070000000f
> > [    0.095923] x86: Booting SMP configuration:
> > [    0.095930] .... node  #0, CPUs:      #1
> > [    0.096967] Disabled fast string operations
> > [    0.099580] NMI watchdog: enabled on all CPUs, permanently consu=
mes one hw-PMU counter.
> > [    0.100113]  #2
> > [    0.101140] Disabled fast string operations
> > [    0.103734]  #3<6>[    0.104768] Disabled fast string operations
> > [    0.106933] x86: Booted up 1 node, 4 CPUs
> > [    0.106946] smpboot: Total of 4 processors activated (12771.58 B=
ogoMIPS)
> > [    0.111893] devtmpfs: initialized
> > [    0.117784] evm: security.selinux
> > [    0.117790] evm: security.SMACK64
> > [    0.117795] evm: security.capability
> > [    0.117966] PM: Registering ACPI NVS region [mem 0xdae7f000-0xda=
f9efff] (1179648 bytes)
> > [    0.118320] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645041785100000 ns
> > [    0.119908] NET: Registered protocol family 16
> > [    0.130858] cpuidle: using governor ladder
> > [    0.146836] cpuidle: using governor menu
> > [    0.146966] ACPI: bus type PCI registered
> > [    0.147247] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0x=
f8000000-0xfbffffff] (base 0xf8000000)
> > [    0.147258] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserve=
d in E820
> > [    0.147272] PCI: Using configuration type 1 for base access
> > [    0.147918] perf_event_intel: PMU erratum BJ122, BV98, HSD29 wor=
ked around, HT is on
> > [    0.164538] ACPI: Added _OSI(Module Device)
> > [    0.164546] ACPI: Added _OSI(Processor Device)
> > [    0.164552] ACPI: Added _OSI(3.0 _SCP Extensions)
> > [    0.164558] ACPI: Added _OSI(Processor Aggregator Device)
> > [    0.176702] ACPI: Executed 1 blocks of module-level executable A=
ML code
> > [    0.185323] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> > [    0.187155] ACPI: Dynamic OEM Table Load:
> > [    0.187184] ACPI: SSDT 0xFFFF88011A696000 000688 (v01 PmRef  Cpu=
0Cst  00003001 INTL 20061109)
> > [    0.189366] ACPI: Dynamic OEM Table Load:
> > [    0.189392] ACPI: SSDT 0xFFFF88011A6A0000 000303 (v01 PmRef  ApI=
st    00003000 INTL 20061109)
> > [    0.191416] ACPI: Dynamic OEM Table Load:
> > [    0.191441] ACPI: SSDT 0xFFFF88011A697A00 000119 (v01 PmRef  ApC=
st    00003000 INTL 20061109)
> > [    0.194769] ACPI : EC: EC started
> > [    0.196329] ACPI: Interpreter enabled
> > [    0.196355] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep=
 State [\_S2_] (20150619/hwxface-580)
> > [    0.196416] ACPI: (supports S0 S1 S3 S4 S5)
> > [    0.196422] ACPI: Using IOAPIC for interrupt routing
> > [    0.196499] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
> > [    0.217685] ACPI: Power Resource [FN00] (off)
> > [    0.218139] ACPI: Power Resource [FN01] (off)
> > [    0.218473] ACPI: Power Resource [FN02] (off)
> > [    0.218804] ACPI: Power Resource [FN03] (off)
> > [    0.219156] ACPI: Power Resource [FN04] (off)
> > [    0.221496] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e=
])
> > [    0.221510] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig A=
SPM ClockPM Segments MSI]
> > [    0.222104] \_SB_.PCI0:_OSC invalid UUID
> > [    0.222106] _OSC request data:1 1f 0
> > [    0.222112] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling A=
SPM
> > [    0.223052] PCI host bridge to bus 0000:00
> > [    0.223061] pci_bus 0000:00: root bus resource [bus 00-3e]
> > [    0.223069] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
> > [    0.223077] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
> > [    0.223084] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
> > [    0.223094] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0=
xfeafffff window]
> > [    0.223103] pci_bus 0000:00: root bus resource [mem 0xfed40000-0=
xfed44fff window]
> > [    0.223165] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
> > [    0.223548] pci 0000:00:02.0: [8086:0116] type 00 class 0x030000
> > [    0.223574] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fff=
ff 64bit]
> > [    0.223586] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffff=
ff 64bit pref]
> > [    0.223594] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
> > [    0.224036] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
> > [    0.224097] pci 0000:00:16.0: reg 0x10: [mem 0xf0705000-0xf07050=
0f 64bit]
> > [    0.224213] pci 0000:00:16.0: PME# supported from D0 D3hot D3col=
d
> > [    0.224555] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
> > [    0.224609] pci 0000:00:1a.0: reg 0x10: [mem 0xf070a000-0xf070a3=
ff]
> > [    0.224745] pci 0000:00:1a.0: PME# supported from D0 D3hot D3col=
d
> > [    0.225049] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
> > [    0.225110] pci 0000:00:1b.0: reg 0x10: [mem 0xf0700000-0xf0703f=
ff 64bit]
> > [    0.225249] pci 0000:00:1b.0: PME# supported from D0 D3hot D3col=
d
> > [    0.225430] pci 0000:00:1b.0: System wakeup disabled by ACPI
> > [    0.225595] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
> > [    0.225745] pci 0000:00:1c.0: PME# supported from D0 D3hot D3col=
d
> > [    0.225902] pci 0000:00:1c.0: System wakeup disabled by ACPI
> > [    0.226069] pci 0000:00:1c.3: [8086:1c16] type 01 class 0x060400
> > [    0.226217] pci 0000:00:1c.3: PME# supported from D0 D3hot D3col=
d
> > [    0.226373] pci 0000:00:1c.3: System wakeup disabled by ACPI
> > [    0.226536] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
> > [    0.226690] pci 0000:00:1c.4: PME# supported from D0 D3hot D3col=
d
> > [    0.227023] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
> > [    0.227078] pci 0000:00:1d.0: reg 0x10: [mem 0xf0709000-0xf07093=
ff]
> > [    0.227213] pci 0000:00:1d.0: PME# supported from D0 D3hot D3col=
d
> > [    0.227512] pci 0000:00:1f.0: [8086:1c49] type 00 class 0x060100
> > [    0.227948] pci 0000:00:1f.2: [8086:1c03] type 00 class 0x010601
> > [    0.228006] pci 0000:00:1f.2: reg 0x10: [io  0x3088-0x308f]
> > [    0.228023] pci 0000:00:1f.2: reg 0x14: [io  0x3094-0x3097]
> > [    0.228040] pci 0000:00:1f.2: reg 0x18: [io  0x3080-0x3087]
> > [    0.228056] pci 0000:00:1f.2: reg 0x1c: [io  0x3090-0x3093]
> > [    0.228073] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
> > [    0.228091] pci 0000:00:1f.2: reg 0x24: [mem 0xf0708000-0xf07087=
ff]
> > [    0.228156] pci 0000:00:1f.2: PME# supported from D3hot
> > [    0.228451] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
> > [    0.228488] pci 0000:00:1f.3: reg 0x10: [mem 0xf0704000-0xf07040=
ff 64bit]
> > [    0.228535] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
> > [    0.229199] pci 0000:01:00.0: [8086:0091] type 00 class 0x028000
> > [    0.229806] pci 0000:01:00.0: reg 0x10: [mem 0xf0600000-0xf0601f=
ff 64bit]
> > [    0.231151] pci 0000:01:00.0: PME# supported from D0 D3hot D3col=
d
> > [    0.231376] pci 0000:01:00.0: System wakeup disabled by ACPI
> > [    0.239181] pci 0000:00:1c.0: PCI bridge to [bus 01]
> > [    0.239198] pci 0000:00:1c.0:   bridge window [mem 0xf0600000-0x=
f06fffff]
> > [    0.239412] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
> > [    0.239610] pci 0000:02:00.0: reg 0x10: [io  0x2000-0x20ff]
> > [    0.239747] pci 0000:02:00.0: reg 0x18: [mem 0xf0404000-0xf0404f=
ff 64bit pref]
> > [    0.239832] pci 0000:02:00.0: reg 0x20: [mem 0xf0400000-0xf0403f=
ff 64bit pref]
> > [    0.240123] pci 0000:02:00.0: supports D1 D2
> > [    0.240125] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot=
 D3cold
> > [    0.240264] pci 0000:02:00.0: System wakeup disabled by ACPI
> > [    0.247093] pci 0000:00:1c.3: PCI bridge to [bus 02]
> > [    0.247105] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff=
]
> > [    0.247120] pci 0000:00:1c.3:   bridge window [mem 0xf0400000-0x=
f04fffff 64bit pref]
> > [    0.247308] pci 0000:03:00.0: [1b21:1042] type 00 class 0x0c0330
> > [    0.247389] pci 0000:03:00.0: reg 0x10: [mem 0xf0500000-0xf0507f=
ff 64bit]
> > [    0.247605] pci 0000:03:00.0: PME# supported from D3hot D3cold
> > [    0.247878] pci 0000:00:1c.4: PCI bridge to [bus 03]
> > [    0.247894] pci 0000:00:1c.4:   bridge window [mem 0xf0500000-0x=
f05fffff]
> > [    0.249944] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *=
11 12 14 15)
> > [    0.250132] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 1=
1 12 14 15) *0, disabled.
> > [    0.250309] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *10 =
11 12 14 15)
> > [    0.250481] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 =
11 12 14 15)
> > [    0.250653] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 1=
1 12 14 15) *9
> > [    0.250826] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 1=
1 12 14 15) *0, disabled.
> > [    0.251047] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 10 *=
11 12 14 15)
> > [    0.251220] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 1=
1 12 14 15) *9
> > [    0.252586] ACPI: Enabled 4 GPEs in block 00 to 3F
> > [    0.252730] ACPI : EC: GPE =3D 0x17, I/O: command/status =3D 0x6=
6, data =3D 0x62
> > [    0.253064] ACPI : EC: 0 stale EC events cleared
> > [    0.253850] vgaarb: setting as boot device: PCI:0000:00:02.0
> > [    0.253858] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+=
mem,owns=3Dio+mem,locks=3Dnone
> > [    0.253874] vgaarb: loaded
> > [    0.253879] vgaarb: bridge control possible 0000:00:02.0
> > [    0.254579] SCSI subsystem initialized
> > [    0.254750] libata version 3.00 loaded.
> > [    0.254844] ACPI: bus type USB registered
> > [    0.254929] usbcore: registered new interface driver usbfs
> > [    0.254970] usbcore: registered new interface driver hub
> > [    0.255089] usbcore: registered new device driver usb
> > [    0.255564] PCI: Using ACPI for IRQ routing
> > [    0.259257] PCI: pci_cache_line_size set to 64 bytes
> > [    0.259388] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
> > [    0.259397] e820: reserve RAM buffer [mem 0xd9c9f000-0xdbffffff]
> > [    0.259400] e820: reserve RAM buffer [mem 0xdb000000-0xdbffffff]
> > [    0.259402] e820: reserve RAM buffer [mem 0x11fe00000-0x11ffffff=
f]
> > [    0.260193] NetLabel: Initializing
> > [    0.260199] NetLabel:  domain hash size =3D 128
> > [    0.260204] NetLabel:  protocols =3D UNLABELED CIPSOv4
> > [    0.260264] NetLabel:  unlabeled traffic allowed by default
> > [    0.260484] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0,=
 0
> > [    0.260498] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> > [    0.263609] clocksource: Switched to clocksource hpet
> > [    0.304691] AppArmor: AppArmor Filesystem Enabled
> > [    0.304963] pnp: PnP ACPI init
> > [    0.305650] system 00:00: [io  0x0680-0x069f] has been reserved
> > [    0.305661] system 00:00: [io  0x1000-0x100f] has been reserved
> > [    0.305669] system 00:00: [io  0x5000-0x5003] has been reserved
> > [    0.305676] system 00:00: [io  0xffff] has been reserved
> > [    0.305685] system 00:00: [io  0x0400-0x0453] could not be reser=
ved
> > [    0.305693] system 00:00: [io  0x0458-0x047f] has been reserved
> > [    0.305701] system 00:00: [io  0x0500-0x057f] has been reserved
> > [    0.305708] system 00:00: [io  0x0a00-0x0a0f] has been reserved
> > [    0.305716] system 00:00: [io  0x164e-0x164f] has been reserved
> > [    0.305724] system 00:00: [io  0x5000-0x500f] could not be reser=
ved
> > [    0.305766] system 00:00: Plug and Play ACPI device, IDs PNP0c02=
 (active)
> > [    0.305855] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (a=
ctive)
> > [    0.306011] system 00:02: [io  0x0454-0x0457] has been reserved
> > [    0.306023] system 00:02: Plug and Play ACPI device, IDs INT3f0d=
 PNP0c02 (active)
> > [    0.306119] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (a=
ctive)
> > [    0.306242] pnp 00:04: Plug and Play ACPI device, IDs ETD0b00 SY=
N0002 PNP0f13 (active)
> > [    0.306668] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been r=
eserved
> > [    0.306677] system 00:05: [mem 0xfed10000-0xfed17fff] has been r=
eserved
> > [    0.306686] system 00:05: [mem 0xfed18000-0xfed18fff] has been r=
eserved
> > [    0.306694] system 00:05: [mem 0xfed19000-0xfed19fff] has been r=
eserved
> > [    0.306702] system 00:05: [mem 0xf8000000-0xfbffffff] has been r=
eserved
> > [    0.306710] system 00:05: [mem 0xfed20000-0xfed3ffff] has been r=
eserved
> > [    0.306718] system 00:05: [mem 0xfed90000-0xfed93fff] has been r=
eserved
> > [    0.306726] system 00:05: [mem 0xfed45000-0xfed8ffff] has been r=
eserved
> > [    0.306734] system 00:05: [mem 0xff000000-0xffffffff] could not =
be reserved
> > [    0.306743] system 00:05: [mem 0xfee00000-0xfeefffff] could not =
be reserved
> > [    0.306754] system 00:05: Plug and Play ACPI device, IDs PNP0c02=
 (active)
> > [    0.307683] system 00:06: Plug and Play ACPI device, IDs PNP0c01=
 (active)
> > [    0.307739] pnp: PnP ACPI: found 7 devices
> > [    0.319020] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
> > [    0.319085] pci 0000:00:1c.0: PCI bridge to [bus 01]
> > [    0.319100] pci 0000:00:1c.0:   bridge window [mem 0xf0600000-0x=
f06fffff]
> > [    0.319120] pci 0000:00:1c.3: PCI bridge to [bus 02]
> > [    0.319128] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff=
]
> > [    0.319146] pci 0000:00:1c.3:   bridge window [mem 0xf0400000-0x=
f04fffff 64bit pref]
> > [    0.319164] pci 0000:00:1c.4: PCI bridge to [bus 03]
> > [    0.319176] pci 0000:00:1c.4:   bridge window [mem 0xf0500000-0x=
f05fffff]
> > [    0.319197] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
> > [    0.319199] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
> > [    0.319202] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
> > [    0.319204] pci_bus 0000:00: resource 7 [mem 0xdfa00000-0xfeafff=
ff window]
> > [    0.319206] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44f=
ff window]
> > [    0.319208] pci_bus 0000:01: resource 1 [mem 0xf0600000-0xf06fff=
ff]
> > [    0.319210] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> > [    0.319213] pci_bus 0000:02: resource 2 [mem 0xf0400000-0xf04fff=
ff 64bit pref]
> > [    0.319215] pci_bus 0000:03: resource 1 [mem 0xf0500000-0xf05fff=
ff]
> > [    0.319354] NET: Registered protocol family 2
> > [    0.320066] TCP established hash table entries: 32768 (order: 6,=
 262144 bytes)
> > [    0.320547] TCP bind hash table entries: 32768 (order: 9, 209715=
2 bytes)
> > [    0.322805] TCP: Hash tables configured (established 32768 bind =
32768)
> > [    0.322963] UDP hash table entries: 2048 (order: 6, 327680 bytes=
)
> > [    0.323327] UDP-Lite hash table entries: 2048 (order: 6, 327680 =
bytes)
> > [    0.323945] NET: Registered protocol family 1
> > [    0.323978] pci 0000:00:02.0: Video device with shadowed ROM
> > [    0.325621] PCI: CLS 64 bytes, default 64
> > [    0.325908] Trying to unpack rootfs image as initramfs...
> > [    0.410866] Freeing initrd memory: 3568K (ffff8800378f8000 - fff=
f880037c74000)
> > [    0.410888] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
> > [    0.410896] software IO TLB [mem 0xd5c9f000-0xd9c9f000] (64MB) m=
apped at [ffff8800d5c9f000-ffff8800d9c9efff]
> > [    0.411077] RAPL PMU detected, API unit is 2^-32 Joules, 3 fixed=
 counters 163840 ms ovfl timer
> > [    0.411087] hw unit of domain pp0-core 2^-16 Joules
> > [    0.411092] hw unit of domain package 2^-16 Joules
> > [    0.411098] hw unit of domain pp1-gpu 2^-16 Joules
> > [    0.411386] microcode: CPU0 sig=3D0x206a7, pf=3D0x10, revision=3D=
0x28
> > [    0.411410] microcode: CPU1 sig=3D0x206a7, pf=3D0x10, revision=3D=
0x28
> > [    0.411430] microcode: CPU2 sig=3D0x206a7, pf=3D0x10, revision=3D=
0x28
> > [    0.411454] microcode: CPU3 sig=3D0x206a7, pf=3D0x10, revision=3D=
0x28
> > [    0.411738] microcode: Microcode Update Driver: v2.00 <tigran@ai=
vazian.fsnet.co.uk>, Peter Oruba
> > [    0.411816] Scanning for low memory corruption every 60 seconds
> > [    0.413211] futex hash table entries: 2048 (order: 6, 262144 byt=
es)
> > [    0.413377] Initialise system trusted keyring
> > [    0.413525] audit: initializing netlink subsys (disabled)
> > [    0.413618] audit: type=3D2000 audit(1439238080.400:1): initiali=
zed
> > [    0.414717] HugeTLB registered 2 MB page size, pre-allocated 0 p=
ages
> > [    0.415273] VFS: Disk quotas dquot_6.6.0
> > [    0.415422] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
> > [    0.416380] fuse init (API version 7.23)
> > [    0.418760] Key type asymmetric registered
> > [    0.418788] Asymmetric key parser 'x509' registered
> > [    0.418848] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 251)
> > [    0.419014] io scheduler noop registered
> > [    0.419025] io scheduler deadline registered (default)
> > [    0.419070] io scheduler cfq registered
> > [    0.419079] start plist test
> > [    0.421511] end plist test
> > [    0.422616] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> > [    0.422642] pciehp: PCI Express Hot Plug Controller Driver versi=
on: 0.4
> > [    0.422865] intel_idle: MWAIT substates: 0x21120
> > [    0.422867] intel_idle: v0.4 model 0x2A
> > [    0.422868] intel_idle: lapic_timer_reliable_states 0xffffffff
> > [    0.424343] ACPI: AC Adapter [ADP1] (on-line)
> > [    0.424599] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:0=
0/PNP0C0D:00/input/input0
> > [    0.424653] ACPI: Lid Switch [LID0]
> > [    0.424799] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS=
:00/PNP0C0C:00/input/input1
> > [    0.424853] ACPI: Power Button [PWRB]
> > [    0.425002] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input2
> > [    0.425014] ACPI: Power Button [PWRF]
> > [    0.428822] thermal LNXTHERM:00: registered as thermal_zone0
> > [    0.428830] ACPI: Thermal Zone [TZ00] (65 C)
> > [    0.429627] thermal LNXTHERM:01: registered as thermal_zone1
> > [    0.429634] ACPI: Thermal Zone [TZ01] (30 C)
> > [    0.429763] GHES: HEST is not enabled!
> > [    0.430223] Serial: 8250/16550 driver, 32 ports, IRQ sharing ena=
bled
> > [    0.438570] ACPI: Battery Slot [BAT1] (battery present)
> > [    0.439678] Linux agpgart interface v0.103
> > [    0.448838] brd: module loaded
> > [    0.453148] loop: module loaded
> > [    0.457143] ahci 0000:00:1f.2: version 3.0
> > [    0.457550] ahci 0000:00:1f.2: SSS flag set, parallel bus scan d=
isabled
> > [    0.471532] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6=
 Gbps 0x1b impl SATA mode
> > [    0.471572] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag p=
m led clo pio slum part ems sxs apst
> > [    0.497787] scsi host0: ahci
> > [    0.498399] scsi host1: ahci
> > [    0.498935] scsi host2: ahci
> > [    0.499410] scsi host3: ahci
> > [    0.499829] scsi host4: ahci
> > [    0.500280] scsi host5: ahci
> > [    0.500489] ata1: SATA max UDMA/133 abar m2048@0xf0708000 port 0=
xf0708100 irq 25
> > [    0.500501] ata2: SATA max UDMA/133 abar m2048@0xf0708000 port 0=
xf0708180 irq 25
> > [    0.500510] ata3: DUMMY
> > [    0.500516] ata4: SATA max UDMA/133 abar m2048@0xf0708000 port 0=
xf0708280 irq 25
> > [    0.500526] ata5: SATA max UDMA/133 abar m2048@0xf0708000 port 0=
xf0708300 irq 25
> > [    0.500535] ata6: DUMMY
> > [    0.502190] libphy: Fixed MDIO Bus: probed
> > [    0.502589] tun: Universal TUN/TAP device driver, 1.6
> > [    0.502596] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.co=
m>
> > [    0.502787] PPP generic driver version 2.4.2
> > [    0.503172] xhci_hcd 0000:03:00.0: xHCI Host Controller
> > [    0.503379] xhci_hcd 0000:03:00.0: new USB bus registered, assig=
ned bus number 1
> > [    0.508006] xhci_hcd 0000:03:00.0: hcc params 0x0200f180 hci ver=
sion 0x96 quirks 0x00080000
> > [    0.508863] usb usb1: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0002
> > [    0.508871] usb usb1: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
> > [    0.508881] usb usb1: Product: xHCI Host Controller
> > [    0.508887] usb usb1: Manufacturer: Linux 4.2.0-rc6-1-iniza-smal=
l xhci-hcd
> > [    0.508893] usb usb1: SerialNumber: 0000:03:00.0
> > [    0.509812] hub 1-0:1.0: USB hub found
> > [    0.509918] hub 1-0:1.0: 2 ports detected
> > [    0.510952] xhci_hcd 0000:03:00.0: xHCI Host Controller
> > [    0.510970] xhci_hcd 0000:03:00.0: new USB bus registered, assig=
ned bus number 2
> > [    0.511110] usb usb2: We don't know the algorithms for LPM for t=
his host, disabling LPM.
> > [    0.511233] usb usb2: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0003
> > [    0.511241] usb usb2: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
> > [    0.511250] usb usb2: Product: xHCI Host Controller
> > [    0.511256] usb usb2: Manufacturer: Linux 4.2.0-rc6-1-iniza-smal=
l xhci-hcd
> > [    0.511262] usb usb2: SerialNumber: 0000:03:00.0
> > [    0.511924] hub 2-0:1.0: USB hub found
> > [    0.512005] hub 2-0:1.0: 2 ports detected
> > [    0.512627] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) =
Driver
> > [    0.512637] ehci-pci: EHCI PCI platform driver
> > [    0.512992] ehci-pci 0000:00:1a.0: EHCI Host Controller
> > [    0.513021] ehci-pci 0000:00:1a.0: new USB bus registered, assig=
ned bus number 3
> > [    0.513049] ehci-pci 0000:00:1a.0: debug port 2
> > [    0.516998] ehci-pci 0000:00:1a.0: cache line size of 64 is not =
supported
> > [    0.517032] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf070a000
> > [    0.527551] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> > [    0.527701] usb usb3: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0002
> > [    0.527708] usb usb3: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
> > [    0.527717] usb usb3: Product: EHCI Host Controller
> > [    0.527723] usb usb3: Manufacturer: Linux 4.2.0-rc6-1-iniza-smal=
l ehci_hcd
> > [    0.527730] usb usb3: SerialNumber: 0000:00:1a.0
> > [    0.528237] hub 3-0:1.0: USB hub found
> > [    0.528269] hub 3-0:1.0: 2 ports detected
> > [    0.529093] ehci-pci 0000:00:1d.0: EHCI Host Controller
> > [    0.529115] ehci-pci 0000:00:1d.0: new USB bus registered, assig=
ned bus number 4
> > [    0.529145] ehci-pci 0000:00:1d.0: debug port 2
> > [    0.533067] ehci-pci 0000:00:1d.0: cache line size of 64 is not =
supported
> > [    0.533095] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf0709000
> > [    0.543473] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> > [    0.543643] usb usb4: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0002
> > [    0.543651] usb usb4: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
> > [    0.543660] usb usb4: Product: EHCI Host Controller
> > [    0.543666] usb usb4: Manufacturer: Linux 4.2.0-rc6-1-iniza-smal=
l ehci_hcd
> > [    0.543672] usb usb4: SerialNumber: 0000:00:1d.0
> > [    0.544119] hub 4-0:1.0: USB hub found
> > [    0.544149] hub 4-0:1.0: 2 ports detected
> > [    0.544598] ehci-platform: EHCI generic platform driver
> > [    0.544636] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driv=
er
> > [    0.544657] ohci-pci: OHCI PCI platform driver
> > [    0.544697] ohci-platform: OHCI generic platform driver
> > [    0.544731] uhci_hcd: USB Universal Host Controller Interface dr=
iver
> > [    0.544875] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:EP=
AD] at 0x60,0x64 irq 1,12
> > [    0.550832] serio: i8042 KBD port at 0x60,0x64 irq 1
> > [    0.550897] serio: i8042 AUX port at 0x60,0x64 irq 12
> > [    0.551693] mousedev: PS/2 mouse device common for all mice
> > [    0.553017] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc=
0
> > [    0.553058] rtc_cmos 00:01: alarms up to one month, y3k, 242 byt=
es nvram, hpet irqs
> > [    0.553145] device-mapper: uevent: version 1.0.3
> > [    0.553447] device-mapper: ioctl: 4.32.0-ioctl (2015-6-26) initi=
alised: dm-devel@redhat.com
> > [    0.553485] Intel P-state driver initializing.
> > [    0.554711] ledtrig-cpu: registered to indicate activity on CPUs
> > [    0.555537] NET: Registered protocol family 10
> > [    0.557698] NET: Registered protocol family 17
> > [    0.557770] Key type dns_resolver registered
> > [    0.560280] input: AT Translated Set 2 keyboard as /devices/plat=
form/i8042/serio0/input/input3
> > [    0.561222] Loading compiled-in X.509 certificates
> > [    0.562479] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 87846484d150bea67f9ddf31e31367f5522e8926'
> > [    0.562527] registered taskstats version 1
> > [    0.572486] Key type trusted registered
> > [    0.583212] Key type encrypted registered
> > [    0.583230] AppArmor: AppArmor sha1 policy hashing enabled
> > [    0.583239] evm: HMAC attrs: 0x1
> > [    0.584338] rtc_cmos 00:01: setting system clock to 2015-08-10 2=
0:21:21 UTC (1439238081)
> > [    0.584548] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
> > [    0.584554] EDD information not available.
> > [    0.819392] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
> > [    0.820715] ata1.00: ATA-8: Hitachi HTS545050A7E380, GG2OA6C0, m=
ax UDMA/133
> > [    0.820740] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (dep=
th 31/32), AA
> > [    0.822102] ata1.00: configured for UDMA/133
> > [    0.823124] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS=
54505 A6C0 PQ: 0 ANSI: 5
> > [    0.824389] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks:=
 (500 GB/465 GiB)
> > [    0.824402] sd 0:0:0:0: [sda] 4096-byte physical blocks
> > [    0.824670] sd 0:0:0:0: [sda] Write Protect is off
> > [    0.824680] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > [    0.824810] sd 0:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
> > [    0.824811] sd 0:0:0:0: Attached scsi generic sg0 type 0
> > [    0.839306] usb 3-1: new high-speed USB device number 2 using eh=
ci-pci
> > [    0.855353] usb 4-1: new high-speed USB device number 2 using eh=
ci-pci
> > [    0.865534]  sda: sda1 sda2 sda3
> > [    0.867291] sd 0:0:0:0: [sda] Attached SCSI disk
> > [    0.972010] usb 3-1: New USB device found, idVendor=3D8087, idPr=
oduct=3D0024
> > [    0.972030] usb 3-1: New USB device strings: Mfr=3D0, Product=3D=
0, SerialNumber=3D0
> > [    0.973017] hub 3-1:1.0: USB hub found
> > [    0.973379] hub 3-1:1.0: 6 ports detected
> > [    0.988086] usb 4-1: New USB device found, idVendor=3D8087, idPr=
oduct=3D0024
> > [    0.988097] usb 4-1: New USB device strings: Mfr=3D0, Product=3D=
0, SerialNumber=3D0
> > [    0.988931] hub 4-1:1.0: USB hub found
> > [    0.989119] hub 4-1:1.0: 6 ports detected
> > [    1.143159] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
> > [    1.144046] ata2.00: ATA-8: SanDisk iSSD P4 16GB, SSD 9.14, max =
UDMA/133
> > [    1.144071] ata2.00: 31277232 sectors, multi 1: LBA48
> > [    1.144813] ata2.00: configured for UDMA/133
> > [    1.145181] scsi 1:0:0:0: Direct-Access     ATA      SanDisk iSS=
D P4  9.14 PQ: 0 ANSI: 5
> > [    1.146049] sd 1:0:0:0: [sdb] 31277232 512-byte logical blocks: =
(16.0 GB/14.9 GiB)
> > [    1.146159] sd 1:0:0:0: Attached scsi generic sg1 type 0
> > [    1.146416] sd 1:0:0:0: [sdb] Write Protect is off
> > [    1.146425] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> > [    1.146539] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
> > [    1.147982]  sdb: sdb1 sdb2
> > [    1.149342] sd 1:0:0:0: [sdb] Attached SCSI disk
> > [    1.247075] usb 3-1.4: new high-speed USB device number 3 using =
ehci-pci
> > [    1.263066] usb 4-1.4: new low-speed USB device number 3 using e=
hci-pci
> > [    1.362046] usb 4-1.4: New USB device found, idVendor=3D046d, id=
Product=3Dc00e
> > [    1.362057] usb 4-1.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> > [    1.362066] usb 4-1.4: Product: USB-PS/2 Optical Mouse
> > [    1.362071] usb 4-1.4: Manufacturer: Logitech
> > [    1.407072] tsc: Refined TSC clocksource calibration: 1596.374 M=
Hz
> > [    1.407083] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x1702c3a922f, max_idle_ns: 440795242034 ns
> > [    1.434941] usb 4-1.5: new full-speed USB device number 4 using =
ehci-pci
> > [    1.462933] ata4: SATA link down (SStatus 0 SControl 300)
> > [    1.499860] usb 3-1.4: New USB device found, idVendor=3D2232, id=
Product=3D1018
> > [    1.499872] usb 3-1.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> > [    1.499882] usb 3-1.4: Product: WebCam SC-13HDL11431N
> > [    1.499887] usb 3-1.4: Manufacturer: 123
> > [    1.532074] usb 4-1.5: New USB device found, idVendor=3D8086, id=
Product=3D0189
> > [    1.532085] usb 4-1.5: New USB device strings: Mfr=3D0, Product=3D=
0, SerialNumber=3D0
> > [    1.782705] ata5: SATA link down (SStatus 0 SControl 300)
> > [    1.783620] Freeing unused kernel memory: 1428K (ffffffff81d5800=
0 - ffffffff81ebd000)
> > [    1.783630] Write protecting the kernel read-only data: 12288k
> > [    1.784127] Freeing unused kernel memory: 124K (ffff8800017e1000=
 - ffff880001800000)
> > [    1.784556] Freeing unused kernel memory: 640K (ffff880001b60000=
 - ffff880001c00000)
> > [    1.824709] udevd[141]: starting version 175
> > [    2.045062] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> > [    2.045097] r8169 0000:02:00.0: can't disable ASPM; OS doesn't h=
ave ASPM control
> > [    2.047480] r8169 0000:02:00.0 eth0: RTL8168evl/8111evl at 0xfff=
fc900009ae000, e8:03:9a:36:17:a9, XID 0c900800 IRQ 31
> > [    2.047501] r8169 0000:02:00.0 eth0: jumbo features [frames: 920=
0 bytes, tx checksumming: ko]
> > [    2.173844] usbcore: registered new interface driver usbhid
> > [    2.173859] usbhid: USB HID core driver
> > [    2.248843] input: Logitech USB-PS/2 Optical Mouse as /devices/p=
ci0000:00/0000:00:1d.0/usb4/4-1/4-1.4/4-
> 1.4:1.0/0003:046D:C00E.0001/input/input5
> > [    2.249420] hid-generic 0003:046D:C00E.0001: input: USB HID v1.1=
0 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-
> 1.4/input0
> > [    2.406539] clocksource: Switched to clocksource tsc
> > [    3.017457] EXT4-fs (loop0): mounted filesystem with ordered dat=
a mode. Opts: (null)
> > [    3.531910] random: nonblocking pool is initialized
> > [    4.040967] usb 3-1.2: new high-speed USB device number 4 using =
ehci-pci
> > [    4.136025] usb 3-1.2: New USB device found, idVendor=3D12d1, id=
Product=3D1446
> > [    4.136036] usb 3-1.2: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D0
> > [    4.136044] usb 3-1.2: Product: HUAWEI Mobile
> > [    4.136049] usb 3-1.2: Manufacturer: HUAWEI Technology
> > [    5.449277] init: ureadahead main process (427) terminated with =
status 5
> > [    9.986567] Adding 262140k swap on /host/ubuntu/disks/swap.disk.=
  Priority:-1 extents:1 across:262140k FS
> > [   10.194584] EXT4-fs (loop0): re-mounted. Opts: errors=3Dremount-=
ro
> > [   10.393378] udevd[661]: starting version 175
> > [   11.533343] lp: driver loaded but no devices found
> > [   13.665906] ACPI Warning: SystemIO range 0x0000000000000428-0x00=
0000000000042F conflicts with OpRegion
> 0x0000000000000400-0x000000000000047F (\PMIO) (20150619/utaddress-254=
)
> > [   13.665916] ACPI: If an ACPI driver is available for this device=
, you should use it instead of the native driver
> > [   13.665922] ACPI Warning: SystemIO range 0x0000000000000540-0x00=
0000000000054F conflicts with OpRegion
> 0x0000000000000500-0x0000000000000563 (\GPIO) (20150619/utaddress-254=
)
> > [   13.665927] ACPI: If an ACPI driver is available for this device=
, you should use it instead of the native driver
> > [   13.665929] ACPI Warning: SystemIO range 0x0000000000000530-0x00=
0000000000053F conflicts with OpRegion
> 0x0000000000000500-0x0000000000000563 (\GPIO) (20150619/utaddress-254=
)
> > [   13.665933] ACPI: If an ACPI driver is available for this device=
, you should use it instead of the native driver
> > [   13.665935] ACPI Warning: SystemIO range 0x0000000000000500-0x00=
0000000000052F conflicts with OpRegion
> 0x0000000000000500-0x0000000000000563 (\GPIO) (20150619/utaddress-254=
)
> > [   13.665939] ACPI: If an ACPI driver is available for this device=
, you should use it instead of the native driver
> > [   13.665941] lpc_ich: Resource conflict(s) found affecting gpio_i=
ch
> > [   13.742870] wmi: Mapper loaded
> > [   13.896992] samsung_laptop: detected SABI interface: SwSmi@
> > [   14.317974] [drm] Initialized drm 1.1.0 20060810
> > [   15.239574] Bluetooth: Core ver 2.20
> > [   15.239659] NET: Registered protocol family 31
> > [   15.239663] Bluetooth: HCI device and connection manager initial=
ized
> > [   15.239774] Bluetooth: HCI socket layer initialized
> > [   15.239784] Bluetooth: L2CAP socket layer initialized
> > [   15.240191] Bluetooth: SCO socket layer initialized
> > [   15.251059] usbcore: registered new interface driver btusb
> > [   15.366567] psmouse serio1: elantech: assuming hardware version =
3 (with firmware version 0x450f00)
> > [   15.381624] psmouse serio1: elantech: Synaptics capabilities que=
ry result 0x08, 0x17, 0x0c.
> > [   15.396750] psmouse serio1: elantech: Elan sample query result 0=
3, 3f, 86
> > [   15.474665] input: ETPS/2 Elantech Touchpad as /devices/platform=
/i8042/serio1/input/input6
> > [   16.514266] usb-storage 3-1.2:1.0: USB Mass Storage device detec=
ted
> > [   16.514971] scsi host6: usb-storage 3-1.2:1.0
> > [   16.515344] usb-storage 3-1.2:1.1: USB Mass Storage device detec=
ted
> > [   16.515634] scsi host7: usb-storage 3-1.2:1.1
> > [   16.515987] usbcore: registered new interface driver usb-storage
> > [   16.652114] ppdev: user-space parallel port driver
> > [   16.708855] cfg80211: World regulatory domain updated:
> > [   16.708861] cfg80211:  DFS Master region: unset
> > [   16.708864] cfg80211:   (start_freq - end_freq @ bandwidth), (ma=
x_antenna_gain, max_eirp), (dfs_cac_time)
> > [   16.708870] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),=
 (300 mBi, 2000 mBm), (N/A)
> > [   16.708874] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz),=
 (300 mBi, 2000 mBm), (N/A)
> > [   16.708877] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),=
 (300 mBi, 2000 mBm), (N/A)
> > [   16.708880] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),=
 (300 mBi, 2000 mBm), (N/A)
> > [   16.708884] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),=
 (300 mBi, 2000 mBm), (N/A)
> > [   16.718812] audit: type=3D1400 audit(1439230897.639:2): apparmor=
=3D"STATUS" operation=3D"profile_load" name=3D"/sbin/dhclient"
> pid=3D954 comm=3D"apparmor_parser"
> > [   16.718824] audit: type=3D1400 audit(1439230897.639:3): apparmor=
=3D"STATUS" operation=3D"profile_load"
> name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D954 comm=
=3D"apparmor_parser"
> > [   16.718831] audit: type=3D1400 audit(1439230897.639:4): apparmor=
=3D"STATUS" operation=3D"profile_load"
> name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D954 comm=3D"a=
pparmor_parser"
> > [   16.719101] audit: type=3D1400 audit(1439230897.639:5): apparmor=
=3D"STATUS" operation=3D"profile_replace" name=3D"/sbin/dhclient"
> pid=3D980 comm=3D"apparmor_parser"
> > [   16.719115] audit: type=3D1400 audit(1439230897.639:6): apparmor=
=3D"STATUS" operation=3D"profile_replace"
> name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D980 comm=
=3D"apparmor_parser"
> > [   16.719126] audit: type=3D1400 audit(1439230897.639:7): apparmor=
=3D"STATUS" operation=3D"profile_replace"
> name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D980 comm=3D"a=
pparmor_parser"
> > [   16.719842] audit: type=3D1400 audit(1439230897.639:8): apparmor=
=3D"STATUS" operation=3D"profile_replace"
> name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D954 comm=
=3D"apparmor_parser"
> > [   16.719854] audit: type=3D1400 audit(1439230897.639:9): apparmor=
=3D"STATUS" operation=3D"profile_replace"
> name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D954 comm=3D"a=
pparmor_parser"
> > [   16.720050] audit: type=3D1400 audit(1439230897.643:10): apparmo=
r=3D"STATUS" operation=3D"profile_replace"
> name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D980 comm=
=3D"apparmor_parser"
> > [   16.720061] audit: type=3D1400 audit(1439230897.643:11): apparmo=
r=3D"STATUS" operation=3D"profile_replace"
> name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D980 comm=3D"a=
pparmor_parser"
> > [   17.230809] Linux video capture interface: v2.00
> > [   17.514072] scsi 7:0:0:0: Direct-Access     HUAWEI   SD Storage =
      2.31 PQ: 0 ANSI: 2
> > [   17.514136] scsi 6:0:0:0: CD-ROM            HUAWEI   Mass Storag=
e     2.31 PQ: 0 ANSI: 2
> > [   17.517436] sd 7:0:0:0: Attached scsi generic sg2 type 0
> > [   17.519836] sd 7:0:0:0: [sdc] Attached SCSI removable disk
> > [   17.538602] sr 6:0:0:0: [sr0] scsi-1 drive
> > [   17.538608] cdrom: Uniform CD-ROM driver Revision: 3.20
> > [   17.553020] Intel(R) Wireless WiFi driver for Linux
> > [   17.553025] Copyright(c) 2003- 2015 Intel Corporation
> > [   17.553470] iwlwifi 0000:01:00.0: can't disable ASPM; OS doesn't=
 have ASPM control
> > [   17.555321] sr 6:0:0:0: Attached scsi CD-ROM sr0
> > [   17.556939] sr 6:0:0:0: Attached scsi generic sg3 type 5
> > [   17.856201] uvcvideo: Found UVC 1.00 device WebCam SC-13HDL11431=
N (2232:1018)
> > [   17.876158] input: WebCam SC-13HDL11431N as /devices/pci0000:00/=
0000:00:1a.0/usb3/3-1/3-1.4/3-1.4:1.0/input/input7
> > [   17.876737] usbcore: registered new interface driver uvcvideo
> > [   17.876742] USB Video Class driver (1.1.1)
> > [   17.952917] init: failsafe main process (1065) killed by TERM si=
gnal
> > [   18.150795] iwlwifi 0000:01:00.0: loaded firmware version 18.168=
=2E6.1 op_mode iwldvm
> > [   18.246252] [drm] Memory usable by graphics device =3D 2048M
> > [   18.246326] [drm] Replacing VGA console driver
> > [   18.255139] [drm] Supports vblank timestamp caching Rev 2 (21.10=
=2E2013).
> > [   18.255142] [drm] Driver supports precise vblank timestamp query=
=2E
> > [   18.255943] vgaarb: device changed decodes: PCI:0000:00:02.0,old=
decodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> > [   18.269783]
> > [   18.269792] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   18.269798] [ INFO: possible circular locking dependency detecte=
d ]
> > [   18.269805] 4.2.0-rc6-1-iniza-small #1 Not tainted
> > [   18.269810] ----------------------------------------------------=
---
> > [   18.269816] modprobe/727 is trying to acquire lock:
> > [   18.269822]  (init_mutex){+.+.+.}, at: [<ffffffffa0090f2d>] acpi=
_video_get_backlight_type+0x17/0x164 [video]
> > [   18.269840]
> > [   18.269840] but task is already holding lock:
> > [   18.269848]  (&(&backlight_notifier)->rwsem){++++..}, at: [<ffff=
ffff810a6519>] __blocking_notifier_call_chain+0x39/0x70
> > [   18.269864]
> > [   18.269864] which lock already depends on the new lock.
> > [   18.269864]
> > [   18.269875]
> > [   18.269875] the existing dependency chain (in reverse order) is:
> > [   18.269884]
> > [   18.269884] -> #1 (&(&backlight_notifier)->rwsem){++++..}:
> > [   18.269894]        [<ffffffff810da59f>] lock_acquire+0xcf/0x280
> > [   18.269902]        [<ffffffff817d6769>] down_write+0x49/0x80
> > [   18.269910]        [<ffffffff810a6691>] blocking_notifier_chain_=
register+0x21/0xb0
> > [   18.269920]        [<ffffffff81461ca8>] backlight_register_notif=
ier+0x18/0x20
> > [   18.269930]        [<ffffffffa0091010>] acpi_video_get_backlight=
_type+0xfa/0x164 [video]
> > [   18.269940]        [<ffffffffa00a40e9>] snd_timer_reschedule+0x2=
9/0xa0 [snd_timer]
> > [   18.269952]        [<ffffffff810020f8>] do_one_initcall+0x88/0x1=
c0
> > [   18.269960]        [<ffffffff817cd082>] do_init_module+0x61/0x1e=
c
> > [   18.269968]        [<ffffffff8111fbb8>] load_module+0x2008/0x25c=
0
> > [   18.269976]        [<ffffffff81120296>] SyS_init_module+0x126/0x=
140
> > [   18.269983]        [<ffffffff817d9332>] entry_SYSCALL_64_fastpat=
h+0x16/0x7a
> > [   18.269992]
> > [   18.269992] -> #0 (init_mutex){+.+.+.}:
> > [   18.270001]        [<ffffffff810d98cd>] __lock_acquire+0x1f5d/0x=
21c0
> > [   18.270008]        [<ffffffff810da59f>] lock_acquire+0xcf/0x280
> > [   18.270015]        [<ffffffff817d4775>] mutex_lock_nested+0x65/0=
x3c0
> > [   18.270022]        [<ffffffffa0090f2d>] acpi_video_get_backlight=
_type+0x17/0x164 [video]
> > [   18.270032]        [<ffffffffa00910b2>] acpi_video_backlight_not=
ify+0x19/0x2f [video]
> > [   18.270043]        [<ffffffff810a631d>] notifier_call_chain+0x5d=
/0x80
> > [   18.270050]        [<ffffffff810a6531>] __blocking_notifier_call=
_chain+0x51/0x70
> > [   18.270060]        [<ffffffff810a6566>] blocking_notifier_call_c=
hain+0x16/0x20
> > [   18.270069]        [<ffffffff81461fe7>] backlight_device_registe=
r+0x197/0x240
> > [   18.270077]        [<ffffffffa044cb83>] intel_backlight_register=
+0xb3/0x180 [i915]
> > [   18.270126]        [<ffffffffa041f166>] intel_modeset_gem_init+0=
x176/0x190 [i915]
> > [   18.270162]        [<ffffffffa0454172>] i915_driver_load+0xf12/0=
x14d0 [i915]
> > [   18.270197]        [<ffffffffa00d8861>] drm_dev_register+0xb1/0x=
100 [drm]
> > [   18.270216]        [<ffffffffa00db62d>] drm_get_pci_dev+0x8d/0x1=
e0 [drm]
> > [   18.270231]        [<ffffffffa039f1fb>] i915_pci_probe+0x3b/0x60=
 [i915]
> > [   18.270255]        [<ffffffff81431a95>] local_pci_probe+0x45/0xa=
0
> > [   18.270263]        [<ffffffff81432e5d>] pci_device_probe+0xcd/0x=
120
> > [   18.270271]        [<ffffffff8152d6a6>] driver_probe_device+0x13=
6/0x2e0
> > [   18.270278]        [<ffffffff8152d8e4>] __driver_attach+0x94/0xa=
0
> > [   18.270285]        [<ffffffff8152b636>] bus_for_each_dev+0x66/0x=
a0
> > [   18.270293]        [<ffffffff8152d1de>] driver_attach+0x1e/0x20
> > [   18.270301]        [<ffffffff8152cdd8>] bus_add_driver+0x1b8/0x2=
30
> > [   18.270309]        [<ffffffff8152e880>] driver_register+0x60/0xe=
0
> > [   18.270316]        [<ffffffff81431354>] __pci_register_driver+0x=
64/0x70
> > [   18.270323]        [<ffffffffa00db860>] drm_pci_init+0xe0/0x110 =
[drm]
> > [   18.270337]        [<ffffffffa04bb0a0>] i915_init+0xa0/0xa8 [i91=
5]
> > [   18.270359]        [<ffffffff810020f8>] do_one_initcall+0x88/0x1=
c0
> > [   18.270367]        [<ffffffff817cd082>] do_init_module+0x61/0x1e=
c
> > [   18.270374]        [<ffffffff8111fbb8>] load_module+0x2008/0x25c=
0
> > [   18.270381]        [<ffffffff81120296>] SyS_init_module+0x126/0x=
140
> > [   18.270388]        [<ffffffff817d9332>] entry_SYSCALL_64_fastpat=
h+0x16/0x7a
> > [   18.270396]
> > [   18.270396] other info that might help us debug this:
> > [   18.270396]
> > [   18.270408]  Possible unsafe locking scenario:
> > [   18.270408]
> > [   18.270416]        CPU0                    CPU1
> > [   18.270421]        ----                    ----
> > [   18.270426]   lock(&(&backlight_notifier)->rwsem);
> > [   18.270433]                                lock(init_mutex);
> > [   18.270439]                                lock(&(&backlight_not=
ifier)->rwsem);
> > [   18.270448]   lock(init_mutex);
> > [   18.270454]
> > [   18.270454]  *** DEADLOCK ***
> > [   18.270454]
> > [   18.270465] 4 locks held by modprobe/727:
> > [   18.270470]  #0:  (&dev->mutex){......}, at: [<ffffffff8152d89b>=
] __driver_attach+0x4b/0xa0
> > [   18.270483]  #1:  (&dev->mutex){......}, at: [<ffffffff8152d8a9>=
] __driver_attach+0x59/0xa0
> > [   18.270495]  #2:  (drm_global_mutex){+.+.+.}, at: [<ffffffffa00d=
87d6>] drm_dev_register+0x26/0x100 [drm]
> > [   18.270514]  #3:  (&(&backlight_notifier)->rwsem){++++..}, at: [=
<ffffffff810a6519>] __blocking_notifier_call_chain+0x39/0x70
> > [   18.270528]
> > [   18.270528] stack backtrace:
> > [   18.270537] CPU: 0 PID: 727 Comm: modprobe Not tainted 4.2.0-rc6=
-1-iniza-small #1
> > [   18.270546] Hardware name: SAMSUNG ELECTRONICS CO., LTD. 530U3BI=
/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS
> 13XK 03/28/2013
> > [   18.270557]  ffffffff826a09c0 ffff8800c8c774b8 ffffffff817cf189 =
0000000000000011
> > [   18.270568]  ffffffff826a09c0 ffff8800c8c77508 ffffffff817cc674 =
ffff8800d40e4e40
> > [   18.270579]  ffff8800c8c77578 ffff8800d40e5710 0000000000000004 =
ffff8800d40e5710
> > [   18.270590] Call Trace:
> > [   18.270596]  [<ffffffff817cf189>] dump_stack+0x4c/0x65
> > [   18.270603]  [<ffffffff817cc674>] print_circular_bug+0x20b/0x21c
> > [   18.270611]  [<ffffffff810d98cd>] __lock_acquire+0x1f5d/0x21c0
> > [   18.270618]  [<ffffffff810da59f>] lock_acquire+0xcf/0x280
> > [   18.270626]  [<ffffffffa0090f2d>] ? acpi_video_get_backlight_typ=
e+0x17/0x164 [video]
> > [   18.270636]  [<ffffffff817d4775>] mutex_lock_nested+0x65/0x3c0
> > [   18.270644]  [<ffffffffa0090f2d>] ? acpi_video_get_backlight_typ=
e+0x17/0x164 [video]
> > [   18.270654]  [<ffffffffa0090f2d>] acpi_video_get_backlight_type+=
0x17/0x164 [video]
> > [   18.270665]  [<ffffffffa00910b2>] acpi_video_backlight_notify+0x=
19/0x2f [video]
> > [   18.270674]  [<ffffffff810a631d>] notifier_call_chain+0x5d/0x80
> > [   18.270681]  [<ffffffff810a6531>] __blocking_notifier_call_chain=
+0x51/0x70
> > [   18.270689]  [<ffffffff810a6566>] blocking_notifier_call_chain+0=
x16/0x20
> > [   18.270697]  [<ffffffff81461fe7>] backlight_device_register+0x19=
7/0x240
> > [   18.270730]  [<ffffffffa044cb83>] intel_backlight_register+0xb3/=
0x180 [i915]
> > [   18.270762]  [<ffffffffa041f166>] intel_modeset_gem_init+0x176/0=
x190 [i915]
> > [   18.270794]  [<ffffffffa0454172>] i915_driver_load+0xf12/0x14d0 =
[i915]
> > [   18.270802]  [<ffffffff810d7419>] ? mark_held_locks+0x69/0x90
> > [   18.270808]  [<ffffffff817d61d0>] ? __mutex_unlock_slowpath+0xc0=
/0x180
> > [   18.270816]  [<ffffffff810d7419>] ? mark_held_locks+0x69/0x90
> > [   18.270823]  [<ffffffff817d89d6>] ? _raw_spin_unlock_irqrestore+=
0x36/0x60
> > [   18.270830]  [<ffffffff810d7591>] ? trace_hardirqs_on_caller+0x1=
51/0x1e0
> > [   18.270838]  [<ffffffff810d762d>] ? trace_hardirqs_on+0xd/0x10
> > [   18.270852]  [<ffffffffa00d8861>] drm_dev_register+0xb1/0x100 [d=
rm]
> > [   18.270866]  [<ffffffffa00db62d>] drm_get_pci_dev+0x8d/0x1e0 [dr=
m]
> > [   18.270890]  [<ffffffffa039f1fb>] i915_pci_probe+0x3b/0x60 [i915=
]
> > [   18.270897]  [<ffffffff81431a95>] local_pci_probe+0x45/0xa0
> > [   18.270903]  [<ffffffff81432d20>] ? pci_match_device+0xe0/0x110
> > [   18.270910]  [<ffffffff81432e5d>] pci_device_probe+0xcd/0x120
> > [   18.270918]  [<ffffffff8152d6a6>] driver_probe_device+0x136/0x2e=
0
> > [   18.270924]  [<ffffffff8152d8e4>] __driver_attach+0x94/0xa0
> > [   18.270931]  [<ffffffff8152d850>] ? driver_probe_device+0x2e0/0x=
2e0
> > [   18.270938]  [<ffffffff8152b636>] bus_for_each_dev+0x66/0xa0
> > [   18.270946]  [<ffffffff8152d1de>] driver_attach+0x1e/0x20
> > [   18.270953]  [<ffffffff8152cdd8>] bus_add_driver+0x1b8/0x230
> > [   18.270960]  [<ffffffff8152e880>] driver_register+0x60/0xe0
> > [   18.270967]  [<ffffffff81431354>] __pci_register_driver+0x64/0x7=
0
> > [   18.270980]  [<ffffffffa00db860>] drm_pci_init+0xe0/0x110 [drm]
> > [   18.270987]  [<ffffffffa04bb000>] ? 0xffffffffa04bb000
> > [   18.271008]  [<ffffffffa04bb0a0>] i915_init+0xa0/0xa8 [i915]
> > [   18.271015]  [<ffffffff810020f8>] do_one_initcall+0x88/0x1c0
> > [   18.271023]  [<ffffffff817cd049>] ? do_init_module+0x28/0x1ec
> > [   18.271030]  [<ffffffff817cd082>] do_init_module+0x61/0x1ec
> > [   18.271037]  [<ffffffff8111fbb8>] load_module+0x2008/0x25c0
> > [   18.271044]  [<ffffffff8111b5a0>] ? m_show+0x1a0/0x1a0
> > [   18.271052]  [<ffffffff817d9f73>] ? retint_kernel+0x10/0x10
> > [   18.271060]  [<ffffffff81120296>] SyS_init_module+0x126/0x140
> > [   18.271067]  [<ffffffff817d9332>] entry_SYSCALL_64_fastpath+0x16=
/0x7a
> > [   18.272671] ACPI: Video Device [GFX0] (multi-head: yes  rom: no =
 post: no)
> > [   18.272855] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00=
/PNP0A08:00/LNXVIDEO:00/input/input8
> > [   18.273042] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02=
=2E0 on minor 0
> > [   18.282710] fbcon: inteldrmfb (fb0) is primary device
> > [   18.434591] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > [   18.434592] Bluetooth: BNEP filters: protocol multicast
> > [   18.434598] Bluetooth: BNEP socket layer initialized
> > [   18.435534] Bluetooth: RFCOMM TTY layer initialized
> > [   18.435541] Bluetooth: RFCOMM socket layer initialized
> > [   18.435552] Bluetooth: RFCOMM ver 1.11
> > [   18.681374] usb 3-1.2: USB disconnect, device number 4
> > [   19.216760] Console: switching to colour frame buffer device 170=
x48
> > [   19.219970] i915 0000:00:02.0: fb0: inteldrmfb frame buffer devi=
ce
> > [   19.219971] i915 0000:00:02.0: registered panic notifier
> > [   20.250828] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUG disabled
> > [   20.250867] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
> > [   20.250898] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEVICE_TRACING =
enabled
> > [   20.250931] iwlwifi 0000:01:00.0: Detected Intel(R) Centrino(R) =
Advanced-N 6230 AGN, REV=3D0xB0
> > [   20.251073] iwlwifi 0000:01:00.0: L1 Enabled - LTR Disabled
> > [   20.396164] ieee80211 phy0: Selected rate control algorithm 'iwl=
-agn-rs'
> > [   21.711882] snd_hda_codec_realtek hdaudioC0D0: autoconfig for AL=
C269VC: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> > [   21.711975] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D=
0 (0x0/0x0/0x0/0x0/0x0)
> > [   21.712025] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0=
x15/0x0/0x0/0x0/0x0)
> > [   21.712062] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=
=3D0x0
> > [   21.712096] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> > [   21.712145] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=
=3D0x19
> > [   21.712183] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
> > [   21.812212] input: HDA Intel PCH Mic as /devices/pci0000:00/0000=
:00:1b.0/sound/card0/input9
> > [   21.812700] input: HDA Intel PCH Headphone as /devices/pci0000:0=
0/0000:00:1b.0/sound/card0/input10
> > [   21.813043] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci=
0000:00/0000:00:1b.0/sound/card0/input11
> > [   21.842948] audit_printk_skb: 63 callbacks suppressed
> > [   21.842985] audit: type=3D1400 audit(1439230902.767:33): apparmo=
r=3D"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evince"
> pid=3D1283 comm=3D"apparmor_parser"
> > [   21.843859] audit: type=3D1400 audit(1439230902.767:34): apparmo=
r=3D"STATUS" operation=3D"profile_load"
> name=3D"launchpad_integration" pid=3D1283 comm=3D"apparmor_parser"
> > [   21.844740] audit: type=3D1400 audit(1439230902.771:35): apparmo=
r=3D"STATUS" operation=3D"profile_load" name=3D"sanitized_helper"
> pid=3D1283 comm=3D"apparmor_parser"
> > [   21.845641] audit: type=3D1400 audit(1439230902.771:36): apparmo=
r=3D"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evince-
> previewer" pid=3D1283 comm=3D"apparmor_parser"
> > [   21.846542] audit: type=3D1400 audit(1439230902.771:37): apparmo=
r=3D"STATUS" operation=3D"profile_load"
> name=3D"launchpad_integration" pid=3D1283 comm=3D"apparmor_parser"
> > [   21.847451] audit: type=3D1400 audit(1439230902.771:38): apparmo=
r=3D"STATUS" operation=3D"profile_load" name=3D"sanitized_helper"
> pid=3D1283 comm=3D"apparmor_parser"
> > [   21.848422] audit: type=3D1400 audit(1439230902.775:39): apparmo=
r=3D"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evince-
> thumbnailer" pid=3D1283 comm=3D"apparmor_parser"
> > [   21.849377] audit: type=3D1400 audit(1439230902.775:40): apparmo=
r=3D"STATUS" operation=3D"profile_load" name=3D"sanitized_helper"
> pid=3D1283 comm=3D"apparmor_parser"
> > [   21.858744] audit: type=3D1400 audit(1439230902.783:41): apparmo=
r=3D"STATUS" operation=3D"profile_replace"
> name=3D"launchpad_integration" pid=3D1283 comm=3D"apparmor_parser"
> > [   21.859611] audit: type=3D1400 audit(1439230902.783:42): apparmo=
r=3D"STATUS" operation=3D"profile_replace"
> name=3D"sanitized_helper" pid=3D1283 comm=3D"apparmor_parser"
> > [   22.459901] usb 3-1.2: new high-speed USB device number 5 using =
ehci-pci
> > [   22.554575] usb 3-1.2: New USB device found, idVendor=3D12d1, id=
Product=3D1436
> > [   22.555649] usb 3-1.2: New USB device strings: Mfr=3D4, Product=3D=
3, SerialNumber=3D0
> > [   22.557297] usb 3-1.2: Product: HUAWEI Mobile
> > [   22.559023] usb 3-1.2: Manufacturer: HUAWEI Technology
> > [   22.563902] usb-storage 3-1.2:1.0: USB Mass Storage device detec=
ted
> > [   22.566018] usb-storage 3-1.2:1.1: USB Mass Storage device detec=
ted
> > [   22.568008] usb-storage 3-1.2:1.2: USB Mass Storage device detec=
ted
> > [   22.569979] usb-storage 3-1.2:1.3: USB Mass Storage device detec=
ted
> > [   22.571945] usb-storage 3-1.2:1.4: USB Mass Storage device detec=
ted
> > [   22.573874] usb-storage 3-1.2:1.5: USB Mass Storage device detec=
ted
> > [   22.576326] scsi host13: usb-storage 3-1.2:1.5
> > [   22.578315] usb-storage 3-1.2:1.6: USB Mass Storage device detec=
ted
> > [   22.580467] scsi host14: usb-storage 3-1.2:1.6
> > [   22.774138] usbcore: registered new interface driver usbserial
> > [   22.798789] cdc_ether 3-1.2:1.1 wwan0: register 'cdc_ether' at u=
sb-0000:00:1a.0-1.2, Mobile Broadband Network Device,
> 02:50:f3:00:00:00
> > [   22.800656] usbcore: registered new interface driver cdc_ether
> > [   23.202323] usbcore: registered new interface driver option
> > [   23.203782] usbserial: USB Serial support registered for GSM mod=
em (1-port)
> > [   23.205337] option 3-1.2:1.0: GSM modem (1-port) converter detec=
ted
> > [   23.206638] usb 3-1.2: GSM modem (1-port) converter now attached=
 to ttyUSB0
> > [   23.207909] option 3-1.2:1.3: GSM modem (1-port) converter detec=
ted
> > [   23.209234] usb 3-1.2: GSM modem (1-port) converter now attached=
 to ttyUSB1
> > [   23.210451] option 3-1.2:1.4: GSM modem (1-port) converter detec=
ted
> > [   23.211816] usb 3-1.2: GSM modem (1-port) converter now attached=
 to ttyUSB2
> > [   23.576666] scsi 13:0:0:0: CD-ROM            HUAWEI   Mass Stora=
ge     2.31 PQ: 0 ANSI: 2
> > [   23.580741] sr 13:0:0:0: [sr0] scsi-1 drive
> > [   23.581991] scsi 14:0:0:0: Direct-Access     HUAWEI   SD Storage=
       2.31 PQ: 0 ANSI: 2
> > [   23.584641] sr 13:0:0:0: Attached scsi CD-ROM sr0
> > [   23.586672] sr 13:0:0:0: Attached scsi generic sg2 type 5
> > [   23.588938] sd 14:0:0:0: Attached scsi generic sg3 type 0
> > [   23.596608] sd 14:0:0:0: [sdc] Attached SCSI removable disk
> > [   25.991485] r8169 0000:02:00.0 eth0: link down
> > [   25.993137] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> > [   26.134956] snd_hda_intel 0000:00:1b.0: control 2:0:0:PCM Playba=
ck Volume:0 is already present
> > [   26.262594] init: alsa-restore main process (1374) terminated wi=
th status 99
> > [   65.193371] PPP BSD Compression module registered
> > [   65.232443] PPP Deflate Compression module registered
> > [   67.303582] usb 4-1.5: USB disconnect, device number 4
>=20
>=20
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>=20
>=20
> --
> Ville Syrj=E4l=E4
> Intel OTC
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
