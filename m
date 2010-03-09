From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: 2.6.34-rc1: ACPI: BUG: key f71f0168 not in .data!
Date: Mon, 8 Mar 2010 16:32:36 -0800
Message-ID: <86802c441003081632g32d35c8arcb50608dd0dcf714@mail.gmail.com>
References: <a4423d671003081547v5c955d58t248db945c06d2a7f@mail.gmail.com>
	 <86802c441003081612r2f44efd6n9664b4b7c98a636a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86802c441003081612r2f44efd6n9664b4b7c98a636a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> [ =A0145.239329] BUG: key ffff88206fe99c58 not in .data!
> [ =A0145.244994] ------------[ cut here ]------------
> [ =A0145.250949] WARNING: at kernel/lockdep.c:2706 lockdep_init_map+0=
xf1/0x53c()
> [ =A0145.267543] Modules linked in:
> [ =A0145.275078] Pid: 1, comm: swapper Not tainted 2.6.34-rc1-yh-dirt=
y #221
> [ =A0145.285140] Call Trace:
> [ =A0145.290143] =A0[<ffffffff810759b0>] warn_slowpath_common+0x7c/0x=
94
> [ =A0145.304624] =A0[<ffffffff810759dc>] warn_slowpath_null+0x14/0x16
> [ =A0145.314632] =A0[<ffffffff8109f299>] lockdep_init_map+0xf1/0x53c
> [ =A0145.325228] =A0[<ffffffff8117e100>] ? sysfs_new_dirent+0x8f/0x10=
4
> [ =A0145.334331] =A0[<ffffffff8117d72e>] sysfs_add_file_mode+0x66/0xa=
c
> [ =A0145.339850] =A0[<ffffffff8117d785>] sysfs_add_file+0x11/0x13
> [ =A0145.355513] =A0[<ffffffff8117d844>] sysfs_create_file+0x2a/0x2c
> [ =A0145.360637] =A0[<ffffffff8148ca98>] device_create_file+0x19/0x1b
> [ =A0145.375187] =A0[<ffffffff8145fc9a>] ipmi_register_smi+0x862/0xd7=
2
> [ =A0145.384606] =A0[<ffffffff8148b9f8>] ? put_device+0x17/0x19
> [ =A0145.395142] =A0[<ffffffff8148cee5>] ? device_add+0x44b/0x52a
> [ =A0145.403666] =A0[<ffffffff8108fb5a>] ? autoremove_wake_function+0=
x0/0x39
> [ =A0145.416309] =A0[<ffffffff81462e71>] try_smi_init+0x6d0/0x8a0
> [ =A0145.424534] =A0[<ffffffff81ba2fd5>] init_ipmi_si+0x4cf/0x907
> [ =A0145.434799] =A0[<ffffffff81ba2b06>] ? init_ipmi_si+0x0/0x907
> [ =A0145.439677] =A0[<ffffffff8100020d>] do_one_initcall+0x72/0x17f
> [ =A0145.455681] =A0[<ffffffff826836a0>] kernel_init+0x166/0x1f0
> [ =A0145.463319] =A0[<ffffffff81032914>] kernel_thread_helper+0x4/0x1=
0
> [ =A0145.476497] =A0[<ffffffff81bfc2bc>] ? restore_args+0x0/0x30
> [ =A0145.485014] =A0[<ffffffff8268353a>] ? kernel_init+0x0/0x1f0
> [ =A0145.495859] =A0[<ffffffff81032910>] ? kernel_thread_helper+0x0/0=
x10
> [ =A0145.501541] ---[ end trace 0ec12b1482c47368 ]---

related to ?
commit a2db6842873c8e5a70652f278d469128cb52db70
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Feb 11 15:20:00 2010 -0800

    sysfs: Only take active references on attributes.

    If we exclude directories and symlinks from the set of sysfs
    dirents where we need active references we are left with
    sysfs attributes (binary or not).

    - Tweak sysfs_deactivate to only do something on attributes
    - Move lockdep initialization into sysfs_file_add_mode to
      limit it to just attributes.
