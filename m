From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] ACPICA: Check whether ACPI is disabled before getting a table
Date: Mon, 21 Aug 2017 15:20:54 +0200
Message-ID: <20170821132054.mwhdxkcka4ocp6h5@pd.tnic>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
 <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
 <CAJZ5v0i_-Sb_o24EcmHN37cQ3fqVf53a+Yc_weX_1Mv7VAOw3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i_-Sb_o24EcmHN37cQ3fqVf53a+Yc_weX_1Mv7VAOw3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Toshi Kani <toshi.kani@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Borislav Petkov <bp@suse.de>

... and save us the splrinking of this test around in the callers.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/acpica/tbxface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 010b1c43df92..881b0d5b2838 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -226,6 +226,9 @@ acpi_get_table_header(char *signature,
 	u32 j;
 	struct acpi_table_header *header;
 
+	if (acpi_disabled)
+		return (AE_ERROR);
+
 	/* Parameter validation */
 
 	if (!signature || !out_table_header) {
-- 
2.13.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
