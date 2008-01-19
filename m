From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/5] ACPI: DMI blacklist for OSI(Linux)
Date: Sat, 19 Jan 2008 02:50:28 -0500
Message-ID: <200801190250.28250.lenb@kernel.org>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org> <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38261 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbYASHum (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 02:50:42 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m0J7oXTp018930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Jan 2008 07:50:34 GMT
In-Reply-To: <0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Subject: ACPI: Fill in DMI blacklist for OSI(Linux)
From: Len Brown <len.brown@intel.com>

move the existing list to blacklist.c from osl.c
and fill it in with all known systems that query OSI(Linux).

dmi_unknown_osi_linux() is invoked to disable
the request for DMI info (as, by definition, we already have it)
but to keep the request for acpi_osi= test results
so we can instead invoke it with dmi_enable_osi_linux()
or dmi_disable_osi_linux() as appropriate.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 blacklist.c |  577 ++++++++++++++++++++++++++++++++++++++++
 osl.c       |   57 ---
 2 files changed, 579 insertions(+), 55 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 7c24a8d..85bbc53 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -1,6 +1,8 @@
 /*
  *  blacklist.c
  *
+ *  X86 specific ACPI blacklists.
+ *
  *  Check to see if the given machine has a known bad ACPI BIOS
  *  or if the BIOS is too old.
  *
@@ -165,3 +167,578 @@ int __init acpi_blacklisted(void)
 
 	return blacklisted;
 }
+#ifdef CONFIG_DMI
+extern void dmi_osi_linux(int enable, const struct dmi_system_id *d);
+
+static int dmi_enable_osi_linux(const struct dmi_system_id *d)
+{
+	dmi_osi_linux(1, d);	/* enable */
+	return 0;
+}
+static int dmi_disable_osi_linux(const struct dmi_system_id *d)
+{
+	dmi_osi_linux(0, d);	/* disable */
+	return 0;
+}
+static int dmi_unknown_osi_linux(const struct dmi_system_id *d)
+{
+	dmi_osi_linux(-1, d);	/* unknown */
+	return 0;
+}
+
+struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer Aspire 5050",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer, inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5050"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer Aspire 5100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer Aspire 5580",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer, inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5580"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer Aspire 5610",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer Aspire 7720Z",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720Z"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer TravelMate 5520",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5520"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer TravelMate 6460",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 6460"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer TravelMate 7510",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 7510"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer Extensa 5220",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Extensa 5220"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer  Ferrari 5000",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer, inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Ferrari 5000"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Apple MacBook 1.1",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "MacBook1,1"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Apple MacBook 2.1",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "MacBook2,1"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Apple MacBookPro 1.1",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro1,1"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Apple MacBookPro 2.2",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro2,2"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Apple MacBookPro 3.1",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3,1"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Apple MacPro 2.1",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "MacPro2,1"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "BenQ",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "BenQ"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Joybook S31"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Clevo M570RU",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Clevo Co."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "M570RU"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Compal IFL91",
+	.matches = {
+		     DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
+		     DMI_MATCH(DMI_BOARD_NAME, "IFL91"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Compal HEL8X",
+	.matches = {
+		     DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
+		     DMI_MATCH(DMI_BOARD_NAME, "HEL8X"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Compal HEL8X",
+	.matches = {
+		     DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
+		     DMI_MATCH(DMI_BOARD_NAME, "HEL8X"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell Dimension 5150",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Dell DM051"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1501"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D830"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex GX620"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1900"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 390"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Dell Vostro 1000",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Vostro   1000"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge SC440"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dialogue Flybook V5",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dialogue Technology Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Flybook V5"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Fujitsu Siemens Amilo Si 1520",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Amilo M1425"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Fujitsu Siemens Amilo Si 1520",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Amilo Si 1520"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Fujitsu Siemens AMILO Pa 2510",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pa 2510"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Fujitsu Siemens AMILO Pi 1536",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1536"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Fujitsu Siemens AMILO Pi 1556",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1556"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Fujitsu Siemens AMILO Xi 1546",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Xi 1546"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Fujitsu Siemens Esprimo Mobile V5505",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "HP Pavilion tx1000",
+	.matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "Quanta"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30BF"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "HP Pavilion dv2000",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30B5"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "HP Pavilion dv5000",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30A7"),
+		},
+	},
+	{ /* OSI(Linux) breaks hibernate */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "HP Pavilion dv6000 30B7",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30B7"),
+		},
+	},
+	{ /* OSI(Linux) breaks hibernate */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "HP Pavilion dv6000",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30B8"),
+		},
+	},
+	{ /* OSI(Linux) breaks hibernate */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "HP Pavilion dv6300 30BC",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30BC"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "HP Pavilion dv6500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30D0"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "HP Pavilion dv9000",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30B9"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "HP Pavilion dv9500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30CB"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "HP/Compaq Presario C500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30C6"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_disable_osi_linux,
+	.ident = "HP/Compaq Presario F500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_BOARD_NAME, "30D3"),
+		},
+	},
+	{ /* OSI(Linux) assumed enabled by CRB BIOS developers */
+	 .callback = dmi_enable_osi_linux,
+	 .ident = "Intel Napa CRB",
+	 .matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
+		     },
+	 },
+	{ /* OSI(Linux) helps sound */
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad R61",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
+		},
+	},
+	{ /* OSI(Linux) helps sound */
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad T61",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Lenovo 3000 V100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "LENOVO3000 V100"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Lenovo 3000 N100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "LG P1 PRO Express Dual 150B",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "P1-J150B"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "NEC VERSA M360",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "NEC Computers SAS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "NEC VERSA M360"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Samsung R40P/R41P",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "R40P/R41P"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Samsung R59P/R60P/R61P",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "R59P/R60P/R61P"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Sony Vaio VGN-FZ11M",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ11M"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Sony Vaio VGN-SZ650N",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ650N"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Sony Vaio VGN-SZ38GP_C",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ38GP_C"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Sony Vaio TZ21MN",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-TZ21MN_N"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Toshiba Satellite A100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A100"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Toshiba Satellite A135",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A135"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Toshiba Satellite A200",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A200"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Toshiba Satellite A210",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A210"),
+		},
+	},
+	{ /* OSI(Linux) breaks sound (bugzilla 7787) */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Toshiba Satellite P100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P100"),
+		},
+	},
+	{ /* OSI(Linux) breaks sound */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Toshiba Satellite P105",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P105"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Toshiba Satellite P205",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P205"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Toshiba Satellite U305",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Toshiba"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U305"),
+		},
+	},
+	{}
+};
+#endif /* CONFIG_DMI */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index ee1a630..78bdddc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -110,7 +110,7 @@ struct osi_linux {
 } osi_linux = { OSI_LINUX_ENABLE, 0, 0, 0};
 
 #ifdef CONFIG_DMI
-static struct __initdata dmi_system_id acpi_osl_dmi_table[];
+extern struct __initdata dmi_system_id acpi_osl_dmi_table[];
 #endif
 
 static void __init acpi_request_region (struct acpi_generic_address *addr,
@@ -973,7 +973,7 @@ static void cmdline_osi_linux(unsigned int enable)
 	return;
 }
 
-static void dmi_osi_linux(int enable, const struct dmi_system_id *d)
+void dmi_osi_linux(int enable, const struct dmi_system_id *d)
 {
 	osi_linux.dmi = 1;	/* DMI knows that this box asks OSI(Linux) */
 
@@ -1246,57 +1246,4 @@ acpi_os_validate_address (
     return AE_OK;
 }
 
-#ifdef CONFIG_DMI
-
-static int dmi_enable_osi_linux(const struct dmi_system_id *d)
-{
-	dmi_osi_linux(1, d);	/* enable */
-	return 0;
-}
-#ifdef	ACPI_FUTURE_USAGE
-static int dmi_disable_osi_linux(const struct dmi_system_id *d)
-{
-	dmi_osi_linux(0, d);	/* disable */
-	return 0;
-}
-static int dmi_unknown_osi_linux(const struct dmi_system_id *d)
-{
-	dmi_osi_linux(-1, d);	/* unknown */
-	return 0;
-}
-#endif
-
-static struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
-	/*
-	 * Boxes that need _OSI(Linux)
-	 */
-	{
-	 .callback = dmi_enable_osi_linux,
-	 .ident = "Intel Napa CRB",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
-		     },
-	 },
-	{
-	.callback = dmi_enable_osi_linux,
-	.ident = "Lenovo ThinkPad T61",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
-		},
-	},
-
-
-	/*
-	 * Boxes that need _OSI(Linux) NOT set
-	 */
-
-	/*
-	 * Boxes that request _OSI(Linux), but proper default is unknown
-	 */
-	{}
-};
-#endif /* CONFIG_DMI */
-
 #endif
