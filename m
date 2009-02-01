From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH] ACPI: add "auto" to acpi_enforce_resources
Date: Sun, 1 Feb 2009 22:22:43 +0100
Message-ID: <20090201212243.GA23852@dreamland.darkstar.lan>
References: <20090125210520.GA12963@dreamland.darkstar.lan> <200901291729.24859.trenn@suse.de> <4981FC38.205@redhat.com> <200901301529.14810.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:12999 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZBAVWt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Feb 2009 16:22:49 -0500
Content-Disposition: inline
In-Reply-To: <200901301529.14810.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, khali@linux-fr.org

On Fri, Jan 30, 2009 at 03:29:13PM +0100, Thomas Renninger wrote: 
> I thought it may only be one specific hwmon driver which could
> interfere on ASUS boards with the ATK0110 device. I agree that
> it would not make sense to cluster all hwmon drivers.
> 
> The problem is similar to the video backlight switching problem
> (legacy drivers vs preferred generic ACPI video driver) where
> you also must know which driver to take before module loading time.
> 
> I hoped to be able to come up with something more clever or say a nicer
> solution or at least a short discussion. But I also have no better idea.
> Maybe all such code should end up in a drivers/acpi/quirks.c file
> at some time, similar to other places in the kernel.
> 
> I think it's time for Len looking at this. I wonder whether he will take
> this patch or why he won't.
> This is an ugly problem which unfortunately needs an ugly fix/check.

I've rewritten the patch, the idea behind it is still the same but the
solution is more generic. The code checks a list of DMI entries and
(optionally) a HID for each entry; if the DMI data matches and the HID
(if not NULL) is found then resource checking is set to strict, otherwise
it falls back to lax.

---
Just RFC, it's still UNTESTED...

 drivers/acpi/osl.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6729a49..c6d1a1c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1063,7 +1063,10 @@ __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
  * in arbitrary AML code and can interfere with legacy drivers.
  * acpi_enforce_resources= can be set to:
  *
- *   - strict           (2)
+ *   - auto             (2)
+ *     -> detect possible conflicts with ACPI drivers and switch to
+ *     strict if needed, otherwise act like lax
+ *   - strict           (3)
  *     -> further driver trying to access the resources will not load
  *   - lax (default)    (1)
  *     -> further driver trying to access the resources will load, but you
@@ -1073,11 +1076,12 @@ __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
  *     -> ACPI Operation Region resources will not be registered
  *
  */
-#define ENFORCE_RESOURCES_STRICT 2
+#define ENFORCE_RESOURCES_STRICT 3
+#define ENFORCE_RESOURCES_AUTO   2
 #define ENFORCE_RESOURCES_LAX    1
 #define ENFORCE_RESOURCES_NO     0
 
-static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
+static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_AUTO;
 
 static int __init acpi_enforce_resources_setup(char *str)
 {
@@ -1086,6 +1090,8 @@ static int __init acpi_enforce_resources_setup(char *str)
 
 	if (!strcmp("strict", str))
 		acpi_enforce_resources = ENFORCE_RESOURCES_STRICT;
+	else if (!strcmp("auto", str))
+		acpi_enforce_resources = ENFORCE_RESOURCES_AUTO;
 	else if (!strcmp("lax", str))
 		acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
 	else if (!strcmp("no", str))
@@ -1096,6 +1102,73 @@ static int __init acpi_enforce_resources_setup(char *str)
 
 __setup("acpi_enforce_resources=", acpi_enforce_resources_setup);
 
+static acpi_status acpi_res_quick_check_hid_cb(acpi_handle obj_handle,
+		u32 nesting_level, void *context, void **return_value)
+{
+	*((bool *)return_value) = true;
+	return AE_CTRL_TERMINATE;
+}
+
+static int acpi_res_quick_check_hid(const struct dmi_system_id *d)
+{
+	acpi_status ret;
+	bool found = false;
+	char *hid;
+
+	if (!d->driver_data)
+		goto strict;
+
+	hid = d->driver_data;
+	ret = acpi_get_devices(hid, acpi_res_quick_check_hid_cb,
+				NULL, (void **)&found);
+
+	if (ret == AE_OK && found)
+		goto strict;
+
+	return 0;
+strict:
+	printk(KERN_DEBUG "ACPI: detected %s system: "
+			"enforcing strict resource checking\n", d->ident);
+	return 1;
+}
+
+/* The following systems have ACPI drivers that might overlap the
+ * functionality of native drivers (mostly in hwmon subsys). If
+ * acpi_enforce_resources is set to auto the following table is
+ * used to enforce strict checking in matching systems, in order
+ * to avoid conflicts.
+ * Note that driver_data and the acpi_res_quick_check_hid callback
+ * are used to further refine the match, checking for the presence
+ * of the given HID (driver_data) in the DSDT. Both fields are
+ * optional for DMI-only rules.
+ */
+static const struct dmi_system_id resource_quirks[] = {
+	{
+		.ident = "Asus",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer"),
+		},
+		.driver_data = "ATK0110",
+		.callback = acpi_res_quick_check_hid,
+	},
+	{ }
+};
+
+static int __init acpi_apply_resource_quirk(void)
+{
+	if (acpi_enforce_resources != ENFORCE_RESOURCES_AUTO)
+		return 0;
+
+	dmi_check_system(resource_quirks);
+
+	if (acpi_enforce_resources == ENFORCE_RESOURCES_AUTO)
+		/* This system is not listed, fallback to 'lax' */
+		acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
+
+	return 0;
+}
+fs_initcall(acpi_apply_resource_quirk);
+
 /* Check for resource conflicts between ACPI OperationRegions and native
  * drivers */
 int acpi_check_resource_conflict(struct resource *res)

Luca
-- 
Mi piace avere amici rispettabili;
Mi piace essere il peggiore della compagnia.
