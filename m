From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPICA Release 20090730 linuxized patches
Date: Mon, 17 Aug 2009 10:04:34 +0800
Message-ID: <1250474674.28336.27.camel@minggr.sh.intel.com>
References: <1250215084.2987.7.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.0908142332450.30537@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43199 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756470AbZHQCLG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Aug 2009 22:11:06 -0400
In-Reply-To: <alpine.LFD.2.00.0908142332450.30537@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Sat, 2009-08-15 at 11:33 +0800, Len Brown wrote:
> On Fri, 14 Aug 2009, Lin Ming wrote:
>=20
> > Hi, Len
> >=20
> > ACPICA Release 20090730 linuxized patches attached.
> > Build&Test on 32&64 bit machines.
>=20
> please build with CONFIG_DMAR=3Dy

=46ix dmar build error.
Now build OK with "make allyesconfig"


diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 674e27b..6f3dce9 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -252,8 +252,8 @@ enum acpi_dmar_scope_type {
 };
=20
 struct acpi_dmar_pci_path {
-	u8 device;
-	u8 function;
+	u8 dev;
+	u8 fn;
 };
=20
 /*


>=20
>   CC      drivers/pci/dmar.o
> drivers/pci/dmar.c: In function =E2=80=98dmar_parse_one_dev_scope=E2=80=
=99:
> drivers/pci/dmar.c:87: error: =E2=80=98struct acpi_dmar_pci_path=E2=80=
=99 has no member=20
> named =E2=80=98dev=E2=80=99
> drivers/pci/dmar.c:87: error: =E2=80=98struct acpi_dmar_pci_path=E2=80=
=99 has no member=20
> named =E2=80=98fn=E2=80=99
> drivers/pci/dmar.c:91: error: =E2=80=98struct acpi_dmar_pci_path=E2=80=
=99 has no member=20
> named =E2=80=98dev=E2=80=99
> drivers/pci/dmar.c:91: error: =E2=80=98struct acpi_dmar_pci_path=E2=80=
=99 has no member=20
> named =E2=80=98fn=E2=80=99
> drivers/pci/dmar.c:101: error: =E2=80=98struct acpi_dmar_pci_path=E2=80=
=99 has no member=20
> named =E2=80=98dev=E2=80=99
> drivers/pci/dmar.c:101: error: =E2=80=98struct acpi_dmar_pci_path=E2=80=
=99 has no member=20
> named =E2=80=98fn=E2=80=99

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
