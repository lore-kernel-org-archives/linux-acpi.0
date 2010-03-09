From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: 2.6.34-rc1: ACPI: BUG: key f71f0168 not in .data!
Date: Tue, 9 Mar 2010 08:40:25 +0800
Message-ID: <20100309004025.GC2722@hack>
References: <a4423d671003081547v5c955d58t248db945c06d2a7f@mail.gmail.com> <86802c441003081612r2f44efd6n9664b4b7c98a636a@mail.gmail.com> <86802c441003081632g32d35c8arcb50608dd0dcf714@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86802c441003081632g32d35c8arcb50608dd0dcf714@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2010 at 04:32:36PM -0800, Yinghai Lu wrote:
>> [ =C2=A0145.239329] BUG: key ffff88206fe99c58 not in .data!
>> [ =C2=A0145.244994] ------------[ cut here ]------------
>> [ =C2=A0145.250949] WARNING: at kernel/lockdep.c:2706 lockdep_init_m=
ap+0xf1/0x53c()
>> [ =C2=A0145.267543] Modules linked in:
>> [ =C2=A0145.275078] Pid: 1, comm: swapper Not tainted 2.6.34-rc1-yh-=
dirty #221
>> [ =C2=A0145.285140] Call Trace:
>> [ =C2=A0145.290143] =C2=A0[<ffffffff810759b0>] warn_slowpath_common+=
0x7c/0x94
>> [ =C2=A0145.304624] =C2=A0[<ffffffff810759dc>] warn_slowpath_null+0x=
14/0x16
>> [ =C2=A0145.314632] =C2=A0[<ffffffff8109f299>] lockdep_init_map+0xf1=
/0x53c
>> [ =C2=A0145.325228] =C2=A0[<ffffffff8117e100>] ? sysfs_new_dirent+0x=
8f/0x104
>> [ =C2=A0145.334331] =C2=A0[<ffffffff8117d72e>] sysfs_add_file_mode+0=
x66/0xac
>> [ =C2=A0145.339850] =C2=A0[<ffffffff8117d785>] sysfs_add_file+0x11/0=
x13
>> [ =C2=A0145.355513] =C2=A0[<ffffffff8117d844>] sysfs_create_file+0x2=
a/0x2c
>> [ =C2=A0145.360637] =C2=A0[<ffffffff8148ca98>] device_create_file+0x=
19/0x1b
>> [ =C2=A0145.375187] =C2=A0[<ffffffff8145fc9a>] ipmi_register_smi+0x8=
62/0xd72
>> [ =C2=A0145.384606] =C2=A0[<ffffffff8148b9f8>] ? put_device+0x17/0x1=
9
>> [ =C2=A0145.395142] =C2=A0[<ffffffff8148cee5>] ? device_add+0x44b/0x=
52a
>> [ =C2=A0145.403666] =C2=A0[<ffffffff8108fb5a>] ? autoremove_wake_fun=
ction+0x0/0x39
>> [ =C2=A0145.416309] =C2=A0[<ffffffff81462e71>] try_smi_init+0x6d0/0x=
8a0
>> [ =C2=A0145.424534] =C2=A0[<ffffffff81ba2fd5>] init_ipmi_si+0x4cf/0x=
907
>> [ =C2=A0145.434799] =C2=A0[<ffffffff81ba2b06>] ? init_ipmi_si+0x0/0x=
907
>> [ =C2=A0145.439677] =C2=A0[<ffffffff8100020d>] do_one_initcall+0x72/=
0x17f
>> [ =C2=A0145.455681] =C2=A0[<ffffffff826836a0>] kernel_init+0x166/0x1=
f0
>> [ =C2=A0145.463319] =C2=A0[<ffffffff81032914>] kernel_thread_helper+=
0x4/0x10
>> [ =C2=A0145.476497] =C2=A0[<ffffffff81bfc2bc>] ? restore_args+0x0/0x=
30
>> [ =C2=A0145.485014] =C2=A0[<ffffffff8268353a>] ? kernel_init+0x0/0x1=
f0
>> [ =C2=A0145.495859] =C2=A0[<ffffffff81032910>] ? kernel_thread_helpe=
r+0x0/0x10
>> [ =C2=A0145.501541] ---[ end trace 0ec12b1482c47368 ]---
>
>related to ?
>commit a2db6842873c8e5a70652f278d469128cb52db70

Yes. Need to add sysfs_attr_init() or sysfs_bin_attr_init() in the
driver code.

--=20
Live like a child, think like the god.
=20
