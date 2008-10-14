From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 1/6] ACPI:  introduce the inactive ACPI tables mangement
Date: Tue, 14 Oct 2008 09:25:33 +0800
Message-ID: <1223947533.2735.235.camel@rzhang-dt>
References: <1223885407.2735.184.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D83085803194DEB@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27136 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbYJNB1e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 21:27:34 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085803194DEB@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2008-10-13 at 15:57 -0600, Moore, Robert wrote:
> acpi_initialize_inactive_tables is fairly large. I would suspect that=
 there is a lot of common code with the "normal" initialize tables
yes.
>  - just a different pointer to the root table list, maybe a couple
> more.
=EF=BB=BF
just a different pointer to a different root table
list(=EF=BB=BFacpi_gbl_inactive_root_table_list).
others are quite similar to acpi_tb_parse_root_table.
but it's not easy to reuse the code
as acpi_gbl_root_table_list is hard coded there.

thanks,
rui
>=20
> >-----Original Message-----
> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >owner@vger.kernel.org] On Behalf Of Zhang Rui
> >Sent: Monday, October 13, 2008 1:10 AM
> >To: Len Brown
> >Cc: linux-acpi; Moore, Robert; Zhang, Rui
> >Subject: [PATCH 1/6] ACPI: introduce the inactive ACPI tables mangem=
ent
> >
> >
> >RSDT and XSDT may export different tables.
> >Linux uses either RSDT or XSDT as the root table.
> >There are some inactive tables which exists but is not used,
> >e.g. Linux is using XSDT but the table is exported by RSDT only.
> >
> >Sometimes we still need to dump these inactive tables for debugging.
> >
> >This patch introduces the inactive table management in Linux.
> >
> >Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >---
> > drivers/acpi/tables/tbutils.c |   22 +++----
> > drivers/acpi/tables/tbxface.c |  131
> >++++++++++++++++++++++++++++++++++++++++++
> > include/acpi/acglobal.h       |    3
> > include/acpi/acpixf.h         |    2
> > include/acpi/actables.h       |    3
> > 5 files changed, 151 insertions(+), 10 deletions(-)
> >
> >Index: linux-acpi-2.6/include/acpi/acglobal.h
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-acpi-2.6.orig/include/acpi/acglobal.h
> >+++ linux-acpi-2.6/include/acpi/acglobal.h
> >@@ -139,6 +139,9 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
> >  * acpi_gbl_FADT is a local copy of the FADT, converted to a common
> >format.
> >  */
> > ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
> >+ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_inactive_root_table_=
list;
> >+ACPI_EXTERN acpi_physical_address acpi_inactive_tables_root_pointer=
;
> >+ACPI_EXTERN u32 acpi_inactive_tables_entry_size;
> > ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
> > extern u8 acpi_gbl_permanent_mmap;
> >
> >Index: linux-acpi-2.6/include/acpi/acpixf.h
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-acpi-2.6.orig/include/acpi/acpixf.h
> >+++ linux-acpi-2.6/include/acpi/acpixf.h
> >@@ -54,6 +54,8 @@
> > acpi_status
> > acpi_initialize_tables(struct acpi_table_desc *initial_storage,
> >                       u32 initial_table_count, u8 allow_resize);
> >+acpi_status
> >+acpi_initialize_inactive_tables(void);
> >
> > acpi_status __init acpi_initialize_subsystem(void);
> >
> >Index: linux-acpi-2.6/drivers/acpi/tables/tbutils.c
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-acpi-2.6.orig/drivers/acpi/tables/tbutils.c
> >+++ linux-acpi-2.6/drivers/acpi/tables/tbutils.c
> >@@ -47,10 +47,6 @@
> > #define _COMPONENT          ACPI_TABLES
> > ACPI_MODULE_NAME("tbutils")
> >
> >-/* Local prototypes */
> >-static acpi_physical_address
> >-acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)=
;
> >-
> >
> >/*******************************************************************=
*******
> >*****
> >  *
> >  * FUNCTION:    acpi_tb_check_xsdt
> >@@ -335,7 +331,7 @@ acpi_tb_install_table(acpi_physical_addr
> >  *
> >
> >********************************************************************=
*******
> >***/
> >
> >-static acpi_physical_address
> >+acpi_physical_address
> > acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
> > {
> >        u64 address64;
> >@@ -399,7 +395,7 @@ acpi_tb_parse_root_table(acpi_physical_a
> >        u32 table_count;
> >        struct acpi_table_header *table;
> >        acpi_physical_address address;
> >-       acpi_physical_address uninitialized_var(rsdt_address);
> >+       acpi_physical_address rsdt_address, xsdt_address =3D 0;
> >        u32 length;
> >        u8 *table_entry;
> >        acpi_status status;
> >@@ -426,14 +422,15 @@ acpi_tb_parse_root_table(acpi_physical_a
> >                 * XSDT if the revision is > 1 and the XSDT pointer =
is
> >present, as per
> >                 * the ACPI specification.
> >                 */
> >-               address =3D (acpi_physical_address) rsdp-
> >>xsdt_physical_address;
> >+               xsdt_address =3D (acpi_physical_address) rsdp-
> >>xsdt_physical_address;
> >+               address =3D xsdt_address;
> >                table_entry_size =3D sizeof(u64);
> >-               rsdt_address =3D (acpi_physical_address)
> >-                                       rsdp->rsdt_physical_address;
> >+               rsdt_address =3D (acpi_physical_address) rsdp-
> >>rsdt_physical_address;
> >        } else {
> >                /* Root table is an RSDT (32-bit physical addresses)=
 */
> >
> >-               address =3D (acpi_physical_address) rsdp-
> >>rsdt_physical_address;
> >+               rsdt_address =3D (acpi_physical_address) rsdp-
> >>rsdt_physical_address;
> >+               address =3D rsdt_address;
> >                table_entry_size =3D sizeof(u32);
> >        }
> >
> >@@ -452,6 +449,11 @@ acpi_tb_parse_root_table(acpi_physical_a
> >                                        "using RSDT"));
> >                }
> >        }
> >+       acpi_inactive_tables_root_pointer =3D
> >+               (address =3D=3D rsdt_address ? xsdt_address : rsdt_a=
ddress);
> >+       acpi_inactive_tables_entry_size =3D
> >+               (table_entry_size =3D=3D sizeof(u32) ? sizeof(u64) :
> >sizeof(u32));
> >+
> >        /* Map the RSDT/XSDT table header to get the full table leng=
th */
> >
> >        table =3D acpi_os_map_memory(address, sizeof(struct
> >acpi_table_header));
> >Index: linux-acpi-2.6/include/acpi/actables.h
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-acpi-2.6.orig/include/acpi/actables.h
> >+++ linux-acpi-2.6/include/acpi/actables.h
> >@@ -105,6 +105,9 @@ u8 acpi_tb_checksum(u8 *buffer, u32 leng
> > acpi_status
> > acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length=
);
> >
> >+acpi_physical_address
> >+acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)=
;
> >+
> > void
> > acpi_tb_install_table(acpi_physical_address address,
> >                      u8 flags, char *signature, u32 table_index);
> >Index: linux-acpi-2.6/drivers/acpi/tables/tbxface.c
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-acpi-2.6.orig/drivers/acpi/tables/tbxface.c
> >+++ linux-acpi-2.6/drivers/acpi/tables/tbxface.c
> >@@ -156,6 +156,137 @@ acpi_initialize_tables(struct acpi_table
> >
> >
> >/*******************************************************************=
*******
> >*****
> >  *
> >+ * FUNCTION:    acpi_initialize_inactive_tables
> >+ *
> >+ * RETURN:      Status
> >+ *
> >+ * DESCRIPTION: Initialize the inactive table manager.
> >+ *             Get the unused root table pointer, parse all the ina=
ctive
> >tables
> >+ *             and install them to the global inactive table list.
> >+ *
> >+
> >********************************************************************=
*******
> >***/
> >+acpi_status __init
> >+acpi_initialize_inactive_tables(void)
> >+{
> >+       acpi_status status;
> >+       u32 length;
> >+       u32 table_count;
> >+       u8 *table_entry;
> >+       u32 i;
> >+       struct acpi_table_header *table;
> >+       struct acpi_table_fadt *fadt;
> >+
> >+       if (!acpi_inactive_tables_root_pointer)
> >+               return AE_NOT_EXIST;
> >+       /* Map the RSDT/XSDT table header to get the full table leng=
th */
> >+       table =3D acpi_os_map_memory(acpi_inactive_tables_root_point=
er,
> >+                                  sizeof(struct acpi_table_header))=
;
> >+       if (!table)
> >+               return_ACPI_STATUS(AE_NO_MEMORY);
> >+
> >+       length =3D table->length;
> >+       acpi_os_unmap_memory(table, sizeof(struct acpi_table_header)=
);
> >+
> >+       if (length < sizeof(struct acpi_table_header))
> >+               return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
> >+
> >+       table =3D acpi_os_map_memory(acpi_inactive_tables_root_point=
er,
> >length);
> >+       if (!table)
> >+               return_ACPI_STATUS(AE_NO_MEMORY);
> >+
> >+       status =3D acpi_tb_verify_checksum(table, length);
> >+       if (ACPI_FAILURE(status)) {
> >+               acpi_os_unmap_memory(table, length);
> >+               return_ACPI_STATUS(status);
> >+       }
> >+
> >+       table_count =3D (u32) ((table->length - sizeof(struct
> >acpi_table_header))
> >+                               / acpi_inactive_tables_entry_size);
> >+
> >+       /* talbe_count tables + XSDT/RSDT + FACP + DSDT */
> >+       acpi_gbl_inactive_root_table_list.size =3D table_count + 3;
> >+       acpi_gbl_inactive_root_table_list.tables =3D ACPI_ALLOCATE_Z=
EROED(
> >+                                       sizeof(struct acpi_table_des=
c) *
> >+
> >acpi_gbl_inactive_root_table_list.size);
> >+       if (!acpi_gbl_inactive_root_table_list.tables)
> >+               return_ACPI_STATUS(AE_NO_MEMORY);
> >+
> >+       acpi_gbl_inactive_root_table_list.tables[0].address =3D
> >+                               acpi_inactive_tables_root_pointer;
> >+       acpi_gbl_inactive_root_table_list.count++;
> >+
> >+       table_entry =3D
> >+               ACPI_CAST_PTR(u8, table) + sizeof(struct
> >acpi_table_header);
> >+
> >+       for (i =3D 0; i < table_count; i++) {
> >+               acpi_gbl_inactive_root_table_list.tables
> >+                       [acpi_gbl_inactive_root_table_list.count].ad=
dress =3D
> >+                       acpi_tb_get_root_table_entry(table_entry,
> >+                                       acpi_inactive_tables_entry_s=
ize);
> >+
> >+               table_entry +=3D acpi_inactive_tables_entry_size;
> >+               acpi_gbl_inactive_root_table_list.count++;
> >+       }
> >+       acpi_os_unmap_memory(table, length);
> >+
> >+       for (i =3D 0; i < acpi_gbl_inactive_root_table_list.count; i=
++) {
> >+               if (!acpi_gbl_inactive_root_table_list.tables[i].add=
ress) {
> >+                       ACPI_WARNING((AE_INFO,
> >+                                       "Null table entry"));
> >+                       continue;
> >+               }
> >+               /* install inactive ACPI tables */
> >+               table =3D acpi_os_map_memory(
> >+
> >acpi_gbl_inactive_root_table_list.tables[i].address,
> >+                       sizeof(struct acpi_table_header));
> >+               if (!table)
> >+                       return_ACPI_STATUS(AE_NO_MEMORY);
> >+
> >+               acpi_gbl_inactive_root_table_list.tables[i].length =3D
> >+                                                               tabl=
e-
> >>length;
> >+               acpi_gbl_inactive_root_table_list.tables[i].flags =3D
> >+
> >ACPI_TABLE_ORIGIN_MAPPED;
> >+               ACPI_MOVE_32_TO_32(&
> >+                       (acpi_gbl_inactive_root_table_list.tables[i]=
=2E
> >+                       signature), table->signature);
> >+               acpi_os_unmap_memory(table, sizeof(struct
> >acpi_table_header));
> >+
> >+               /* Special case for FADT - get the DSDT and FACS */
> >+               if (!ACPI_COMPARE_NAME
> >+
> >(&acpi_gbl_inactive_root_table_list.tables[i].signature,
> >+                       ACPI_SIG_FADT))
> >+                       continue;
> >+
> >+               fadt =3D acpi_os_map_memory(
> >+
> >acpi_gbl_inactive_root_table_list.tables[i].address,
> >+
> >acpi_gbl_inactive_root_table_list.tables[i].length);
> >+               if (!fadt)
> >+                       return_ACPI_STATUS(AE_NOT_FOUND);
> >+
> >+               acpi_gbl_inactive_root_table_list.tables
> >+                       [acpi_gbl_inactive_root_table_list.count].ad=
dress =3D
> >+                               (acpi_physical_address)
> >+                               (((fadt->header.length =3D=3D
> >+                               sizeof(struct acpi_table_fadt)) &&
> >+                               fadt->Xdsdt) ? fadt->Xdsdt : fadt->d=
sdt);
> >+               acpi_gbl_inactive_root_table_list.count++;
> >+
> >+               acpi_gbl_inactive_root_table_list.tables
> >+                       [acpi_gbl_inactive_root_table_list.count].ad=
dress =3D
> >+                               (acpi_physical_address)
> >+                               (((fadt->header.length =3D=3D
> >+                               sizeof(struct acpi_table_fadt)) &&
> >+                               fadt->Xfacs) ? fadt->Xfacs : fadt->f=
acs);
> >+               acpi_gbl_inactive_root_table_list.count++;
> >+
> >+               acpi_os_unmap_memory(fadt,
> >+
> >acpi_gbl_inactive_root_table_list.tables[i].length);
> >+       }
> >+
> >+       return_ACPI_STATUS(status);
> >+}
> >+/******************************************************************=
*******
> >******
> >+ *
> >  * FUNCTION:    acpi_reallocate_root_table
> >  *
> >  * PARAMETERS:  None
> >
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
