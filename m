From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: asus_atk0110 not working on Asus P7P55D PRO
Date: Mon, 21 Sep 2009 21:04:34 +0200
Message-ID: <20090921190434.GA10101@dreamland.darkstar.lan>
References: <4AB1C907.1070503@gmail.com>
 <20090920162306.GA18214@dreamland.darkstar.lan>
 <51f3faa70909201047x56313d99q7cdc49bcc4634b01@mail.gmail.com>
 <20090920185824.GA23206@dreamland.darkstar.lan>
 <51f3faa70909201551k70ace90x2b25351bfc04c555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:50915 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZIUTEJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:04:09 -0400
Content-Disposition: inline
In-Reply-To: <51f3faa70909201551k70ace90x2b25351bfc04c555@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Il Sun, Sep 20, 2009 at 04:51:10PM -0600, Robert Hancock ha scritto:=20
> On Sun, Sep 20, 2009 at 12:58 PM, Luca Tettamanti <kronos.it@gmail.co=
m> wrote:
> >> >> I'm guessing this board uses a different format than what the d=
river
> >> >> is expecting. I'm attaching the gzipped decompiled DSDT from th=
e
> >> >> board, hopefully it's useful to somebody..
> >> >
> >> > Please try the following patch, it should detect the proper buff=
er size.
> >> >
> >>
> >> Obviously something not quite right:
> >
> > Ah yes, the pointer for the output buffer was pointing to the wrong
> > variable. Sorry for that ;)
>=20
> Cool, seems to be working.

Excellent :)

> Though the high and critical temperatures
> seem a bit odd, but maybe that's what the BIOS actually reports:
[...]
> CPU Temperature:    +32.5=B0C  (high =3D +45.0=B0C, crit =3D +45.5=B0=
C)
> MB Temperature:     +31.0=B0C  (high =3D +45.0=B0C, crit =3D +46.0=B0=
C)

The limits are declared in the DSDT, the driver doesn't do any
calculation.
It's possible that Asus changed the encoding (again); so far I've been
unable to locate a "version" field that would allow the driver to detec=
t
a change in the data structures.

I've got a new patch for you: instead of probing and preallocating the
buffer this version lets ACPI code do the allocation; the return value
is cached anyway, so there won't be a big number of allocations.
Can you please test and see if it works?

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.=
c
index fe4fa29..aed6e90 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -129,9 +129,15 @@ struct atk_sensor_data {
 	char const *acpi_name;
 };
=20
-struct atk_acpi_buffer_u64 {
-	union acpi_object buf;
-	u64 value;
+/* Return buffer format:
+ * [0-3] "value" is valid flag
+ * [4-7] value
+ * [8- ] unknown stuff on newer mobos
+ */
+struct atk_acpi_ret_buffer {
+	u32 flags;
+	u32 value;
+	u8 data[];
 };
=20
 static int atk_add(struct acpi_device *device);
@@ -446,8 +452,10 @@ static int atk_read_value_new(struct atk_sensor_da=
ta *sensor, u64 *value)
 	struct acpi_object_list params;
 	struct acpi_buffer ret;
 	union acpi_object id;
-	struct atk_acpi_buffer_u64 tmp;
+	union acpi_object *obj;
+	struct atk_acpi_ret_buffer *buf;
 	acpi_status status;
+	int err =3D 0;
=20
 	id.type =3D ACPI_TYPE_INTEGER;
 	id.integer.value =3D sensor->id;
@@ -455,11 +463,7 @@ static int atk_read_value_new(struct atk_sensor_da=
ta *sensor, u64 *value)
 	params.count =3D 1;
 	params.pointer =3D &id;
=20
-	tmp.buf.type =3D ACPI_TYPE_BUFFER;
-	tmp.buf.buffer.pointer =3D (u8 *)&tmp.value;
-	tmp.buf.buffer.length =3D sizeof(u64);
-	ret.length =3D sizeof(tmp);
-	ret.pointer =3D &tmp;
+	ret.length =3D ACPI_ALLOCATE_BUFFER;
=20
 	status =3D acpi_evaluate_object_typed(data->read_handle, NULL, &param=
s,
 			&ret, ACPI_TYPE_BUFFER);
@@ -468,23 +472,31 @@ static int atk_read_value_new(struct atk_sensor_d=
ata *sensor, u64 *value)
 				acpi_format_exception(status));
 		return -EIO;
 	}
+	obj =3D ret.pointer;
=20
-	/* Return buffer format:
-	 * [0-3] "value" is valid flag
-	 * [4-7] value
-	 */
-	if (!(tmp.value & 0xffffffff)) {
+	/* Sanity check */
+	if (obj->buffer.length < 8) {
+		dev_warn(dev, "Unexpected ASBF length: %u\n",
+				obj->buffer.length);
+		err =3D -EIO;
+		goto out;
+	}
+	buf =3D (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
+
+	if (!buf->flags) {
 		/* The reading is not valid, possible causes:
 		 * - sensor failure
 		 * - enumeration was FUBAR (and we didn't notice)
 		 */
-		dev_info(dev, "Failure: %#llx\n", tmp.value);
-		return -EIO;
+		dev_warn(dev, "Failure: %#x\n", buf->flags);
+		err =3D -EIO;
+		goto out;
 	}
=20
-	*value =3D (tmp.value & 0xffffffff00000000ULL) >> 32;
-
-	return 0;
+	*value =3D buf->value;
+out:
+	ACPI_FREE(ret.pointer);
+	return err;
 }
=20
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value)


thanks,
Luca
--=20
"Perch=E9 =E8 cos=EC che ti frega, la vita. Ti piglia quando hai ancora=
 l'anima
 addormentata e ti semina dentro un'immagine, o un odore, o un suono ch=
e
 poi non te lo togli pi=F9. E quella l=EC era la felicit=E0."
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
