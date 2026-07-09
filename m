Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA743935A
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563347; cv=none; b=qROJPgGInisZROxy/Bs2LIDyG6XjbLO7vtbQkrThYWmzNY6Ka9zV6EgBiRlwPj1gFk8u7BZIcPAPv88Ac/46nD55aHwNviVPeJVYWzJMJgUzt93ymny/CGODCSttkcMXF3voIY/RayuCjoC2OYtXHDl/6v6hcJust+Gz+YpBriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563347; c=relaxed/simple;
	bh=KPN/ZkZrqF4fSSBcs/sPVJGUpjpHcZRlcVIAWHsQ3UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBSLFFPjqlBsdnd/BN9jbVwy0+mtUQGSX5aWm7zpc4NzddCoNB2ablVv9zsOUJOKndjoeNpTuGu37AsfQc4hpvl/4gQYW+PkUx72a51soelTXZnscLJuhKG0kfR0rLkZ1QS2KeC+68NL2GBZeb3HBeLRVna3LQmKjbVx1Mrrgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPpMxiDw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPpMxiDw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace7da66eso14302995ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 08 Jul 2026 19:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783563346; x=1784168146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMkPiJq/fyrzWCUwRPm6G+BYtSCZmkHOyXwa6vbMRgo=;
        b=CPpMxiDwhmJMp0hSRtlrqt7QaRdA3h9QNbwFTa1HHhojFtKm/DcuSSPS4tkA2OSxzK
         OBTfmY0K+Im/1fqbgFu3PinivPT2hni5EO6v6aA9kgJqeMSk0pOT0loQXUcmQn3uXyk8
         Tfs0pyeBVupPch22mKZhNr06DKdMyug++MKnHj+96hHDf1F8sLXXSdq+6oOIhY3dGUET
         gAjNoGIIW8FKAEjmG4bFBPZZ3UleNqgAKQkmAvS3SgXGmHYcfVKPzdaXBslUYYBPp6Kx
         BaTIeClX06Tff/LBRRsGyptzY1w+EYyKYSmswAL1r035jYuUPzJvDaE0LXpKWy7j5oeR
         /4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783563346; x=1784168146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMkPiJq/fyrzWCUwRPm6G+BYtSCZmkHOyXwa6vbMRgo=;
        b=r8H8GsNWhtTtw4O3bXRzyI5mP6iLHUMa99ywzHSqHV9Hlnjemuk1QCq21BlAJwS1qv
         nYrWKFp9S1BNWcuu9GCu00WQSrla5nggAD93Mq9efqBon3E4PGOTSwO63iqQch1OjQgf
         Prje4PIvpfJ0k3QfvV//X+veyd9Wi+7tzy7TxWKzKRAeee2fKaMJNFIBFWwzYDfWFat1
         uePUxfZbH0qBw7jqLWi31/azdVgifrqRUQ9pyZTumeBzsacRtbiS9zGHVbRLvWDWWHIK
         Mz3DIpYIqYE4XFIpUKT9K/Sgg/cK+7WWU9QfvsVUUlOJLHN4bgnEfNuCJ7drmuwrk9/L
         M1Jg==
X-Forwarded-Encrypted: i=1; AHgh+RrO6USAnZXQfOcSX7RJfSQi23N9sIOed/cyjV4XWU07pMAVX91xgmuh6S4/0oGxx3fkT+gf8sZtgtW8@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIFi19VYC/nPYdN/FJOg/PViJt5UQe3deNUZP61TR+fq9TEO+
	qVWW3ZZsOWYSXkGAnNfnjYqhfh71ZoOxGoI24moX44k/1CvECRucI+RI
X-Gm-Gg: AfdE7cmWPpn+7m8ZW8VI37w0h8fzaP+7y7AnX/9H91IhJ2ObaWYsHv/qr/skQDlsqX3
	YZpWDS2l+hCqtpmjJRN+WaPYK8K5hOJJ4buCs3bdA8HctJxv2QG8VjmtmKEvJsg462YLp3PtVhu
	y6QTLIw3c/oBGhpzvLL6tdtnmArS1beV4HD3ixxwGREg/QU+YQyrbJ1wrdjXuGUcWj+rWbvy6NI
	tcDR8OPuAB0IpKpe3MReYzAdhNOcvqDHXRyE2IUKfS23XR9qvCupxQI7dKYu0SaAxjXxTcizrhP
	048vYmQ4K3Ej1vtggb3kKNyQw/Hv25Q09AtRk80UzXrM2ek1B/Q8ti6aLVTxcBRgQ3YAhNqoLMl
	p4KzhxLOP8GpMnps+HyTWXDqEF9fdpjpDL9N69KX3COhhs4eALcgBnBKG8Vky3T1CFp1gjSHyyK
	uH5KKz676611aWiNlgUW57qBOrekzPRIR6otl4gm8=
X-Received: by 2002:a17:903:1b23:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2ccea36a539mr54667875ad.7.1783563345563;
        Wed, 08 Jul 2026 19:15:45 -0700 (PDT)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:e18a:624b:af6a:fe87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d60da9sm35234455ad.84.2026.07.08.19.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:15:44 -0700 (PDT)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	derekjohn.clark@gmail.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	mark.pearson@lenovo.com,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [PATCH v4] platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support
Date: Thu,  9 Jul 2026 11:15:04 +0900
Message-ID: <20260709021504.465792-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer ThinkPad systems expose a USB-C Security (Restricted Mode) feature.
When active, USB-C data connections are disabled while power delivery is
preserved. This is useful for kiosk and physically-secured deployments.

Hardware interface:

The HKEY device exposes a read-only ACPI method USCS():

  Return value bit layout:
    Bit 16 : Capability flag (1 = feature present on this SKU)
    Bit  0 : Current state  (0 = security OFF, 1 = security ON)

The sysfs attribute is read-only.

The Fn+U followed by Fn+S hotkey chord is the only way to toggle the
hardware state.

Hotkey:

Fn+U followed by Fn+S generates HKEY event 0x131e.

sysfs interface:

  /sys/devices/platform/thinkpad_acpi/usb_c_security  (read-only)
  "enabled\n"  -- data connections are currently blocked
  "disabled\n" -- data connections are currently allowed

  The attribute is hidden on SKUs where the USCS capability bit (bit 16)
  is not set, so there is no ABI impact on unsupported hardware.

Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
Changes since v3:
- Add comment to usbc_security_mutex documenting what the lock protects

Changes since v2:
- Move usbc_security_enabled out of tp_features bitfield to a bool
  member of tp_features to avoid unsafe concurrent bitfield RMW;
  usbc_security_supported remains a bitfield as it is init-only.
- Pass &tp_features.usbc_security_enabled directly to
  usbc_security_query() removing the local bool intermediary
  in both init and hotkey paths.
- Remove extra blank line before */ in block comment.
- Fix kerneldoc Returns: syntax and rewrite return value description
  to match the int return type.
- Split ternary return into two separate if statements for clarity

Changes since v1:
- Use guard(mutex) from cleanup.h instead of manual mutex_lock/unlock
- Revert usbc_security_query() to return int (-EIO/-ENODEV/0) instead
  of bool to avoid uninitialized *enabled bug on unsupported platforms
- Remove !! when assigning to bool in usbc_security_query()
- Remove dead tp_features.usbc_security_supported check in show()
  since is_visible() already gates the attribute on unsupported SKUs
- Use str_enabled_disabled() from string_choices.h in show()
- Fix uninitialized *enabled bug in tpacpi_usbc_security_init() by
  only assigning usbc_security_enabled after a successful query
---
 .../admin-guide/laptops/thinkpad-acpi.rst     |  24 ++++
 drivers/platform/x86/lenovo/thinkpad_acpi.c   | 117 ++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index f874db31801d..db4588af0278 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -1543,6 +1543,30 @@ Values:
 
 	This setting can also be toggled via the Fn+doubletap hotkey.
 
+USB-C Security
+--------------
+
+sysfs: usb_c_security
+
+Reports the current state of the USB-C Security (Restricted Mode) feature
+on supported ThinkPad systems. When enabled, USB-C data connections are
+disabled while power delivery is preserved.
+
+The available command is::
+
+        cat /sys/devices/platform/thinkpad_acpi/usb_c_security
+
+Values:
+
+	* ``enabled``  - USB-C data connections are currently blocked
+	* ``disabled`` - USB-C data connections are currently allowed
+
+The attribute is read-only. The USB-C Security state can only be toggled
+via the Fn+U followed by Fn+S hotkey chord.
+
+The sysfs attribute is not created on platforms that do not support this
+feature.
+
 Auxmac
 ------
 
diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 445e1403308e..91db4c8eeac2 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -38,6 +38,7 @@
 #include <linux/backlight.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -67,6 +68,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/string_helpers.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -186,6 +188,7 @@ enum tpacpi_hkey_event_t {
 	TP_HKEY_EV_AMT_TOGGLE		= 0x131a, /* Toggle AMT on/off */
 	TP_HKEY_EV_CAMERASHUTTER_TOGGLE = 0x131b, /* Toggle Camera Shutter */
 	TP_HKEY_EV_DOUBLETAP_TOGGLE	= 0x131c, /* Toggle trackpoint doubletap on/off */
+	TP_HKEY_EV_USB_C_SECURITY	= 0x131e, /* USB C Security (Fn+U, Fn+S) */
 	TP_HKEY_EV_PROFILE_TOGGLE	= 0x131f, /* Toggle platform profile in 2024 systems */
 	TP_HKEY_EV_PROFILE_TOGGLE2	= 0x1401, /* Toggle platform profile in 2025 + systems */
 
@@ -374,6 +377,8 @@ static struct {
 	u32 has_adaptive_kbd:1;
 	u32 kbd_lang:1;
 	u32 trackpoint_doubletap_enable:1;
+	u32 usbc_security_supported:1;
+	bool usbc_security_enabled;
 	struct quirk_entry *quirks;
 } tp_features;
 
@@ -11285,6 +11290,111 @@ static struct ibm_struct hwdd_driver_data = {
 	.name = "hwdd",
 };
 
+/*************************************************************************
+ * USB-C Security subdriver
+ *
+ * HKEY.USCS(0) is a read-only ACPI method; its argument is ignored.
+ * It always returns:
+ *   bit 16 - USB-C security capability present on this SKU or not
+ *   bit  0 - USB-C Security state (enable or disable)
+ *
+ * Hotkey
+ * ------
+ * 0x131e (Fn+U, Fn+S): firmware toggles USBS before firing the event.
+ * The driver reads back the new state and notifies the sysfs attribute.
+ */
+
+/* USCS() return word bit layout */
+#define USCS_CAP_BIT		BIT(16)	/* capability: feature present on SKU */
+#define USCS_STATUS_BIT		BIT(0)	/* current security state */
+
+/* Protects USCS() ACPI method calls in usbc_security_query() */
+static DEFINE_MUTEX(usbc_security_mutex);
+
+/**
+ * usbc_security_query - read current USB-C security state via USCS()
+ * @enabled: out - true when security is ON (data connections blocked)
+ *
+ * Returns:
+ *   0        success, @enabled contains the current state
+ *  -EIO      ACPI evaluation failed
+ *  -ENODEV   capability bit absent; feature not present on this SKU*
+ */
+static int usbc_security_query(bool *enabled)
+{
+	int status;
+
+	guard(mutex)(&usbc_security_mutex);
+	if (!acpi_evalf(hkey_handle, &status, "USCS", "dd", 0))
+		return -EIO;
+
+	if (!(status & USCS_CAP_BIT)) {
+		pr_debug("USCS cap bit absent (raw=0x%x)\n", status);
+		return -ENODEV;
+	}
+
+	*enabled = status & USCS_STATUS_BIT;
+	return 0;
+}
+
+/* sysfs: /sys/devices/platform/thinkpad_acpi/usb_c_security ---------- */
+static ssize_t usb_c_security_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  str_enabled_disabled(tp_features.usbc_security_enabled));
+}
+
+static DEVICE_ATTR_RO(usb_c_security);
+
+static struct attribute *usbc_security_attributes[] = {
+	&dev_attr_usb_c_security.attr,
+	NULL,
+};
+
+static umode_t usbc_security_attr_is_visible(struct kobject *kobj,
+					     struct attribute *attr, int n)
+{
+	return tp_features.usbc_security_supported ? attr->mode : 0;
+}
+
+static const struct attribute_group usbc_security_attr_group = {
+	.is_visible = usbc_security_attr_is_visible,
+	.attrs = usbc_security_attributes,
+};
+
+static int tpacpi_usbc_security_init(struct ibm_init_struct *iibm)
+{
+	int err;
+
+	err = usbc_security_query(&tp_features.usbc_security_enabled);
+	if (err == -ENODEV)
+		return 0;
+	if (err)
+		return err;
+
+	tp_features.usbc_security_supported = true;
+	return 0;
+}
+
+/* tpacpi_usbc_security_hotkey - handle Fn+U Fn+S hotkey (0x131e) */
+static bool tpacpi_usbc_security_hotkey(void)
+{
+	if (!tp_features.usbc_security_supported)
+		return false;
+
+	if (usbc_security_query(&tp_features.usbc_security_enabled))
+		return false;
+
+	sysfs_notify(&tpacpi_pdev->dev.kobj, NULL, "usb_c_security");
+	return true;
+}
+
+static struct ibm_struct usbc_security_driver_data = {
+	.name = "usbc_security",
+};
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *tpacpi_driver_attributes[] = {
@@ -11345,6 +11455,7 @@ static const struct attribute_group *tpacpi_groups[] = {
 	&dprc_attr_group,
 	&auxmac_attr_group,
 	&hwdd_attr_group,
+	&usbc_security_attr_group,
 	NULL,
 };
 
@@ -11499,6 +11610,8 @@ static bool tpacpi_driver_event(const unsigned int hkey_event)
 	case TP_HKEY_EV_PROFILE_TOGGLE2:
 		platform_profile_cycle();
 		return true;
+	case TP_HKEY_EV_USB_C_SECURITY:
+		return tpacpi_usbc_security_hotkey();
 	}
 
 	return false;
@@ -11964,6 +12077,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = tpacpi_hwdd_init,
 		.data = &hwdd_driver_data,
 	},
+	{
+		.init = tpacpi_usbc_security_init,
+		.data = &usbc_security_driver_data,
+	},
 };
 
 static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
-- 
2.51.0

