From: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH 7/8] ideapad: rewrite the sw rfkill set
Date: Wed, 18 Aug 2010 16:38:42 +0800
Message-ID: <1282120722-11598-1-git-send-email-ike.pan@canonical.com>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1282120564-11324-1-git-send-email-ike.pan@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Control power of rf modules by ec commands

Signed-off-by: Ike Panhc <ike.pan@canonical.com>
---
 drivers/platform/x86/ideapad_acpi.c |   37 +++++++++++-----------------------
 1 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/ideapad_acpi.c b/drivers/platform/x86/ideapad_acpi.c
index 9d0e23f..7c414e5 100644
--- a/drivers/platform/x86/ideapad_acpi.c
+++ b/drivers/platform/x86/ideapad_acpi.c
@@ -37,18 +37,19 @@
 struct ideapad_private {
 	acpi_handle handle;
 	struct rfkill *rfk[5];
-};
+} *ideapad_priv;
 
 static struct {
 	char *name;
 	int cfgbit;
+	int opcode;
 	int type;
 } ideapad_rfk_data[] = {
-	{ "ideapad_camera",	19, NUM_RFKILL_TYPES },
-	{ "ideapad_wlan",	18, RFKILL_TYPE_WLAN },
-	{ "ideapad_bluetooth",	16, RFKILL_TYPE_BLUETOOTH },
-	{ "ideapad_3g",		17, RFKILL_TYPE_WWAN },
-	{ "ideapad_killsw",	0, RFKILL_TYPE_WLAN }
+	{ "ideapad_camera",	19, 0x1E, NUM_RFKILL_TYPES },
+	{ "ideapad_wlan",	18, 0x15, RFKILL_TYPE_WLAN },
+	{ "ideapad_bluetooth",	16, 0x17, RFKILL_TYPE_BLUETOOTH },
+	{ "ideapad_3g",		17, 0x20, RFKILL_TYPE_WWAN },
+	{ "ideapad_killsw",	0,  0,    RFKILL_TYPE_WLAN }
 };
 
 /*
@@ -162,24 +163,6 @@ static int write_ec_cmd(acpi_handle handle, int cmd, unsigned long data)
 }
 /* the above is ACPI helpers */
 
-static int ideapad_dev_set_state(int device, int state)
-{
-	acpi_status status;
-	union acpi_object in_params[2];
-	struct acpi_object_list input = { 2, in_params };
-
-	in_params[0].type = ACPI_TYPE_INTEGER;
-	in_params[0].integer.value = device + 1;
-	in_params[1].type = ACPI_TYPE_INTEGER;
-	in_params[1].integer.value = state;
-
-	status = acpi_evaluate_object(NULL, "\\_SB_.SECN", &input, NULL);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_WARNING "IdeaPAD \\_SB_.SECN method failed %d\n", status);
-		return -ENODEV;
-	}
-	return 0;
-}
 static ssize_t show_ideapad_cam(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -219,7 +202,10 @@ static int ideapad_rfk_set(void *data, bool blocked)
 
 	if (device == IDEAPAD_DEV_KILLSW)
 		return -EINVAL;
-	return ideapad_dev_set_state(device, !blocked);
+
+	return write_ec_cmd(ideapad_priv->handle,
+			    ideapad_rfk_data[device].opcode,
+			    !blocked);
 }
 
 static struct rfkill_ops ideapad_rfk_ops = {
@@ -317,6 +303,7 @@ static int ideapad_acpi_add(struct acpi_device *adevice)
 
 	priv->handle = adevice->handle;
 	dev_set_drvdata(&adevice->dev, priv);
+	ideapad_priv = priv;
 	for (i = IDEAPAD_DEV_WLAN; i <= IDEAPAD_DEV_KILLSW; i++) {
 		if (!devs_present[i])
 			continue;
-- 
1.7.0.4
