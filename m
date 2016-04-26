From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/4] ACPI / osi: Fix an issue that acpi_osi=!* cannot disable ACPICA internal strings
Date: Tue, 26 Apr 2016 15:40:04 +0800
Message-ID: <6ab91537dd8fdd8091acb41d87b0a6472a9c7916.1461656216.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461656216.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The order of the _OSI related functionalities is as follows:
  acpi_blacklisted()
    acpi_dmi_osi_linux()
      acpi_osi_setup()
    acpi_osi_setup()
      acpi_update_interfaces() if "!*"
      <<<<<<<<<<<<<<<<<<<<<<<<
  parse_args()
    __setup("acpi_osi=")
      acpi_osi_setup_linux()
        acpi_update_interfaces() if "!*"
        <<<<<<<<<<<<<<<<<<<<<<<<
  acpi_early_init()
    acpi_initialize_subsystem()
      acpi_ut_initialize_interfaces()
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  acpi_bus_init()
    acpi_os_initialize1()
      acpi_install_interface_handler(acpi_osi_handler)
      acpi_osi_setup_late()
        acpi_update_interfaces() for "!"
        >>>>>>>>>>>>>>>>>>>>>>>>
  acpi_osi_handler()
Since acpi_osi_setup_linux() can override acpi_dmi_osi_linux(), the command
line setting can override the DMI detection. That's why acpi_blacklisted()
is put before __setup("acpi_osi=").

Then we can notice the following wrong invocation order. There are
acpi_update_interfaces() (marked by <<<<) calls invoked before
acpi_ut_initialize_interfaces() (marked by ^^^^). This makes it impossible
to use acpi_osi=!* correctly from OSI DMI table or from the command line.
The use of acpi_osi=!* is meant to disable both ACPICA
(acpi_gbl_supported_interfaces) and Linux specific strings
(osi_setup_entries) while the ACPICA part should have stopped working
because of the order issue.

This patch fixes this issue by moving acpi_update_interfaces() to where
it is invoked for acpi_osi=! (marked by >>>>) as this is ensured to be
invoked after acpi_ut_initialize_interfaces() (marked by ^^^^). Linux
specific strings are still handled in the original place in order to make
the following command line working: acpi_osi=!* acpi_osi="Module Device".

Note that since acpi_osi=!* is meant to further disable linux specific
string comparing to the acpi_osi=!, there is no such use case in our bug
fixing work and hence there is no one using acpi_osi=!* either from the
command line or from the DMI quirks, this issue is just a theoretical
issue.

Cc: <stable@vger.kernel.org> # all applicable
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/osl.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 00d2a22..d7d84a8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -135,7 +135,7 @@ static struct osi_linux {
 	unsigned int	enable:1;
 	unsigned int	dmi:1;
 	unsigned int	cmdline:1;
-	unsigned int	default_disabling:1;
+	u8		default_disabling;
 } osi_linux = {0, 0, 0, 0};
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
@@ -1477,10 +1477,13 @@ void __init acpi_osi_setup(char *str)
 	if (*str == '!') {
 		str++;
 		if (*str == '\0') {
-			osi_linux.default_disabling = 1;
+			/* Do not override acpi_osi=!* */
+			if (!osi_linux.default_disabling)
+				osi_linux.default_disabling =
+					ACPI_DISABLE_ALL_VENDOR_STRINGS;
 			return;
 		} else if (*str == '*') {
-			acpi_update_interfaces(ACPI_DISABLE_ALL_STRINGS);
+			osi_linux.default_disabling = ACPI_DISABLE_ALL_STRINGS;
 			for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
 				osi = &osi_setup_entries[i];
 				osi->enable = false;
@@ -1553,10 +1556,13 @@ static void __init acpi_osi_setup_late(void)
 	acpi_status status;
 
 	if (osi_linux.default_disabling) {
-		status = acpi_update_interfaces(ACPI_DISABLE_ALL_VENDOR_STRINGS);
+		status = acpi_update_interfaces(osi_linux.default_disabling);
 
 		if (ACPI_SUCCESS(status))
-			printk(KERN_INFO PREFIX "Disabled all _OSI OS vendors\n");
+			printk(KERN_INFO PREFIX "Disabled all _OSI OS vendors%s\n",
+				osi_linux.default_disabling ==
+				ACPI_DISABLE_ALL_STRINGS ?
+				" and feature groups" : "");
 	}
 
 	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
-- 
1.7.10
