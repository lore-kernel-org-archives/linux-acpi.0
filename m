From: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Subject: [PATCH v3 04/11] platform/x86: asus-wmi: Improve DSTS WMI method ID
 detection
Date: Fri, 19 Apr 2019 12:08:42 +0200
Message-ID: <d6ee51cc-eb0f-2bb9-fef9-f8b4bf849076@gmail.com>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Daniel Drake <drake@endlessm.com>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The DSTS method detection mistakenly selects DCTS instead of DSTS if
nothing is returned when the method ID is not defined in WMNB. As a result,
the control of keyboard backlight is not functional for TUF Gaming series
laptops. Implement another detection method instead.

There is evidence that DCTS is handled by ACPI WMI devices that have _UID
ASUSWMI, whereas none of the devices without ASUSWMI respond to DCTS and
DSTS is used instead [1]. To check the _UID a new method is added to wmi.h
/ wmi.c. It returns _UID of the ACPI WMI device that declares WMI object
with given GUID.

Generally, it is possible that multiple PNP0C14 ACPI devices are present in
the system as mentioned in the commit message of commit bff431e49ff5
("ACPI: WMI: Add ACPI-WMI mapping driver").

Therefore the _UID is checked for given GUID that maps to a specific ACPI
device, to which it is also mapped by other methods of wmi module.

DSDT examples:

FX505GM:
Method (WMNB, 3, Serialized)
{ ...
    If ((Local0 == 0x53545344))
    {
        ...
        Return (Zero)
    }
    ...
    // No return
}

K54C:
Method (WMNB, 3, Serialized)
{ ...
    If ((Local0 == 0x53545344))
    {
        ...
        Return (0x02)
    }
    ...
    Return (0xFFFFFFFE)
}

[1] https://lkml.org/lkml/2019/4/11/322

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Suggested-by: Daniel Drake <drake@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c            | 20 ++++++++++++++++++--
 drivers/platform/x86/wmi.c                 | 19 +++++++++++++++++++
 include/linux/acpi.h                       |  1 +
 include/linux/platform_data/x86/asus-wmi.h |  4 ++--
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ba04737ece0d..266d0eda5476 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -80,6 +80,8 @@ MODULE_LICENSE("GPL");
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
+#define ASUS_ACPI_UID_ASUSWMI		"ASUSWMI"
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static bool ashs_present(void)
@@ -1847,6 +1849,7 @@ static int asus_wmi_sysfs_init(struct platform_device *device)
 static int asus_wmi_platform_init(struct asus_wmi *asus)
 {
 	int rv;
+	char *wmi_uid;
 
 	/* INIT enable hotkeys on some models */
 	if (!asus_wmi_evaluate_method(ASUS_WMI_METHODID_INIT, 0, 0, &rv))
@@ -1875,11 +1878,24 @@ static int asus_wmi_platform_init(struct asus_wmi *asus)
 	 * Note, on most Eeepc, there is no way to check if a method exist
 	 * or note, while on notebooks, they returns 0xFFFFFFFE on failure,
 	 * but once again, SPEC may probably be used for that kind of things.
+	 *
+	 * Additionally at least TUF Gaming series laptops return nothing for
+	 * unknown methods, so the detection in this way is not possible.
+	 *
+	 * There is strong indication that only ACPI WMI devices that have _UID
+	 * equal to "ASUSWMI" use DCTS whereas those with "ATK" use DSTS.
 	 */
-	if (!asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, 0, 0, NULL))
+	wmi_uid = wmi_get_acpi_device_uid(ASUS_WMI_MGMT_GUID);
+	if (!wmi_uid)
+		return -ENODEV;
+
+	if (!strcmp(wmi_uid, ASUS_ACPI_UID_ASUSWMI)) {
+		pr_info("Detected ASUSWMI, use DCTS\n");
 		asus->dsts_id = ASUS_WMI_METHODID_DSTS;
-	else
+	} else {
+		pr_info("Detected %s, not ASUSWMI, use DSTS\n", wmi_uid);
 		asus->dsts_id = ASUS_WMI_METHODID_DSTS2;
+	}
 
 	/* CWAP allow to define the behavior of the Fn+F2 key,
 	 * this method doesn't seems to be present on Eee PCs */
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7b26b6ccf1a0..b08ffb769cbe 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -635,6 +635,25 @@ bool wmi_has_guid(const char *guid_string)
 }
 EXPORT_SYMBOL_GPL(wmi_has_guid);
 
+/**
+ * wmi_get_acpi_device_uid() - Get _UID name of ACPI device that defines GUID
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ *
+ * Find the _UID of ACPI device associated with this WMI GUID.
+ *
+ * Return: The ACPI _UID field value or NULL if the WMI GUID was not found
+ */
+char *wmi_get_acpi_device_uid(const char *guid_string)
+{
+	struct wmi_block *wblock = NULL;
+
+	if (!find_guid(guid_string, &wblock))
+		return NULL;
+
+	return acpi_device_uid(wblock->acpi_device);
+}
+EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);
+
 static struct wmi_block *dev_to_wblock(struct device *dev)
 {
 	return container_of(dev, struct wmi_block, dev.dev);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d5dcebd7aad3..d31c7fd66f97 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -376,6 +376,7 @@ extern acpi_status wmi_install_notify_handler(const char *guid,
 extern acpi_status wmi_remove_notify_handler(const char *guid);
 extern acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out);
 extern bool wmi_has_guid(const char *guid);
+extern char *wmi_get_acpi_device_uid(const char *guid);
 
 #endif	/* CONFIG_ACPI_WMI */
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 53dfc2541960..a5fe7e68944b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -18,8 +18,8 @@
 #define ASUS_WMI_METHODID_GDSP		0x50534447 /* Get DiSPlay output */
 #define ASUS_WMI_METHODID_DEVP		0x50564544 /* DEVice Policy */
 #define ASUS_WMI_METHODID_OSVR		0x5256534F /* OS VeRsion */
-#define ASUS_WMI_METHODID_DSTS		0x53544344 /* Device STatuS */
-#define ASUS_WMI_METHODID_DSTS2		0x53545344 /* Device STatuS #2*/
+#define ASUS_WMI_METHODID_DSTS		0x53544344 /* Device STatuS (DCTS) */
+#define ASUS_WMI_METHODID_DSTS2		0x53545344 /* Device STatuS (DSTS) */
 #define ASUS_WMI_METHODID_BSTS		0x53545342 /* Bios STatuS ? */
 #define ASUS_WMI_METHODID_DEVS		0x53564544 /* DEVice Set */
 #define ASUS_WMI_METHODID_CFVS		0x53564643 /* CPU Frequency Volt Set */
-- 
2.17.1
