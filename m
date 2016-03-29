From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC PATCH] acpi: Use a more normal logging style for
 ACPI_<LEVEL> calls
Date: Tue, 29 Mar 2016 15:27:12 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553D5@ORSMSX110.amr.corp.intel.com>
References: <1459222225.25110.58.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57427 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbcC2P1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2016 11:27:15 -0400
In-Reply-To: <1459222225.25110.58.camel@perches.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, linux-kernel <linux-kernel@vger.kernel.org>

Probably not, because ACPI_INFO is a public (and documented) macro, and=
 ACPICA is used in many operating systems.

The double parens are there to allow for variable-length arguments, I b=
elieve.

Bob


> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Monday, March 28, 2016 8:30 PM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel
> Subject: [RFC PATCH] acpi: Use a more normal logging style for
> ACPI_<LEVEL> calls
>=20
> This is just an example of a conversion of ACPI_INFO to a more typica=
l
> kernel use style.  All of the other ACPI_<LEVEL> calls would also nee=
d
> conversion.
>=20
> Almost all logging functions and macros in the kernel are lower case =
and
> nearly all use formats with terminating newlines.
>=20
> ACPI uses upper case macros and no terminating newline in the format.
>=20
> Some of the uses though _do_ have newlines. =A0This can cause undesir=
ed
> newlines in dmesg output.
>=20
> Also, the ACPI_<LEVEL> macros use a somewhat odd and unpleasant style=
 with
> double parentheses.
>=20
> Convert this to a lower case macro, add terminating newlines to forma=
ts
> and remove the unnecessary extra parentheses.
>=20
> Rename the logging function to _acpi_info and have the acpi_info macr=
os
> call this _acpi_info function.
>=20
> Remove the newline from the _acpi_info call.
>=20
> This means that all calls to acpi_info are complete and it is not pos=
sible
> for any other message to be interleaved into this message.
>=20
> Miscellanea:
>=20
> o Coalesce formats
> o Realign arguments
> o Coalesce arguments even if > 80 columns
> ---
> =A0drivers/acpi/acpica/dbcmds.c=A0=A0=A0=A0|=A0=A04 ++--
> =A0drivers/acpi/acpica/dsmethod.c=A0=A0|=A0=A06 ++----
> =A0drivers/acpi/acpica/dsobject.c=A0=A0|=A0=A05 ++---
> =A0drivers/acpi/acpica/evgpeblk.c=A0=A0|=A0=A08 ++++----
> =A0drivers/acpi/acpica/evgpeinit.c |=A0=A02 +-
> =A0drivers/acpi/acpica/exconfig.c=A0=A0|=A0=A04 ++--
> =A0drivers/acpi/acpica/nseval.c=A0=A0=A0=A0|=A0=A04 ++--
> =A0drivers/acpi/acpica/tbinstal.c=A0=A0| 15 +++++++--------
> =A0drivers/acpi/acpica/tbprint.c=A0=A0=A0| 36 ++++++++++++++++-------=
-------------
> =A0drivers/acpi/acpica/tbutils.c=A0=A0=A0|=A0=A03 ++-
> =A0drivers/acpi/acpica/tbxfload.c=A0=A0|=A0=A05 +++--
> =A0drivers/acpi/acpica/uttrack.c=A0=A0=A0|=A0=A02 +-
> =A0drivers/acpi/acpica/utxferror.c |=A0=A07 +++----
> =A0include/acpi/acoutput.h=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A06 +++---
> =A0include/acpi/acpixf.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A02 +-
> =A015 files changed, 51 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmd=
s.c
> index 772178c..1ef21be 100644
> --- a/drivers/acpi/acpica/dbcmds.c
> +++ b/drivers/acpi/acpica/dbcmds.c
> @@ -348,8 +348,8 @@ void acpi_db_display_table_info(char *table_arg)
> =A0		} else {
> =A0			/* If the pointer is null, the table has been unloaded
> */
>=20
> -			ACPI_INFO(("%4.4s - Table has been unloaded",
> -				=A0=A0=A0table_desc->signature.ascii));
> +			acpi_info("%4.4s - Table has been unloaded\n",
> +				=A0=A0table_desc->signature.ascii);
> =A0		}
> =A0	}
> =A0}
> diff --git a/drivers/acpi/acpica/dsmethod.c
> b/drivers/acpi/acpica/dsmethod.c index 1982310..4730b0a 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -809,10 +809,8 @@ acpi_ds_terminate_control_method(union
> acpi_operand_object *method_desc,
> =A0		if (method_desc->method.
> =A0		=A0=A0=A0=A0info_flags & ACPI_METHOD_SERIALIZED_PENDING) {
> =A0			if (walk_state) {
> -				ACPI_INFO(("Marking method %4.4s as Serialized "
> -					=A0=A0=A0"because of AE_ALREADY_EXISTS error",
> -					=A0=A0=A0walk_state->method_node->name.
> -					=A0=A0=A0ascii));
> +				acpi_info("Marking method %4.4s as Serialized
> because of AE_ALREADY_EXISTS error\n",
> +					=A0=A0walk_state->method_node->name.ascii);
> =A0			}
>=20
> =A0			/*
> diff --git a/drivers/acpi/acpica/dsobject.c
> b/drivers/acpi/acpica/dsobject.c index a91de2b..6787274 100644
> --- a/drivers/acpi/acpica/dsobject.c
> +++ b/drivers/acpi/acpica/dsobject.c
> @@ -524,9 +524,8 @@ acpi_ds_build_internal_package_obj(struct
> acpi_walk_state *walk_state,
> =A0			arg =3D arg->common.next;
> =A0		}
>=20
> -		ACPI_INFO(("Actual Package length (%u) is larger than "
> -			=A0=A0=A0"NumElements field (%u), truncated",
> -			=A0=A0=A0i, element_count));
> +		acpi_info("Actual Package length (%u) is larger than
> NumElements field (%u), truncated\n",
> +			=A0=A0i, element_count);
> =A0	} else if (i < element_count) {
> =A0		/*
> =A0		=A0* Arg list (elements) was exhausted, but we did not reach
> num_elements count.
> diff --git a/drivers/acpi/acpica/evgpeblk.c
> b/drivers/acpi/acpica/evgpeblk.c index 447fa1c..2244ed8 100644
> --- a/drivers/acpi/acpica/evgpeblk.c
> +++ b/drivers/acpi/acpica/evgpeblk.c
> @@ -499,10 +499,10 @@ acpi_ev_initialize_gpe_block(struct
> acpi_gpe_xrupt_info *gpe_xrupt_info,
> =A0	}
>=20
> =A0	if (gpe_enabled_count) {
> -		ACPI_INFO(("Enabled %u GPEs in block %02X to %02X",
> -			=A0=A0=A0gpe_enabled_count, (u32)gpe_block->block_base_number,
> -			=A0=A0=A0(u32)(gpe_block->block_base_number +
> -				=A0(gpe_block->gpe_count - 1))));
> +		acpi_info("Enabled %u GPEs in block %02X to %02X\n",
> +			=A0=A0gpe_enabled_count, (u32)gpe_block->block_base_number,
> +			=A0=A0(u32)(gpe_block->block_base_number +
> +				gpe_block->gpe_count - 1));
> =A0	}
>=20
> =A0	gpe_block->initialized =3D TRUE;
> diff --git a/drivers/acpi/acpica/evgpeinit.c
> b/drivers/acpi/acpica/evgpeinit.c index 7dc7547..3a6d717 100644
> --- a/drivers/acpi/acpica/evgpeinit.c
> +++ b/drivers/acpi/acpica/evgpeinit.c
> @@ -281,7 +281,7 @@ void acpi_ev_update_gpes(acpi_owner_id table_owne=
r_id)
> =A0	}
>=20
> =A0	if (walk_info.count) {
> -		ACPI_INFO(("Enabled %u new GPEs", walk_info.count));
> +		acpi_info("Enabled %u new GPEs\n", walk_info.count);
> =A0	}
>=20
> =A0	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
> diff --git a/drivers/acpi/acpica/exconfig.c
> b/drivers/acpi/acpica/exconfig.c index f741613..99916fe 100644
> --- a/drivers/acpi/acpica/exconfig.c
> +++ b/drivers/acpi/acpica/exconfig.c
> @@ -252,7 +252,7 @@ acpi_ex_load_table_op(struct acpi_walk_state
> *walk_state,
>=20
> =A0	status =3D acpi_get_table_by_index(table_index, &table);
> =A0	if (ACPI_SUCCESS(status)) {
> -		ACPI_INFO(("Dynamic OEM Table Load:"));
> +		acpi_info("Dynamic OEM Table Load:\n");
> =A0		acpi_tb_print_table_header(0, table);
> =A0	}
>=20
> @@ -472,7 +472,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_de=
sc,
>=20
> =A0	/* Install the new table into the local data structures */
>=20
> -	ACPI_INFO(("Dynamic OEM Table Load:"));
> +	acpi_info("Dynamic OEM Table Load:\n");
> =A0	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
>=20
> =A0	status =3D acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(ta=
ble),
> diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseva=
l.c
> index 5d59cfc..18777f0 100644
> --- a/drivers/acpi/acpica/nseval.c
> +++ b/drivers/acpi/acpica/nseval.c
> @@ -378,8 +378,8 @@ void acpi_ns_exec_module_code_list(void)
> =A0		acpi_ut_remove_reference(prev);
> =A0	}
>=20
> -	ACPI_INFO(("Executed %u blocks of module-level executable AML code"=
,
> -		=A0=A0=A0method_count));
> +	acpi_info("Executed %u blocks of module-level executable AML
> code\n",
> +		=A0=A0method_count);
>=20
> =A0	ACPI_FREE(info);
> =A0	acpi_gbl_module_code_list =3D NULL;
> diff --git a/drivers/acpi/acpica/tbinstal.c
> b/drivers/acpi/acpica/tbinstal.c index 4dc6108..28f2ab7 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -267,9 +267,9 @@ acpi_tb_install_standard_table(acpi_physical_addr=
ess
> address,
> =A0	if (!reload &&
> =A0	=A0=A0=A0=A0acpi_gbl_disable_ssdt_table_install &&
> =A0	=A0=A0=A0=A0ACPI_COMPARE_NAME(&new_table_desc.signature, ACPI_SIG=
_SSDT)) {
> -		ACPI_INFO(("Ignoring installation of %4.4s at %8.8X%8.8X",
> -			=A0=A0=A0new_table_desc.signature.ascii,
> -			=A0=A0=A0ACPI_FORMAT_UINT64(address)));
> +		acpi_info("Ignoring installation of %4.4s at %8.8X%8.8X\n",
> +			=A0=A0new_table_desc.signature.ascii,
> +			=A0=A0ACPI_FORMAT_UINT64(address));
> =A0		goto release_and_exit;
> =A0	}
>=20
> @@ -431,11 +431,10 @@ finish_override:
> =A0		return;
> =A0	}
>=20
> -	ACPI_INFO(("%4.4s 0x%8.8X%8.8X"
> -		=A0=A0=A0" %s table override, new table: 0x%8.8X%8.8X",
> -		=A0=A0=A0old_table_desc->signature.ascii,
> -		=A0=A0=A0ACPI_FORMAT_UINT64(old_table_desc->address),
> -		=A0=A0=A0override_type,
> ACPI_FORMAT_UINT64(new_table_desc.address)));
> +	acpi_info("%4.4s 0x%8.8X%8.8X %s table override, new table:
> 0x%8.8X%8.8X\n",
> +		=A0=A0old_table_desc->signature.ascii,
> +		=A0=A0ACPI_FORMAT_UINT64(old_table_desc->address),
> +		=A0=A0override_type, ACPI_FORMAT_UINT64(new_table_desc.address));
>=20
> =A0	/* We can now uninstall the original table */
>=20
> diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbpr=
int.c
> index 26d61db..030d610 100644
> --- a/drivers/acpi/acpica/tbprint.c
> +++ b/drivers/acpi/acpica/tbprint.c
> @@ -132,9 +132,9 @@ acpi_tb_print_table_header(acpi_physical_address
> address,
>=20
> =A0		/* FACS only has signature and length fields */
>=20
> -		ACPI_INFO(("%-4.4s 0x%8.8X%8.8X %06X",
> -			=A0=A0=A0header->signature, ACPI_FORMAT_UINT64(address),
> -			=A0=A0=A0header->length));
> +		acpi_info("%-4.4s 0x%8.8X%8.8X %06X\n",
> +			=A0=A0header->signature, ACPI_FORMAT_UINT64(address),
> +			=A0=A0header->length);
> =A0	} else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
>=20
> =A0		/* RSDP has no common fields */
> @@ -144,28 +144,24 @@ acpi_tb_print_table_header(acpi_physical_addres=
s
> address,
> =A0		=A0=A0=A0=A0=A0=A0=A0ACPI_OEM_ID_SIZE);
> =A0		acpi_tb_fix_string(local_header.oem_id, ACPI_OEM_ID_SIZE);
>=20
> -		ACPI_INFO(("RSDP 0x%8.8X%8.8X %06X (v%.2d %-6.6s)",
> -			=A0=A0=A0ACPI_FORMAT_UINT64(address),
> -			=A0=A0=A0(ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
> -			=A0=A0=A0=A0revision >
> -			=A0=A0=A0=A00) ? ACPI_CAST_PTR(struct acpi_table_rsdp,
> -					=A0=A0=A0=A0=A0=A0=A0header)->length : 20,
> -			=A0=A0=A0ACPI_CAST_PTR(struct acpi_table_rsdp,
> -					=A0header)->revision,
> -			=A0=A0=A0local_header.oem_id));
> +		acpi_info("RSDP 0x%8.8X%8.8X %06X (v%.2d %-6.6s)\n",
> +			=A0=A0ACPI_FORMAT_UINT64(address),
> +			=A0=A0ACPI_CAST_PTR(struct acpi_table_rsdp, header)-
> >revision > 0 ?
> +			=A0=A0ACPI_CAST_PTR(struct acpi_table_rsdp, header)->length
> : 20,
> +			=A0=A0ACPI_CAST_PTR(struct acpi_table_rsdp, header)-
> >revision,
> +			=A0=A0local_header.oem_id);
> =A0	} else {
> =A0		/* Standard ACPI table with full common header */
>=20
> =A0		acpi_tb_cleanup_table_header(&local_header, header);
>=20
> -		ACPI_INFO(("%-4.4s 0x%8.8X%8.8X"
> -			=A0=A0=A0" %06X (v%.2d %-6.6s %-8.8s %08X %-4.4s %08X)",
> -			=A0=A0=A0local_header.signature, ACPI_FORMAT_UINT64(address),
> -			=A0=A0=A0local_header.length, local_header.revision,
> -			=A0=A0=A0local_header.oem_id, local_header.oem_table_id,
> -			=A0=A0=A0local_header.oem_revision,
> -			=A0=A0=A0local_header.asl_compiler_id,
> -			=A0=A0=A0local_header.asl_compiler_revision));
> +		acpi_info("%-4.4s 0x%8.8X%8.8X %06X (v%.2d %-6.6s %-8.8s %08X
> %-4.4s %08X)\n",
> +			=A0=A0local_header.signature, ACPI_FORMAT_UINT64(address),
> +			=A0=A0local_header.length, local_header.revision,
> +			=A0=A0local_header.oem_id, local_header.oem_table_id,
> +			=A0=A0local_header.oem_revision,
> +			=A0=A0local_header.asl_compiler_id,
> +			=A0=A0local_header.asl_compiler_revision);
> =A0	}
> =A0}
>=20
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbut=
ils.c
> index 9240c76..8f64b38 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -174,7 +174,8 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32
> table_index)
> =A0				=A0=A0=A0=A0=A0=A0ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
> =A0				=A0=A0=A0=A0=A0=A0new_table);
>=20
> -	ACPI_INFO(("Forced DSDT copy: length 0x%05X copied locally, origina=
l
> unmapped", new_table->length));
> +	acpi_info("Forced DSDT copy: length 0x%05X copied locally, original
> unmapped\n",
> +		=A0=A0new_table->length);
>=20
> =A0	return (new_table);
> =A0}
> diff --git a/drivers/acpi/acpica/tbxfload.c
> b/drivers/acpi/acpica/tbxfload.c index 3151968..0827d17 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,8 @@ acpi_status acpi_tb_load_namespace(void)
> =A0	}
>=20
> =A0	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded\n", tables_loaded));
> +		acpi_info("%u ACPI AML tables successfully acquired and
> loaded\n",
> +			=A0=A0tables_loaded);
> =A0	} else {
> =A0		ACPI_ERROR((AE_INFO,
> =A0			=A0=A0=A0=A0"%u table load failures, %u successful", @@ -333,7
> +334,7 @@ acpi_status acpi_load_table(struct acpi_table_header *table=
)
>=20
> =A0	/* Install the table and load it into the namespace */
>=20
> -	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
> +	acpi_info("Host-directed Dynamic ACPI Table Load:\n");
> =A0	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
>=20
> =A0	status =3D acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(ta=
ble),
> diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttr=
ack.c
> index 60c406a..b1d6f4a 100644
> --- a/drivers/acpi/acpica/uttrack.c
> +++ b/drivers/acpi/acpica/uttrack.c
> @@ -712,7 +712,7 @@ void acpi_ut_dump_allocations(u32 component, cons=
t
> char *module)
> =A0	/* Print summary */
>=20
> =A0	if (!num_outstanding) {
> -		ACPI_INFO(("No outstanding allocations"));
> +		acpi_info("No outstanding allocations\n");
> =A0	} else {
> =A0		ACPI_ERROR((AE_INFO, "%u(0x%X) Outstanding allocations",
> =A0			=A0=A0=A0=A0num_outstanding, num_outstanding)); diff --git
> a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c i=
ndex
> d9f15cb..e9a80c2 100644
> --- a/drivers/acpi/acpica/utxferror.c
> +++ b/drivers/acpi/acpica/utxferror.c
> @@ -161,7 +161,7 @@ ACPI_EXPORT_SYMBOL(acpi_warning)
>=20
> =A0/*****************************************************************=
*******
> *******
> =A0 *
> - * FUNCTION:=A0=A0=A0=A0acpi_info
> + * FUNCTION:=A0=A0=A0=A0_acpi_info
> =A0 *
> =A0 * PARAMETERS:=A0=A0module_name=A0=A0=A0=A0=A0=A0=A0=A0=A0- Caller=
's module name (for error
> output)
> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0line_number=A0=A0=A0=A0=
=A0=A0=A0=A0=A0- Caller's line number (for error
> output) @@ -175,7 +175,7 @@ ACPI_EXPORT_SYMBOL(acpi_warning)
> =A0 * TBD: module_name and line_number args are not needed, should be
> removed.
> =A0 *
> =A0 *****************************************************************=
*******
> ******/
> -void ACPI_INTERNAL_VAR_XFACE acpi_info(const char *format, ...)
> +void ACPI_INTERNAL_VAR_XFACE _acpi_info(const char *format, ...)
> =A0{
> =A0	va_list arg_list;
>=20
> @@ -184,13 +184,12 @@ void ACPI_INTERNAL_VAR_XFACE acpi_info(const ch=
ar
> *format, ...)
>=20
> =A0	va_start(arg_list, format);
> =A0	acpi_os_vprintf(format, arg_list);
> -	acpi_os_printf("\n");
> =A0	va_end(arg_list);
>=20
> =A0	ACPI_MSG_REDIRECT_END;
> =A0}
>=20
> -ACPI_EXPORT_SYMBOL(acpi_info)
> +ACPI_EXPORT_SYMBOL(_acpi_info)
>=20
> =A0/*****************************************************************=
*******
> *******
> =A0 *
> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index
> 34f601e..4812992 100644
> --- a/include/acpi/acoutput.h
> +++ b/include/acpi/acoutput.h
> @@ -223,10 +223,9 @@
>=20
> =A0/*
> =A0 * Error reporting. Callers module and line number are inserted by
> AE_INFO,
> - * the plist contains a set of parens to allow variable-length lists=
=2E
> =A0 * These macros are used for both the debug and non-debug versions=
 of the
> code.
> =A0 */
> -#define ACPI_INFO(plist)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0acpi_info plist
> +#define acpi_info(fmt, ...)		_acpi_info(fmt, ##__VA_ARGS__)
> =A0#define ACPI_WARNING(plist)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
acpi_warning plist
> =A0#define ACPI_EXCEPTION(plist)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0acpi=
_exception plist
> =A0#define ACPI_ERROR(plist)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0acpi_error plist @@ -238,7 +237,8
> @@
>=20
> =A0/* No error messages */
>=20
> -#define ACPI_INFO(plist)
> +#define acpi_info(fmt, ...)					\
> +	do { if (0) _acpi_info(fmt, ##__VA_ARGS__); } while (0)
> =A0#define ACPI_WARNING(plist)
> =A0#define ACPI_EXCEPTION(plist)
> =A0#define ACPI_ERROR(plist)
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index
> 1755697..f5f96ac 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -899,7 +899,7 @@ ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3=
)
> =A0					=A0=A0=A0=A0=A0const char *format, ...))
> =A0ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(1)
> =A0				void ACPI_INTERNAL_VAR_XFACE
> -				acpi_info(const char *format, ...))
> +				_acpi_info(const char *format, ...))
> =A0ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
> =A0				void ACPI_INTERNAL_VAR_XFACE
> =A0				acpi_bios_error(const char *module_name,
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
