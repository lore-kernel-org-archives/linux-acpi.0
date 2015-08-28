From: Dennis Chen <dennis.chen@arm.com>
Subject: [PATCH] ACPI / ARM64: Get configuration base address of ECAM via ACPI MCFG table
Date: Fri, 28 Aug 2015 20:49:23 +0800
Message-ID: <1440766163-12101-1-git-send-email-dennis.chen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:44016 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751848AbbH1Mt4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Aug 2015 08:49:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, dennis.chen@arm.com

This patch will fall back to ACPI MCFG table if _CBA method fails
to get the configuration base address of ECAM. Firmware on ARM
platform uses MCFG table instead of _CBA method. This is needed
to scan the PCIe root complex for ARM SoC.

Signed-off-by: Dennis Chen <dennis.chen@arm.com>
---
 drivers/pci/pci-acpi.c | 102 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 314a625..211b9d9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -27,18 +27,110 @@ const u8 pci_acpi_dsm_uuid[] =3D {
 =090x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
 };
=20
+static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg)
+{
+=09if (mcfg->header.revision !=3D 1) {
+=09=09pr_err("invalid header revision:%d in ACPI MCFG table\n",
+=09=09=09mcfg->header.revision);
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
+static phys_addr_t __init acpi_get_mcfg_cba(u16 segment, u8 bus)
+{
+=09struct acpi_table_header *table =3D NULL;
+=09acpi_size tbl_size;
+=09struct acpi_table_mcfg *mcfg =3D NULL;
+=09struct acpi_mcfg_allocation *cfg_table, *cfg;
+=09acpi_status status;
+=09phys_addr_t cba =3D 0;
+=09unsigned long i;
+=09int entries;
+
+=09if (acpi_disabled)
+=09=09return 0;
+
+=09status =3D acpi_get_table_with_size(ACPI_SIG_MCFG, 0, &table, &tbl_size=
);
+=09if (ACPI_FAILURE(status)) {
+=09=09const char *msg =3D acpi_format_exception(status);
+
+=09=09pr_err("Failed to get MCFG table, %s\n", msg);
+=09=09return 0;
+=09}
+
+=09if (table)
+=09=09mcfg =3D (struct acpi_table_mcfg *)table;
+
+=09entries =3D 0;
+=09i =3D table->length - sizeof(struct acpi_table_mcfg);
+=09while (i >=3D sizeof(struct acpi_mcfg_allocation)) {
+=09=09entries++;
+=09=09i -=3D sizeof(struct acpi_mcfg_allocation);
+=09}
+=09if (entries =3D=3D 0) {
+=09=09pr_err("ACPI MCFG table has no entries\n");
+=09=09goto out;
+=09}
+
+=09cfg_table =3D (struct acpi_mcfg_allocation *) &mcfg[1];
+=09for (i =3D 0; i < entries; i++) {
+=09=09cfg =3D &cfg_table[i];
+=09=09if (acpi_mcfg_check_entry(mcfg))
+=09=09=09goto out;
+
+=09=09if (cfg->pci_segment =3D=3D segment &&
+=09=09=09cfg->start_bus_number <=3D bus &&
+=09=09=09bus <=3D cfg->end_bus_number) {
+=09=09=09cba =3D (phys_addr_t)cfg->address;
+=09=09=09goto out;
+=09=09}
+=09}
+out:
+=09/*
+=09 * acpi_get_table_with_size() creates MCFG table mapping that
+=09 * should be released after parsing and before resuming boot
+=09 */
+=09early_acpi_os_unmap_memory(table, tbl_size);
+=09return cba;
+}
+
 phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 {
 =09acpi_status status =3D AE_NOT_EXIST;
-=09unsigned long long mcfg_addr;
+=09unsigned long long mcfg_addr, mcfg_seg, mcfg_bus;
+=09u16 seg;
+=09u8 bus;
+
+=09if (!handle)
+=09=09return 0;
=20
-=09if (handle)
-=09=09status =3D acpi_evaluate_integer(handle, METHOD_NAME__CBA,
+=09status =3D acpi_evaluate_integer(handle, METHOD_NAME__CBA,
 =09=09=09=09=09       NULL, &mcfg_addr);
+=09if (ACPI_SUCCESS(status))
+=09=09return (phys_addr_t)mcfg_addr;
+
+=09pr_info("ACPI: Falling back to acpi mcfg table\n");
+
+=09/*
+=09 * Fall back to MCFG table if _CBA failed:
+=09 * get the mcfg_addr via ACPI MCFG table. PCI Firmware v3.2 spec: 4.1.2
+=09 */
+=09status =3D acpi_evaluate_integer(handle, METHOD_NAME__SEG,
+=09=09=09=09=09=09NULL, &mcfg_seg);
 =09if (ACPI_FAILURE(status))
-=09=09return 0;
+=09=09mcfg_seg =3D 0;
+
+=09status =3D acpi_evaluate_integer(handle, METHOD_NAME__BBN,
+=09=09=09=09=09=09NULL, &mcfg_bus);
+=09if (ACPI_FAILURE(status))
+=09=09mcfg_bus =3D 0;
+
+=09seg =3D mcfg_seg & 0xFFFF;
+=09bus =3D mcfg_bus & 0xFF;
=20
-=09return (phys_addr_t)mcfg_addr;
+=09return acpi_get_mcfg_cba(seg, bus);
 }
=20
 static acpi_status decode_type0_hpx_record(union acpi_object *record,
--=20
1.9.1

