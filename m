From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 2/4] ACPI: introduce the mechanism to save/restore ACPI NVS memory
Date: Fri, 4 Jul 2008 01:34:14 +0200
Message-ID: <200807040134.15094.rjw@sisk.pl>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44544 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299AbYGCXcj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jul 2008 19:32:39 -0400
In-Reply-To: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@zh-kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>

On Thursday, 3 of July 2008, Zhang Rui wrote:
> According to the ACPI spec, ACPI NVS memory region is required to be
> saved/restored by OS during hibernation.
>=20
> Section 15.3.2 ACPI Spec 3.0b,
> "OSPM will call the _PTS control method some time before entering a s=
leeping state,
> to allow the platform=E2=80=99s AML code to update this memory image =
before entering the
> sleeping state. After the system awakes from an S4 state, OSPM will r=
estore this memory
> area and call the _WAK control method to enable the BIOS to reclaim i=
ts memory image."
>=20
> Add the mechanism to save/restore ACPI NVS memory during hibernation.
>=20
> Note: now Linux save ACPI NVS memory in acpi_hibernation_pre_snapshot=
, and restore it in
> 	acpi_hibernation_leave. Both of these functions will be invoked only=
 once during
> 	the hibernate and resume.
> Note: in Section 14.3 ACPI spec 3.0b, I only get
> 	"EfiACPIMemoryNVS: The OS and loader must preserve this memory range=
 in
> 	the working and ACPI S1=E2=80=93S3 states."
> 	whether we should save/restore this piece of memory is not cleared.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/sleep/main.c |  103 +++++++++++++++++++++++++++++++++++=
++++++++++-
>  include/linux/acpi.h      |    3 +
>  2 files changed, 104 insertions(+), 2 deletions(-)
>=20
> Index: linux-2.6/drivers/acpi/sleep/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/sleep/main.c	2008-06-30 16:28:56.0000=
00000 +0800
> +++ linux-2.6/drivers/acpi/sleep/main.c	2008-07-01 09:30:36.000000000=
 +0800
> @@ -15,6 +15,7 @@
>  #include <linux/dmi.h>
>  #include <linux/device.h>
>  #include <linux/suspend.h>
> +#include <linux/highmem.h>
> =20
>  #include <asm/io.h>
> =20
> @@ -255,11 +256,91 @@
>  #endif /* CONFIG_SUSPEND */
> =20
>  #ifdef CONFIG_HIBERNATION
> +
> +/* ACPI NVS memory need to be saved/stored during hibernation */
> +struct nvs_page {
> +	unsigned long pfn;
> +	void *data;
> +	struct list_head node;
> +};
> +static LIST_HEAD(nvs_pages_list);
> +
> +int acpi_mark_nvs_region(unsigned long start, unsigned long end)
> +{
> +	struct nvs_page *pos;
> +
> +	while (start <=3D end) {
> +		pos =3D kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
> +		if (!pos)
> +			return -ENOMEM;

I'd prefer to free the already allocated items and make the list empty =
in this
case, although it will porbably never happen.

> +		pos->pfn =3D start;
> +		start++;
> +		list_add_tail(&pos->node, &nvs_pages_list);
> +	}
> +	return 0;
> +}
> +
> +static int acpi_free_nvs_pages(void)
> +{
> +	struct nvs_page *pos;
> +
> +	list_for_each_entry(pos, &nvs_pages_list, node) {
> +		if (!pos->data)
> +			break;
> +		free_page((long)pos->data);
> +		pos->data =3D NULL;
> +	}
> +	return 0;
> +}
> +
> +static int acpi_allocate_nvs_pages(void)
> +{
> +	struct nvs_page *pos;
> +
> +	list_for_each_entry(pos, &nvs_pages_list, node) {
> +		pos->data =3D (void *)__get_free_page(GFP_KERNEL);
> +		if (!pos->data) {
> +			acpi_free_nvs_pages();
> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void acpi_save_nvs_memory(void)
> +{
> +	void *kaddr;
> +	struct nvs_page *pos;
> +
> +	pr_debug("ACPI: Saving ACPI NVS memory\n");
> +	list_for_each_entry(pos, &nvs_pages_list, node) {
> +		/* nvs page might not have a 'struct page' */
> +		kaddr =3D kmap_atomic_pfn(pos->pfn, KM_USER0);
> +		copy_page(pos->data, kaddr);
> +		kunmap_atomic(kaddr, KM_USER0);
> +	}
> +	return;
> +}
> +
> +static void acpi_restore_nvs_memory(void)
> +{
> +	void *kaddr;
> +	struct nvs_page *pos;
> +
> +	pr_debug("ACPI: Restoring ACPI NVS memory\n");
> +	list_for_each_entry(pos, &nvs_pages_list, node) {
> +		kaddr =3D kmap_atomic_pfn(pos->pfn, KM_USER0);
> +		copy_page(kaddr, pos->data);
> +		kunmap_atomic(kaddr, KM_USER0);
> +	}
> +}
> +
>  static int acpi_hibernation_begin(void)
>  {
>  	acpi_target_sleep_state =3D ACPI_STATE_S4;
> =20
> -	return 0;
> +	/* allocate pages for ACPI NVS memory before swsusp_shrink_memory *=
/
> +	return acpi_allocate_nvs_pages();

I think we shouldn't abort hibernation because of that.

This may be an emergency hibernation due to critical battery status and=
 we
surely don't want to about that.

>  }
> =20
>  static int acpi_hibernation_prepare(void)
> @@ -274,6 +355,20 @@
>  	return ACPI_SUCCESS(acpi_hw_disable_all_gpes()) ? 0 : -EFAULT;
>  }
> =20
> +static int acpi_hibernation_pre_snapshot(void)
> +{
> +	int error =3D acpi_sleep_prepare(ACPI_STATE_S4);
> +
> +	if (error) {
> +		acpi_target_sleep_state =3D ACPI_STATE_S0;
> +		return error;
> +	}
> +
> +	acpi_save_nvs_memory();
> +
> +	return ACPI_SUCCESS(acpi_hw_disable_all_gpes()) ? 0 : -EFAULT;
> +}
> +
>  static int acpi_hibernation_enter(void)
>  {
>  	acpi_status status =3D AE_OK;
> @@ -301,6 +396,7 @@
>  	acpi_enable();
>  	/* Reprogram control registers and execute _BFS */
>  	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
> +	acpi_restore_nvs_memory();
>  }
> =20
>  static void acpi_hibernation_finish(void)
> @@ -321,6 +417,9 @@
>  	 * during a failing transition to the sleep state.
>  	 */
>  	acpi_target_sleep_state =3D ACPI_STATE_S0;
> +
> +	/* free pages allocated for ACPI NVS memory */
> +	acpi_free_nvs_pages();
>  }
> =20
>  static int acpi_hibernation_pre_restore(void)
> @@ -340,7 +439,7 @@
>  static struct platform_hibernation_ops acpi_hibernation_ops =3D {
>  	.begin =3D acpi_hibernation_begin,
>  	.end =3D acpi_hibernation_end,
> -	.pre_snapshot =3D acpi_hibernation_prepare,
> +	.pre_snapshot =3D acpi_hibernation_pre_snapshot,
>  	.finish =3D acpi_hibernation_finish,
>  	.prepare =3D acpi_hibernation_prepare,
>  	.enter =3D acpi_hibernation_enter,
> Index: linux-2.6/include/linux/acpi.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/acpi.h	2008-06-30 16:28:56.000000000=
 +0800
> +++ linux-2.6/include/linux/acpi.h	2008-06-30 16:29:26.000000000 +080=
0
> @@ -106,6 +106,9 @@
>  void acpi_numa_arch_fixup(void);
>  #endif
> =20
> +#ifdef CONFIG_HIBERNATION
> +int acpi_mark_nvs_region(unsigned long, unsigned long);
> +#endif
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  /* Arch dependent functions for cpu hotplug support */
>  int acpi_map_lsapic(acpi_handle handle, int *pcpu);

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
