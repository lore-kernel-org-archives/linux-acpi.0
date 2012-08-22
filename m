From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 1/2] ACPI: Use ACPICA native way to decode the PLD buffer
Date: Wed, 22 Aug 2012 15:05:38 +0800
Message-ID: <503484C2.8070106@intel.com>
References: <1345616676-30915-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45595 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab2HVHFx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Aug 2012 03:05:53 -0400
In-Reply-To: <1345616676-30915-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, mjg@redhat.com, gregkh@linuxfoundation.org, Bob Moore <robert.moore@intel.com>

On 2012=E5=B9=B408=E6=9C=8822=E6=97=A5 14:24, Feng Tang wrote:
> This patch is on top of the ACPICA 20120816 release, which implemente=
d
> a native way to decode PLD buffer, so use it instead of leting upper
> level users do the decoding.
>=20
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/utils.c    |   11 +++++++----
>  include/acpi/acpi_bus.h |   31 +------------------------------
>  2 files changed, 8 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 3e87c9c..e697bf2 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -384,7 +384,7 @@ acpi_evaluate_reference(acpi_handle handle,
>  EXPORT_SYMBOL(acpi_evaluate_reference);
> =20
>  acpi_status
> -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d *pld)
> +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d_info **pld)
Sorry. I have not found the definition of struct acpi_pld_info or is
there something I have missed?
>  {
>  	acpi_status status;
>  	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -400,13 +400,16 @@ acpi_get_physical_device_location(acpi_handle h=
andle, struct acpi_pld *pld)
>  	if (!output || output->type !=3D ACPI_TYPE_PACKAGE
>  	    || !output->package.count
>  	    || output->package.elements[0].type !=3D ACPI_TYPE_BUFFER
> -	    || output->package.elements[0].buffer.length > sizeof(*pld)) {
> +	    || output->package.elements[0].buffer.length > 16) {
>  		status =3D AE_TYPE;
>  		goto out;
>  	}
> =20
> -	memcpy(pld, output->package.elements[0].buffer.pointer,
> -	       output->package.elements[0].buffer.length);
> +	status =3D acpi_decode_pld_buffer(
> +			output->package.elements[0].buffer.pointer,
> +			output->package.elements[0].buffer.length,
> +			pld);
> +
>  out:
>  	kfree(buffer.pointer);
>  	return status;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index bde976e..0c1fcd4 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -54,37 +54,8 @@ acpi_status
>  acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
>  			u32 status_code, struct acpi_buffer *status_buf);
> =20
> -struct acpi_pld {
> -	unsigned int revision:7; /* 0 */
> -	unsigned int ignore_colour:1; /* 7 */
> -	unsigned int colour:24; /* 8 */
> -	unsigned int width:16; /* 32 */
> -	unsigned int height:16; /* 48 */
> -	unsigned int user_visible:1; /* 64 */
> -	unsigned int dock:1; /* 65 */
> -	unsigned int lid:1; /* 66 */
> -	unsigned int panel:3; /* 67 */
> -	unsigned int vertical_pos:2; /* 70 */
> -	unsigned int horizontal_pos:2; /* 72 */
> -	unsigned int shape:4; /* 74 */
> -	unsigned int group_orientation:1; /* 78 */
> -	unsigned int group_token:8; /* 79 */
> -	unsigned int group_position:8; /* 87 */
> -	unsigned int bay:1; /* 95 */
> -	unsigned int ejectable:1; /* 96 */
> -	unsigned int ospm_eject_required:1; /* 97 */
> -	unsigned int cabinet_number:8; /* 98 */
> -	unsigned int card_cage_number:8; /* 106 */
> -	unsigned int reference:1; /* 114 */
> -	unsigned int rotation:4; /* 115 */
> -	unsigned int order:5; /* 119 */
> -	unsigned int reserved:4; /* 124 */
> -	unsigned int vertical_offset:16; /* 128 */
> -	unsigned int horizontal_offset:16; /* 144 */
> -} __attribute__((__packed__));
> -
>  acpi_status
> -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d *pld);
> +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pl=
d_info **pld);
>  #ifdef CONFIG_ACPI
> =20
>  #include <linux/proc_fs.h>
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
