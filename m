From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: asus_atk0110 not working on Asus P7P55D PRO
Date: Sun, 20 Sep 2009 20:58:24 +0200
Message-ID: <20090920185824.GA23206@dreamland.darkstar.lan>
References: <4AB1C907.1070503@gmail.com>
 <20090920162306.GA18214@dreamland.darkstar.lan>
 <51f3faa70909201047x56313d99q7cdc49bcc4634b01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:61182 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723AbZITS6A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Sep 2009 14:58:00 -0400
Content-Disposition: inline
In-Reply-To: <51f3faa70909201047x56313d99q7cdc49bcc4634b01@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Il Sun, Sep 20, 2009 at 11:47:25AM -0600, Robert Hancock ha scritto:=20
> On Sun, Sep 20, 2009 at 10:23 AM, Luca Tettamanti <kronos.it@gmail.co=
m> wrote:
> > Il Wed, Sep 16, 2009 at 11:28:39PM -0600, Robert Hancock ha scritto=
:
> >> Just built a new system with an Asus P7P55D PRO motherboard. The
> >> ATK0110 driver doesn't seem to be able to retrieve any hardware
> >> monitoring parameters successfully, sensors gives:
> >>
> >> atk0110-acpi-0
> >> Adapter: ACPI interface
> >> ERROR: Can't get value of subfeature in0_input: I/O error
> >> Vcore Voltage: =A0 =A0 =A0+0.00 V =A0(min =3D =A0+0.80 V, max =3D =
=A0+1.60 V)
> >> ERROR: Can't get value of subfeature in1_input: I/O error
> >> +3.3V Voltage: =A0 =A0 =A0+0.00 V =A0(min =3D =A0+2.97 V, max =3D =
=A0+3.63 V)
> >> ERROR: Can't get value of subfeature in2_input: I/O error
> >> +5V Voltage: =A0 =A0 =A0 =A0+0.00 V =A0(min =3D =A0+4.50 V, max =3D=
 =A0+5.50 V)
> >>
> >> etc. and dmesg spits out a bunch of these:
> >>
> >> ATK0110 ATK0110:00: atk_read_value_new: ACPI exception: AE_BUFFER_=
OVERFLOW
> >>
> >> I'm guessing this board uses a different format than what the driv=
er
> >> is expecting. I'm attaching the gzipped decompiled DSDT from the
> >> board, hopefully it's useful to somebody..
> >
> > Please try the following patch, it should detect the proper buffer =
size.
> >
>=20
> Obviously something not quite right:

Ah yes, the pointer for the output buffer was pointing to the wrong
variable. Sorry for that ;)


diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.=
c
index fe4fa29..f1056cf 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -75,6 +75,13 @@ enum atk_pack_member {
 #define _HWMON_OLD_PACK_ENABLE	4
=20
=20
+struct atk_acpi_out_buffer {
+	union acpi_object buf;
+	u32 flags;
+	u32 value;
+	u8 data[];
+};
+
 struct atk_data {
 	struct device *hwmon_dev;
 	acpi_handle atk_handle;
@@ -94,6 +101,10 @@ struct atk_data {
 	int temperature_count;
 	int fan_count;
 	struct list_head sensor_list;
+
+	struct atk_acpi_out_buffer *buffer;
+	size_t buffer_size;
+	struct mutex buffer_lock;
 };
=20
=20
@@ -129,11 +140,6 @@ struct atk_sensor_data {
 	char const *acpi_name;
 };
=20
-struct atk_acpi_buffer_u64 {
-	union acpi_object buf;
-	u64 value;
-};
-
 static int atk_add(struct acpi_device *device);
 static int atk_remove(struct acpi_device *device, int type);
 static void atk_print_sensor(struct atk_data *data, union acpi_object =
*obj);
@@ -446,8 +452,8 @@ static int atk_read_value_new(struct atk_sensor_dat=
a *sensor, u64 *value)
 	struct acpi_object_list params;
 	struct acpi_buffer ret;
 	union acpi_object id;
-	struct atk_acpi_buffer_u64 tmp;
 	acpi_status status;
+	int err =3D 0;
=20
 	id.type =3D ACPI_TYPE_INTEGER;
 	id.integer.value =3D sensor->id;
@@ -455,36 +461,35 @@ static int atk_read_value_new(struct atk_sensor_d=
ata *sensor, u64 *value)
 	params.count =3D 1;
 	params.pointer =3D &id;
=20
-	tmp.buf.type =3D ACPI_TYPE_BUFFER;
-	tmp.buf.buffer.pointer =3D (u8 *)&tmp.value;
-	tmp.buf.buffer.length =3D sizeof(u64);
-	ret.length =3D sizeof(tmp);
-	ret.pointer =3D &tmp;
+	mutex_lock(&data->buffer_lock);
+
+	ret.length =3D data->buffer_size;
+	ret.pointer =3D data->buffer;
=20
 	status =3D acpi_evaluate_object_typed(data->read_handle, NULL, &param=
s,
 			&ret, ACPI_TYPE_BUFFER);
 	if (status !=3D AE_OK) {
 		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
 				acpi_format_exception(status));
-		return -EIO;
+		err =3D -EIO;
+		goto out;
 	}
=20
-	/* Return buffer format:
-	 * [0-3] "value" is valid flag
-	 * [4-7] value
-	 */
-	if (!(tmp.value & 0xffffffff)) {
+	if (!data->buffer->flags) {
 		/* The reading is not valid, possible causes:
 		 * - sensor failure
 		 * - enumeration was FUBAR (and we didn't notice)
 		 */
-		dev_info(dev, "Failure: %#llx\n", tmp.value);
-		return -EIO;
-	}
+		dev_info(dev, "Failure: %#x\n", data->buffer->flags);
=20
-	*value =3D (tmp.value & 0xffffffff00000000ULL) >> 32;
+		err =3D -EIO;
+		goto out;
+	}
=20
-	return 0;
+	*value =3D data->buffer->value;
+out:
+	mutex_unlock(&data->buffer_lock);
+	return err;
 }
=20
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value)
@@ -721,11 +726,40 @@ static int atk_enumerate_new_hwmon(struct atk_dat=
a *data)
 	struct acpi_object_list params;
 	union acpi_object id;
 	union acpi_object *pack;
+	union acpi_object *asbf;
 	int err;
 	int i;
=20
 	dev_dbg(dev, "Enumerating hwmon sensors\n");
=20
+	/* Probe ASBF */
+	buf.length =3D ACPI_ALLOCATE_BUFFER;
+	ret =3D acpi_evaluate_object_typed(data->atk_handle, "ASBF", NULL, &b=
uf,
+			ACPI_TYPE_BUFFER);
+	if (ret !=3D AE_OK) {
+		dev_warn(dev, "Failed to evaluate ASBF: %s\n",
+				acpi_format_exception(ret));
+		return -ENODEV;
+	}
+	asbf =3D buf.pointer;
+	data->buffer_size =3D asbf->buffer.length;
+	ACPI_FREE(buf.pointer);
+	buf.pointer =3D NULL;
+
+	dev_dbg(dev, "ASBF buffer size: %zu\n", data->buffer_size);
+	/* Sanity check */
+	if (data->buffer_size < 8 || data->buffer_size > 512) {
+		dev_warn(dev, "Invalid ASBF buffer size: %zu\n",
+				data->buffer_size);
+		return -EINVAL;
+	}
+	data->buffer_size +=3D sizeof(union acpi_object);
+
+	data->buffer =3D kzalloc(data->buffer_size, GFP_KERNEL);
+	if (!data->buffer)
+		return -ENOMEM;
+	mutex_init(&data->buffer_lock);
+
 	id.type =3D ACPI_TYPE_INTEGER;
 	id.integer.value =3D ATK_MUX_HWMON;
 	params.count =3D 1;
@@ -737,7 +771,8 @@ static int atk_enumerate_new_hwmon(struct atk_data =
*data)
 	if (ret !=3D AE_OK) {
 		dev_warn(dev, METHOD_ENUMERATE ": ACPI exception: %s\n",
 				acpi_format_exception(ret));
-		return -ENODEV;
+		err =3D -ENODEV;
+		goto out;
 	}
=20
 	/* Result must be a package */
@@ -759,6 +794,8 @@ static int atk_enumerate_new_hwmon(struct atk_data =
*data)
 	err =3D data->voltage_count + data->temperature_count + data->fan_cou=
nt;
=20
 out:
+	if (err < 0)
+		kfree(data->buffer);
 	ACPI_FREE(buf.pointer);
 	return err;
 }
@@ -988,6 +1025,7 @@ static int atk_remove(struct acpi_device *device, =
int type)
 	atk_free_sensors(data);
 	hwmon_device_unregister(data->hwmon_dev);
=20
+	kfree(data->buffer);
 	kfree(data);
=20
 	return 0;


Luca
--=20
The trouble with computers is that they do what you tell them,=20
not what you want.
D. Cohen
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
