From: Len Brown <len.brown@intel.com>
Subject: [PATCH 055/105] ACPI: thinkpad-acpi: improve thinkpad detection
Date: Sun, 29 Apr 2007 00:50:55 -0400
Message-ID: <11778223562656-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756128AbXD2Ewk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:40 -0400
In-Reply-To: <11778223551720-git-send-email-len.brown@intel.com>
Message-Id: <0dcef77c5b889338811d35e786b42046259fe433.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Improve the detection of ThinkPads, so as to reduce the chances of false
positives.

Since this could potentially add false negatives on the very old models,
add a module parameter to force the detection of a thinkpad.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |    7 +++++++
 drivers/misc/thinkpad_acpi.c    |   13 +++++++++++++
 drivers/misc/thinkpad_acpi.h    |    1 +
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 20d5ec3..1a42b77 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -716,3 +716,10 @@ to enable more than one output class, just add their values.
 
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
+
+Force loading of module
+-----------------------
+
+If thinkpad-acpi refuses to detect your ThinkPad, you can try to specify
+the module parameter force_load=1.  Regardless of whether this works or
+not, please contact ibm-acpi-devel@lists.sourceforge.net with a report.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 5611268..cddf81b 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2881,6 +2881,16 @@ static int __init probe_for_thinkpad(void)
 		return -ENODEV;
 	}
 
+	/*
+	 * Risks a regression on very old machines, but reduces potential
+	 * false positives a damn great deal
+	 */
+	if (!is_thinkpad)
+		is_thinkpad = dmi_name_in_vendors("IBM");
+
+	if (!is_thinkpad && !force_load)
+		return -ENODEV;
+
 	return 0;
 }
 
@@ -2986,6 +2996,9 @@ module_param(experimental, int, 0);
 static u32 dbg_level;
 module_param_named(debug, dbg_level, uint, 0);
 
+static int force_load;
+module_param(force_load, int, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 97467b7..2020398 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -128,6 +128,7 @@ static char *next_cmd(char **cmds);
 /* Module */
 static int experimental;
 static u32 dbg_level;
+static int force_load;
 static char *ibm_thinkpad_ec_found;
 
 static char* check_dmi_for_ec(void);
-- 
1.5.2.rc0.34.gda94
