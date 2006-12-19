From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 3/22] Remove deprecated parameters
Date: Tue, 19 Dec 2006 13:45:00 -0800
Message-ID: <20061219134500.a058bb8f.randy.dunlap@oracle.com>
References: <200612192218.55855.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet02.oracle.com ([148.87.113.119]:54782 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932960AbWLSVyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Dec 2006 16:54:54 -0500
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	by rgminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id kBJLsqSx020232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2006 14:54:52 -0700
In-Reply-To: <200612192218.55855.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

On Tue, 19 Dec 2006 22:18:55 +0100 Corentin CHARY wrote:

> Remove the deprecated asus_uid and asus_gid parameters.

Hi,
Where are they documented as deprecated?

Thanks.

> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
>  asus_acpi.c |   29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
> 
> --- a/drivers/acpi/asus_acpi.c  2006-12-15 10:36:09.000000000 +0100
> +++ b/drivers/acpi/asus_acpi.c  2006-12-15 10:37:36.000000000 +0100
> @@ -76,13 +76,6 @@
>  MODULE_DESCRIPTION(ACPI_HOTK_NAME);
>  MODULE_LICENSE("GPL");
> 
> -static uid_t asus_uid;
> -static gid_t asus_gid;
> -module_param(asus_uid, uint, 0);
> -MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n");
> -module_param(asus_gid, uint, 0);
> -MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
> -
>  /* For each model, all features implemented,
>   * those marked with R are relative to HOTK, A for absolute */
>  struct model_data {
> @@ -916,8 +909,8 @@
>         proc->read_proc = readfunc;
>         proc->data = acpi_driver_data(device);
>         proc->owner = THIS_MODULE;
> -       proc->uid = asus_uid;
> -       proc->gid = asus_gid;
> +       proc->uid = 0;
> +       proc->gid = 0;
>         return 0;
>  }
> 
> @@ -926,19 +919,7 @@
>         struct proc_dir_entry *proc;
>         mode_t mode;
> 
> -       /*
> -        * If parameter uid or gid is not changed, keep the default setting 
> for
> -        * our proc entries (-rw-rw-rw-) else, it means we care about 
> security,
> -        * and then set to -rw-rw----
> -        */
> -
> -       if ((asus_uid == 0) && (asus_gid == 0)) {
> -               mode = S_IFREG | S_IRUGO | S_IWUGO;
> -       } else {
> -               mode = S_IFREG | S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP;
> -               printk(KERN_WARNING "  asus_uid and asus_gid parameters are "
> -                      "deprecated, use chown and chmod instead!\n");
> -       }
> +       mode = S_IFREG | S_IRUGO | S_IWUGO;
> 
>         acpi_device_dir(device) = asus_proc_dir;
>         if (!acpi_device_dir(device))
> @@ -949,8 +930,8 @@
>                 proc->read_proc = proc_read_info;
>                 proc->data = acpi_driver_data(device);
>                 proc->owner = THIS_MODULE;
> -               proc->uid = asus_uid;
> -               proc->gid = asus_gid;
> +               proc->uid = 0;
> +               proc->gid = 0;
>         } else {
>                 printk(KERN_WARNING "  Unable to create " PROC_INFO
>                        " fs entry\n");
> 
> 
> -- 

---
~Randy
