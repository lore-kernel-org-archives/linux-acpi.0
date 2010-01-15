From: Lin Ming <lin@minggr.cn>
Subject: Re: [PATCH] ACPICA: wrong acpi_parse_state assigned
	acpi_ps_init_scope() ?
Date: Fri, 15 Jan 2010 09:47:14 +0800
Message-ID: <d3f22a1001141747p25b3406fv55364be65002546b@mail.gmail.com>
References: <4B4FB766.1020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58491 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0AOBrP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2010 20:47:15 -0500
In-Reply-To: <4B4FB766.1020805@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Jan 15, 2010 at 8:31 AM, Roel Kluin <roel.kluin@gmail.com> wrot=
e:
> Assign the package end, not the last AML byte.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this right?
>
> diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/pssc=
ope.c
> index 2feca5c..a8dfe16 100644
> --- a/drivers/acpi/acpica/psscope.c
> +++ b/drivers/acpi/acpica/psscope.c
> @@ -118,7 +118,7 @@ acpi_ps_init_scope(struct acpi_parse_state * pars=
er_state,
> =A0 =A0 =A0 =A0scope->parse_scope.op =3D root_op;
> =A0 =A0 =A0 =A0scope->parse_scope.arg_count =3D ACPI_VAR_ARGS;
> =A0 =A0 =A0 =A0scope->parse_scope.arg_end =3D parser_state->aml_end;
> - =A0 =A0 =A0 scope->parse_scope.pkg_end =3D parser_state->aml_end;
> + =A0 =A0 =A0 scope->parse_scope.pkg_end =3D parser_state->pkg_end;

->aml_end and ->pkg_end are same here.

acpi_ps_init_scope is only called in acpi_ds_init_aml_walk which set
aml_end and pkg_end the same.

acpi_ds_init_aml_walk(...)
{
    ....
    walk_state->parser_state.aml_end =3D
            walk_state->parser_state.pkg_end =3D aml_start + aml_length=
;
    .....

    status =3D acpi_ps_init_scope(&walk_state->parser_state, op);
    .....
}

Lin Ming

>
> =A0 =A0 =A0 =A0parser_state->scope =3D scope;
> =A0 =A0 =A0 =A0parser_state->start_op =3D root_op;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
