From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPI: Add facility to disable all _OSI OS vendor strings
Date: Mon, 22 Jul 2013 16:08:25 +0800
Message-ID: <9501e427ee7b753e5fd3fe4da5d929ca7262079e.1374474116.git.lv.zheng@intel.com>
References: <cover.1369380671.git.lv.zheng@intel.com> <cover.1374474116.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32350 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab3GVIIe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jul 2013 04:08:34 -0400
In-Reply-To: <cover.1374474116.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch introduces "acpi_osi=!" command line to force Linux replying
"UNSUPPORTED" to all of the _OSI strings.  This patch is based on an
ACPICA enhancement - the new API acpi_update_interfaces().

The _OSI object provides the platform with the ability to query OSPM to
determine the set of ACPI related interfaces, behaviors, or features that
the operating system supports.  The argument passed to the _OSI is a
string like the followings:
1. Feature Group String, examples include
   Module Device
   Processor Device
   3.0 _SCP Extensions
   Processor Aggregator Device
   ...
2. OS Vendor String, examples include
   Linux
   FreeBSD
   Windows
   ...

There are AML codes provided in the ACPI namespace written in the following
style to determine OSPM interfaces / features:
    Method(OSCK)
    {
        if (CondRefOf(_OSI, Local0))
        {
            if (\_OSI("Windows"))
            {
                Return (One)
            }
            if (\_OSI("Windows 2006"))
            {
                Return (Ones)
            }
            Return (Zero)
        }
        Return (Zero)
    }

There is a debugging facility implemented in the Linux.  Users can pass
"acpi_osi=" boot parameters to the kernel to tune the _OSI evaluation
result so that certain AML codes can be executed.  Current implementation
includes:
1. 'acpi_osi=' - this makes CondRefOf(_OSI, Local0) TRUE
2. 'acpi_osi="Windows"' - this makes \_OSI("Windows") TRUE
3. 'acpi_osi="!Windows"' - this makes \_OSI("Windows") FALSE
The function to implement this feature is also used as a quirk mechanism
in the Linux ACPI subystem.

When _OSI is evaluatated by the AML codes, ACPICA replies "SUPPORTED" to
all Windows operating system vendor strings.  This is because Windows
operating systems return "SUPPORTED" if the argument to the _OSI method
specifies an earlier version of Windows.  Please refer to the following
MSDN document:
How to Identify the Windows Version in ACPI by Using _OSI
http://msdn.microsoft.com/en-us/library/hardware/gg463275.aspx

This adds difficulties when developers want to feed specific Windows
operating system vendor string to the BIOS codes for debugging purpose,
multiple acpi_osi="!xxx" should be specified in the command line to
force Linux replying "UNSUPPORTED" to the Windows OS vendor strings
listed in the AML codes.

This patch has passed a unit test carried out by AcpiExec.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |   29 +++++++++++++++++++++++++++--
 drivers/acpi/osl.c                  |   14 +++++++++++++-
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 7f64e0f..131394f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -235,10 +235,35 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Format: To spoof as Windows 98: ="Microsoft Windows"
 
 	acpi_osi=	[HW,ACPI] Modify list of supported OS interface strings
-			acpi_osi="string1"	# add string1 -- only one string
-			acpi_osi="!string2"	# remove built-in string2
+			acpi_osi="string1"	# add string1
+			acpi_osi="!string2"	# remove string2
+			acpi_osi=!		# disable all built-in OS vendor
+						  strings
 			acpi_osi=		# disable all strings
 
+			'acpi_osi=!' can be used in combination with single or
+			multiple 'acpi_osi="string1"' to support specific OS
+			vendor string(s).  Note that such command can only
+			affect the default state of the OS vendor strings, thus
+			it cannot affect the default state of the feature group
+			strings and the current state of the OS vendor strings,
+			specifying it multiple times through kernel command line
+			is meaningless.
+			Examples:
+			  1. 'acpi_osi=! acpi_osi="Windows 2000"' is equivalent
+			     to 'acpi_osi="Windows 2000" acpi_osi=!', they all
+			     can make '_OSI("Windows 2000")' TRUE.
+
+			'acpi_osi=' cannot be used in combination with other
+			'acpi_osi=' command lines, the _OSI method will not
+			exist in the ACPI namespace.  NOTE that such command can
+			only affect the _OSI support state, thus specifying it
+			multiple times through kernel command line is also
+			meaningless.
+			Examples:
+			  1. 'acpi_osi=' can make 'CondRefOf(_OSI, Local1)'
+			     FALSE.
+
 	acpi_pm_good	[X86]
 			Override the pmtimer bug detection: force the kernel
 			to assume that this machine's pmtimer latches its value
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index da6b663..5dc311d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -140,7 +140,8 @@ static struct osi_linux {
 	unsigned int	enable:1;
 	unsigned int	dmi:1;
 	unsigned int	cmdline:1;
-} osi_linux = {0, 0, 0};
+	unsigned int	default_disabling:1;
+} osi_linux = {0, 0, 0, 0};
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 {
@@ -1386,6 +1387,10 @@ void __init acpi_osi_setup(char *str)
 
 	if (*str == '!') {
 		str++;
+		if (*str == '\0') {
+			osi_linux.default_disabling = 1;
+			return;
+		}
 		enable = false;
 	}
 
@@ -1451,6 +1456,13 @@ static void __init acpi_osi_setup_late(void)
 	int i;
 	acpi_status status;
 
+	if (osi_linux.default_disabling) {
+		status = acpi_update_interfaces(ACPI_DISABLE_ALL_VENDOR_STRINGS);
+
+		if (ACPI_SUCCESS(status))
+			printk(KERN_INFO PREFIX "Disabled all _OSI OS vendors\n");
+	}
+
 	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
 		osi = &osi_setup_entries[i];
 		str = osi->string;
-- 
1.7.10

