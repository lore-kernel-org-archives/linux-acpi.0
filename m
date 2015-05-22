From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI / property: Define a symbol for PRP0001
Date: Fri, 22 May 2015 19:01:03 +0800
Message-ID: <555F0C6F.6030503@linaro.org>
References: <1703975.P7AUE5bA3t@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35981 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbbEVLBN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2015 07:01:13 -0400
Received: by pdfh10 with SMTP id h10so16993803pdf.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2015 04:01:13 -0700 (PDT)
In-Reply-To: <1703975.P7AUE5bA3t@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>

On 2015=E5=B9=B405=E6=9C=8822=E6=97=A5 10:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Use a #defined symbol ACPI_DT_NAMESPACE_HID instead of the PRP0001
> string.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/internal.h |    2 ++
>   drivers/acpi/property.c |    8 ++++----
>   drivers/acpi/scan.c     |   28 +++++++++++++++-------------
>   3 files changed, 21 insertions(+), 17 deletions(-)
>
> Index: linux-pm/drivers/acpi/internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -191,6 +191,8 @@ bool acpi_osi_is_win8(void);
>   /*-----------------------------------------------------------------=
---------
>   				Device properties
>     -----------------------------------------------------------------=
--------- */
> +#define ACPI_DT_NAMESPACE_HID	"PRP0001"

This makes PRP0001 easy understood,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

> +
>   void acpi_init_properties(struct acpi_device *adev);
>   void acpi_free_properties(struct acpi_device *adev);
>
> Index: linux-pm/drivers/acpi/scan.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -135,12 +135,13 @@ static int create_pnp_modalias(struct ac
>   	struct acpi_hardware_id *id;
>
>   	/*
> -	 * Since we skip PRP0001 from the modalias below, 0 should be retur=
ned
> -	 * if PRP0001 is the only ACPI/PNP ID in the device's list.
> +	 * Since we skip ACPI_DT_NAMESPACE_HID from the modalias below, 0 s=
hould
> +	 * be returned if ACPI_DT_NAMESPACE_HID is the only ACPI/PNP ID in =
the
> +	 * device's list.
>   	 */
>   	count =3D 0;
>   	list_for_each_entry(id, &acpi_dev->pnp.ids, list)
> -		if (strcmp(id->id, "PRP0001"))
> +		if (strcmp(id->id, ACPI_DT_NAMESPACE_HID))
>   			count++;
>
>   	if (!count)
> @@ -153,7 +154,7 @@ static int create_pnp_modalias(struct ac
>   	size -=3D len;
>
>   	list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
> -		if (!strcmp(id->id, "PRP0001"))
> +		if (!strcmp(id->id, ACPI_DT_NAMESPACE_HID))
>   			continue;
>
>   		count =3D snprintf(&modalias[len], size, "%s:", id->id);
> @@ -177,7 +178,8 @@ static int create_pnp_modalias(struct ac
>    * @size: Size of the buffer.
>    *
>    * Expose DT compatible modalias as of:NnameTCcompatible.  This fun=
ction should
> - * only be called for devices having PRP0001 in their list of ACPI/P=
NP IDs.
> + * only be called for devices having ACPI_DT_NAMESPACE_HID in their =
list of
> + * ACPI/PNP IDs.
>    */
>   static int create_of_modalias(struct acpi_device *acpi_dev, char *m=
odalias,
>   			      int size)
> @@ -980,9 +982,9 @@ static void acpi_device_remove_files(str
>    * @adev: ACPI device object to match.
>    * @of_match_table: List of device IDs to match against.
>    *
> - * If @dev has an ACPI companion which has the special PRP0001 devic=
e ID in its
> - * list of identifiers and a _DSD object with the "compatible" prope=
rty, use
> - * that property to match against the given list of identifiers.
> + * If @dev has an ACPI companion which has ACPI_DT_NAMESPACE_HID in =
its list of
> + * identifiers and a _DSD object with the "compatible" property, use=
 that
> + * property to match against the given list of identifiers.
>    */
>   static bool acpi_of_match_device(struct acpi_device *adev,
>   				 const struct of_device_id *of_match_table)
> @@ -1038,14 +1040,14 @@ static const struct acpi_device_id *__ac
>   				return id;
>
>   		/*
> -		 * Next, check the special "PRP0001" ID and try to match the
> +		 * Next, check ACPI_DT_NAMESPACE_HID and try to match the
>   		 * "compatible" property if found.
>   		 *
>   		 * The id returned by the below is not valid, but the only
>   		 * caller passing non-NULL of_ids here is only interested in
>   		 * whether or not the return value is NULL.
>   		 */
> -		if (!strcmp("PRP0001", hwid->id)
> +		if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
>   		    && acpi_of_match_device(device, of_ids))
>   			return id;
>   	}
> @@ -2391,7 +2393,7 @@ static void acpi_default_enumeration(str
>   }
>
>   static const struct acpi_device_id generic_device_ids[] =3D {
> -	{"PRP0001", },
> +	{ACPI_DT_NAMESPACE_HID, },
>   	{"", },
>   };
>
> @@ -2399,8 +2401,8 @@ static int acpi_generic_device_attach(st
>   				      const struct acpi_device_id *not_used)
>   {
>   	/*
> -	 * Since PRP0001 is the only ID handled here, the test below can be
> -	 * unconditional.
> +	 * Since ACPI_DT_NAMESPACE_HID is the only ID handled here, the tes=
t
> +	 * below can be unconditional.
>   	 */
>   	if (adev->data.of_compatible)
>   		acpi_default_enumeration(adev);
> Index: linux-pm/drivers/acpi/property.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/property.c
> +++ linux-pm/drivers/acpi/property.c
> @@ -110,11 +110,11 @@ void acpi_init_properties(struct acpi_de
>   	int i;
>
>   	/*
> -	 * Check if the special PRP0001 ACPI ID is present and in that case=
 we
> -	 * fill in Device Tree compatible properties for this device.
> +	 * Check if ACPI_DT_NAMESPACE_HID is present and inthat case we fil=
l in
> +	 * Device Tree compatible properties for this device.
>   	 */
>   	list_for_each_entry(hwid, &adev->pnp.ids, list) {
> -		if (!strcmp(hwid->id, "PRP0001")) {
> +		if (!strcmp(hwid->id, ACPI_DT_NAMESPACE_HID)) {
>   			acpi_of =3D true;
>   			break;
>   		}
> @@ -170,7 +170,7 @@ void acpi_init_properties(struct acpi_de
>    out:
>   	if (acpi_of && !adev->flags.of_compatible_ok)
>   		acpi_handle_info(adev->handle,
> -				 "PRP0001 requires 'compatible' property\n");
> +			 ACPI_DT_NAMESPACE_HID " requires 'compatible' property\n");
>   }
>
>   void acpi_free_properties(struct acpi_device *adev)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
