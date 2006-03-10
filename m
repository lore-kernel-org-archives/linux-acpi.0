From: "Brown, Len" <len.brown@intel.com>
Subject: RE: acpi resume
Date: Fri, 10 Mar 2006 14:02:46 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30065968E6@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:57570 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750976AbWCJTDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Mar 2006 14:03:02 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Stelian Pop <stelian@popies.net>, linux-acpi@vger.kernel.org, Patrick Mochel <mochel@linux.intel.com>

>So I thought I'd get cunning and make the Vaio's screen restore the
>brightness after s2r:
>
>--- devel/drivers/acpi/sony_acpi.c~sony_apci-resume	
>2006-03-10 03:39:06.000000000 -0800
>+++ devel-akpm/drivers/acpi/sony_acpi.c	2006-03-10 
>03:44:42.000000000 -0800
>@@ -46,19 +46,6 @@ module_param(debug, int, 0);
> MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want 
>to help "
> 			"the development of this driver");
> 
>-static int sony_acpi_add (struct acpi_device *device);
>-static int sony_acpi_remove (struct acpi_device *device, int type);
>-
>-static struct acpi_driver sony_acpi_driver = {
>-	.name	= ACPI_SNC_DRIVER_NAME,
>-	.class	= ACPI_SNC_CLASS,
>-	.ids	= ACPI_SNC_HID,
>-	.ops	= {
>-			.add	= sony_acpi_add,
>-			.remove	= sony_acpi_remove,
>-		  },
>-};
>-
> static acpi_handle sony_acpi_handle;
> static struct proc_dir_entry *sony_acpi_dir;
> 
>@@ -69,6 +56,8 @@ static struct sony_acpi_value {
> 	char			*acpiset;/* name of the ACPI 
>get function */
> 	int 			min;	 /* minimum allowed 
>value or -1 */
> 	int			max;	 /* maximum allowed 
>value or -1 */
>+	int			value;	 /* current setting */
>+	int			valid;	 /* Has ever been set */
> 	int			debug;	 /* active only in 
>debug mode ? */
> } sony_acpi_values[] = {
> 	{
>@@ -234,10 +223,31 @@ static int sony_acpi_write(struct file *
> 
> 	if (acpi_callsetfunc(sony_acpi_handle, item->acpiset, 
>value, NULL) < 0)
> 		return -EIO;
>-
>+	item->value = value;
>+	item->valid = 1;
> 	return count;
> }
> 
>+static int sony_acpi_resume(struct acpi_device *device, int state)
>+{
>+	struct sony_acpi_value *item;
>+
>+	printk("%s\n", __FUNCTION__);
>+	for (item = sony_acpi_values; item->name; item++) {
>+		int ret;
>+
>+		if (!item->valid)
>+			continue;
>+		ret = acpi_callsetfunc(sony_acpi_handle, item->acpiset,
>+					item->value, NULL);
>+		if (ret < 0) {
>+			printk("%s: %d\n", __FUNCTION__, ret);
>+			break;
>+		}
>+	}
>+	return 0;
>+}
>+
> static void sony_acpi_notify(acpi_handle handle, u32 event, 
>void *data)
> {
> 	printk(LOG_PFX "sony_acpi_notify\n");
>@@ -339,7 +349,6 @@ outwalk:
> 	return result;
> }
> 
>-
> static int sony_acpi_remove(struct acpi_device *device, int type)
> {
> 	acpi_status status;
>@@ -362,6 +371,17 @@ static int sony_acpi_remove(struct acpi_
> 	return 0;
> }
> 
>+static struct acpi_driver sony_acpi_driver = {
>+	.name	= ACPI_SNC_DRIVER_NAME,
>+	.class	= ACPI_SNC_CLASS,
>+	.ids	= ACPI_SNC_HID,
>+	.ops	= {
>+			.add	= sony_acpi_add,
>+			.remove	= sony_acpi_remove,
>+			.resume = sony_acpi_resume,
>+		  },
>+};
>+
> static int __init sony_acpi_init(void)
> {
> 	int result;
>_
>
>
>But afaict, core ACPI never calls that resume method :(

The "acpi drivers" themselves don't have suspend/resume methods yet.
Others need them too, the biggest is the button driver
that needs to forget events that happened during suspend,
and the next one is probably thermal, which doesn't
restore the user-supplied trip-points.

I think acpi/sysfs patch Patrick is working on is supposed
to address this framework issue.

-Len
