From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPICA: Put back the call to acpi_os_validate_address
Date: Mon, 12 Dec 2011 21:07:32 +0800
Message-ID: <CAF1ivSaunVqDvf-8hO5wL2K0hsteC3uoWVJ1LtZznnfb7ph0Og@mail.gmail.com>
References: <1322576015.6856.10.camel@hp6530s>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:40496 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab1LLNHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2011 08:07:33 -0500
Received: by qadb15 with SMTP id b15so4549566qad.19
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2011 05:07:32 -0800 (PST)
In-Reply-To: <1322576015.6856.10.camel@hp6530s>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, kronos.it@gmail.com, "Moore, Robert" <robert.moore@intel.com>, Jean Delvare <khali@linux-fr.org>, stable@kernel.org

On Tue, Nov 29, 2011 at 10:13 PM, Lin Ming <ming.m.lin@intel.com> wrote=
:
> The call to acpi_os_validate_address in acpi_ds_get_region_arguments =
was
> removed by mistake in commit 9ad19ac(ACPICA: Split large dsopcode and
> dsload.c files).
>
> Put it back.
>
> Reported-and-bisected-by: Luca Tettamanti <kronos.it@gmail.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

Hi Len,

Could you take this patch?

(CC stable@kernel.org)

=46or stable kernel 2.6.39, 3.0, 3.1.

Thanks,
Lin Ming

> ---
>
> Len,
>
> Could you apply this patch?
> And it should be ported to stable kernel since v2.6.39.
>
> =A0drivers/acpi/acpica/dsargs.c | =A0 24 ++++++++++++++++++++++++
> =A01 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsarg=
s.c
> index 634f5b2..d69e4a5 100644
> --- a/drivers/acpi/acpica/dsargs.c
> +++ b/drivers/acpi/acpica/dsargs.c
> @@ -387,5 +387,29 @@ acpi_status acpi_ds_get_region_arguments(union a=
cpi_operand_object *obj_desc)
> =A0 =A0 =A0 =A0status =3D acpi_ds_execute_arguments(node, extra_desc-=
>extra.scope_node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 extra_desc->extra.aml_length,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 extra_desc->extra.aml_start);
> + =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Validate the region address/length via the host OS *=
/
> +
> + =A0 =A0 =A0 status =3D acpi_os_validate_address(obj_desc->region.sp=
ace_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 obj_desc->region.address,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (acpi_size) obj_desc->region.length,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 acpi_ut_get_node_name(node));
> +
> + =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Invalid address/length. We will em=
it an error message and mark
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the region as invalid, so that it =
will cause an additional error if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it is ever used. Then return AE_OK=
=2E
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_EXCEPTION((AE_INFO, status,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "During=
 address validation of OpRegion [%4.4s]",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node->n=
ame.ascii));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 obj_desc->common.flags |=3D AOPOBJ_INVA=
LID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D AE_OK;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return_ACPI_STATUS(status);
> =A0}
> --
> 1.7.2.5
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
