From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [WARNING -rc8] at fs/sysfs/dir.c:424 sysfs_add_one(), related
	with processor (ACPI)
Date: Thu, 24 Jan 2008 09:44:36 +0800
Message-ID: <20080124014436.GA3020@darkstar.te-china.tietoenator.com>
References: <653402b90801210953u71a85f91udce9e382d588af09@mail.gmail.com> <20080123140643.b56ea8eb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754469AbYAXBnc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080123140643.b56ea8eb.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <maxextreme@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 23, 2008 at 02:06:43PM -0800, Andrew Morton wrote:
> > On Mon, 21 Jan 2008 18:53:18 +0100 "Miguel Ojeda" <maxextreme@gmail.com> wrote:
> > Booting 2.6.24-rc8 I get this:
> > 
> > 
> > sysfs: duplicate filename 'fan' can not be created
> > WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
> > Pid: 819, comm: modprobe Not tainted 2.6.24-rc8 #2
> >  [<c01b18ff>] sysfs_add_one+0x9f/0xe0
> >  [<c01b1e38>] create_dir+0x48/0x90
> >  [<c01b1ea9>] sysfs_create_dir+0x29/0x50
> >  [<c024873f>] kobject_get+0xf/0x20
> >  [<c0248bff>] kobject_add+0x8f/0x1b0
> >  [<c0248db1>] kobject_register+0x21/0x50
> >  [<c02dc6f1>] bus_add_driver+0x71/0x1e0
> >  [<f886402f>] acpi_fan_init+0x2f/0x4d [fan]
> >  [<c0148986>] sys_init_module+0x126/0x19b0
> >  [<c024af87>] rb_insert_color+0xb7/0xe0
> >  [<c029dc8d>] acpi_bus_register_driver+0x0/0x38
> >  [<c0104286>] syscall_call+0x7/0xb
> >  =======================
> > kobject_add failed for fan with -EEXIST, don't try to register things
> > with the same name in the same directory.
> > Pid: 819, comm: modprobe Not tainted 2.6.24-rc8 #2
> >  [<c0248c81>] kobject_add+0x111/0x1b0
> >  [<c0248db1>] kobject_register+0x21/0x50
> >  [<c02dc6f1>] bus_add_driver+0x71/0x1e0
> >  [<f886402f>] acpi_fan_init+0x2f/0x4d [fan]
> >  [<c0148986>] sys_init_module+0x126/0x19b0
> >  [<c024af87>] rb_insert_color+0xb7/0xe0
> >  [<c029dc8d>] acpi_bus_register_driver+0x0/0x38
> >  [<c0104286>] syscall_call+0x7/0xb
> >  =======================
> > processor: exports duplicate symbol acpi_processor_set_thermal_limit
> > (owned by kernel)
> > 

Could apply following debug patch and see the result?


diff -upr linux/fs/sysfs/dir.c linux.new/fs/sysfs/dir.c
--- linux/fs/sysfs/dir.c	2008-01-23 09:56:24.000000000 +0800
+++ linux.new/fs/sysfs/dir.c	2008-01-23 09:59:12.000000000 +0800
@@ -418,6 +418,8 @@ void sysfs_addrm_start(struct sysfs_addr
  */
 int sysfs_add_one(struct sysfs_addrm_cxt *acxt, struct sysfs_dirent *sd)
 {
+	if (!strcmp(sd->s_name, "fan"))
+		dump_stack();
 	if (sysfs_find_dirent(acxt->parent_sd, sd->s_name)) {
 		printk(KERN_WARNING "sysfs: duplicate filename '%s' "
 		       "can not be created\n", sd->s_name);
