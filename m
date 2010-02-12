From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: mmotm 2010-02-10 - lockdep whinge in ACPI code
Date: Fri, 12 Feb 2010 10:11:30 +0800
Message-ID: <a8e1da1002111811l104027d7uc126bdb960b675e6@mail.gmail.com>
References: <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>
	 <5114.1265865104@localhost>
	 <20100210212655.7784dc5b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:62888 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab0BLCLc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2010 21:11:32 -0500
In-Reply-To: <20100210212655.7784dc5b.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Valdis.Kletnieks@vt.edu, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Feb 11, 2010 at 1:26 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 11 Feb 2010 00:11:44 -0500 Valdis.Kletnieks@vt.edu wrote:
>
>> On Wed, 10 Feb 2010 16:17:41 PST, akpm@linux-foundation.org said:
>> > The mm-of-the-moment snapshot 2010-02-10-16-17 has been uploaded t=
o
>> >
>> > =C2=A0 =C2=A0http://userweb.kernel.org/~akpm/mmotm/
>>
>> Seen at boot:
>>
>> [ =C2=A0 =C2=A00.207242] ACPI: (supports S0 S5)
>> [ =C2=A0 =C2=A00.207257] ACPI: Using IOAPIC for interrupt routing
>> [ =C2=A0 =C2=A00.335315]
>> [ =C2=A0 =C2=A00.335316] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> [ =C2=A0 =C2=A00.335483] [ INFO: possible recursive locking detected=
 ]
>> [ =C2=A0 =C2=A00.335572] 2.6.33-rc7-mmotm0210 #1
>> [ =C2=A0 =C2=A00.335658] -------------------------------------------=
--
>> [ =C2=A0 =C2=A00.335746] swapper/1 is trying to acquire lock:
>> [ =C2=A0 =C2=A00.335834] =C2=A0(&dev->mutex){+.+...}, at: [<ffffffff=
812eb521>] __driver_attach+0x47/0x80
>> [ =C2=A0 =C2=A00.335999]
>> [ =C2=A0 =C2=A00.335999] but task is already holding lock:
>> [ =C2=A0 =C2=A00.335999] =C2=A0(&dev->mutex){+.+...}, at: [<ffffffff=
812eb513>] __driver_attach+0x39/0x80
>> [ =C2=A0 =C2=A00.335999]
>> [ =C2=A0 =C2=A00.335999] other info that might help us debug this:
>> [ =C2=A0 =C2=A00.335999] 1 lock held by swapper/1:
>> [ =C2=A0 =C2=A00.335999] =C2=A0#0: =C2=A0(&dev->mutex){+.+...}, at: =
[<ffffffff812eb513>] __driver_attach+0x39/0x80
>> [ =C2=A0 =C2=A00.335999]
>> [ =C2=A0 =C2=A00.335999] stack backtrace:
>> [ =C2=A0 =C2=A00.335999] Pid: 1, comm: swapper Not tainted 2.6.33-rc=
7-mmotm0210 #1
>> [ =C2=A0 =C2=A00.335999] Call Trace:
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81063b47>] __lock_acquire+0=
xc77/0xcee
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81061fad>] ? mark_lock+0x2d=
/0x22c
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb521>] ? __driver_attac=
h+0x47/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81063c89>] lock_acquire+0xc=
b/0xe8
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb521>] ? __driver_attac=
h+0x47/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff810621fe>] ? mark_held_lock=
s+0x52/0x70
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81568c9d>] __mutex_lock_com=
mon+0x5c/0x5aa
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb521>] ? __driver_attac=
h+0x47/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff815583f8>] ? klist_next+0x2=
4/0xd7
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb521>] ? __driver_attac=
h+0x47/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb4da>] ? __driver_attac=
h+0x0/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81569291>] mutex_lock_neste=
d+0x34/0x39
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb521>] __driver_attach+=
0x47/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb4da>] ? __driver_attac=
h+0x0/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb4da>] ? __driver_attac=
h+0x0/0x80
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eaa43>] bus_for_each_dev=
+0x54/0x89
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb28a>] driver_attach+0x=
19/0x1b
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eaed5>] bus_add_driver+0=
xb4/0x203
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff812eb833>] driver_register+=
0xb8/0x129
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81231604>] acpi_bus_registe=
r_driver+0x3e/0x40
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81b45094>] acpi_ec_init+0x3=
7/0x55
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81b44ef1>] acpi_init+0x115/=
0x12a
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81b44ddc>] ? acpi_init+0x0/=
0x12a
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff810001ef>] do_one_initcall+=
0x59/0x14e
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81b26655>] kernel_init+0x14=
d/0x1a3
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81003354>] kernel_thread_he=
lper+0x4/0x10
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff8156b0c0>] ? restore_args+0=
x0/0x30
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81b26508>] ? kernel_init+0x=
0/0x1a3
>> [ =C2=A0 =C2=A00.335999] =C2=A0[<ffffffff81003350>] ? kernel_thread_=
helper+0x0/0x10
>> [ =C2=A0 =C2=A00.340036] ACPI: EC: GPE =3D 0x11, I/O: command/status=
 =3D 0x934, data =3D 0x930
>>
>
> driver_attach() got converted from sem to mutex in linux-next. =C2=A0=
So this
> is probably an old bug which just got exposed.

Here is the possible fix for this:
http://lkml.org/lkml/2010/2/8/161

>
> Or maybe not. =C2=A0Thomas, has that patch been in some other tree (r=
t?) for
> a while? =C2=A0If so, was this bug observed in that tree? =C2=A0If no=
t, it might
> be new.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards
dave
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
