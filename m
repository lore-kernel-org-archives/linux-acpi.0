From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: bug report: ACPI Error: [RAMB] Namespace lookup failure,
 AE_NOT_FOUND (20110112/psargs-359)
Date: Thu, 22 Sep 2011 15:51:05 +0800
Message-ID: <CAF1ivSY2bMjz0Jb9PzktV_8Qry+MYFo13gHwvuWcTUPEm7eVrw@mail.gmail.com>
References: <CACAe89zvHM7Dz4X1_aTjFt6JpLSJOTWn6HdhyUHCM81+=0Uv=w@mail.gmail.com>
	<CAF1ivSa45AFa5bVWx32qCVNUCfAoEk4ZNSjmy3B1E47kE9VvWQ@mail.gmail.com>
	<CACAe89zS5zckGc-2CMcO+QW5tZyXpDq4mvUHNUc8T4WZYMPF6A@mail.gmail.com>
	<1316415840.3634.13.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60524 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab1IVHvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2011 03:51:08 -0400
Received: by vcbfk10 with SMTP id fk10so259149vcb.19
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 00:51:05 -0700 (PDT)
In-Reply-To: <1316415840.3634.13.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jim Green <student.northwestern@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Mon, Sep 19, 2011 at 3:04 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> On Mon, 2011-09-19 at 10:12 +0800, Jim Green wrote:
>> On 19 September 2011 00:23, Lin Ming <ming.m.lin@intel.com> wrote:
>> > On Mon, Sep 19, 2011 at 1:18 AM, Jim Green
>> > <student.northwestern@gmail.com> wrote:
>> >> Hello:
>> >>
>> >> I am running 2.6.38.8-4 kernel on p8p67 deluxe motherboard(bios
>> >> version 1702, latest stable)
>> >>
>> >> 2357 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.045727] ACPI: E=
C: Look
>> >> up EC in DSDT
>> >> 2358 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.046535] ACPI: E=
xecuted 1
>> >> blocks of module-level executable AML code
>> >> 2359 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049876] ACPI Er=
ror:
>> >> [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-35=
9)
>> >> 2360 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049880] ACPI Ex=
ception:
>> >> AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region)
>> >> (20110112/ =A0 =A0 =A0 =A0 nsinit-349)
>> >> 2361 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050347] ACPI: S=
SDT
>> >> 00000000df5d4818 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 MS=
=46T 03000001)
>> >> 2362 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050805] ACPI: D=
ynamic
>> >> OEM Table Load:
>> >> 2363 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050807] ACPI: S=
SDT
>> >> =A0 =A0(null) 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 MSFT =
03000001)
>> >> 2364 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050883] ACPI: S=
SDT
>> >> 00000000df5dba18 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 MS=
=46T 03000001)
>> >> 2365 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051168] ACPI: D=
ynamic
>> >> OEM Table Load:
>> >> 2366 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051169] ACPI: S=
SDT
>> >> =A0 =A0(null) 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 MSFT =
03000001)
>> >> 2367 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052510] ACPI: I=
nterpreter enabled
>> >> 2368 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052512] ACPI: (=
supports
>> >> S0 S1 S3 S4 S5)
>> >> 2369 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052530] ACPI: U=
sing
>> >> IOAPIC for interrupt routing
>> >>
>> >> Could anyone help how to fix this error?.. is this bug fixed in s=
ome
>> >> later kernel versions?
>> >
>> > Could you attach the acpidump output?
>>
>> Hi!
>>
>> Pls see attached, THanks!
>
> Hi, please try below patch on 2.6.38.* kernel.

Hi, Jim

Did you get a chance to test below patch?

Thanks,
Lin Ming

>
> (Note, this patch can't be applied on top of latest 3.1-rc kernel,
> because dsopcode.c file was renamed).
>
> From 5eeaba8a77213dc9ce777a69fd178468253ef578 Mon Sep 17 00:00:00 200=
1
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Mon, 19 Sep 2011 14:36:42 +0800
> Subject: [PATCH] ACPICA: Save scope node to resolve region argument
>
> =A0 =A0Scope (_SB)
> =A0 =A0{
> =A0 =A0 =A0 =A0Name (RAMB, 0xDF5A1018)
> =A0 =A0 =A0 =A0OperationRegion (\RAMW, SystemMemory, RAMB, 0x00010000=
)
> =A0 =A0}
>
> For above ASL code, we need to save scope node(\_SB) to lookup
> the argument node(\_SB.RAMB).
>
> Reported-by: Jim Green <student.northwestern@gmail.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
> =A0drivers/acpi/acpica/acobject.h | =A0 =A01 +
> =A0drivers/acpi/acpica/dsopcode.c | =A0 =A02 +-
> =A0drivers/acpi/acpica/excreate.c | =A0 =A06 ++++++
> =A03 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/aco=
bject.h
> index 1055769..6d276c2 100644
> --- a/drivers/acpi/acpica/acobject.h
> +++ b/drivers/acpi/acpica/acobject.h
> @@ -358,6 +358,7 @@ typedef enum {
> =A0*/
> =A0struct acpi_object_extra {
> =A0 =A0 =A0 =A0ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *=
method_REG; =A0 =A0 =A0 /* _REG method for this region (if any) */
> + =A0 =A0 =A0 struct acpi_namespace_node *scope_node;
> =A0 =A0 =A0 =A0void *region_context; =A0 /* Region-specific data */
> =A0 =A0 =A0 =A0u8 *aml_start;
> =A0 =A0 =A0 =A0u32 aml_length;
> diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dso=
pcode.c
> index bbecf29..7ba0335 100644
> --- a/drivers/acpi/acpica/dsopcode.c
> +++ b/drivers/acpi/acpica/dsopcode.c
> @@ -394,7 +394,7 @@ acpi_status acpi_ds_get_region_arguments(union ac=
pi_operand_object *obj_desc)
>
> =A0 =A0 =A0 =A0/* Execute the argument AML */
>
> - =A0 =A0 =A0 status =3D acpi_ds_execute_arguments(node, node->parent=
,
> + =A0 =A0 =A0 status =3D acpi_ds_execute_arguments(node, extra_desc->=
extra.scope_node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 extra_desc->extra.aml_length,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 extra_desc->extra.aml_start);
> =A0 =A0 =A0 =A0if (ACPI_FAILURE(status)) {
> diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/exc=
reate.c
> index e7b372d..df6ef00 100644
> --- a/drivers/acpi/acpica/excreate.c
> +++ b/drivers/acpi/acpica/excreate.c
> @@ -329,6 +329,12 @@ acpi_ex_create_region(u8 * aml_start,
> =A0 =A0 =A0 =A0region_obj2 =3D obj_desc->common.next_object;
> =A0 =A0 =A0 =A0region_obj2->extra.aml_start =3D aml_start;
> =A0 =A0 =A0 =A0region_obj2->extra.aml_length =3D aml_length;
> + =A0 =A0 =A0 if (walk_state->scope_info) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region_obj2->extra.scope_node =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 walk_state->scope_info->scope.n=
ode;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 region_obj2->extra.scope_node =3D node;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Init the region from the operands */
>
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
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
