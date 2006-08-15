From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Allow acpi_osi="Winows XY" overrides
Date: Tue, 15 Aug 2006 11:04:12 +0200
Message-ID: <1155632652.4302.1118.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wwJv7BI8UDi4ZGWDpTJu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932304AbWHOI7d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 04:59:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>


--=-wwJv7BI8UDi4ZGWDpTJu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is an ASL example from a HP nx9420.
The first part tries to evaluate the OS with the old
\_OS method (you can already fake the OS with acpi_os_name="Microsoft
Windows"). The second part makes use of the new _OSI function.
Overriding the _OSI provided string by OS was not yet implemented, that
is what the patch does.

For this BIOS it already was possible to fake the OS string for
"Microsoft Windows", "Microsoft WindowsME: Millennium Edition",
"Microsoft Windows NT" by e.g.: 
acpi_osi="" acpi_os_name="Microsoft Windows"

now you also can (currently it would use "Windows 2001 SP2") also fake
e.g.:
acpi_osi="Windows 2006"      (acpi_os_name="" -> not explicitly needed 
                              here, maybe on other AML implementations)


------------------------------------------------------------
    Name (C015, Package (0x03)
    {
        "Microsoft Windows",
        "Microsoft WindowsME: Millennium Edition",
        "Microsoft Windows NT"
    })
...

            Store (\_OS, Local0)
            Store (SizeOf (C015), Local7)
            Store (0x00, Local1)
            While (LAnd (LLess (Local1, Local7), LEqual (C014, 0xFFFFFFFD)))
            {
                Store (\C011 (Local0, DerefOf (Index (C015, Local1))), Local2)
                If (Local2)
                {
                    Add (Local1, 0x01, C014)
                }
                Else
                {
                    Increment (Local1)
                }
            }

            If (LEqual (C014, 0xFFFFFFFD))
            {
                Store (0x00, C014)
            }

            If (LOr (LEqual (C014, 0x00), LEqual (C014, 0x03)))
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x04, C014)
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        Store (0x04, C014)
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x05, C014)
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x06, C014)
                    }
                }
            }
------------------------------------------------------------

The patch is based on a SUSE 2.6.16.21 kernel. There shouldn't have
changed that much. It needs manual modifications as it touches ACPICA
code anyway.



Allow acpi_osi="Winows XY" overrides

Nearly all BIOSes have special code paths for special Windows
OS verions. This patch tells ACPI BIOS parts which OS it should
assume and might workaround BIOS issues.

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/osl.c              |   19 +++++++++++++------
 drivers/acpi/utilities/uteval.c |   22 +++++++++++++++-------
 include/acpi/acglobal.h         |    3 +++
 3 files changed, 31 insertions(+), 13 deletions(-)

Index: linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/osl.c
===================================================================
--- linux-2.6.16-SLES10_GA_BRANCH.orig/drivers/acpi/osl.c
+++ linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/osl.c
@@ -228,8 +228,6 @@ acpi_os_get_physical_address(void *virt,
 }
 #endif
 
-#define ACPI_MAX_OVERRIDE_LEN 100
-
 static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
 
 acpi_status
@@ -1067,17 +1065,26 @@ __setup("acpi_os_name=", acpi_os_name_se
 /*
  * _OSI control
  * empty string disables _OSI
- * TBD additional string adds to _OSI
  */
+char acpi_osi_override[ACPI_MAX_OVERRIDE_LEN] = "\0";
+
 static int __init acpi_osi_setup(char *str)
 {
+	int len;
+
 	if (str == NULL || *str == '\0') {
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
 	} else {
-		/* TBD */
-		printk(KERN_ERR PREFIX "_OSI additional string ignored -- %s\n",
-		       str);
+		len = strlen(str);
+		if(len > ACPI_MAX_OVERRIDE_LEN)
+			printk(KERN_ERR PREFIX "acpi_osi_name too long"
+			       "(%d, max: %d)\n", len, ACPI_MAX_OVERRIDE_LEN);
+		else{
+			strcpy(acpi_osi_override, str);
+			printk(KERN_INFO PREFIX "_OSI string set to: %s\n",
+			       acpi_osi_override);
+		}
 	}
 
 	return 1;
Index: linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/utilities/uteval.c
===================================================================
--- linux-2.6.16-SLES10_GA_BRANCH.orig/drivers/acpi/utilities/uteval.c
+++ linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/utilities/uteval.c
@@ -93,17 +93,25 @@ acpi_status acpi_ut_osi_implementation(s
 
 	/* Compare input string to table of supported strings */
 
-	for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
-		if (!ACPI_STRCMP(string_desc->string.pointer,
-				 ACPI_CAST_PTR(char,
+	if (acpi_osi_override[0] == '\0'){
+		for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
+			if (!ACPI_STRCMP(string_desc->string.pointer,
+					 ACPI_CAST_PTR(char,
 					       acpi_gbl_valid_osi_strings[i])))
-		{
-			/* This string is supported */
+			{
+				/* This string is supported */
 
-			return_desc->integer.value = 0xFFFFFFFF;
-			break;
+				return_desc->integer.value = 0xFFFFFFFF;
+				break;
+			}
 		}
 	}
+	else{
+		if (!ACPI_STRCMP(string_desc->string.pointer,
+				 acpi_osi_override))
+			/* This string is supported */
+			return_desc->integer.value = 0xFFFFFFFF;
+	}
 
 	walk_state->return_desc = return_desc;
 	return_ACPI_STATUS(AE_CTRL_TERMINATE);
Index: linux-2.6.16-SLES10_GA_BRANCH/include/acpi/acglobal.h
===================================================================
--- linux-2.6.16-SLES10_GA_BRANCH.orig/include/acpi/acglobal.h
+++ linux-2.6.16-SLES10_GA_BRANCH/include/acpi/acglobal.h
@@ -246,6 +246,9 @@ extern const struct acpi_opcode_info acp
 extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
 extern const char *acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS];
 
+#define ACPI_MAX_OVERRIDE_LEN 100
+extern char acpi_osi_override[ACPI_MAX_OVERRIDE_LEN];
+
 /*****************************************************************************
  *
  * Namespace globals


--=-wwJv7BI8UDi4ZGWDpTJu
Content-Disposition: attachment; filename=acpi_osi_override.patch
Content-Type: text/x-patch; name=acpi_osi_override.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Allow acpi_osi="Winows XY" overrides

Nearly all BIOSes have special code paths for special Windows
OS verions. This patch tells ACPI BIOS parts which OS it should
assume and might workaround BIOS issues.

Signed-off-by: Thomas Renninger <mail@renninger.de>


 drivers/acpi/osl.c              |   19 +++++++++++++------
 drivers/acpi/utilities/uteval.c |   22 +++++++++++++++-------
 include/acpi/acglobal.h         |    3 +++
 3 files changed, 31 insertions(+), 13 deletions(-)

Index: linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/osl.c
===================================================================
--- linux-2.6.16-SLES10_GA_BRANCH.orig/drivers/acpi/osl.c
+++ linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/osl.c
@@ -228,8 +228,6 @@ acpi_os_get_physical_address(void *virt,
 }
 #endif
 
-#define ACPI_MAX_OVERRIDE_LEN 100
-
 static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
 
 acpi_status
@@ -1067,17 +1065,26 @@ __setup("acpi_os_name=", acpi_os_name_se
 /*
  * _OSI control
  * empty string disables _OSI
- * TBD additional string adds to _OSI
  */
+char acpi_osi_override[ACPI_MAX_OVERRIDE_LEN] = "\0";
+
 static int __init acpi_osi_setup(char *str)
 {
+	int len;
+
 	if (str == NULL || *str == '\0') {
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
 	} else {
-		/* TBD */
-		printk(KERN_ERR PREFIX "_OSI additional string ignored -- %s\n",
-		       str);
+		len = strlen(str);
+		if(len > ACPI_MAX_OVERRIDE_LEN)
+			printk(KERN_ERR PREFIX "acpi_osi_name too long"
+			       "(%d, max: %d)\n", len, ACPI_MAX_OVERRIDE_LEN);
+		else{
+			strcpy(acpi_osi_override, str);
+			printk(KERN_INFO PREFIX "_OSI string set to: %s\n",
+			       acpi_osi_override);
+		}
 	}
 
 	return 1;
Index: linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/utilities/uteval.c
===================================================================
--- linux-2.6.16-SLES10_GA_BRANCH.orig/drivers/acpi/utilities/uteval.c
+++ linux-2.6.16-SLES10_GA_BRANCH/drivers/acpi/utilities/uteval.c
@@ -93,17 +93,25 @@ acpi_status acpi_ut_osi_implementation(s
 
 	/* Compare input string to table of supported strings */
 
-	for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
-		if (!ACPI_STRCMP(string_desc->string.pointer,
-				 ACPI_CAST_PTR(char,
+	if (acpi_osi_override[0] == '\0'){
+		for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
+			if (!ACPI_STRCMP(string_desc->string.pointer,
+					 ACPI_CAST_PTR(char,
 					       acpi_gbl_valid_osi_strings[i])))
-		{
-			/* This string is supported */
+			{
+				/* This string is supported */
 
-			return_desc->integer.value = 0xFFFFFFFF;
-			break;
+				return_desc->integer.value = 0xFFFFFFFF;
+				break;
+			}
 		}
 	}
+	else{
+		if (!ACPI_STRCMP(string_desc->string.pointer,
+				 acpi_osi_override))
+			/* This string is supported */
+			return_desc->integer.value = 0xFFFFFFFF;
+	}
 
 	walk_state->return_desc = return_desc;
 	return_ACPI_STATUS(AE_CTRL_TERMINATE);
Index: linux-2.6.16-SLES10_GA_BRANCH/include/acpi/acglobal.h
===================================================================
--- linux-2.6.16-SLES10_GA_BRANCH.orig/include/acpi/acglobal.h
+++ linux-2.6.16-SLES10_GA_BRANCH/include/acpi/acglobal.h
@@ -246,6 +246,9 @@ extern const struct acpi_opcode_info acp
 extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
 extern const char *acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS];
 
+#define ACPI_MAX_OVERRIDE_LEN 100
+extern char acpi_osi_override[ACPI_MAX_OVERRIDE_LEN];
+
 /*****************************************************************************
  *
  * Namespace globals

--=-wwJv7BI8UDi4ZGWDpTJu--

