From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 0/7] New misc/asus-laptop.c driver
Date: Tue, 30 Jan 2007 02:53:25 -0500
Message-ID: <200701300253.25321.lenb@kernel.org>
References: <200701251254.34491.corentincj@iksaif.net> <200701260251.04762.lenb@kernel.org> <200701261404.23961.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51627 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965443AbXA3IAr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jan 2007 03:00:47 -0500
In-Reply-To: <200701261404.23961.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Friday 26 January 2007 08:04, Corentin CHARY wrote:
> Le vendredi 26 janvier 2007 08:51, Len Brown a =E9crit=A0:
> > On Thursday 25 January 2007 06:54, Corentin CHARY wrote:
> > > Hi,
> > > I've done a lot of work on asus_acpi
> >
> > Excellent.
> >
> > A couple of nits on e-mail patch format:
> >
> > Please fit the comments within 80 lines.
> > ie. pipe them through fmt -w 68 or something.
> >
> > The --- in your e-mail should come before the diffstat, not after.
> >
> done :) thanks.
> I just send the new series, with some cleanups (write_led -> write_st=
atus,=20
> etc ..), and some bugfix ... This series is made to apply on top of=20
> 2.6.20-rc6. This time, my mails are well formatted, I hope :p.

1-7 applied to acpi-test
I also ran scripts/Lindent over it to fix the whitespace.
Then, after merging into acpi-test I also applied the patch below.

Your choice if you want to make future updates with incremental patches
on top of acpi-test or re-send the series.

Also, while I see that distros do set CONFIG_LEDS_CLASS,
depending on it will make the driver vanish from menuconfig
if somebody hasn't set it.  I don't know if this is a big deal or not.
One possibility is to not depend on it in Kconfig, but via #ifdef's in =
the source.
The other is to retreat to using select -- which I'm hopeful we can avo=
id.
Or, maybe folks that don't get the driver via distro (who tend to enabl=
e everything)
will not get stumped by this.

thanks
-Len

commit 57262852805a54ab312c00fe3129e8b99a24c94b
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jan 30 02:44:03 2007 -0500

    asus-laptop: handle new ACPI table manager
   =20
    acpi_get_table() used to give us a copy of a table,
    now it gives us a mapping to the BIOS' copy of the table.
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index b624350..861c399 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -777,7 +777,6 @@ static int asus_handle_init(char *name, acpi_handle=
 * handle,
 static int asus_hotk_get_info(void)
 {
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer dsdt =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model =3D NULL;
 	int bsts_result, hwrs_result;
 	char *string =3D NULL;
@@ -791,11 +790,9 @@ static int asus_hotk_get_info(void)
 	 * HID), this bit will be moved. A global variable asus_info contains
 	 * the DSDT header.
 	 */
-	status =3D acpi_get_table(ACPI_TABLE_ID_DSDT, 1, &dsdt);
+	status =3D acpi_get_table(ACPI_SIG_DSDT, 1, &asus_info);
 	if (ACPI_FAILURE(status))
 		printk(ASUS_WARNING "Couldn't get the DSDT table header\n");
-	else
-		asus_info =3D dsdt.pointer;
=20
 	/* We have to write 0 on init this far for all ASUS models */
 	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
@@ -1014,8 +1011,6 @@ static void __exit asus_laptop_exit(void)
 	sysfs_remove_group(&asuspf_device->dev.kobj, &asuspf_attribute_group)=
;
 	platform_device_unregister(asuspf_device);
 	platform_driver_unregister(&asuspf_driver);
-
-	kfree(asus_info);
 }
=20
 static int asus_backlight_init(struct device *dev)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
