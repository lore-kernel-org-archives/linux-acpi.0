From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI error during Sandybridge boot
Date: Sun, 29 Nov 2009 14:20:00 +0300
Message-ID: <4B1258E0.7040203@suse.de>
References: <57C9024A16AD2D4C97DC78E552063EA3E39CC12C@orsmsx505.amr.corp.intel.com>	 <1259113351.2552.13.camel@localhost.localdomain>	 <4B0CE645.9000705@gmail.com> <1259197886.2552.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050502000502090600060403"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:49551 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754242AbZK2Lj5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Nov 2009 06:39:57 -0500
In-Reply-To: <1259197886.2552.25.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Kay, Allen M" <allen.m.kay@intel.com>, "lenb@kernel.org" <lenb@kernel.org>

This is a multi-part message in MIME format.
--------------050502000502090600060403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ykzhao wrote:
> On Wed, 2009-11-25 at 16:09 +0800, Alexey Starikovskiy wrote:
>> Hi Yakui,
>> May I see DSDT? What is the reason to not include ECDT while it's 
>> clearly needed by design?
>>
> On this box there is no ECDT table. 
You don't understand me again... I am asking, why this unreleased box violates spec by not having ECDT?
> The attached is the dsdt.dsl file. Only the part of EC/_GPE is reserved.
I'm attaching patch, you could add new DMI workaround for your box similar to ASUS.

Regards,
Alex.
> 
> thanks.
> 
>> Regards,
>> Alex.
>>
>> ykzhao wrote:
>>> Hi, Alexey
>>>
>>>    The following warning message is complained on one box in the boot
>>> phase. And the EC opregion field is accessed in the GPE L01 method.
>>> After looking at the source code it seems that the GPE L01 is enabled
>>> before installing EC space handler.
>>>
>>>     There is no ECDT table in the acpidump. And there is no _INI object
>>> for the ACPI EC device. 
>>>     
>>>
>>> Any idea about this issue?
>>>     Can we also initialize the EC device and installing EC space handler
>>> earlier as we have done on the machine with the ECDT table?
>>>
>>> Thanks.
>>>     Yakui    
>>>
>>>   
>>>> [  371.362936] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] 
>>>> 20090521 evgpe-568
>>>> [  371.484758] ACPI Error: No handler for Region [ECF2] (ffff88006cc0b900) [Embe
>>>> ddedControl] 20090521 evregion-319
>>>> [  371.484780] ACPI Error: Region EmbeddedControl(3) has no handler 20090521 exf
>>>> ldio-294
>>>> [  371.484798] ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._
>>>> L01] (Node ffff88006cc5c9a0), AE_NOT_EXIST
>>>> [  371.484917] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] 
>>>> 20090521 evgpe-568
>>>> [  371.608737] ACPI Error: No handler for Region [ECF2] (ffff88006cc0b900) [Embe
>>>> ddedControl] 20090521 evregion-319
>>>> [  371.608760] ACPI Error: Region EmbeddedControl(3) has no handler 20090521 exf
>>>> ldio-294
>>>> [  371.608785] ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._
>>>> L01] (Node ffff88006cc5c9a0), AE_NOT_EXIST
>>>> [  371.609012] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] 
>>>> 20090521 evgpe-568
>>>> [  371.731704] ACPI Error: No handler for Region [ECF2] (ffff88006cc0b900) [Embe
>>>> ddedControl] 20090521 evregion-319
>>>> [  371.731726] ACPI Error: Region EmbeddedControl(3) has no handler 20090521 exf
>>>> ldio-294
>>>>     
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>   


--------------050502000502090600060403
Content-Type: text/x-diff;
 name="simplify_dmi_scan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simplify_dmi_scan.patch"

ACPI: EC: Simplify DMI workarounds scanning

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   31 ++++++++-----------------------
 1 files changed, 8 insertions(+), 23 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7511029..ce7132c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -119,8 +119,7 @@ static struct acpi_ec {
 } *boot_ec, *first_ec;
 
 static int EC_FLAGS_MSI; /* Out-of-spec MSI controller */
-static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be validated */
-static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT scan */
+static int EC_FLAGS_ASUS; /* Out-of-spec ASUStek BIOS */
 
 /* --------------------------------------------------------------------------
                              Transaction Management
@@ -899,17 +898,10 @@ static const struct acpi_device_id ec_device_ids[] = {
 	{"", 0},
 };
 
-/* Some BIOS do not survive early DSDT scan, skip it */
-static int ec_skip_dsdt_scan(const struct dmi_system_id *id)
-{
-	EC_FLAGS_SKIP_DSDT_SCAN = 1;
-	return 0;
-}
-
 /* ASUStek often supplies us with broken ECDT, validate it */
-static int ec_validate_ecdt(const struct dmi_system_id *id)
+static int ec_flag_asus(const struct dmi_system_id *id)
 {
-	EC_FLAGS_VALIDATE_ECDT = 1;
+	EC_FLAGS_ASUS = 1;
 	return 0;
 }
 
@@ -918,16 +910,11 @@ static int ec_flag_msi(const struct dmi_system_id *id)
 {
 	printk(KERN_DEBUG PREFIX "Detected MSI hardware, enabling workarounds.\n");
 	EC_FLAGS_MSI = 1;
-	EC_FLAGS_VALIDATE_ECDT = 1;
 	return 0;
 }
 
 static struct dmi_system_id __initdata ec_dmi_table[] = {
 	{
-	ec_skip_dsdt_scan, "Compal JFL92", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
-	DMI_MATCH(DMI_BOARD_NAME, "JFL92") }, NULL},
-	{
 	ec_flag_msi, "MSI hardware", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "Micro-Star")}, NULL},
 	{
@@ -937,7 +924,7 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	ec_flag_msi, "MSI hardware", {
 	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-Star")}, NULL},
 	{
-	ec_validate_ecdt, "ASUS hardware", {
+	ec_flag_asus, "ASUS hardware", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
 	{},
 };
@@ -966,7 +953,7 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->handle = ACPI_ROOT_OBJECT;
 		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
 		/* Don't trust ECDT, which comes from ASUSTek */
-		if (!EC_FLAGS_VALIDATE_ECDT)
+		if (!EC_FLAGS_MSI && !EC_FLAGS_ASUS)
 			goto install;
 		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 		if (!saved_ec)
@@ -975,9 +962,8 @@ int __init acpi_ec_ecdt_probe(void)
 	/* fall through */
 	}
 
-	if (EC_FLAGS_SKIP_DSDT_SCAN)
+	if (!EC_FLAGS_MSI && !EC_FLAGS_ASUS)
 		return -ENODEV;
-
 	/* This workaround is needed only on some broken machines,
 	 * which require early EC, but fail to provide ECDT */
 	printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
@@ -1004,9 +990,8 @@ int __init acpi_ec_ecdt_probe(void)
 		* Keep boot_ec struct as it will be needed soon.
 		*/
 		acpi_handle dummy;
-		if (!dmi_name_in_vendors("ASUS") ||
-		    ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI",
-							&dummy)))
+		if (EC_FLAGS_ASUS &&
+		    ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
 			return -ENODEV;
 	}
 install:

--------------050502000502090600060403--
