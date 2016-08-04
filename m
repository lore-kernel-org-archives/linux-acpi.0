From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/30] ACPICA: iASL/Disassembler: Add a check for missing filename
Date: Thu,  4 Aug 2016 16:43:26 +0800
Message-ID: <f0ac0e067216254c44043da805addb2c3242a924.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:60715 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932814AbcHDInd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:43:33 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit fc0f12b1eff6253f83e599a7ee1765fcc8e42dcc

Add check for required filename for the -d and -da options.
ACPICA BZ 1285.

Link: https://github.com/acpica/acpica/commit/fc0f12b1
Link: https://bugs.acpica.org/show_bug.cgi?id=1285
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/common/getopt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 0bd343f..e9e8091 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -94,7 +94,7 @@ int acpi_getopt_argument(int argc, char **argv)
 		acpi_gbl_optarg =
 		    &argv[acpi_gbl_optind++][(int)(current_char_ptr + 1)];
 	} else if (++acpi_gbl_optind >= argc) {
-		ACPI_OPTION_ERROR("Option requires an argument: -", 'v');
+		ACPI_OPTION_ERROR("\nOption requires an argument", 0);
 
 		current_char_ptr = 1;
 		return (-1);
-- 
1.7.10

