From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Add mutex to avoid race condition of reference
 count of notify object
Date: Mon, 16 Jun 2014 05:10:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880262DB43@SHSMSX101.ccr.corp.intel.com>
References: <1402884715-25049-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5535 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbaFPFKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jun 2014 01:10:34 -0400
In-Reply-To: <1402884715-25049-1-git-send-email-jlee@suse.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>

Hi,

> From: Lee, Chun-Yi [mailto:joeyli.kernel@gmail.com]
> Sent: Monday, June 16, 2014 10:12 AM
> 
> This issue found on v3.0 kernel, unfortunately there was no chance
> to test latest kernel on issue mchine. This patch tested on v3.0 kernel
> then sent to linux-acpi for review and note, maybe latest kernel also need.
> 
> The problem happened when acpi thermal driver evaluate _PSL, but acpi
> processor driver install notify handler at the same time. In the
> code path of evaluate _PSL, it updates reference count of processor
> and its notify objects. When the notify handler installation done
> after the reference count of processor updated, it causes the
> ref_count of processor doesn't sync with its notify object's
> ref_count value.
> 
> Here is an debugging log when issue reproduced:
> 
> [    3.481773] ACPI_TYPE_PROCESSOR set ACPI_DEVICE_NOTIFY, object_desc->common.reference_count: 3, notify_obj-
> >common.reference_count: 1
> [    3.481958] PROCESSOR device_hid: LNXCPU
> ...
> [    3.487427] ACPI_TYPE_PROCESSOR, action = 1
> [    3.487428] Update device_notify ref_count
> [    3.487429] REF_DECREMENT ACPI_TYPE_LOCAL_NOTIFY original_count: 0
> [    3.487431] ACPI Warning: Obj ffff8800b0f40b28, Reference Count is already zero, cannot decrement
> [    3.487433]  (20110413/utdelete-431)
> [    3.487434] REF_DECREMENT ACPI_TYPE_PROCESSOR original_count: 2
> 
> Accroding log, found the reference_count of parent object
> (it's processor in this case) is 3, it doesn't match with notify_object's
> reference_count, value is 1. It triggered "Reference Count is already zero"
> warning, then happen object double free issue later.
> 
> To avoid rece condition, this patch introded ACPI_MTX_NOTIFY_REF_COUNT
> mutex to keep the ref_count of notify object sync with its parent
> object. And, it also set the reference_count value of new notify object
> equals to its parent object's reference_count.
> 
> Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> ---
>  drivers/acpi/acpica/aclocal.h  | 3 ++-
>  drivers/acpi/acpica/evxface.c  | 7 ++++++-
>  drivers/acpi/acpica/utdelete.c | 6 ++++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index c7f743c..e25a4af 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -85,8 +85,9 @@ union acpi_parse_object;
>  #define ACPI_MTX_MEMORY                 5	/* Debug memory tracking lists */
>  #define ACPI_MTX_DEBUG_CMD_COMPLETE     6	/* AML debugger */
>  #define ACPI_MTX_DEBUG_CMD_READY        7	/* AML debugger */
> +#define ACPI_MTX_NOTIFY_REF_COUNT	8	/* Reference count of notify object */
> 
> -#define ACPI_MAX_MUTEX                  7
> +#define ACPI_MAX_MUTEX                  8
>  #define ACPI_NUM_MUTEX                  ACPI_MAX_MUTEX+1
> 
>  /* Lock structure for reader/writer interfaces */
> diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
> index e114140..213fe1a 100644
> --- a/drivers/acpi/acpica/evxface.c
> +++ b/drivers/acpi/acpica/evxface.c
> @@ -495,6 +495,10 @@ acpi_install_notify_handler(acpi_handle device,
>  						handler, context,
>  						NULL);
> 
> +		acpi_ut_acquire_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
> +
> +		notify_obj->common.reference_count = obj_desc->common.reference_count;
> +

Should be converted to spin_lock here.

>  		if (handler_type & ACPI_SYSTEM_NOTIFY) {
>  			obj_desc->common_notify.system_notify = notify_obj;
>  		}
> @@ -503,8 +507,9 @@ acpi_install_notify_handler(acpi_handle device,
>  			obj_desc->common_notify.device_notify = notify_obj;
>  		}
> 
> -		if (handler_type == ACPI_ALL_NOTIFY) {
> +		acpi_ut_release_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
> 
> +		if (handler_type == ACPI_ALL_NOTIFY) {
>  			/* Extra ref if installed in both */
> 
>  			acpi_ut_add_reference(notify_obj);
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
> index 31f5a78..7559813 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -504,6 +504,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
> 
>  			/* Update the notify objects for these types (if present) */
> 
> +			acpi_ut_acquire_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
>  			acpi_ut_update_ref_count(object->common_notify.
>  						 system_notify, action);

If you take a look at acpi_ut_update_ref_count, there is already a spin_lock held around the code to update the reference count.

Thanks
-Lv

>  			acpi_ut_update_ref_count(object->common_notify.
> @@ -592,6 +593,11 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
>  		 * main object to be deleted.
>  		 */
>  		acpi_ut_update_ref_count(object, action);
> +		if (object->common.type == ACPI_TYPE_PROCESSOR ||
> +		    object->common.type == ACPI_TYPE_DEVICE ||
> +		    object->common.type == ACPI_TYPE_POWER ||
> +		    object->common.type == ACPI_TYPE_THERMAL)
> +			acpi_ut_release_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
>  		object = NULL;
> 
>  		/* Move on to the next object to be updated */
> --
> 1.8.4.5

