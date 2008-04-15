From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 15 Apr 2008 12:36:18 +0400
Message-ID: <48046902.8040900@gmail.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:61560 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbYDOIgZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 04:36:25 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1912078fgb.17
        for <linux-acpi@vger.kernel.org>; Tue, 15 Apr 2008 01:36:21 -0700 (PDT)
In-Reply-To: <200804150309.25361.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>
> drivers/acpi/dispatcher/dsobject.c:499: warning: format =91%X=92 expe=
cts type =91unsigned int=92, but argument 4 has type =91acpi_native_uin=
t=92
> drivers/acpi/dispatcher/dsobject.c:507: warning: format =91%X=92 expe=
cts type =91unsigned int=92, but argument 7 has type =91acpi_native_uin=
t=92
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/dispatcher/dsobject.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispat=
cher/dsobject.c
> index 5184278..bdef2f0 100644
> --- a/drivers/acpi/dispatcher/dsobject.c
> +++ b/drivers/acpi/dispatcher/dsobject.c
> @@ -373,7 +373,7 @@ acpi_ds_build_internal_package_obj(struct acpi_wa=
lk_state *walk_state,
>  	union acpi_parse_object *parent;
>  	union acpi_operand_object *obj_desc =3D NULL;
>  	acpi_status status =3D AE_OK;
> -	acpi_native_uint i;
> +	u32 i;
>  =20
why not just unsigned ?
>  	u16 index;
>  	u16 reference_count;
> =20
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
