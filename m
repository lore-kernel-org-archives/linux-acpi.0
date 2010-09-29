From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 1/5] ACPI, APEI, Fix APEI related table size checking
Date: Wed, 29 Sep 2010 19:53:51 +0800
Message-ID: <1285761235-4751-2-git-send-email-ying.huang@intel.com>
References: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Huang Ying's machine:

erst_tab->header_length == sizeof(struct acpi_table_einj)

but Yinghai reported that on his machine,

erst_tab->header_length == sizeof(struct acpi_table_einj) -
sizeof(struct acpi_table_header)

To make erst table size checking code works on all systems, both
testing are treated as PASS.

Same situation applies to einj_tab->header_length, so corresponding
table size checking is changed in similar way too.

v2:

- Treat both table size as valid

Originally-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/einj.c |    4 +++-
 drivers/acpi/apei/erst.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -426,7 +426,9 @@ DEFINE_SIMPLE_ATTRIBUTE(error_inject_fop
 
 static int einj_check_table(struct acpi_table_einj *einj_tab)
 {
-	if (einj_tab->header_length != sizeof(struct acpi_table_einj))
+	if ((einj_tab->header_length !=
+	     (sizeof(struct acpi_table_einj) - sizeof(einj_tab->header)))
+	    && (einj_tab->header_length != sizeof(struct acpi_table_einj)))
 		return -EINVAL;
 	if (einj_tab->header.length < sizeof(struct acpi_table_einj))
 		return -EINVAL;
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -750,7 +750,9 @@ __setup("erst_disable", setup_erst_disab
 
 static int erst_check_table(struct acpi_table_erst *erst_tab)
 {
-	if (erst_tab->header_length != sizeof(struct acpi_table_erst))
+	if ((erst_tab->header_length !=
+	     (sizeof(struct acpi_table_erst) - sizeof(erst_tab->header)))
+	    && (erst_tab->header_length != sizeof(struct acpi_table_einj)))
 		return -EINVAL;
 	if (erst_tab->header.length < sizeof(struct acpi_table_erst))
 		return -EINVAL;
