From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Wed, 17 Nov 2004 10:27:58 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC087@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

My more comments :

1.	-static unsigned int acpi_irq_irq;
	-static acpi_osd_handler acpi_irq_handler;
	-static void *acpi_irq_context;

1.1  I don't think it is good idea to remove acpi_irq_irq, which just
for FADT sci. If you haven't add FADT stuff in the dev_id_list.
So , please consider add FADT GPE onto dev_id_list.

2.  	 +struct acpi_dev_id {
	+	acpi_osd_handler handler;
	+	void *context;
	+	int irq;
	+	struct acpi_dev_id *next;
	+};

2.1  Do you think a spin lock or semaphore is unnecessary here?

3.  acpi_os_install_interrupt_handler

+	 * If this is the FADT interrupt, ignore the GSI from the core and
+	 * use the value in our copy of the FADT instead.  It may not be the
+	 * same if an interrupt source override exists for the SCI.
 	 */
-	gsi =3D acpi_fadt.sci_int;
+	if (gsi =3D=3D acpi_gbl_FADT->sci_int)
+		gsi =3D acpi_fadt.sci_int;

3.1  This part should be revised to handle gsi !=3D =
acpi_gbl_FADT->sci_int case.
Because ACPI spec said:" You must have an interrupt source override =
entry for=20
the IRQ mapped to the SCI interrupt if this IRQ is not identity mapped."
GPE device need to look for their own override recorde.

4. acpi_os_remove_interrupt_handler

+	if (gsi =3D=3D acpi_gbl_FADT->sci_int)
+		gsi =3D acpi_fadt.sci_int;
+
+	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
+		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
+		       gsi);
+		return AE_OK;
 	}

4.1 same reason as 3.1


5. acpi_gpe_block_remove

5.1 If you check code acpi_ev_delete_gpe_xrupt, you will find that
if a GPE device's interrupt_level happen to equal to =
acpi_gbl_FADT->sci_int,
the cleanup will abort.



Thanks
Luming=20

>-----Original Message-----
>From: willy-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org [mailto:willy-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org]=20
>On Behalf Of Matthew Wilcox
>Sent: 2004=C4=EA11=D4=C217=C8=D5 2:47
>To: Matthew Wilcox
>Cc: Yu, Luming; Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;=20
>Fu, Michael
>Subject: Re: [ACPI] Re: [PATCH] Teach OSL to handle multiple=20
>interrupts [1/2]
>
>On Tue, Nov 16, 2004 at 03:22:18AM +0000, Matthew Wilcox wrote:
>> > 1.1  Shouldn't it return AE_ERROR.
>>=20
>> I don't think it really matters.  The driver will attach to=20
>these devices,
>> but that doesn't do any harm.
>>=20
>> > 2.1 fadt seems always to be 0, So why you need it?
>>=20
>> fadt is only set to 0 when _CRS resources exist.  ie for GPE=20
>blocks that
>> aren't described in the FADT.  We shouldn't unregister GPE=20
>blocks that're
>> described in the FADT because we didn't register them in the=20
>first place.
>>=20
>> > 3.2  address.reserved must be 0. (You allocate it at stack)
>>=20
>> Doesn't really matter.  It isn't used.  But I'll fix that.
>
>OK, here's an interdiff from the 0.2 to the 0.3 driver which=20
>fixes these
>issues:
>
>diff -u linux-2.6/drivers/acpi/gpe-block.c=20
>linux-2.6/drivers/acpi/gpe-block.c
>--- linux-2.6/drivers/acpi/gpe-block.c  7 Nov 2004 14:34:33 -0000
>+++ linux-2.6/drivers/acpi/gpe-block.c  16 Nov 2004 18:12:52 -0000
>@@ -18,7 +18,7 @@
>=20
> MODULE_AUTHOR("Matthew Wilcox <willy-VXdhtT5mjnY@public.gmane.org>");
> MODULE_LICENSE("GPL");
>-MODULE_VERSION("0.2");
>+MODULE_VERSION("0.3");
>=20
> #define NAME "gpe-block"
>=20
>@@ -83,9 +83,6 @@
> {
>        struct acpi_resource_address64 addr;
>        int size;
>-       int *fadt =3D context;
>-
>-       *fadt =3D 0;
>=20
>        if (res->id !=3D ACPI_RSTYPE_ADDRESS16 &&
>            res->id !=3D ACPI_RSTYPE_ADDRESS32 &&
>@@ -107,26 +104,24 @@
> {
>        struct gpe_block block;
>=20
>-       block.register_count =3D 0;
>+       memset(&block, 0, sizeof(block));
>        acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>                        acpi_gpe_block_crs_add, &block);
>+
>+       /* Decline to handle GPE blocks with no _CRS. */
>        if (block.register_count =3D=3D 0)
>-               return 0;
>+               return -ENODEV;
>=20
>        acpi_install_gpe_block(device->handle, &block.address,
>                        block.register_count, block.interrupt_level);
>=20
>-       return AE_OK;
>+       return 0;
> }
>=20
> static int acpi_gpe_block_remove(struct acpi_device *device, int type)
> {
>-       int fadt =3D 1;
>-
>        acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>-                       acpi_gpe_block_crs_remove, &fadt);
>-       if (fadt)
>-               return AE_OK;
>+                       acpi_gpe_block_crs_remove, NULL);
>=20
>        return acpi_remove_gpe_block(device->handle);
> }
>
>This driver still works, so if I don't get any more comments,=20
>I'll submit
>the 0.3 driver for inclusion ...
>
>--=20
>"Next the statesmen will invent cheap lies, putting the blame upon=20
>the nation that is attacked, and every man will be glad of those
>conscience-soothing falsities, and will diligently study them,=20
>and refuse
>to examine any refutations of them; and thus he will by and by=20
>convince=20
>himself that the war is just, and will thank God for the better sleep=20
>he enjoys after this process of grotesque self-deception." --=20
>Mark Twain
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
