From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] Video Extension patch
Date: Thu, 26 Aug 2004 18:21:40 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84054F41D0@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

All,
Since Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> has implemented acpi video
extension filed at bug 1944.
I made some improvement against his code.=20

The patch [1/2] posted here is the original implementation of video
extension written by Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> .
The patch [2/2] posted here is my patch on top of the patch [1/2].=20
Please give it a review, and have it a try.

Thanks=20
Luming

diff -BruN test/2.6-testing/Documentation/power/video_extension.txt
2.6-testing/Documentation/power/video_extension.txt
--- test/2.6-testing/Documentation/power/video_extension.txt
1970-01-01 08:00:00.000000000 +0800
+++ 2.6-testing/Documentation/power/video_extension.txt	2004-08-26
18:32:27.000000000 +0800
@@ -0,0 +1,34 @@
+This driver implement the ACPI Extensions For Display Adapters
+for integrated graphics devices on motherboard, as specified in
+ACPI 2.0 Specification, Appendix B, allowing to perform some basic
+control like defining the video POST device, retrieving EDID
information
+or to setup a video output, etc.  Note that this is an ref.
implementation only.
+It may or may not work for your integrated video device.
+
+Interfaces exposed to userland through /proc/acpi/video:
+
+VGA/info : display the supported video bus device capability like
,Video ROM, CRT/LCD/TV.
+VGA/ROM :  Used to get a copy of the display devices' ROM data (up to
4k).
+VGA/POST_info : Used to determine what options are implemented.
+VGA/POST : Used to get/set POST device.
+VGA/DOS : Used to get/set ownership of output switching:
+	Please refer ACPI spec B.4.1 _DOS
+VGA/CRT : CRT output
+VGA/LCD : LCD output
+VGA/TV : TV output=20
+VGA/*/brightness : Used to get/set brightness of output device
+
+Notify event through /proc/acpi/event:
+
+#define ACPI_VIDEO_NOTIFY_SWITCH        0x80
+#define ACPI_VIDEO_NOTIFY_PROBE         0x81
+#define ACPI_VIDEO_NOTIFY_CYCLE         0x82
+#define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT   0x83
+#define ACPI_VIDEO_NOTIFY_PREV_OUTPUT   0x84
+
+#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS      0x82
+#define ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS        0x83
+#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS        0x84
+#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS       0x85
+#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF           0x86
+
--- test/2.6-testing/drivers/acpi/video.c	2004-08-24
11:05:51.000000000 +0800
+++ 2.6-testing/drivers/acpi/video.c	2004-08-26 18:03:25.000000000
+0800
@@ -42,6 +42,16 @@
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
 #define ACPI_VIDEO_NOTIFY_SWITCH	0x80
 #define ACPI_VIDEO_NOTIFY_PROBE		0x81
+#define ACPI_VIDEO_NOTIFY_CYCLE		0x82
+#define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT	0x83
+#define ACPI_VIDEO_NOTIFY_PREV_OUTPUT	0x84
+
+#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x82
+#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x83
+#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x84
+#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x85
+#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x86
+
=20
 #define ACPI_VIDEO_HEAD_INVALID		(~0ul - 1)
 #define ACPI_VIDEO_HEAD_END		(~0ul)
@@ -58,53 +69,97 @@
 static int acpi_video_bus_remove (struct acpi_device *device, int
type);
 static int acpi_video_bus_match (struct acpi_device *device, struct
acpi_driver *driver);
=20
-
 static struct acpi_driver acpi_video_bus =3D {
-	.name =3D		ACPI_VIDEO_DRIVER_NAME,
-	.class =3D	ACPI_VIDEO_CLASS,
-	.ops =3D		{
-				.add =3D		acpi_video_bus_add,
-				.remove =3D	acpi_video_bus_remove,
-				.match =3D	acpi_video_bus_match,
-			},
+	.name =3D ACPI_VIDEO_DRIVER_NAME,
+	.class =3D ACPI_VIDEO_CLASS,
+	.ops =3D {
+		.add =3D acpi_video_bus_add,
+		.remove =3D acpi_video_bus_remove,
+		.match =3D acpi_video_bus_match,
+	},
 };
=20
 struct acpi_video_bus_flags {
-	u8			multihead:1;	/* can switch video
heads */
-	u8			rom:1;		/* can retrieve a video
rom */
-	u8			post:1;		/* can configure the
head to
-						 * be POSTed at boot */
-	u8			reserved:5;
+	u8	multihead:1;	/* can switch video heads */
+	u8	rom:1;		/* can retrieve a video rom */
+	u8	post:1;		/* can configure the head to */
+	u8	reserved:5;
+};
+
+struct acpi_video_bus_cap {
+	u8	_DOS:1; /*Enable/Disable output switching*/
+	u8	_DOD:1; /*Enumerate all devices attached to display
adapter*/
+	u8	_ROM:1; /*Get ROM Data*/
+	u8	_GPD:1; /*Get POST Device*/
+	u8	_SPD:1; /*Set POST Device*/
+	u8	_VPO:1; /*Video POST Options*/
+	u8	reserved:2;
+};
+
+struct acpi_video_device_attrib{
+	u32	display_index:4; /* A zero-based instance of the
Display*/
+	u32	display_port_attachment:4; /*This field differenates
displays type*/
+	u32	display_type:4;	/*Describe the specific type in use*/
+	u32	vendor_specific:4; /*Chipset Vendor Specifi*/=20
+	u32	bios_can_detect:1; /*BIOS can detect the device*/
+	u32	depend_on_vga:1; /*Non-VGA output device whose power is
related to=20
+				   the VGA device.*/
+	u32	pipe_id:3; /*For VGA multiple-head devices.*/
+	u32	reserved:10; /*Must be 0*/
+	u32	device_id_scheme:1; /*Device ID Scheme*/
+};
+
+struct acpi_video_enumerated_device {
+	union {
+		u32 int_val;
+		struct acpi_video_device_attrib	attrib;
+	} value;
+	struct acpi_video_device *bind_info;
 };
=20
 struct acpi_video_bus {
-	acpi_handle		handle;
-	unsigned long		*device_ids;
+	acpi_handle	handle;
+	u8	dos_setting;
+	struct acpi_video_enumerated_device *attached_array;
+	u8			attached_count;
+	struct acpi_video_bus_cap	cap;
 	struct acpi_video_bus_flags flags;
 	struct semaphore	sem;
-	struct list_head	video_driver_list;
+	struct list_head	video_device_list;
 	struct proc_dir_entry	*dir;
 };
=20
 struct acpi_video_device_flags {
-	u8			crt:1;
-	u8			lcd:1;
-	u8			tvout:1;
-	u8			bios:1;
-	u8			unknown:1;
-	u8			reserved:3;
+	u8	crt:1;
+	u8	lcd:1;
+	u8	tvout:1;
+	u8	bios:1;
+	u8	unknown:1;
+	u8	reserved:3;
+};
+
+struct acpi_video_device_cap {
+	u8	_ADR:1;	/*Return the unique ID */
+	u8	_BCL:1; /*Query list of brightness control levels
supported*/
+	u8	_BCM:1; /*Set the brightness level*/
+	u8	_DDC:1; /*Return the EDID for this device*/
+	u8	_DCS:1; /*Return status of output device*/
+	u8	_DGS:1; /*Query graphics state*/
+	u8	_DSS:1; /*Device state set*/
+	u8	_reserved:1;
 };
=20
 struct acpi_video_device_brightness {
-	int			curr;
-	int			count;
-	int			*levels;
+	int	curr;
+	int	count;
+	int	*levels;
 };
=20
 struct acpi_video_device {
 	acpi_handle		handle;
 	unsigned long		device_id;
 	struct acpi_video_device_flags	flags;
+	struct acpi_video_device_cap	cap;
 	struct list_head	entry;
 	struct acpi_video_bus	*video;
 	struct acpi_device	*dev;
@@ -146,6 +201,14 @@
 };
=20
=20
+static int acpi_video_bus_DOS_open_fs(struct inode *inode, struct file
*file);
+static struct file_operations acpi_video_bus_DOS_fops =3D {
+	.open		=3D acpi_video_bus_DOS_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
 /* device */
 static int acpi_video_device_info_open_fs(struct inode *inode, struct
file *file);
 static struct file_operations acpi_video_device_info_fops =3D {
@@ -179,6 +242,13 @@
 	.release	=3D single_release,
 };
=20
+static void acpi_video_device_notify ( acpi_handle handle, u32 event,
void *data);
+static void acpi_video_device_rebind( struct acpi_video_bus *video);
+static void acpi_video_device_bind( struct acpi_video_bus *video,
struct acpi_video_device *device);
+static int acpi_video_device_enumerate(struct acpi_video_bus *video);
+static int acpi_video_switch_output( struct acpi_video_bus *video, int
event);
+static int acpi_video_get_next_level( struct acpi_video_device *device,
u32 level_current,u32 event);
+static void acpi_video_switch_brightness ( struct acpi_video_device
*device, int event);
=20
=20
 /*
------------------------------------------------------------------------
--
@@ -202,10 +274,12 @@
 static int
 acpi_video_device_get_state (
 	struct acpi_video_device	*device,
-	unsigned long			*state)
+	unsigned long 		*state)
 {
 	int			status;
-	ACPI_FUNCTION_TRACE("acpi_video_device_get_output");
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_get_state");
+
 	status =3D acpi_evaluate_integer(device->handle, "_DCS", NULL,
state);
=20
 	return_VALUE(status);
@@ -220,10 +294,10 @@
 	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
 	struct acpi_object_list	args =3D {1, &arg0};
=20
-	ACPI_FUNCTION_TRACE("acpi_video_device_set_output");
+	ACPI_FUNCTION_TRACE("acpi_video_device_set_state");
=20
 	arg0.integer.value =3D state;
-	status =3D acpi_evaluate_integer(device->handle, "_DCS", &args,
NULL);
+	status =3D acpi_evaluate_integer(device->handle, "_DSS", &args,
NULL);
=20
 	return_VALUE(status);
 }
@@ -282,6 +356,19 @@
 }
=20
 static int
+acpi_video_device_lcd_get_level_current (
+	struct acpi_video_device	*device,
+	unsigned long 	*level)
+{
+	int			status;
+	ACPI_FUNCTION_TRACE("acpi_video_device_lcd_get_level_current");
+
+	status =3D acpi_evaluate_integer(device->handle, "_BQC", NULL,
level);
+
+	return_VALUE(status);
+}
+
+static int
 acpi_video_device_EDID (
 	struct acpi_video_device	*device,
 	union acpi_object		**edid,
@@ -346,7 +433,7 @@
 	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
 	struct acpi_object_list	args =3D {1, &arg0};
=20
-	ACPI_FUNCTION_TRACE("acpi_video_bus_post_set");
+	ACPI_FUNCTION_TRACE("acpi_video_bus_set_POST");
=20
 	arg0.integer.value =3D option;
=20
@@ -364,9 +451,10 @@
 {
 	int status;
=20
-	ACPI_FUNCTION_TRACE("acpi_video_bus_post_get");
+	ACPI_FUNCTION_TRACE("acpi_video_bus_get_POST");
=20
 	status =3D acpi_evaluate_integer(video->handle, "_GPD", NULL, id);
+
 	return_VALUE(status);
 }
=20
@@ -376,7 +464,7 @@
 	unsigned long		*options)
 {
 	int			status;
-	ACPI_FUNCTION_TRACE("acpi_video_bus_post_options");
+	ACPI_FUNCTION_TRACE("acpi_video_bus_POST_options");
=20
 	status =3D acpi_evaluate_integer(video->handle, "_VPO", NULL,
options);
 	*options &=3D 3;
@@ -384,34 +472,187 @@
 	return_VALUE(status);
 }
=20
+/*
+ *  Arg:
+ *  	video		: video bus device pointer
+ *	bios_flag	:=20
+ *		0.	The system BIOS should NOT automatically
switch(toggle)
+ *			the active display output.
+ *		1.	The system BIOS should automatically switch
(toggle) the
+ *			active display output. No swich event.
+ *		2.	The _DGS value should be locked.
+ *		3.	The system BIOS should not automatically switch
(toggle) the
+ *			active display output, but instead generate the
display switch
+ *			event notify code.
+ *	lcd_flag	:
+ *		0.	The system BIOS should automatically control the
brightness level
+ *			of the LCD, when the power changes from AC to DC
+ *		1. 	The system BIOS should NOT automatically control
the brightness=20
+ *			level of the LCD, when the power changes from AC
to DC.
+ * Return Value:
+ * 		-1	wrong arg.
+ */
+
 static int
-acpi_video_bus_ownership (
+acpi_video_bus_DOS(
 	struct acpi_video_bus	*video,
-	int			get,
-	int			lcd)
+	int			bios_flag,
+	int			lcd_flag)
 {
-	acpi_integer		status;
+	acpi_integer		status =3D 0;
 	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
 	struct acpi_object_list	args =3D {1, &arg0};
=20
-	ACPI_FUNCTION_TRACE("acpi_video_bus_ownership");
-
-	arg0.integer.value =3D (lcd << 2) | (get << 0);
+	ACPI_FUNCTION_TRACE("acpi_video_bus_DOS");
=20
-	status =3D acpi_evaluate_object(video->handle, "_DOS", &args,
NULL);
+	if (bios_flag < 0 || bios_flag >3 || lcd_flag < 0 || lcd_flag >
1){
+		status =3D -1;
+		goto Failed;
+	}
+	arg0.integer.value =3D (lcd_flag << 2) | bios_flag;
+	video->dos_setting =3D arg0.integer.value;
+	acpi_evaluate_object(video->handle, "_DOS", &args, NULL);
=20
+Failed:
 	return_VALUE(status);
 }
=20
+/*
+ *  Arg:=09
+ *  	device	: video output device (LCD, CRT, ..)
+ *
+ *  Return Value:
+ *  	None
+ *
+ *  Find out all required AML method defined under the output
+ *  device.
+ */
+
+static void
+acpi_video_device_find_cap (struct acpi_video_device *device)
+{
+	acpi_integer		status;
+	acpi_handle h_dummy1;
+	int i;
+	union acpi_object *obj =3D NULL;
+	struct acpi_video_device_brightness *br =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_find_cap");
+
+	memset( &device->cap, 0, 4);
+
+    	if( ACPI_SUCCESS(acpi_get_handle(device->handle, "_ADR",
&h_dummy1))) {
+		device->cap._ADR =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCL",
&h_dummy1))) {
+		device->cap._BCL=3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCM",
&h_dummy1))) {
+		device->cap._BCM=3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(device->handle, "_DDC",
&h_dummy1))) {
+		device->cap._DDC=3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(device->handle, "_DCS",
&h_dummy1))) {
+		device->cap._DCS =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(device->handle, "_DGS",
&h_dummy1))) {
+		device->cap._DGS =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(device->handle, "_DSS",
&h_dummy1))) {
+		device->cap._DSS =3D 1;
+	}
+
+	status =3D acpi_video_device_lcd_query_levels(device, &obj);
+
+	if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package.count
>=3D 2) {
+		int count =3D 0;
+		union acpi_object *o;
+	=09
+		br =3D kmalloc(sizeof &br, GFP_KERNEL);
+		if (!br) {
+			printk(KERN_ERR "can't allocate memory\n");
+		} else {
+			memset(br, 0, sizeof &br);
+			br->levels =3D kmalloc(obj->package.count * sizeof
&br->levels, GFP_KERNEL);
+			if (!br->levels)
+				goto out;
+
+			for (i =3D 0; i < obj->package.count; i++) {
+				o =3D (union acpi_object *)
&obj->package.elements[i];
+				if (o->type !=3D ACPI_TYPE_INTEGER) {
+					ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
"Invalid data\n"));
+					continue;
+				}
+				br->levels[count] =3D (u32)
o->integer.value;
+				count++;
+			}
+out:
+			if (count < 2) {
+				if (br->levels)
+					kfree(br->levels);
+				kfree(br);
+			} else {
+				br->count =3D count;
+				device->brightness =3D br;
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "found
%d brightness levels\n", count));
+			}
+		}
+	}
+
+	if (obj)
+		kfree(obj);
+
+	return_VOID;
+}
+
+/*
+ *  Arg:=09
+ *  	device	: video output device (VGA)
+ *
+ *  Return Value:
+ *  	None
+ *
+ *  Find out all required AML method defined under the video bus
device.
+ */
+
+static void=20
+acpi_video_bus_find_cap (struct acpi_video_bus *video)
+{
+	acpi_handle	h_dummy1;
+
+	memset(&video->cap ,0, 4);
+    	if( ACPI_SUCCESS(acpi_get_handle(video->handle, "_DOS",
&h_dummy1))) {
+		video->cap._DOS =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(video->handle, "_DOD",
&h_dummy1))) {
+		video->cap._DOD =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(video->handle, "_ROM",
&h_dummy1))) {
+		video->cap._ROM =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(video->handle, "_GPD",
&h_dummy1))) {
+		video->cap._GPD =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(video->handle, "_SPD",
&h_dummy1))) {
+		video->cap._SPD =3D 1;
+	}
+    	if( ACPI_SUCCESS(acpi_get_handle(video->handle, "_VPO",
&h_dummy1))) {
+		video->cap._VPO =3D 1;
+	}
+}
+
+/*
+ * Check whether the video bus device has required AML method to
+ * support the desired features
+ */
+
 static int
 acpi_video_bus_check (
 	struct acpi_video_bus	*video)
 {
 	acpi_status		status =3D -ENOENT;
=20
-	acpi_handle		h_dummy1;
-	acpi_handle		h_dummy2;
-	acpi_handle		h_dummy3;
=20
 	ACPI_FUNCTION_TRACE("acpi_video_bus_check");
=20
@@ -423,22 +664,19 @@
 	 */
=20
 	/* Does this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(video->handle, "_DOD",
&h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(video->handle, "_DOS",
&h_dummy2))) {
+	if(video->cap._DOS){
 		video->flags.multihead =3D 1;
 		status =3D 0;
 	}
=20
 	/* Does this device able to retrieve a retrieve a video ROM ? */
-	if (ACPI_SUCCESS(acpi_get_handle(video->handle, "_ROM",
&h_dummy1))) {
+	if(video->cap._ROM){
 		video->flags.rom =3D 1;
 		status =3D 0;
 	}
=20
 	/* Does this device able to configure which video device to POST
? */
-	if (ACPI_SUCCESS(acpi_get_handle(video->handle, "_VPO",
&h_dummy1)) &&
-	    ACPI_SUCCESS(acpi_get_handle(video->handle, "_GPD",
&h_dummy2)) &&
-	    ACPI_SUCCESS(acpi_get_handle(video->handle, "_SPD",
&h_dummy3))) {
+	if(video->cap._GPD && video->cap._SPD && video->cap._VPO){
 		video->flags.post =3D 1;
 		status =3D 0;
 	}
@@ -500,7 +737,7 @@
 {
 	int			status;
 	struct acpi_video_device	*dev =3D (struct acpi_video_device
*) seq->private;
-	unsigned long		state;
+	unsigned long	state;
=20
 	ACPI_FUNCTION_TRACE("acpi_video_device_state_seq_show");
=20
@@ -904,6 +1141,20 @@
 	return_VALUE(0);
 }
=20
+static ssize_t
+acpi_video_bus_DOS_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *)
seq->private;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_DOS_seq_show");
+
+	seq_printf(seq, "DOS setting: <%d>\n", video->dos_setting );
+
+	return_VALUE(0);
+}
+
 static int
 acpi_video_bus_POST_open_fs (
 	struct inode		*inode,
@@ -912,6 +1163,14 @@
 	return single_open(file, acpi_video_bus_POST_seq_show,
PDE(inode)->data);
 }
=20
+static int
+acpi_video_bus_DOS_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_bus_DOS_seq_show,
PDE(inode)->data);
+}
+
 static ssize_t
 acpi_video_bus_write_POST (
 	struct file		*file,
@@ -957,6 +1216,41 @@
 	return_VALUE(count);
 }
=20
+static ssize_t
+acpi_video_bus_write_DOS (
+	struct file		*file,
+	const char		__user *buffer,
+	size_t			count,
+	loff_t			*data)
+{
+	int			status;
+	struct seq_file		*m =3D (struct seq_file *)
file->private_data;
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *)
m->private;
+	char			str[12] =3D {0};
+	unsigned long		opt, options;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_write_DOS");
+
+
+	if (!video || count + 1 > sizeof str)
+		return_VALUE(-EINVAL);
+
+	if (copy_from_user(str, buffer, count))
+		return_VALUE(-EFAULT);
+
+	str[count] =3D 0;
+	opt =3D strtoul(str, NULL, 0);
+	if (opt > 7)
+		return_VALUE(-EFAULT);
+
+	status =3D acpi_video_bus_DOS (video, opt & 0x3, (opt & 0x4)>>2);
+
+	if (!ACPI_SUCCESS(status))
+		return_VALUE(-EFAULT);
+
+	return_VALUE(count);
+}
+
 static int
 acpi_video_bus_add_fs (
 	struct acpi_device	*device)
@@ -1014,6 +1308,16 @@
 		entry->data =3D acpi_driver_data(device);
 	}
=20
+	/* 'DOS' [R/W] */
+	entry =3D create_proc_entry("DOS", S_IFREG|S_IRUGO|S_IRUSR,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to create 'DOS'
fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_bus_DOS_fops;
+		entry->proc_fops->write =3D acpi_video_bus_write_DOS;
+		entry->data =3D acpi_driver_data(device);
+	}
+
 	return_VALUE(0);
 }
=20
@@ -1043,7 +1347,7 @@
 	struct acpi_video_bus	*video)
 {
 	unsigned long		device_id;
-	int			status;
+	int			status, result;
 	struct acpi_video_device	*data;
=20
 	ACPI_FUNCTION_TRACE("acpi_video_bus_get_one_device");
@@ -1053,9 +1357,6 @@
=20
 	status =3D acpi_evaluate_integer(device->handle, "_ADR", NULL,
&device_id);
 	if (ACPI_SUCCESS(status)) {
-		int i;
-		union acpi_object *obj =3D NULL;
-		struct acpi_video_device_brightness *br =3D NULL;
=20
 		data =3D kmalloc(sizeof(struct acpi_video_device),
GFP_KERNEL);
 		if (!data)
@@ -1076,7 +1377,7 @@
 		case 0x0100:
 			data->flags.crt =3D 1;
 			break;
-		case 0x0110:
+		case 0x0400:
 			data->flags.lcd =3D 1;
 			break;
 		case 0x0200:
@@ -1086,55 +1387,21 @@
 			data->flags.unknown =3D 1;
 			break;
 		}
+	=09
+		acpi_video_device_bind(video, data);
+		acpi_video_device_find_cap(data);
=20
-		for (i =3D 0; video->device_ids[i] !=3D
ACPI_VIDEO_HEAD_INVALID && i < 10; i++) {
-			if (device_id =3D=3D (video->device_ids[i] &
0xffff)) {
-				data->flags.bios =3D video->device_ids[i]
& 0x00010000 ? 1:0;
-				break;
-			}
-		}
-
-		status =3D acpi_video_device_lcd_query_levels(data, &obj);
-		if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE &&
obj->package.count >=3D 2) {
-			int count =3D 0;
-			union acpi_object *o;
-		=09
-			br =3D kmalloc(sizeof &br, GFP_KERNEL);
-			if (!br) {
-				printk(KERN_ERR "can't allocate
memory\n");
-			} else {
-				memset(br, 0, sizeof &br);
-				br->levels =3D kmalloc(obj->package.count
* sizeof &br->levels, GFP_KERNEL);
-				if (!br->levels)
-					goto out;
-
-				for (i =3D 0; i < obj->package.count; i++)
{
-					o =3D (union acpi_object *)
&obj->package.elements[i];
-					if (o->type !=3D
ACPI_TYPE_INTEGER) {
-
ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
-						continue;
-					}
-					br->levels[count] =3D (u32)
o->integer.value;
-					count++;
-				}
-out:
-				if (count < 2) {
-					if (br->levels)
-						kfree(br->levels);
-					kfree(br);
-				} else {
-					br->count =3D count;
-					data->brightness =3D br;
-					ACPI_DEBUG_PRINT((ACPI_DB_INFO,
"found %d brightness levels\n", count));
-				}
-			}
+		status =3D acpi_install_notify_handler(data->handle,
+			ACPI_DEVICE_NOTIFY, acpi_video_device_notify,
data);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error installing notify handler\n"));
+			result =3D -ENODEV;
+			goto end;
 		}
=20
-		if (obj)
-			kfree(obj);
-
 		down(&video->sem);
-		list_add_tail(&data->entry, &video->video_driver_list);
+		list_add_tail(&data->entry, &video->video_device_list);
 		up(&video->sem);
=20
 		acpi_video_device_add_fs(device);
@@ -1142,24 +1409,88 @@
 		return_VALUE(0);
 	}
=20
+end:
 	return_VALUE(-ENOENT);
 }
=20
-static int
-acpi_video_bus_get_devices (
-	struct acpi_video_bus	*video,
-	struct acpi_device	*device)
+/*
+ *  Arg:
+ *  	video	: video bus device=20
+ *
+ *  Return:
+ *  	none
+ * =20
+ *  Enumerate the video device list of the video bus,=20
+ *  bind the ids with the corresponding video devices
+ *  under the video bus.
+ */ =20
+
+static void
+acpi_video_device_rebind( struct acpi_video_bus *video)
+{
+	struct list_head * node, * next;
+	list_for_each_safe(node, next, &video->video_device_list) {
+		struct acpi_video_device * dev =3D container_of(node,
struct acpi_video_device, entry);
+		acpi_video_device_bind( video, dev);
+	}
+}
+
+/*
+ *  Arg:
+ *  	video	: video bus device=20
+ *  	device	: video output device under the video=20
+ *  		bus
+ *
+ *  Return:
+ *  	none
+ * =20
+ *  Bind the ids with the corresponding video devices
+ *  under the video bus.
+ */ =20
+
+static void
+acpi_video_device_bind( struct acpi_video_bus *video,
+			struct acpi_video_device *device)
+{
+	int	i;
+	ACPI_FUNCTION_TRACE("acpi_video_device_bind");
+
+#define IDS_VAL(i) video->attached_array[i].value.int_val
+#define IDS_BIND(i) video->attached_array[i].bind_info
+=09
+	for (i =3D 0; IDS_VAL(i) !=3D ACPI_VIDEO_HEAD_INVALID &&=20
+		i < video->attached_count; i++) {
+		if (device->device_id =3D=3D (IDS_VAL(i)& 0xffff)) {
+			IDS_BIND(i) =3D device;
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "device_bind
%d\n", i));
+		}
+	}
+#undef IDS_VAL
+#undef IDS_BIND
+}
+
+/*
+ *  Arg:
+ *  	video	: video bus device=20
+ *
+ *  Return:
+ *  	< 0	: error
+ * =20
+ *  Call _DOD to enumerate all devices attached to display adapter
+ *
+ */ =20
+
+static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 {
 	int			status;
 	int			count;
 	int			i;
-	unsigned long		*device_ids;
+	struct acpi_video_enumerated_device *active_device_list;
 	struct acpi_buffer	buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object	*dod =3D NULL;
 	union acpi_object	*obj;
-	struct list_head	*node, *next;
=20
-	ACPI_FUNCTION_TRACE("acpi_video_get_devices");
+	ACPI_FUNCTION_TRACE("acpi_video_device_enumerate");
=20
 	status =3D acpi_evaluate_object(video->handle, "_DOD", NULL,
&buffer);
 	if (!ACPI_SUCCESS(status)) {
@@ -1177,8 +1508,11 @@
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d video heads in
_DOD\n",
 		dod->package.count));
=20
-	device_ids =3D kmalloc(dod->package.count * sizeof(device_ids[0]),
GFP_KERNEL);
-	if (!device_ids) {
+	active_device_list=3D kmalloc(
+ 		dod->package.count*sizeof(struct
acpi_video_enumerated_device),
+	       	GFP_KERNEL);
+
+	if (!active_device_list) {
 		status =3D -ENOMEM;
 		goto out;
 	}
@@ -1189,14 +1523,113 @@
=20
 		if (obj->type !=3D ACPI_TYPE_INTEGER) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _DOD
data\n"));
-			device_ids[i] =3D ACPI_VIDEO_HEAD_INVALID;
+			active_device_list[i].value.int_val =3D
ACPI_VIDEO_HEAD_INVALID;
 		}
-
-		device_ids[i] =3D obj->integer.value;
+		active_device_list[i].value.int_val =3D
obj->integer.value;
+		active_device_list[i].bind_info =3D NULL;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] =3D
%d\n", i, obj->integer.value));
 		count++;
 	}
-	device_ids[count] =3D ACPI_VIDEO_HEAD_END;
-	video->device_ids =3D device_ids;
+	active_device_list[count].value.int_val =3D ACPI_VIDEO_HEAD_END;
+
+	if(video->attached_array)
+		kfree(video->attached_array);
+=09
+	video->attached_array =3D active_device_list;
+	video->attached_count =3D count;
+out:
+	acpi_os_free(buffer.pointer);
+	return_VALUE(status);
+}
+
+/*
+ *  Arg:
+ *  	video	: video bus device=20
+ *  	event	: Nontify Event
+ *
+ *  Return:
+ *  	< 0	: error
+ * =20
+ *	1. Find out the current active output device.
+ *	2. Identify the next output device to switch
+ *	3. call _DSS to do actual switch.
+ */ =20
+
+static int=20
+acpi_video_switch_output(
+	struct acpi_video_bus *video,=20
+	int	event)
+{
+	struct list_head * node, * next;
+	struct acpi_video_device *dev=3DNULL;
+       	struct acpi_video_device *dev_next=3DNULL;
+	struct acpi_video_device *dev_prev=3DNULL;
+	unsigned long state;
+	int status =3D 0;
+
+	ACPI_FUNCTION_TRACE("acpi_video_switch_output");
+
+	list_for_each_safe(node, next, &video->video_device_list) {
+		struct acpi_video_device * dev =3D container_of(node,
struct acpi_video_device, entry);
+		status =3D acpi_video_device_get_state(dev, &state);
+		if (state & 0x2){
+			dev_next =3D container_of(node->next, struct
acpi_video_device, entry);
+			dev_prev =3D container_of(node->prev, struct
acpi_video_device, entry);
+			goto out;
+		}
+	}
+	dev_next =3D container_of(node->next, struct acpi_video_device,
entry);
+	dev_prev =3D container_of(node->prev, struct acpi_video_device,
entry);
+out:=09
+	switch (event) {
+	case ACPI_VIDEO_NOTIFY_CYCLE:
+	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:
+		acpi_video_device_set_state(dev, 0);
+		acpi_video_device_set_state(dev_next, 0x80000001);
+		break;
+	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:
+		acpi_video_device_set_state(dev, 0);
+		acpi_video_device_set_state(dev_prev, 0x80000001);
+	default:
+		break;
+	}
+
+	return_VALUE(status);
+}
+
+static int=20
+acpi_video_get_next_level(
+	struct acpi_video_device *device,
+	u32	level_current,
+	u32	event)
+{
+	/*Fix me*/
+	return level_current;
+}
+
+
+static void
+acpi_video_switch_brightness (
+	struct acpi_video_device *device,=20
+	int	event)
+{
+	unsigned long level_current, level_next;
+	acpi_video_device_lcd_get_level_current(device, &level_current);
+	level_next =3D acpi_video_get_next_level(device, level_current,
event);
+	acpi_video_device_lcd_set_level(device, level_next);
+}
+
+static int
+acpi_video_bus_get_devices (
+	struct acpi_video_bus	*video,
+	struct acpi_device	*device)
+{
+	int			status =3D 0;
+	struct list_head	*node, *next;
+
+	ACPI_FUNCTION_TRACE("acpi_video_get_devices");
+
+	acpi_video_device_enumerate(video);
=20
 	list_for_each_safe(node, next, &device->children) {
 		struct acpi_device *dev =3D list_entry(node, struct
acpi_device, node);
@@ -1211,11 +1644,6 @@
 		}
=20
 	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found valid %d video heads\n",
count));
-
-out:
-	acpi_os_free(buffer.pointer);
 	return_VALUE(status);
 }
=20
@@ -1249,7 +1677,7 @@
=20
 	ACPI_FUNCTION_TRACE("acpi_video_bus_put_devices");
=20
-	list_for_each_safe(node, next, &video->video_driver_list) {
+	list_for_each_safe(node, next, &video->video_device_list) {
 		struct acpi_video_device *data =3D list_entry(node, struct
acpi_video_device, entry);
 		if (!data)
 			continue;
@@ -1273,14 +1701,14 @@
 acpi_video_bus_start_devices(
 	struct acpi_video_bus	*video)
 {
-	return acpi_video_bus_ownership(video, 1, 0);
+	return acpi_video_bus_DOS(video, 1, 0);
 }
=20
 static int
 acpi_video_bus_stop_devices(
 	struct acpi_video_bus	*video)
 {
-	return acpi_video_bus_ownership(video, 0, 1);
+	return acpi_video_bus_DOS(video, 0, 1);
 }
=20
 static void
@@ -1289,10 +1717,11 @@
 	u32			event,
 	void			*data)
 {
-	struct acpi_video	*video =3D (struct acpi_video *) data;
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *) data;
 	struct acpi_device	*device =3D NULL;
=20
 	ACPI_FUNCTION_TRACE("acpi_video_bus_notify");
+	printk("video bus notify\n");
=20
 	if (!video)
 		return_VOID;
@@ -1303,14 +1732,24 @@
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User request that a switch
occur,
 					 * most likely via hotkey. */
-		printk(KERN_INFO "acpi_video: notify switch received:
please implement me.\n");
-
+		acpi_bus_generate_event(device, event, 0);
 		break;
+
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plug or remove a video
 					 * connector. */
-		printk(KERN_INFO "acpi_video: notify reprobe received:
please implement me.\n");
+		acpi_video_device_enumerate(video);
+		acpi_video_device_rebind(video);
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
+		break;
=20
+	case ACPI_VIDEO_NOTIFY_CYCLE: /* Cycle Display output hotkey
pressed.*/
+	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT: /* Next Display output
hotkey pressed. */
+	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT: /* previous Display output
hotkey pressed. */
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
 		break;
+
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			"Unsupported event [0x%x]\n", event));
@@ -1320,6 +1759,45 @@
 	return_VOID;
 }
=20
+static void
+acpi_video_device_notify (
+	acpi_handle		handle,
+	u32			event,
+	void			*data)
+{
+	struct acpi_video_device	*video_device =3D (struct
acpi_video_device *) data;
+	struct acpi_device	*device =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_notify");
+
+	printk("video device notify\n");
+	if (!video_device)
+		return_VOID;
+
+	if (acpi_bus_get_device(handle, &device))
+		return_VOID;
+
+	switch (event) {
+	case ACPI_VIDEO_NOTIFY_SWITCH: /* change in status (cycle output
device) */
+	case ACPI_VIDEO_NOTIFY_PROBE: /* change in status (output device
status) */
+		acpi_bus_generate_event(device, event, 0);
+		break;
+	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS: /* Cycle brightness */
+	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS: /* Increase brightness */
+	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS: /* Decrease brightness */
+	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS: /* zero brightnesss */
+	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF: /* display device off */
+		acpi_video_switch_brightness (video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		break;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Unsupported event [0x%x]\n", event));
+		break;
+	}
+	return_VOID;
+}
+
 static int
 acpi_video_bus_add (
 	struct acpi_device	*device)
@@ -1343,6 +1821,7 @@
 	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 	acpi_driver_data(device) =3D video;
=20
+	acpi_video_bus_find_cap(video);
 	result =3D acpi_video_bus_check(video);
 	if (result)
 		goto end;
@@ -1352,7 +1831,7 @@
 		goto end;
=20
 	init_MUTEX(&video->sem);
-	INIT_LIST_HEAD(&video->video_driver_list);
+	INIT_LIST_HEAD(&video->video_device_list);
=20
 	acpi_video_bus_get_devices(video, device);
 	acpi_video_bus_start_devices(video);
@@ -1407,8 +1886,8 @@
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
=20
-	if (video->device_ids)
-		kfree(video->device_ids);
+	if (video->attached_array)
+		kfree(video->attached_array);
 	kfree(video);
=20
 	return_VALUE(0);
@@ -1460,6 +1939,11 @@
=20
 	ACPI_FUNCTION_TRACE("acpi_video_init");
=20
+	/*
+	acpi_dbg_level =3D 0xFFFFFFFF;
+	acpi_dbg_layer =3D 0x08000000;
+	*/
+
 	acpi_video_dir =3D proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
 	if (!acpi_video_dir)
 		return_VALUE(-ENODEV);


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
