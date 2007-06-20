From: Len Brown <lenb@kernel.org>
Subject: Re: backlight mystery (PATCH to fix asus_acpi loading when no device)
Date: Wed, 20 Jun 2007 00:35:59 -0400
Message-ID: <200706200036.00441.lenb@kernel.org>
References: <20070305233037.0c5727e7.akpm@linux-foundation.org> <20070306171050.GE26813@redhat.com> <1173373051.5863.70.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47182 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851AbXFTEg5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Jun 2007 00:36:57 -0400
In-Reply-To: <1173373051.5863.70.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, corentincj@iksaif.net
Cc: Zhao Forrest <forrest.zhao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org, Dave Jones <davej@redhat.com>

On Thursday 08 March 2007 11:57, Thomas Renninger wrote:
> On Tue, 2007-03-06 at 12:10 -0500, Dave Jones wrote:
> > On Tue, Mar 06, 2007 at 03:58:01PM +0800, Zhao Forrest wrote:
> >  > On 3/6/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> >  > > On Tue, 6 Mar 2007 02:43:12 -0500 Dave Jones <davej@redhat.com> wrote:
> >  > >
> >  > > > On Mon, Mar 05, 2007 at 11:30:37PM -0800, Andrew Morton wrote:
> >  > > >  >
> >  > > >  > I always get stuff like this coming out when I boot my x86_64 machine:
> >  > > >  >
> >  > > >  > asus_acpi: Unknown symbol backlight_device_unregister
> >  > > >  > asus_acpi: Unknown symbol backlight_device_register
> >  > > >  > ibm_acpi: Unknown symbol backlight_device_unregister
> >  > > >  > ibm_acpi: Unknown symbol backlight_device_register
> >  > > >  > toshiba_acpi: Unknown symbol backlight_device_unregister
> >  > > >  > toshiba_acpi: Unknown symbol backlight_device_register
> >  > > >  > video: Unknown symbol backlight_device_unregister
> >  > > >  > video: Unknown symbol backlight_device_register
> >  > > >  >
> >  > > >  > This is a nocoma server, not a laptop.  I'm not sure how those modules are
> >  > > >  > even getting loaded.  The distro is FC4, which might be doing something
> >  > > >  > peculiar.
> >  > > >
> >  > > > I covered this on the list last week.  There's no way to
> >  > > > have a module autoload based on dmi strings or the like,
> >  > > > (Which is the only sane way these modules can determine
> >  > > >  if they need to run).
> >  > > >
> >  > > > Given the absense of mechanism, there's a pretty gross hack
> >  > > > in Fedora's rc.sysinit which loads every module in drivers/acpi/*/*
> >  > > > that it finds.  Shameful I know.
> >  > >
> >  > > I thought it might be something like that.  I'm a bit surprised that we
> >  > > can't get at the DMI stuff from userspace, or export it from the kernel.
> >  > > But whatever.
> >  > 
> >  > I have a question: why can't we get at the DMI stuff from userspace
> >  > since "dmidecode" is a tool in userspace?
> > 
> > We can, but we could do better.
> > What's missing is an *event* that udev can see, so that it
> > knows what to do.
> > 
> > Imagine: asus_acpi gets a MODULE_DMI("ASUS") or whatever, and then
> > at boottime, we register a sysfs modalias of the system DMI string.
> > Suddenly we have two pieces of the puzzle, and udev will see the
> > modalias and happily pull in any modules that match the alias.
> > 
> > All without any changes to userspace at all.
> 
> I also saw asus_acpi module loaded on a server.
> rmmodding it results in (sorry about escape chars):
> 
> 
> BUG: at lib/kref.c:32 kref_get()
> 
> Call Trace:
>  [<ffffffff80232ed2>] kref_get+0x2f/0x34
>  [<ffffffff802501ed>] kobject_get+0x12/0x17
>  [<ffffffff80386422>] get_driver+0x14/0x1a
>  [<ffffffff80386439>] driver_remove_file+0x11/0x32
>  [<ffffffff803858e8>] bus_remove_driver+0x1c/0x90
>  [<ffffffff8038637e>] driver_unregister+0xd/0x16
>  [<ffffffff8829e79d>] :asus_acpi:asus_acpi_exit+0x21/0x35
> Starting D-Bus d [<ffffffff802981ad>] sys_delete_module+0x1b1/0x1e0
> aemonESC7ESC[?25l^MESC[ [<ffffffff80220069>] dma_alloc_coherent
> +0x57/0x23f
> 80CESC[10DESC[1;32md [<ffffffff8025511e>] system_call+0x7e/0x83
> oneESC[m^OESC8ESC[?25h^M
> 
> BUG: at lib/kref.c:32 kref_get()
> 
> Call Trace:
>  [<ffffffff80232ed2>] kref_get+0x2f/0x34
>  [<ffffffff802501ed>] kobject_get+0x12/0x17
> Starting irqbala [<ffffffff80386422>] get_driver+0x14/0x1a
> nce ESC7ESC[?25l^MESC[8 [<ffffffff803115bb>] kobject_release+0x0/0x9
> 0CESC[10DESC[1;32mdo [<ffffffff80386439>] driver_remove_file+0x11/0x32
> neESC[m^OESC8ESC[?25h^M^M [<ffffffff803858f7>] bus_remove_driver
> +0x2b/0x90
> 
> acpid: loading  [<ffffffff8038637e>] driver_unregister+0xd/0x16
> ACPI modules ( a [<ffffffff8829e79d>] :asus_acpi:asus_acpi_exit
> +0x21/0x35
> c battery button [<ffffffff802981ad>] sys_delete_module+0x1b1/0x1e0
>  ) ESC7ESC[?25l^MESC[80 [<ffffffff80220069>] dma_alloc_coherent
> +0x57/0x23f
> CESC[10DESC[1;32mdon [<ffffffff8025511e>] system_call+0x7e/0x83
> eESC[m^OESC8ESC[?25h^M
> 
> acpid: will not Unable to handle kernel NULL pointer dereference at
> 0000000000000020 RIP: 
>  [<ffffffff803f8a02>] klist_del+0xa/0x46
> PGD 21f3d0067 PUD 21efa9067 PMD 0 
> Oops: 0000 [1] SMP 
> CPU 0 
> 
> 
> This patch fixes it (Len, can you apply this?):

Applied.

thanks,
-Len

> Do not load asus_acpi if no device has been found
> 
> Do not rely on acpi_bus_register_driver() return value which
> is always zero, even no device has been found.
> 
> ---
>  drivers/acpi/asus_acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.21-rc3/drivers/acpi/asus_acpi.c
> ===================================================================
> --- linux-2.6.21-rc3.orig/drivers/acpi/asus_acpi.c
> +++ linux-2.6.21-rc3/drivers/acpi/asus_acpi.c
> @@ -1398,7 +1398,7 @@ static int __init asus_acpi_init(void)
>  	if (!asus_hotk_found) {
>  		acpi_bus_unregister_driver(&asus_hotk_driver);
>  		remove_proc_entry(PROC_ASUS, acpi_root_dir);
> -		return result;
> +		return -ENODEV;
>  	}
>  
>  	asus_backlight_device = backlight_device_register("asus",NULL,NULL,
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
