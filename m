From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: [PATCH] ACPI / APEI: Fix parsing HEST that includes Deferred Machine
 Check subtable
Date: Mon, 12 Nov 2018 19:00:55 +0000
Message-ID: <20181112190029.41760-1-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "keescook@chromium.org" <keescook@chromium.org>, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
List-Id: linux-acpi@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

ACPI 6.2 includes a new definition for a Deferred Machine Check "DMC"
subtable.

The definition of this subtable was included in following commit:

c042933df2b1 ("ACPICA: Add support for new HEST subtable")

However, the HEST parsing function was not updated to include this new
subtable. Therefore, Linux will fail to parse the HEST on systems that
include a DMC entry.

Add the length check for the new DMC subtable so that HEST parsing
doesn't fail on systems that include it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/acpi/apei/hest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index b1e9f81ebeea..0935a0ef37e5 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -53,6 +53,7 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVE=
D] =3D {
 	[ACPI_HEST_TYPE_AER_BRIDGE] =3D sizeof(struct acpi_hest_aer_bridge),
 	[ACPI_HEST_TYPE_GENERIC_ERROR] =3D sizeof(struct acpi_hest_generic),
 	[ACPI_HEST_TYPE_GENERIC_ERROR_V2] =3D sizeof(struct acpi_hest_generic_v2)=
,
+	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] =3D -1,
 };
=20
 static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
@@ -75,6 +76,11 @@ static int hest_esrc_len(struct acpi_hest_header *hest_h=
dr)
 		mc =3D (struct acpi_hest_ia_machine_check *)hest_hdr;
 		len =3D sizeof(*mc) + mc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+	} else if (hest_type =3D=3D ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
+		struct acpi_hest_ia_deferred_check *mc;
+		mc =3D (struct acpi_hest_ia_deferred_check *)hest_hdr;
+		len =3D sizeof(*mc) + mc->num_hardware_banks *
+			sizeof(struct acpi_hest_ia_error_bank);
 	}
 	BUG_ON(len =3D=3D -1);
=20
--=20
2.17.1
