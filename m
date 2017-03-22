From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/7] ACPICA: Tables: Enable acpi_ut_is_aml_table()
 for all ACPICA modules
Date: Wed, 22 Mar 2017 07:00:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE4E589@SHSMSX101.ccr.corp.intel.com>
References: <cover.1489558845.git.lv.zheng@intel.com>
 <aebe450e81b34015bf32aee74a73144df5fecce4.1489558845.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35480 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758387AbdCVHBG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 03:01:06 -0400
In-Reply-To: <aebe450e81b34015bf32aee74a73144df5fecce4.1489558845.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Box, David E" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Hans de Goede <hdegoede@redhat.com>, "Ye, Xiaolong" <xiaolong.ye@intel.com>, "Du, Julie" <julie.du@intel.com>

Hi, Hans

Just FYI.
This commit is wrong.
It shouldn't change static table load signature check.
Should be replaced by this fix:
https://github.com/acpica/acpica/pull/121/commits/3d9eeb046c
Thanks Xiaolong for his test and report.

Thanks and best regards
Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kern=
el.org] On Behalf Of Lv Zheng
> Subject: [RFC PATCH 5/7] ACPICA: Tables: Enable acpi_ut_is_aml_table() fo=
r all ACPICA modules
>=20
> This patch enables acpi_ut_is_aml_table() for all ACPICA modules so that =
it can
> be used by Linux kernel. Lv Zheng.
>=20
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpica/acutils.h  |  4 +---
>  drivers/acpi/acpica/tbdata.c   | 17 +++--------------
>  drivers/acpi/acpica/tbxfload.c | 10 +++-------
>  drivers/acpi/acpica/utmisc.c   | 27 +++++++++++++++++----------
>  4 files changed, 24 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.=
h
> index 6f28cfa..c0b697f 100644
> --- a/drivers/acpi/acpica/acutils.h
> +++ b/drivers/acpi/acpica/acutils.h
> @@ -545,9 +545,7 @@ const struct acpi_exception_info *acpi_ut_validate_ex=
ception(acpi_status
>=20
>  u8 acpi_ut_is_pci_root_bridge(char *id);
>=20
> -#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_=
NAMES_APP)
> -u8 acpi_ut_is_aml_table(struct acpi_table_header *table);
> -#endif
> +u8 acpi_ut_is_aml_table(char *signature);
>=20
>  acpi_status
>  acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
> diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
> index 1a4371b..1e1222d 100644
> --- a/drivers/acpi/acpica/tbdata.c
> +++ b/drivers/acpi/acpica/tbdata.c
> @@ -859,20 +859,9 @@ acpi_tb_validate_table_for_load(u32 *table_index,
>  		goto unlock_and_exit;
>  	}
>=20
> -	/*
> -	 * Validate the incoming table signature.
> -	 *
> -	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
> -	 * 2) We added support for OEMx tables, signature "OEM".
> -	 * 3) Valid tables were encountered with a null signature, so we just
> -	 *    gave up on validating the signature, (05/2008).
> -	 * 4) We encountered non-AML tables such as the MADT, which caused
> -	 *    interpreter errors and kernel faults. So now, we once again allow
> -	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
> -	 */
> -	if ((table_desc->signature.ascii[0] !=3D 0x00) &&
> -	    (!ACPI_COMPARE_NAME(&table_desc->signature, ACPI_SIG_SSDT)) &&
> -	    (strncmp(table_desc->signature.ascii, "OEM", 3))) {
> +	/* Validate the incoming table signature */
> +
> +	if (!acpi_ut_is_aml_table(table_desc->signature.ascii)) {
>  		ACPI_BIOS_ERROR((AE_INFO,
>  				 "Table has invalid signature [%4.4s] (0x%8.8X), "
>  				 "must be SSDT or OEMx",
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfloa=
d.c
> index b71ce3b..9753176 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -206,13 +206,9 @@ acpi_status acpi_tb_load_namespace(void)
>  	for (i =3D 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
>  		table =3D &acpi_gbl_root_table_list.tables[i];
>=20
> -		if (!acpi_gbl_root_table_list.tables[i].address ||
> -		    (!ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_SSDT)
> -		     && !ACPI_COMPARE_NAME(table->signature.ascii,
> -					   ACPI_SIG_PSDT)
> -		     && !ACPI_COMPARE_NAME(table->signature.ascii,
> -					   ACPI_SIG_OSDT))
> -		    || ACPI_FAILURE(acpi_tb_validate_table(table))) {
> +		if (!table->address || i =3D=3D acpi_gbl_dsdt_index ||
> +		    !acpi_ut_is_aml_table(table->signature.ascii) ||
> +		    ACPI_FAILURE(acpi_tb_validate_table(table))) {
>  			continue;
>  		}
>=20
> diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
> index 443ffad..e5074d8 100644
> --- a/drivers/acpi/acpica/utmisc.c
> +++ b/drivers/acpi/acpica/utmisc.c
> @@ -75,7 +75,6 @@ u8 acpi_ut_is_pci_root_bridge(char *id)
>  	return (FALSE);
>  }
>=20
> -#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_=
NAMES_APP)
>  /***********************************************************************=
********
>   *
>   * FUNCTION:    acpi_ut_is_aml_table
> @@ -90,21 +89,29 @@ u8 acpi_ut_is_pci_root_bridge(char *id)
>   *
>   ***********************************************************************=
*******/
>=20
> -u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
> +u8 acpi_ut_is_aml_table(char *signature)
>  {
> -
> -	/* These are the only tables that contain executable AML */
> -
> -	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) ||
> -	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_PSDT) ||
> -	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT) ||
> -	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT)) {
> +	/*
> +	 * These are the only tables that contain executable AML
> +	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
> +	 * 2) We added support for OEMx tables, signature "OEM".
> +	 * 3) Valid tables were encountered with a null signature, so we just
> +	 *    gave up on validating the signature, (05/2008).
> +	 * 4) We encountered non-AML tables such as the MADT, which caused
> +	 *    interpreter errors and kernel faults. So now, we once again allow
> +	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
> +	 */
> +	if (signature[0] =3D=3D 0x00 ||
> +	    ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT) ||
> +	    ACPI_COMPARE_NAME(signature, ACPI_SIG_PSDT) ||
> +	    ACPI_COMPARE_NAME(signature, ACPI_SIG_SSDT) ||
> +	    ACPI_COMPARE_NAME(signature, ACPI_SIG_OSDT) ||
> +	    strncmp(signature, "OEM", 3) =3D=3D 0) {
>  		return (TRUE);
>  	}
>=20
>  	return (FALSE);
>  }
> -#endif
>=20
>  /***********************************************************************=
********
>   *
> --
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
