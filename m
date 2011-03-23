From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/42] PCIe, AER, use pre-generated prefix in error information
 printing
Date: Wed, 23 Mar 2011 02:42:45 -0400
Message-ID: <b64a44146540a4761bb1cf8047fffd9dbf0c3090.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab1CWIHp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:45 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:36 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhang Yanmin <yanmin.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

When printing PCIe AER error information, each line is prefixed with
PCIe device and driver information.  In original implementation, the
prefix is generated when each line is printed.  In fact, all lines
share the same prefix.  So this patch pre-generated the prefix, and
use that one when each line is printed.

In addition to common prefix can be pre-generated, the trailing white
spaces in string constants and NULLs in char * array constants can be
removed too.  These can reduce the object file size further.

The size of object file before and after changing is as follow:

           text    data     bss     dec
before:    3038       0       0    3038
after:     2118       0       0    2118

Signed-off-by: Huang Ying <ying.huang@intel.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Zhang Yanmin <yanmin.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c |  123 ++++++++++++-------------------
 1 files changed, 48 insertions(+), 75 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 9d3e4c8..7a237f6 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -57,86 +57,44 @@
 	(e & AER_DATA_LINK_LAYER_ERROR_MASK(t)) ? AER_DATA_LINK_LAYER_ERROR : \
 	AER_TRANSACTION_LAYER_ERROR)
 
-#define AER_PR(info, pdev, fmt, args...)				\
-	printk("%s%s %s: " fmt, (info->severity == AER_CORRECTABLE) ?	\
-		KERN_WARNING : KERN_ERR, dev_driver_string(&pdev->dev),	\
-		dev_name(&pdev->dev), ## args)
-
 /*
  * AER error strings
  */
-static char *aer_error_severity_string[] = {
+static const char *aer_error_severity_string[] = {
 	"Uncorrected (Non-Fatal)",
 	"Uncorrected (Fatal)",
 	"Corrected"
 };
 
-static char *aer_error_layer[] = {
+static const char *aer_error_layer[] = {
 	"Physical Layer",
 	"Data Link Layer",
 	"Transaction Layer"
 };
-static char *aer_correctable_error_string[] = {
-	"Receiver Error        ",	/* Bit Position 0	*/
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	"Bad TLP               ",	/* Bit Position 6	*/
-	"Bad DLLP              ",	/* Bit Position 7	*/
-	"RELAY_NUM Rollover    ",	/* Bit Position 8	*/
-	NULL,
-	NULL,
-	NULL,
-	"Replay Timer Timeout  ",	/* Bit Position 12	*/
-	"Advisory Non-Fatal    ",	/* Bit Position 13	*/
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
+
+static const char *aer_correctable_error_string[] = {
+	"Receiver Error",		/* Bit Position 0	*/
 	NULL,
 	NULL,
 	NULL,
 	NULL,
 	NULL,
+	"Bad TLP",			/* Bit Position 6	*/
+	"Bad DLLP",			/* Bit Position 7	*/
+	"RELAY_NUM Rollover",		/* Bit Position 8	*/
 	NULL,
 	NULL,
 	NULL,
+	"Replay Timer Timeout",		/* Bit Position 12	*/
+	"Advisory Non-Fatal",		/* Bit Position 13	*/
 };
 
-static char *aer_uncorrectable_error_string[] = {
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	"Data Link Protocol    ",	/* Bit Position 4	*/
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	"Poisoned TLP          ",	/* Bit Position 12	*/
-	"Flow Control Protocol ",	/* Bit Position 13	*/
-	"Completion Timeout    ",	/* Bit Position 14	*/
-	"Completer Abort       ",	/* Bit Position 15	*/
-	"Unexpected Completion ",	/* Bit Position 16	*/
-	"Receiver Overflow     ",	/* Bit Position 17	*/
-	"Malformed TLP         ",	/* Bit Position 18	*/
-	"ECRC                  ",	/* Bit Position 19	*/
-	"Unsupported Request   ",	/* Bit Position 20	*/
+static const char *aer_uncorrectable_error_string[] = {
 	NULL,
 	NULL,
 	NULL,
 	NULL,
+	"Data Link Protocol",		/* Bit Position 4	*/
 	NULL,
 	NULL,
 	NULL,
@@ -144,19 +102,29 @@ static char *aer_uncorrectable_error_string[] = {
 	NULL,
 	NULL,
 	NULL,
+	"Poisoned TLP",			/* Bit Position 12	*/
+	"Flow Control Protocol",	/* Bit Position 13	*/
+	"Completion Timeout",		/* Bit Position 14	*/
+	"Completer Abort",		/* Bit Position 15	*/
+	"Unexpected Completion",	/* Bit Position 16	*/
+	"Receiver Overflow",		/* Bit Position 17	*/
+	"Malformed TLP",		/* Bit Position 18	*/
+	"ECRC",				/* Bit Position 19	*/
+	"Unsupported Request",		/* Bit Position 20	*/
 };
 
-static char *aer_agent_string[] = {
+static const char *aer_agent_string[] = {
 	"Receiver ID",
 	"Requester ID",
 	"Completer ID",
 	"Transmitter ID"
 };
 
-static void __aer_print_error(struct aer_err_info *info, struct pci_dev *dev)
+static void __aer_print_error(const char *prefix,
+			      struct aer_err_info *info)
 {
 	int i, status;
-	char *errmsg = NULL;
+	const char *errmsg = NULL;
 
 	status = (info->status & ~info->mask);
 
@@ -165,15 +133,17 @@ static void __aer_print_error(struct aer_err_info *info, struct pci_dev *dev)
 			continue;
 
 		if (info->severity == AER_CORRECTABLE)
-			errmsg = aer_correctable_error_string[i];
+			errmsg = i < ARRAY_SIZE(aer_correctable_error_string) ?
+				aer_correctable_error_string[i] : NULL;
 		else
-			errmsg = aer_uncorrectable_error_string[i];
+			errmsg = i < ARRAY_SIZE(aer_uncorrectable_error_string) ?
+				aer_uncorrectable_error_string[i] : NULL;
 
 		if (errmsg)
-			AER_PR(info, dev, "   [%2d] %s%s\n", i, errmsg,
+			printk("%s""   [%2d] %-22s%s\n", prefix, i, errmsg,
 				info->first_error == i ? " (First)" : "");
 		else
-			AER_PR(info, dev, "   [%2d] Unknown Error Bit%s\n", i,
+			printk("%s""   [%2d] Unknown Error Bit%s\n", prefix, i,
 				info->first_error == i ? " (First)" : "");
 	}
 }
@@ -181,11 +151,15 @@ static void __aer_print_error(struct aer_err_info *info, struct pci_dev *dev)
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int id = ((dev->bus->number << 8) | dev->devfn);
+	char prefix[44];
+
+	snprintf(prefix, sizeof(prefix), "%s%s %s: ",
+		 (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR,
+		 dev_driver_string(&dev->dev), dev_name(&dev->dev));
 
 	if (info->status == 0) {
-		AER_PR(info, dev,
-			"PCIe Bus Error: severity=%s, type=Unaccessible, "
-			"id=%04x(Unregistered Agent ID)\n",
+		printk("%s""PCIe Bus Error: severity=%s, type=Unaccessible, "
+			"id=%04x(Unregistered Agent ID)\n", prefix,
 			aer_error_severity_string[info->severity], id);
 	} else {
 		int layer, agent;
@@ -193,23 +167,22 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 		agent = AER_GET_AGENT(info->severity, info->status);
 
-		AER_PR(info, dev,
-			"PCIe Bus Error: severity=%s, type=%s, id=%04x(%s)\n",
-			aer_error_severity_string[info->severity],
+		printk("%s""PCIe Bus Error: severity=%s, type=%s, id=%04x(%s)\n",
+			prefix, aer_error_severity_string[info->severity],
 			aer_error_layer[layer], id, aer_agent_string[agent]);
 
-		AER_PR(info, dev,
-			"  device [%04x:%04x] error status/mask=%08x/%08x\n",
-			dev->vendor, dev->device, info->status, info->mask);
+		printk("%s""  device [%04x:%04x] error status/mask=%08x/%08x\n",
+			prefix, dev->vendor, dev->device,
+			info->status, info->mask);
 
-		__aer_print_error(info, dev);
+		__aer_print_error(prefix, info);
 
 		if (info->tlp_header_valid) {
 			unsigned char *tlp = (unsigned char *) &info->tlp;
-			AER_PR(info, dev, "  TLP Header:"
+			printk("%s""  TLP Header:"
 				" %02x%02x%02x%02x %02x%02x%02x%02x"
 				" %02x%02x%02x%02x %02x%02x%02x%02x\n",
-				*(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
+				prefix, *(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
 				*(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
 				*(tlp + 11), *(tlp + 10), *(tlp + 9),
 				*(tlp + 8), *(tlp + 15), *(tlp + 14),
@@ -218,8 +191,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	}
 
 	if (info->id && info->error_dev_num > 1 && info->id == id)
-		AER_PR(info, dev,
-			"  Error of this Agent(%04x) is reported first\n", id);
+		printk("%s""  Error of this Agent(%04x) is reported first\n",
+			prefix, id);
 }
 
 void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
-- 
1.7.4.1.343.ga91df

