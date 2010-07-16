From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 5/9] ACPI EC: remove deprecated procfs I/F
Date: Fri, 16 Jul 2010 08:26:22 +0400
Message-ID: <4C3FDF6E.9050800@suse.de>
References: <1279161996.4537.8518.camel@rzhang1-desktop>	 <4C3ED134.8010101@suse.de> <1279242806.4537.8539.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:44399 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab0GPE0Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2010 00:26:25 -0400
In-Reply-To: <1279242806.4537.8539.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

16.07.2010 05:13, Zhang Rui =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Thu, 2010-07-15 at 17:13 +0800, Alexey Starikovskiy wrote:
>> Hi Rui,
>>
>> Please add reporting of GLK use in dmesg, this is the only missing p=
iece.
>>
> Okay, new patch attached.
Looks good,
Thanks,
Alex.
>=20
>=20
> Remove deprecated EC procfs I/F as all the info can be got in dmesg.
>=20
> Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/ec.c |   92 ++-----------------------------------------=
-----------
>  1 file changed, 5 insertions(+), 87 deletions(-)
>=20
> Index: linux-2.6/drivers/acpi/ec.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/ec.c
> +++ linux-2.6/drivers/acpi/ec.c
> @@ -34,8 +34,6 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/delay.h>
> -#include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
> @@ -672,72 +670,6 @@ acpi_ec_space_handler(u32 function, acpi
>  }
> =20
>  /* -----------------------------------------------------------------=
---------
> -                              FS Interface (/proc)
> -   -----------------------------------------------------------------=
--------- */
> -
> -static struct proc_dir_entry *acpi_ec_dir;
> -
> -static int acpi_ec_read_info(struct seq_file *seq, void *offset)
> -{
> -	struct acpi_ec *ec =3D seq->private;
> -
> -	if (!ec)
> -		goto end;
> -
> -	seq_printf(seq, "gpe:\t\t\t0x%02x\n", (u32) ec->gpe);
> -	seq_printf(seq, "ports:\t\t\t0x%02x, 0x%02x\n",
> -		   (unsigned)ec->command_addr, (unsigned)ec->data_addr);
> -	seq_printf(seq, "use global lock:\t%s\n",
> -		   ec->global_lock ? "yes" : "no");
> -      end:
> -	return 0;
> -}
> -
> -static int acpi_ec_info_open_fs(struct inode *inode, struct file *fi=
le)
> -{
> -	return single_open(file, acpi_ec_read_info, PDE(inode)->data);
> -}
> -
> -static const struct file_operations acpi_ec_info_ops =3D {
> -	.open =3D acpi_ec_info_open_fs,
> -	.read =3D seq_read,
> -	.llseek =3D seq_lseek,
> -	.release =3D single_release,
> -	.owner =3D THIS_MODULE,
> -};
> -
> -static int acpi_ec_add_fs(struct acpi_device *device)
> -{
> -	struct proc_dir_entry *entry =3D NULL;
> -
> -	if (!acpi_device_dir(device)) {
> -		acpi_device_dir(device) =3D proc_mkdir(acpi_device_bid(device),
> -						     acpi_ec_dir);
> -		if (!acpi_device_dir(device))
> -			return -ENODEV;
> -	}
> -
> -	entry =3D proc_create_data(ACPI_EC_FILE_INFO, S_IRUGO,
> -				 acpi_device_dir(device),
> -				 &acpi_ec_info_ops, acpi_driver_data(device));
> -	if (!entry)
> -		return -ENODEV;
> -	return 0;
> -}
> -
> -static int acpi_ec_remove_fs(struct acpi_device *device)
> -{
> -
> -	if (acpi_device_dir(device)) {
> -		remove_proc_entry(ACPI_EC_FILE_INFO, acpi_device_dir(device));
> -		remove_proc_entry(acpi_device_bid(device), acpi_ec_dir);
> -		acpi_device_dir(device) =3D NULL;
> -	}
> -
> -	return 0;
> -}
> -
> -/* -----------------------------------------------------------------=
---------
>                                 Driver Interface
>     -----------------------------------------------------------------=
--------- */
>  static acpi_status
> @@ -887,9 +819,10 @@ static int acpi_ec_add(struct acpi_devic
>  	if (!first_ec)
>  		first_ec =3D ec;
>  	device->driver_data =3D ec;
> -	acpi_ec_add_fs(device);
> -	pr_info(PREFIX "GPE =3D 0x%lx, I/O: command/status =3D 0x%lx, data =
=3D 0x%lx\n",
> -			  ec->gpe, ec->command_addr, ec->data_addr);
> +	pr_info(PREFIX "GPE =3D 0x%lx, Global Lock: %s, "
> +		       "I/O: command/status =3D 0x%lx, data =3D 0x%lx",
> +		       ec->gpe, ec->global_lock ? "yes" : "no",
> +		       ec->command_addr, ec->data_addr);
> =20
>  	ret =3D ec_install_handlers(ec);
> =20
> @@ -914,7 +847,6 @@ static int acpi_ec_remove(struct acpi_de
>  		kfree(handler);
>  	}
>  	mutex_unlock(&ec->lock);
> -	acpi_ec_remove_fs(device);
>  	device->driver_data =3D NULL;
>  	if (ec =3D=3D first_ec)
>  		first_ec =3D NULL;
> @@ -1093,20 +1025,8 @@ static struct acpi_driver acpi_ec_driver
> =20
>  int __init acpi_ec_init(void)
>  {
> -	int result =3D 0;
> -
> -	acpi_ec_dir =3D proc_mkdir(ACPI_EC_CLASS, acpi_root_dir);
> -	if (!acpi_ec_dir)
> -		return -ENODEV;
> -
>  	/* Now register the driver for the EC */
> -	result =3D acpi_bus_register_driver(&acpi_ec_driver);
> -	if (result < 0) {
> -		remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
> -		return -ENODEV;
> -	}
> -
> -	return result;
> +	return acpi_bus_register_driver(&acpi_ec_driver);
>  }
> =20
>  /* EC driver currently not unloadable */
> @@ -1116,8 +1036,6 @@ static void __exit acpi_ec_exit(void)
> =20
>  	acpi_bus_unregister_driver(&acpi_ec_driver);
> =20
> -	remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
> -
>  	return;
>  }
>  #endif	/* 0 */
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
