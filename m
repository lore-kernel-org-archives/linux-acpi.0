From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] Fix a if-statement in setup_sys_fs_device_files()
Date: Wed, 23 Feb 2005 13:45:58 +0900
Message-ID: <20050223134558.3b513553.tokunaga.keiich@jp.fujitsu.com>
References: <20050222185918.34429904.tokunaga.keiich@jp.fujitsu.com>
 <20050222194948.5e890df4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-reply-to: <20050222194948.5e890df4.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew,

  Sorry, I sent an old patch including a typo (I forgot to
refpatch...).  I'm attaching a fixed patch that was tested
on 2.6.11-rc4.

Thanks,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---

 linux-2.6.11-rc4-kei/drivers/acpi/scan.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/scan.c~eject_interface_bug drivers/acpi/scan.c
--- linux-2.6.11-rc4/drivers/acpi/scan.c~eject_interface_bug	2005-02-22 18:22:29.000000000 +0900
+++ linux-2.6.11-rc4-kei/drivers/acpi/scan.c	2005-02-23 13:03:40.000000000 +0900
@@ -358,7 +358,15 @@ setup_sys_fs_device_files (
 	struct acpi_device *dev,
 	acpi_device_sysfs_files *func)
 {
-	if (dev->flags.ejectable == 1)
+	acpi_status		status;
+	acpi_handle		temp = NULL;
+
+	/*
+	 * If device has _EJ0, 'eject' file is created that is used to trigger
+	 * hot-removal function from userland.
+	 */
+	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
+	if (ACPI_SUCCESS(status))
 		(*(func))(&dev->kobj,&acpi_device_attr_eject.attr);
 }
 

_



On Tue, 22 Feb 2005 19:49:48 -0800 Andrew Morton wrote:
> Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
> >
> > 
> >    This fixes a if-statement in setup_sys_fs_device_files().
> >  It seems to assume that 'struct acpi_device_flags.ejectable'
> >  indicates whether a device has _EJ0 or not.  But this is
> >  not a right assumption.  It indicates whether a device has
> >  _EJ0|_EJD (See acpi_bus_get_flags() function).
> >    setup_sys_fs_device_files() creates 'eject' file for
> >  devices that have _EJ0 control method under a corresponding
> >  directory in /sys/firmware/acpi/namespace/ACPI/.  'eject'
> >  file is used to trigger hot-removal function from userland.
> > 
> >  Thanks,
> >  Keiichiro Tokunaga
> > 
> > 
> > 
> >  Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> >  ---
> > 
> >   linux-2.6.11-rc4-kei/drivers/acpi/scan.c |   10 +++++++++-
> >   1 files changed, 9 insertions(+), 1 deletion(-)
> > 
> >  diff -puN drivers/acpi/scan.c~eject_interface_bug drivers/acpi/scan.c
> >  --- linux-2.6.11-rc4/drivers/acpi/scan.c~eject_interface_bug	2005-02-22 18:22:29.000000000 +0900
> >  +++ linux-2.6.11-rc4-kei/drivers/acpi/scan.c	2005-02-22 18:48:09.000000000 +0900
> >  @@ -358,7 +358,15 @@ setup_sys_fs_device_files (
> >   	struct acpi_device *dev,
> >   	acpi_device_sysfs_files *func)
> >   {
> >  -	if (dev->flags.ejectable == 1)
> >  +	acpi_status		status;
> >  +	acpi_handle		temp = NULL;
> >  +
> >  +	/*
> >  +	 * If device has _EJ0, 'eject' file is created that is used to trigger
> >  +	 * hot-removal function from userland.
> >  +	 */
> >  +	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
> >  +	if (ACPI_SUCESS(status))
> 
> This won't compile.  So...  how well tested can it be?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
