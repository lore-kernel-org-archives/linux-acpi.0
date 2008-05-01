From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 05/10] acpi: use __init* on everything in
	tables/tbfadt.c
Date: Thu, 01 May 2008 20:55:51 +0200
Message-ID: <1209668151.1131.60.camel@linux-2bdv.site>
References: <200805010952.m419q40A031809@imap1.linux-foundation.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:39703 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbYEASz5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 May 2008 14:55:57 -0400
In-Reply-To: <200805010952.m419q40A031809@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, akpm <akpm@linux-foundation.org>

Andrew, IMO you can drop this and the const cleanups from -mm tree.

Jan, nearly all code in:
drivers/acpi/*/*.[hc]
is part of ACPICA. This currently still is =EF=BB=BF(may change) an Int=
el
internal repository which gets synced to several OS implementations,
also Linux. __init does not exist there (yet).
Also the const changes may be a bit of a pain -> this is what Robert
meant with as long as it won't end in a chain of const cleanups :)
The whole code gets style cleaned up through Lindent and manually to
half way fit to the Linux kernel style when things get merged.

=EF=BB=BFCurrently Robert has to readjust this to ACPICA coding style b=
y hand
and merge it into the internal Intel repository. Len has to pick it up
somewhat later and merge it back to the Linux kernel...

Therefore I expect for cleanup patches (this one is on the edge, but I
could understand Intel if they hold it off) the best is to wait until
Intel publishs ACPICA as CVS or whatever repository on their
lesswatts.org site.

Then it is at least only half of the merging work and this half a bit
automated with Lindent...

ACPICA is packaged on SUSE in the pmtools package, it's rather new, but
it's not the very latest version, waiting for a revision control system
is worth it, before ending up in manual fiddling...

   Thomas

On Thu, 2008-05-01 at 02:52 -0700, akpm@linux-foundation.org wrote:
> From: "Jan Beulich" <jbeulich@novell.com>
>=20
> All of the code in this file is use at boot time only.
>=20
> Additionally, acpi_tb_create_local_fadt() doesn't need a globally vis=
ible
> declaration.
>=20
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
>  drivers/acpi/tables/tbfadt.c |   15 +++++++++------
>  include/acpi/actables.h      |    2 --
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff -puN drivers/acpi/tables/tbfadt.c~acpi-use-__init-on-everything-=
in-tables-tbfadtc drivers/acpi/tables/tbfadt.c
> --- a/drivers/acpi/tables/tbfadt.c~acpi-use-__init-on-everything-in-t=
ables-tbfadtc
> +++ a/drivers/acpi/tables/tbfadt.c
> @@ -52,6 +52,8 @@ static void inline
>  acpi_tb_init_generic_address(struct acpi_generic_address *generic_ad=
dress,
>  			     u8 bit_width, u64 address);
> =20
> +static void acpi_tb_create_local_fadt(struct acpi_table_header *, u3=
2 length);
> +
>  static void acpi_tb_convert_fadt(void);
> =20
>  static void acpi_tb_validate_fadt(void);
> @@ -59,7 +61,7 @@ static void acpi_tb_validate_fadt(void);
>  /* Table for conversion of FADT to common internal format and FADT v=
alidation */
> =20
>  typedef struct acpi_fadt_info {
> -	char *name;
> +	const char *name;
>  	u8 target;
>  	u8 source;
>  	u8 length;
> @@ -70,7 +72,7 @@ typedef struct acpi_fadt_info {
>  #define ACPI_FADT_REQUIRED          1
>  #define ACPI_FADT_SEPARATE_LENGTH   2
> =20
> -static struct acpi_fadt_info fadt_info_table[] =3D {
> +static struct acpi_fadt_info __initdata fadt_info_table[] =3D {
>  	{"Pm1aEventBlock", ACPI_FADT_OFFSET(xpm1a_event_block),
>  	 ACPI_FADT_OFFSET(pm1a_event_block),
>  	 ACPI_FADT_OFFSET(pm1_event_length), ACPI_FADT_REQUIRED},
> @@ -155,7 +157,7 @@ acpi_tb_init_generic_address(struct acpi
>   *
>   *******************************************************************=
***********/
> =20
> -void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
> +void __init acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flag=
s)
>  {
>  	u32 length;
>  	struct acpi_table_header *table;
> @@ -215,7 +217,8 @@ void acpi_tb_parse_fadt(acpi_native_uint
>   *
>   *******************************************************************=
***********/
> =20
> -void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 =
length)
> +static void __init
> +acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 lengt=
h)
>  {
> =20
>  	/*
> @@ -276,7 +279,7 @@ void acpi_tb_create_local_fadt(struct ac
>   *
>   *******************************************************************=
***********/
> =20
> -static void acpi_tb_convert_fadt(void)
> +static void __init acpi_tb_convert_fadt(void)
>  {
>  	u8 pm1_register_length;
>  	struct acpi_generic_address *target;
> @@ -397,7 +400,7 @@ static void acpi_tb_convert_fadt(void)
>   *
>   *******************************************************************=
***********/
> =20
> -static void acpi_tb_validate_fadt(void)
> +static void __init acpi_tb_validate_fadt(void)
>  {
>  	u32 *address32;
>  	struct acpi_generic_address *address64;
> diff -puN include/acpi/actables.h~acpi-use-__init-on-everything-in-ta=
bles-tbfadtc include/acpi/actables.h
> --- a/include/acpi/actables.h~acpi-use-__init-on-everything-in-tables=
-tbfadtc
> +++ a/include/acpi/actables.h
> @@ -51,8 +51,6 @@ acpi_status acpi_allocate_root_table(u32
>   */
>  void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
> =20
> -void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 =
length);
> -
>  /*
>   * tbfind - find ACPI table
>   */
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
