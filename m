From: "Dave Young" <hidave.darkstar@gmail.com>
Subject: Re: [WARNING -rc8] at fs/sysfs/dir.c:424 sysfs_add_one(), related with processor (ACPI)
Date: Fri, 25 Jan 2008 09:27:06 +0800
Message-ID: <a8e1da0801241727y1af0b0feu96b1153a6e3da954@mail.gmail.com>
References: <653402b90801210953u71a85f91udce9e382d588af09@mail.gmail.com>
	 <20080123140643.b56ea8eb.akpm@linux-foundation.org>
	 <20080124014436.GA3020@darkstar.te-china.tietoenator.com>
	 <653402b90801240832n4b39ec55gadb0cf193dcfc717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:53242 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYAYB1H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jan 2008 20:27:07 -0500
Received: by nz-out-0506.google.com with SMTP id s18so368042nze.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Jan 2008 17:27:06 -0800 (PST)
In-Reply-To: <653402b90801240832n4b39ec55gadb0cf193dcfc717@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Jan 25, 2008 12:32 AM, Miguel Ojeda <maxextreme@gmail.com> wrote:
>
> On Jan 24, 2008 2:44 AM, Dave Young <hidave.darkstar@gmail.com> wrote:
> >
> > On Wed, Jan 23, 2008 at 02:06:43PM -0800, Andrew Morton wrote:
> > > > On Mon, 21 Jan 2008 18:53:18 +0100 "Miguel Ojeda" <maxextreme@gmail.com> wrote:
> > > > Booting 2.6.24-rc8 I get this:
> > > >
> > > >
> > > > sysfs: duplicate filename 'fan' can not be created
> > > > WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
> > > > Pid: 819, comm: modprobe Not tainted 2.6.24-rc8 #2
> > > >  [<c01b18ff>] sysfs_add_one+0x9f/0xe0
> > > >  [<c01b1e38>] create_dir+0x48/0x90
> > > >  [<c01b1ea9>] sysfs_create_dir+0x29/0x50
> > > >  [<c024873f>] kobject_get+0xf/0x20
> > > >  [<c0248bff>] kobject_add+0x8f/0x1b0
> > > >  [<c0248db1>] kobject_register+0x21/0x50
> > > >  [<c02dc6f1>] bus_add_driver+0x71/0x1e0
> > > >  [<f886402f>] acpi_fan_init+0x2f/0x4d [fan]
> > > >  [<c0148986>] sys_init_module+0x126/0x19b0
> > > >  [<c024af87>] rb_insert_color+0xb7/0xe0
> > > >  [<c029dc8d>] acpi_bus_register_driver+0x0/0x38
> > > >  [<c0104286>] syscall_call+0x7/0xb
> > > >  =======================
> > > > kobject_add failed for fan with -EEXIST, don't try to register things
> > > > with the same name in the same directory.
> > > > Pid: 819, comm: modprobe Not tainted 2.6.24-rc8 #2
> > > >  [<c0248c81>] kobject_add+0x111/0x1b0
> > > >  [<c0248db1>] kobject_register+0x21/0x50
> > > >  [<c02dc6f1>] bus_add_driver+0x71/0x1e0
> > > >  [<f886402f>] acpi_fan_init+0x2f/0x4d [fan]
> > > >  [<c0148986>] sys_init_module+0x126/0x19b0
> > > >  [<c024af87>] rb_insert_color+0xb7/0xe0
> > > >  [<c029dc8d>] acpi_bus_register_driver+0x0/0x38
> > > >  [<c0104286>] syscall_call+0x7/0xb
> > > >  =======================
> > > > processor: exports duplicate symbol acpi_processor_set_thermal_limit
> > > > (owned by kernel)
> > > >
> >
> > Could apply following debug patch and see the result?
> >
> >
> > diff -upr linux/fs/sysfs/dir.c linux.new/fs/sysfs/dir.c
> > --- linux/fs/sysfs/dir.c        2008-01-23 09:56:24.000000000 +0800
> > +++ linux.new/fs/sysfs/dir.c    2008-01-23 09:59:12.000000000 +0800
> > @@ -418,6 +418,8 @@ void sysfs_addrm_start(struct sysfs_addr
> >   */
> >  int sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd)
> >  {
> > +       if (!strcmp(sd->s_name, "fan"))
> > +               dump_stack();
> >         if (sysfs_find_dirent(acxt->parent_sd, sd->s_name)) {
> >                 printk(KERN_WARNING "sysfs: duplicate filename '%s' "
> >                        "can not be created\n", sd->s_name);
> >
> >
>
> Done. The following appears in the new dmesg output.
>
>
> ACPI: Power Button (CM) [PBTN]
> input: Sleep Button (CM) as /class/input/input2
> ACPI: Sleep Button (CM) [SBTN]
> Pid: 1, comm: swapper Not tainted 2.6.24-rc8 #3
>  [<c01b18d5>] sysfs_add_one+0x75/0x100
>  [<c01b199f>] sysfs_addrm_start+0x3f/0xb0
>  [<c01b1e58>] create_dir+0x48/0x90
>  [<c01b1ec9>] sysfs_create_dir+0x29/0x50
>  [<c024875f>] kobject_get+0xf/0x20
>  [<c0248c1f>] kobject_add+0x8f/0x1b0
>  [<c0248dd1>] kobject_register+0x21/0x50
>  [<c02dc711>] bus_add_driver+0x71/0x1e0
>  [<c05c7663>] acpi_fan_init+0x2f/0x4d
>  [<c05ad551>] kernel_init+0x121/0x300
>  [<c010416a>] ret_from_fork+0x6/0x1c
>  [<c05ad430>] kernel_init+0x0/0x300
>  [<c05ad430>] kernel_init+0x0/0x300
>  [<c0104e6f>] kernel_thread_helper+0x7/0x18
>  =======================

I'm curious, the "fan" is configured as built-in, why the modprobe be called?

> ACPI: SSDT 3FE93134, 0244 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
> ACPI: SSDT 3FE92ACA, 05E5 (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
> Monitor-Mwait will be used to enter C-1 state
> Monitor-Mwait will be used to enter C-2 state
>
> Attached dmesg.txt
>
>
> --
> Miguel Ojeda
> http://maxextreme.googlepages.com/index.htm
>
