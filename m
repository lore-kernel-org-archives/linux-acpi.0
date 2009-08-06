From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 7 Aug 2009 00:18:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0908070012490.11170@sister.anvils>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mk-filter-3-a-1.mail.uk.tiscali.com ([212.74.100.54]:46460 "EHLO
	mk-filter-3-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756880AbZHFXS0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 19:18:26 -0400
In-Reply-To: <200908062257.n76MvuCr024266@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, ming.m.lin@intel.com, Valdis.Kletnieks@vt.edu

On Thu, 6 Aug 2009, akpm@linux-foundation.org wrote:
> From: Lin Ming <ming.m.lin@intel.com>
> 
> acpi_device->pnp.hardware_id and unique_id are now allocated pointer. 
> If it's NULL, return "\0" for acpi_device_hid and acpi_device_uid. 
> Also, free hardware_id and unique_id when acpi_device is going to be
> freed.
> 
> Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> Cc: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/scan.c     |    4 ++++
>  include/acpi/acpi_bus.h |    4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/scan.c~acpi-fix-null-bug-for-hid-uid-string drivers/acpi/scan.c
> --- a/drivers/acpi/scan.c~acpi-fix-null-bug-for-hid-uid-string
> +++ a/drivers/acpi/scan.c
> @@ -309,6 +309,8 @@ static void acpi_device_release(struct d
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  
>  	kfree(acpi_dev->pnp.cid_list);
> +	kfree(acpi_dev->pnp.hardware_id);
> +	kfree(acpi_dev->pnp.unique_id);
>  	kfree(acpi_dev);
>  }
>  
> @@ -1359,6 +1361,8 @@ end:
>  		*child = device;
>  	else {
>  		kfree(device->pnp.cid_list);
> +		kfree(device->pnp.hardware_id);
> +		kfree(device->pnp.unique_id);
>  		kfree(device);
>  	}
>  
> diff -puN include/acpi/acpi_bus.h~acpi-fix-null-bug-for-hid-uid-string include/acpi/acpi_bus.h
> --- a/include/acpi/acpi_bus.h~acpi-fix-null-bug-for-hid-uid-string
> +++ a/include/acpi/acpi_bus.h
> @@ -186,8 +186,8 @@ struct acpi_device_pnp {
>  
>  #define acpi_device_bid(d)	((d)->pnp.bus_id)
>  #define acpi_device_adr(d)	((d)->pnp.bus_address)
> -#define acpi_device_hid(d)	((d)->pnp.hardware_id)
> -#define acpi_device_uid(d)	((d)->pnp.unique_id)
> +#define acpi_device_hid(d)	((d)->pnp.hardware_id ? (d)->pnp.hardware_id : "\0")
> +#define acpi_device_uid(d)	((d)->pnp.unique_id ? (d)->pnp.unique_id : "\0")
>  #define acpi_device_name(d)	((d)->pnp.device_name)
>  #define acpi_device_class(d)	((d)->pnp.device_class)
>  
> _

It's up to Len to choose, but I thought we preferred...

From: Hugh Dickins <hugh.dickins@tiscali.co.uk>

acpi_device->pnp.hardware_id and unique_id are now allocated pointers,
replacing the previous arrays.  acpi_device_install_notify_handler()
oopsed on the NULL hid when probing the video device, and perhaps other
uses are vulnerable too.  So initialize those pointers to empty strings
when there is no hid or uid.  Also, free hardware_id and unique_id when
when acpi_device is going to be freed.

Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---

 drivers/acpi/scan.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- mmotm/drivers/acpi/scan.c	2009-07-17 12:53:20.000000000 +0100
+++ linux/drivers/acpi/scan.c	2009-07-27 18:01:32.000000000 +0100
@@ -309,6 +309,10 @@ static void acpi_device_release(struct d
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
 	kfree(acpi_dev->pnp.cid_list);
+	if (acpi_dev->flags.hardware_id)
+		kfree(acpi_dev->pnp.hardware_id);
+	if (acpi_dev->flags.unique_id)
+		kfree(acpi_dev->pnp.unique_id);
 	kfree(acpi_dev);
 }
 
@@ -1144,8 +1148,9 @@ static void acpi_device_set_id(struct ac
 			strcpy(device->pnp.hardware_id, hid);
 			device->flags.hardware_id = 1;
 		}
-	} else
-		device->pnp.hardware_id = NULL;
+	}
+	if (!device->flags.hardware_id)
+		device->pnp.hardware_id = "";
 
 	if (uid) {
 		device->pnp.unique_id = ACPI_ALLOCATE_ZEROED(strlen (uid) + 1);
@@ -1153,8 +1158,9 @@ static void acpi_device_set_id(struct ac
 			strcpy(device->pnp.unique_id, uid);
 			device->flags.unique_id = 1;
 		}
-	} else
-		device->pnp.unique_id = NULL;
+	}
+	if (!device->flags.unique_id)
+		device->pnp.unique_id = "";
 
 	if (cid_list || cid_add) {
 		struct acpica_device_id_list *list;
@@ -1369,10 +1375,8 @@ acpi_add_single_object(struct acpi_devic
 end:
 	if (!result)
 		*child = device;
-	else {
-		kfree(device->pnp.cid_list);
-		kfree(device);
-	}
+	else
+		acpi_device_release(&device->dev);
 
 	return result;
 }
