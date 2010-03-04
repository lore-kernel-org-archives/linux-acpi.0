From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 2/4] ipmi: Remove SPMI table based device discovery method
Date: Wed, 03 Mar 2010 20:44:15 -0700
Message-ID: <20100304034415.30205.59685.stgit@bob.kio>
References: <20100304033146.30205.68689.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:26525 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0CDDoQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 22:44:16 -0500
In-Reply-To: <20100304033146.30205.68689.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

Remove optional ACPI static Service Processor Management Interface
(SPMI) table based IPMI device discovery mechanism.

The SPMI table is available for use as an early boot process device
description mechanism (i.e. prior to the availability of the OS to
utilize ACPI, namespace based [IPI001], control methods) however,
=E2=80=98Plug-and-Play=E2=80=99 enumeration mechanisms such as PCI and =
ACPI should
be used when possible [1].

Windows relies solely on ACPI/IPI0001 or PCI device based enumeration
for IPMI.  HP added the SPMI table for HP-UX to use before ACPI
namespace is available but Linux doesn't need such as its driver's
discovery processing takes place after both ACPI and PCI subsystems
have been set up.

[1] From Appendix C1 of the afore mentioned IPMI specification -
    "... this structure (referring to SPMI) should be used only
    when the interface cannot be discovered via 'Plug-and-Play'
    discovery mechanisms incorporated in interfaces such as PCI
    and ACPI."

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/char/ipmi/ipmi_bt_sm.c   |    2=20
 drivers/char/ipmi/ipmi_si_intf.c |  165 ------------------------------=
--------
 2 files changed, 2 insertions(+), 165 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt=
_sm.c
index 7b98c06..d0e868e 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -204,7 +204,7 @@ static unsigned int bt_init_data(struct si_sm_data =
*bt, struct si_sm_io *io)
 	bt->BT_CAP_req2rsp =3D BT_NORMAL_TIMEOUT * 1000000;
 	bt->BT_CAP_retries =3D BT_NORMAL_RETRY_LIMIT;
 	/* BT_CAP_outreqs =3D=3D zero is a flag to read BT Capabilities */
-	return 3; /* We claim 3 bytes of space; ought to check SPMI table */
+	return 3; /* We claim 3 bytes of space */
 }
=20
 /* Jam a completion code (probably an error) into a response */
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_=
si_intf.c
index 86a7dd7..806ae83 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1118,7 +1118,7 @@ static struct ipmi_smi_handlers handlers =3D {
=20
 /*
  * There can be 4 IO ports passed in (with or without IRQs), 4 address=
es,
- * a default IO port, and 1 ACPI/SPMI address.  That sets SI_MAX_DRIVE=
RS.
+ * a default IO port, and 1 ACPI address.  That sets SI_MAX_DRIVERS.
  */
=20
 static LIST_HEAD(smi_infos);
@@ -1808,13 +1808,6 @@ static __devinit void hardcode_find_bmc(void)
=20
 #include <linux/acpi.h>
=20
-/*
- * Once we get an ACPI failure, we don't try any more, because we go
- * through the tables sequentially.  Once we don't find a table, there
- * are no more.
- */
-static int acpi_failure;
-
 /* For GPE-type interrupts. */
 static u32 ipmi_acpi_gpe(void *context)
 {
@@ -1873,158 +1866,6 @@ static int acpi_gpe_irq_setup(struct smi_info *=
info)
 	}
 }
=20
-/*
- * Defined at
- * http://h21007.www2.hp.com/dspp/files/unprotected/devresource/
- * Docs/TechPapers/IA64/hpspmi.pdf
- */
-struct SPMITable {
-	s8	Signature[4];
-	u32	Length;
-	u8	Revision;
-	u8	Checksum;
-	s8	OEMID[6];
-	s8	OEMTableID[8];
-	s8	OEMRevision[4];
-	s8	CreatorID[4];
-	s8	CreatorRevision[4];
-	u8	InterfaceType;
-	u8	IPMIlegacy;
-	s16	SpecificationRevision;
-
-	/*
-	 * Bit 0 - SCI interrupt supported
-	 * Bit 1 - I/O APIC/SAPIC
-	 */
-	u8	InterruptType;
-
-	/*
-	 * If bit 0 of InterruptType is set, then this is the SCI
-	 * interrupt in the GPEx_STS register.
-	 */
-	u8	GPE;
-
-	s16	Reserved;
-
-	/*
-	 * If bit 1 of InterruptType is set, then this is the I/O
-	 * APIC/SAPIC interrupt.
-	 */
-	u32	GlobalSystemInterrupt;
-
-	/* The actual register address. */
-	struct acpi_generic_address addr;
-
-	u8	UID[4];
-
-	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
-};
-
-static __devinit int try_init_spmi(struct SPMITable *spmi)
-{
-	struct smi_info  *info;
-	u8 		 addr_space;
-
-	if (spmi->IPMIlegacy !=3D 1) {
-	    printk(KERN_INFO "IPMI: Bad SPMI legacy %d\n", spmi->IPMIlegacy);
-	    return -ENODEV;
-	}
-
-	if (spmi->addr.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		addr_space =3D IPMI_MEM_ADDR_SPACE;
-	else
-		addr_space =3D IPMI_IO_ADDR_SPACE;
-
-	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
-		return -ENOMEM;
-	}
-
-	info->addr_source =3D "SPMI";
-
-	/* Figure out the interface type. */
-	switch (spmi->InterfaceType) {
-	case 1:	/* KCS */
-		info->si_type =3D SI_KCS;
-		break;
-	case 2:	/* SMIC */
-		info->si_type =3D SI_SMIC;
-		break;
-	case 3:	/* BT */
-		info->si_type =3D SI_BT;
-		break;
-	default:
-		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
-			spmi->InterfaceType);
-		kfree(info);
-		return -EIO;
-	}
-
-	if (spmi->InterruptType & 1) {
-		/* We've got a GPE interrupt. */
-		info->irq =3D spmi->GPE;
-		info->irq_setup =3D acpi_gpe_irq_setup;
-	} else if (spmi->InterruptType & 2) {
-		/* We've got an APIC/SAPIC interrupt. */
-		info->irq =3D spmi->GlobalSystemInterrupt;
-		info->irq_setup =3D std_irq_setup;
-	} else {
-		/* Use the default interrupt setting. */
-		info->irq =3D 0;
-		info->irq_setup =3D NULL;
-	}
-
-	if (spmi->addr.bit_width) {
-		/* A (hopefully) properly formed register bit width. */
-		info->io.regspacing =3D spmi->addr.bit_width / 8;
-	} else {
-		info->io.regspacing =3D DEFAULT_REGSPACING;
-	}
-	info->io.regsize =3D info->io.regspacing;
-	info->io.regshift =3D spmi->addr.bit_offset;
-
-	if (spmi->addr.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		info->io_setup =3D mem_setup;
-		info->io.addr_type =3D IPMI_MEM_ADDR_SPACE;
-	} else if (spmi->addr.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
-		info->io_setup =3D port_setup;
-		info->io.addr_type =3D IPMI_IO_ADDR_SPACE;
-	} else {
-		kfree(info);
-		printk(KERN_WARNING
-		       "ipmi_si: Unknown ACPI I/O Address type\n");
-		return -EIO;
-	}
-	info->io.addr_data =3D spmi->addr.address;
-
-	try_smi_init(info);
-
-	return 0;
-}
-
-static __devinit void spmi_find_bmc(void)
-{
-	acpi_status      status;
-	struct SPMITable *spmi;
-	int              i;
-
-	if (acpi_disabled)
-		return;
-
-	if (acpi_failure)
-		return;
-
-	for (i =3D 0; ; i++) {
-		status =3D acpi_get_table(ACPI_SIG_SPMI, i+1,
-					(struct acpi_table_header **)&spmi);
-		if (status !=3D AE_OK)
-			return;
-
-		try_init_spmi(spmi);
-	}
-}
-
 static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 				    const struct pnp_device_id *dev_id)
 {
@@ -3217,10 +3058,6 @@ static __devinit int init_ipmi_si(void)
 	dmi_find_bmc();
 #endif
=20
-#ifdef CONFIG_ACPI
-	spmi_find_bmc();
-#endif
-
 	if (si_trydefaults) {
 		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
