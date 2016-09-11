From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 24/26] ACPI / APD: constify local structures
Date: Sun, 11 Sep 2016 15:06:06 +0200
Message-ID: <1473599168-30561-25-git-send-email-Julia.Lawall@lip6.fr>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

For structure types defined in the same file or local header files, find
top-level static structure declarations that have the following
properties:
1. Never reassigned.
2. Address never taken
3. Not passed to a top-level macro call
4. No pointer or array-typed field passed to a function or stored in a
variable.
Declare structures having all of these properties as const.

Done using Coccinelle.
Based on a suggestion by Joe Perches <joe@perches.com>.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch seems too long for a commit log, but is in the cover
letter.

 drivers/acpi/acpi_apd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 1f30fff..d58fbf7 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -72,7 +72,7 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 }
 
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
-static struct apd_device_desc cz_i2c_desc = {
+static const struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
 };
@@ -84,7 +84,7 @@ static struct property_entry uart_properties[] = {
 	{ },
 };
 
-static struct apd_device_desc cz_uart_desc = {
+static const struct apd_device_desc cz_uart_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 48000000,
 	.properties = uart_properties,
@@ -92,12 +92,12 @@ static struct apd_device_desc cz_uart_desc = {
 #endif
 
 #ifdef CONFIG_ARM64
-static struct apd_device_desc xgene_i2c_desc = {
+static const struct apd_device_desc xgene_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 100000000,
 };
 
-static struct apd_device_desc vulcan_spi_desc = {
+static const struct apd_device_desc vulcan_spi_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
 };

