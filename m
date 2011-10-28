From: Myron Stowe <myron.stowe@gmail.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Fri, 28 Oct 2011 16:40:36 -0600
Message-ID: <CAL-B5D3-R6=67Wy5PCUSSo8J_UQvjmEGHc62oLiKtXJCKSbCoQ@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe>
	<201110280349.26410.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42363 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab1J1Wki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Oct 2011 18:40:38 -0400
Received: by vcge1 with SMTP id e1so3805735vcg.19
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2011 15:40:37 -0700 (PDT)
In-Reply-To: <201110280349.26410.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com, bhelgaas@google.com

On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wrote=
:
> On Thursday 29 September 2011 23:59:08 Myron Stowe wrote:
> ..
>> Myron Stowe (2):
>> =A0 =A0 =A0 ACPI: Convert acpi_pre_map_gar()/acpi_atomic_read() and =
remove ./drivers/acpi/atomicio.[ch]
>> =A0 =A0 =A0 ACPI: Export interfaces for ioremapping/iounmapping ACPI=
 registers
>
> Would be great to know whether these are going to be accepted.
> If yes, this check should get removed as well:
>
> drivers/acpi/acpica/hwregs.c:
> acpi_status
> acpi_hw_validate_register(struct acpi_generic_address *reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 max_bit_width, =
u64 *address)
> {
> ...
> =A0 =A0 =A0 =A0if (reg->bit_offset !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_WARNING((AE_INFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unsupport=
ed register bit offset: 0x%X",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg->bit_o=
ffset));
> =A0 =A0 =A0 =A0}
>
> because APEI GAR declarations do use bit_offset !=3D 0.
>
> There is another problem. Would be great to get some opinions/feedbac=
k
> on it already:
> APEI GAR entries seem to have invalid bit_width entries on some platf=
orms.
> After looking at several tables, I expect that with APEI tables acces=
s width
> (in bytes) should get used instead, Windows seem to ignore bit width =
fields,
> at least for APEI tables.
>
> I have patches but I need to know whether your patches are accepted.
>
> There also is a problem with modifying GAR bit_width field to be able=
 to
> pass it to the generic acpica functions (what your patches are doing)=
=2E
> The problem is that the structures are located in reserved BIOS areas=
 and
> they should be const and not get modified.
>
> I have 2 solutions for this:
> =A01) Make apei_check_gar() pass 2 struct acpi_generic_address:
> =A0 =A0 int apei_check_gar(struct acpi_generic_address *reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct acpi_generic_addr=
ess *orig, u64 *paddr)
> =A0 =A0 orig -> is the one located in reserved mem area, mapped to vi=
rtual addr space
> =A0 =A0 reg =A0-> will be a copy of it, possibly with bit_width adjus=
ted which then
> =A0 =A0 =A0 =A0 =A0 =A0can be passed to acpi_memory_read/write and fr=
iends.
> =A02) Allocate memory and copy whole APEI tables
>
> 1. Should have the advantage of less memory waste
> 2. Should have the advantage of a bit nicer code (kalloc and memcpy p=
er table) and
> =A0 if more things like this happen, tables could get adjusted easily=
=2E
> =A0 It also has the advantage that GAR structures do not need to get =
double
> =A0 checked and eventually adjusted at runtime again.
>
> Below is the first patch which goes for 1. More patches may be needed=
, but I
> as said, I need to know whether your patches get accepted.
> What do you think?

Hi Thomas,

I assume the question as to whether or not my patches are going to get
accepted is more to Len.

I did ping Len and Rafael a couple of weeks ago with the same
question.  Rafael said that he would try to review them soon.  I would
like Rafael to review them and provide any feedback if necessary as he
did quite a lot of optimization and a bug fix or two on my original
series - in which this was the last patch in the series and never
ended up being pulled in - a year ago.

Hopefully we will hear from Len and Rafael soon and you can follow on
as necessary as you do seem to have found some valid issues.  If it
would help, or you need me to, I can re-post my series with some
changes incorporated.

Thanks,
 Myron
>
> Thanks,
>
> =A0 =A0Thomas
>
> ----
> ACPI APEI: Adjust GAR checking code to what exists out there
>
> Comparing different Generic Adress Register definitions of
> different vendors it came out that bit width (at least in APEI
> tables) is sometimes wrong or used different compared to older
> ACPI BIOS definitions (e.g. older FACP tables).
> It looks like Windows ignores the bit width field in
> latest implementations. Either in APEI table parts only
> (I'd say more likely) or in other ACPI parts as well.
>
> Worst case is that an address value to be read from a GAR structure
> can have a 8 bit width definition resulting in:
> ERST: Can not request iomem region <0x =A0 =A0 =A0 =A0 =A0 =A0 =A03f-=
0x =A0 =A0 =A0 =A0 =A0 =A0 =A03f>
> while the access width is correct:
> [1B0h 0432 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Action :=
 0D (Get Error Address Range)
> [1B4h 0436 12] =A0 =A0 =A0 =A0 =A0 =A0 =A0Register Region : <Generic =
Address Structure>
> [1B4h 0436 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Space ID : 0=
0 (SystemMemory)
> [1B5h 0437 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Bit Width : 0=
8
> [1B6h 0438 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Bit Offset : 00
> [1B7h 0439 =A01] =A0 =A0 =A0 =A0 Encoded Access Width : 04 (QWord Acc=
ess:64)
> [1B8h 0440 =A08] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address :=
 000000007F8A8032
>
>
> -> Ignore bit width field in APEI GAR checking code.
> Correct bit width value if needed (derived from access width)
> in the GAR structure, so that generic acpi read/write functions
> can still be used.
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
> =A0drivers/acpi/apei/apei-base.c =A0 =A0 | =A0 63 +++++++++++++++++++=
++++++++++-------
> =A0drivers/acpi/apei/apei-internal.h | =A0 =A02 +
> =A02 files changed, 52 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-b=
ase.c
> index 6154036..d05f084 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -520,25 +520,53 @@ void apei_resources_release(struct apei_resourc=
es *resources)
> =A0}
> =A0EXPORT_SYMBOL_GPL(apei_resources_release);
>
> -static int apei_check_gar(struct acpi_generic_address *reg, u64 *pad=
dr)
> +int apei_check_gar(struct acpi_generic_address *reg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct acpi_generic_addres=
s *orig, u64 *paddr)
> =A0{
> - =A0 =A0 =A0 u32 width, space_id;
> + =A0 =A0 =A0 int bit_width, space_id, acc_width, acc_width_bits;
>
> - =A0 =A0 =A0 width =3D reg->bit_width;
> + =A0 =A0 =A0 memcpy(reg, orig, sizeof(struct acpi_generic_address));
> + =A0 =A0 =A0 bit_width =3D reg->bit_width;
> =A0 =A0 =A0 =A0space_id =3D reg->space_id;
> + =A0 =A0 =A0 acc_width =3D reg->access_width;
> +
> =A0 =A0 =A0 =A0/* Handle possible alignment issues */
> =A0 =A0 =A0 =A0memcpy(paddr, &reg->address, sizeof(*paddr));
> =A0 =A0 =A0 =A0if (!*paddr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning(FW_BUG APEI_PFX
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invalid physical=
 address in GAR [0x%llx/%u/%u]\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*paddr, width, s=
pace_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*paddr, bit_widt=
h, space_id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if ((width !=3D 8) && (width !=3D 16) && (width !=3D 32=
) && (width !=3D 64)) {
> + =A0 =A0 =A0 switch (acc_width) {
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acc_width_bits =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acc_width_bits =3D 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acc_width_bits =3D 32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acc_width_bits =3D 64;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Never seen this, acc_width should al=
ways be correct */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((bit_width =3D=3D 8) || (bit_width =
=3D=3D 16) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (bit_width =3D=3D 32) || (bit_w=
idth =3D=3D 64)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning(FW_BUG APEI_=
PFX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"Incorrect acc width, using bit width"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"[%d]\n", bit_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acc_width =3D bit_width=
 / 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acc_width_bits =3D bit_=
width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning(FW_BUG APEI_PFX
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Invalid bit wid=
th in GAR [0x%llx/%u/%u]\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*paddr, width, s=
pace_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Invalid access =
width in GAR [0x%llx/%u/%u]\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*paddr, bit_widt=
h, space_id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> @@ -546,19 +574,28 @@ static int apei_check_gar(struct acpi_generic_a=
ddress *reg, u64 *paddr)
> =A0 =A0 =A0 =A0 =A0 =A0space_id !=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning(FW_BUG APEI_PFX
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Invalid address =
space type in GAR [0x%llx/%u/%u]\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*paddr, width, s=
pace_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*paddr, bit_widt=
h, space_id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* bit width is not much worth in APEI GAR structures *=
/
> + =A0 =A0 =A0 if (acc_width_bits !=3D bit_width) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(FW_INFO APEI_PFX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Correcting bit widt=
h value 0x%x -> 0x%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg->bit_width, acc_=
width_bits);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg->bit_width =3D acc_width_bits;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +EXPORT_SYMBOL_GPL(apei_check_gar);
>
> =A0static int collect_res_callback(struct apei_exec_context *ctx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 acpi_whea_header *entry,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *=
data)
> =A0{
> =A0 =A0 =A0 =A0struct apei_resources *resources =3D data;
> - =A0 =A0 =A0 struct acpi_generic_address *reg =3D &entry->register_r=
egion;
> + =A0 =A0 =A0 struct acpi_generic_address reg;
> + =A0 =A0 =A0 const struct acpi_generic_address *orig =3D &entry->reg=
ister_region;
> =A0 =A0 =A0 =A0u8 ins =3D entry->instruction;
> =A0 =A0 =A0 =A0u64 paddr;
> =A0 =A0 =A0 =A0int rc;
> @@ -566,17 +603,17 @@ static int collect_res_callback(struct apei_exe=
c_context *ctx,
> =A0 =A0 =A0 =A0if (!(ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS=
_REGISTER))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 rc =3D apei_check_gar(reg, &paddr);
> + =A0 =A0 =A0 rc =3D apei_check_gar(&reg, orig, &paddr);
> =A0 =A0 =A0 =A0if (rc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return rc;
>
> - =A0 =A0 =A0 switch (reg->space_id) {
> + =A0 =A0 =A0 switch (reg.space_id) {
> =A0 =A0 =A0 =A0case ACPI_ADR_SPACE_SYSTEM_MEMORY:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return apei_res_add(&resources->iomem,=
 paddr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 reg->bit_width / 8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 reg.bit_width / 8);
> =A0 =A0 =A0 =A0case ACPI_ADR_SPACE_SYSTEM_IO:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return apei_res_add(&resources->ioport=
, paddr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 reg->bit_width / 8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 reg.bit_width / 8);
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/ap=
ei-internal.h
> index f57050e..63d43d8 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -82,6 +82,8 @@ int apei_exec_noop(struct apei_exec_context *ctx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_whea_header *entry);
> =A0int apei_exec_pre_map_gars(struct apei_exec_context *ctx);
> =A0int apei_exec_post_unmap_gars(struct apei_exec_context *ctx);
> +int apei_check_gar(struct acpi_generic_address *reg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct acpi_generic_addres=
s *orig, u64 *paddr);
>
> =A0struct apei_resources {
> =A0 =A0 =A0 =A0struct list_head iomem;
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
