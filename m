From: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver
Date: Sat, 21 Aug 2004 23:45:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41284119.1060504@linuxboxen.org>
References: <41244219.1090603@linuxboxen.org> <87zn4pl116.wl%miura@da-cha.org>
 <87n00pkqc5.wl%miura@da-cha.org> <41270B53.3060903@linuxboxen.org>
 <87d61klqzh.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------080001090605000209010907
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <87d61klqzh.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, letsnote-tech-eXqGM+LsbTTAqL8d+zIrHngSJqDPrsil@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080001090605000209010907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hiroshi Miura wrote:

>At Sat, 21 Aug 2004 01:44:03 -0700,
>David Bronaugh wrote:
>  
>
>>OK, this all makes sense now. It seems like the best way to do screen 
>>brightness setting would be to read fields 2 and 3 from SINF into 
>>internal fields (pcc_max_bright and pcc_min_bright?) to check user input 
>>and make sure it is not outside these bounds.
>>    
>>
>
>these are ok?
>
>pcc_ac_max_bright
>pcc_ac_min_bright
>pcc_dc_max_bright
>pcc_dc_min_bright
>  
>
In my patch, I took off the "pcc" prefix -- I felt it was unnecessary because the name the driver uses in /proc/acpi is "pcc".

I also modified the names slightly; if you don't like them, you can change them.

>>I don't think it is necessary to adjust (or read) fields 5 6 and 7 -- 
>>could you confirm on your R3 that these are not necessary (try the 
>>things I tried on my R1N)? If you can confirm this, we can simplify the 
>>driver to only expose 1 field for the 'brightness' control.
>>    
>>
>
>I think it is necessary to adjuct field 5 6 and 7.
>This sinf is kept through hibernate/power off and on.
>BIOS show this field when boot or resume and set brightness according as power state.
>
>
>  
>
Yes, I noticed that the SINF does persist over reboots.

The attached patch is against Hiroshi's v0.5 code, and does the following:
 - gives access (via a simple interface) to all the fields in SINF that 
are available on the person's laptop
 - cleans up the coding style to bring it closer to 
Documentation/CodingStyle guidelines
 - cleans up a few messy spots in the code
 - corrects typographic errors
 - documents some of the stranger SINF fields in the code
 - makes an attempt at cleaning up error messages
 - centralizes data structure definitions at the top of the file
 - removes the global 'sinf' variable (I left the 'num_sifr' variable alone)
 - moves the call to acpi_pcc_proc_init to avoid a possible use of 
uninitialized data via the /proc interface

I didn't decide to put code in the driver to make the R1N look like all 
the others; this could be a TODO (though I like having access to all 235 
brightness levels).

I also haven't really cleaned up the error messages enough -- hopefully 
this can happen later. Nor have I unified all the naming conventions -- 
the driver still has an identity crisis (it isn't sure if it's ACPI_PCC, 
pcc_acpi, or HOTKEY).

Someone should run scripts/Lintain on the code, too, to clean up 
inconsistencies.

I have also attached a separate patch which cleans up the in-kernel 
help. Later today (or maybe tomorrow; I'm getting tired) I'll send 
scripts which handle all the hotkey events properly; then these can be 
put up on the website.

David Bronaugh

--------------080001090605000209010907
Content-Type: text/x-patch;
 name="pcc-0.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcc-0.6.patch"

diff -Nru la-2.6.8.1/drivers/acpi/pcc_acpi.c linux-2.6.8.1/drivers/acpi/pcc_acpi.c
--- la-2.6.8.1/drivers/acpi/pcc_acpi.c	2004-08-20 13:20:49.000000000 -0700
+++ linux-2.6.8.1/drivers/acpi/pcc_acpi.c	2004-08-21 22:52:32.000000000 -0700
@@ -20,6 +20,11 @@
  *---------------------------------------------------------------------------
  *
  * ChangeLog:
+ *      Aug.20, 2004    David Bronaugh
+ *              - v0.6  Correct brightness controls to reflect reality
+ *                      based on information gleaned by Hiroshi Miura
+ *                      and discussions with Hiroshi Miura
+ *
  *	Aug.10, 2004	Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
  *		- v0.5  support LCD brightness control
  *			based on the disclosed information by MEI.
@@ -39,7 +44,7 @@
  *
  */
 
-#define ACPI_PCC_VERSION	"0.5"
+#define ACPI_PCC_VERSION	"0.6"
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -56,10 +61,10 @@
 ACPI_MODULE_NAME		("pcc_acpi")
 
 MODULE_AUTHOR("Hiroshi Miura");
-MODULE_DESCRIPTION("ACPI HotKey driver for lets note");
+MODULE_DESCRIPTION("ACPI HotKey driver for Panasonic Lets Note laptops");
 MODULE_LICENSE("GPL");
 
-#define LOGPREFIX "acpi_pcc: "
+#define LOGPREFIX "pcc_acpi: "
 
 /****************************************************
  * Define ACPI PATHs 
@@ -81,15 +86,24 @@
 #define PROC_PCC		"pcc"
 #define PROC_VIDEO "video"
 
-#define ACPI_HOTKEY_DRIVER_NAME "PCC HotKey Driver"
+#define ACPI_PCC_DRIVER_NAME "PCC HotKey Driver"
 #define ACPI_HOTKEY_DEVICE_NAME "HotKey"
 #define ACPI_HOTKEY_CLASS "HKEY"
 
+/* LCD_TYPEs: 0 = Normal, 1 = Semi-transparent
+   ENV_STATEs: Normal temp=0x01, High temp=0x81, N/A=0x00 
+*/
+enum SINF_BITS { SINF_NUM_BATTERIES, SINF_LCD_TYPE, SINF_AC_MAX_BRIGHT, 
+		 SINF_AC_MIN_BRIGHT, SINF_AC_CUR_BRIGHT, SINF_DC_MAX_BRIGHT,
+		 SINF_DC_MIN_BRIGHT, SINF_DC_CUR_BRIGHT, SINF_MUTE,
+		 SINF_RESERVED,      SINF_ENV_STATE,
+};
+
 static int acpi_pcc_hotkey_add (struct acpi_device *device);
 static int acpi_pcc_hotkey_remove (struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_hotkey_driver = {
-	.name =		ACPI_HOTKEY_DRIVER_NAME,
+	.name =		ACPI_PCC_DRIVER_NAME,
 	.class =	ACPI_HOTKEY_CLASS,
 	.ids =		HKEY_HID,
 	.ops =		{
@@ -104,8 +118,17 @@
 	unsigned long		status;
 };
 
-static int
-write_sset(int func, int val)
+typedef struct _ProcItem
+{
+	const char* name;
+	char* (*read_func)(char*);
+	unsigned long (*write_func)(const char*, unsigned long);
+} ProcItem;
+
+static int num_sifr;
+static struct proc_dir_entry* acpi_pcc_dir;
+
+static int write_sset(int func, int val)
 {
 	struct acpi_object_list params;
 	union acpi_object in_objs[2];
@@ -124,8 +147,7 @@
 	return_VALUE(status == AE_OK);
 }
 
-static int
-read_acpi_int(acpi_handle handle, const char* methodName, int* pVal)
+static int read_acpi_int(acpi_handle handle, const char* methodName, int* pVal)
 {
 	struct acpi_buffer results;
 	union acpi_object out_objs[1];
@@ -136,55 +158,49 @@
 
 	status = acpi_evaluate_object(handle, (char*)methodName, 0, &results);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_INFO "acpi evaluate error on %s\n", methodName);
+		printk(KERN_INFO LOGPREFIX "acpi evaluate error on %s\n", 
+		       methodName);
 		return (-EFAULT);
 	}
 
 	if (out_objs[0].type == ACPI_TYPE_INTEGER) {
 		*pVal = out_objs[0].integer.value;
 	} else {
-		printk(KERN_INFO "return value is not int\n");
+		printk(KERN_INFO LOGPREFIX "return value is not int\n");
 		status = AE_ERROR;
 	}
 
 	return (status == AE_OK);
 }
 
-static struct proc_dir_entry*	acpi_pcc_dir;
-
-typedef struct _ProcItem
-{
-	const char* name;
-	char* (*read_func)(char*);
-	unsigned long (*write_func)(const char*, unsigned long);
-} ProcItem;
-
-
 /* register utils for proc handler */
-static int
-dispatch_read(char* page, char** start, off_t off, int count, int* eof,
-	ProcItem* item)
+static int dispatch_read(char* page, char** start, off_t off, int count, 
+			 int* eof, ProcItem* item)
 {
 	char* p = page;
 	int len;
 
-	if (off == 0) {
-		if (item->read_func)
-			p = item->read_func(p);
+	if (off == 0 && item->read_func) {
+		p = item->read_func(p);
 	}
 
 	/* ISSUE: I don't understand this code */
 	len = (p - page);
-	if (len <= off+count) *eof = 1;
+	if (len <= off+count) {
+		*eof = 1;
+	}
 	*start = page + off;
 	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
+	if (len > count) {
+		len = count;
+	}
+	if (len < 0) {
+		len = 0;
+	}
 	return len;
 }
 
-static int
-dispatch_write(struct file* file, __user const char* buffer,
+static int dispatch_write(struct file* file, __user const char* buffer,
 	unsigned long count, ProcItem* item)
 {
 	int result;
@@ -197,8 +213,7 @@
 	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
 	if (copy_from_user(tmp_buffer, buffer, count)) {
 		result = -EFAULT;
-	}
-	else {
+	} else {
 		tmp_buffer[count] = 0;
 		result = item->write_func(tmp_buffer, count);
 	}
@@ -206,41 +221,34 @@
 	return result;
 }
 
-static int* sinf;
-static int num_sifr;
-
-static int
-acpi_pcc_init_sinf_buffer(void)
+static inline int acpi_pcc_get_sqty(void) 
 {
-	acpi_status status = AE_OK;
-
-	ACPI_FUNCTION_TRACE("acpi_pcc_init_sinf_buffer");
+	int s;
 
-	if (!read_acpi_int(NULL, DEVICE_NAME_HKEY "." METHOD_HKEY_SQTY, &num_sifr)){
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "evaluation error HKEY.SQTY\n"));
-		return_VALUE(-EINVAL);
-	}
+	ACPI_FUNCTION_TRACE("acpi_pcc_get_sqty");
 
-	if ((sinf = (int*)kmalloc(sizeof(int) * (num_sifr + 1), GFP_KERNEL)) == NULL ) {
-		status = AE_ERROR;
+	if (read_acpi_int(NULL, DEVICE_NAME_HKEY "." METHOD_HKEY_SQTY, &s)) {
+		return s;
+	} else {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
+				  "evaluation error HKEY.SQTY\n"));
+		return -EINVAL;
 	}
 	
-	return_VALUE(status == AE_OK);
 }
 
-static int
-acpi_pcc_retrive_biosdata(void) 
+static int acpi_pcc_retrieve_biosdata(u32* sinf) 
 {
 	acpi_status status;
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *hkey = NULL;
 	int i;
 
-	ACPI_FUNCTION_TRACE("acpi_pcc_retrive_biosdata");
+	ACPI_FUNCTION_TRACE("acpi_pcc_retrieve_biosdata");
 
 	status = acpi_evaluate_object(NULL, DEVICE_NAME_HKEY "." METHOD_HKEY_SINF, 0 , &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "evaluation error HEKY.SINF\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "evaluation error HKEY.SINF\n"));
 		return_VALUE(0);
 	}
 
@@ -259,7 +267,7 @@
 	for (i = 0; i < hkey->package.count; i++) {
 		union acpi_object *element = &(hkey->package.elements[i]);
 		if (likely(element->type == ACPI_TYPE_INTEGER)) {
-			sinf[i] = (int)element->integer.value;
+			sinf[i] = element->integer.value;
 		} else 
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid HKEY.SINF data\n"));
 	}
@@ -270,91 +278,160 @@
 	return_VALUE(status == AE_OK);
 }
 
-static char*
-acpi_pcc_read_brightness(char* p)
+static char* acpi_pcc_read_sinf_field(char* p, int field) 
 {
-	int i;
+	u32* sinf;
 
-	if (!acpi_pcc_retrive_biosdata())
+	if (!(sinf = kmalloc(sizeof(u32) * num_sifr, GFP_KERNEL))) {
+		printk(KERN_INFO LOGPREFIX "Couldn't allocate %i bytes\n", 
+		       sizeof(u32) * num_sifr);
 		return p;
+	}
 
-	for (i = 2; i < 8 ; i++) {
-		p += sprintf(p, "%d",	sinf[i]);
-		switch (i) {
-		case 2:
-		case 3:
-		case 5:
-		case 6:
-			p += sprintf(p, ",");
-			break;
-		case 4:
-		case 7:
-			p += sprintf(p, "\n");
-			break;
-		default:
-			p += sprintf(p, ","); 
-		}
+	if (acpi_pcc_retrieve_biosdata(sinf)) {
+		p += sprintf(p, "%d\n",	sinf[field]);
+	} else {
+		printk(KERN_INFO LOGPREFIX "Couldn't retrieve BIOS data\n");
 	}
-	
+
+	kfree(sinf);
 	return p;
 }
 
-static char*
-read_mute(char* p)
+/* Sinf read methods */
+static char* acpi_pcc_read_num_batteries(char* p) 
 {
-	if (!acpi_pcc_retrive_biosdata())
-		return p;
+	return acpi_pcc_read_sinf_field(p, SINF_NUM_BATTERIES);
+}
 
-	p += sprintf(p, "%d\n", sinf[8]);
+static char* acpi_pcc_read_lcd_type(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_LCD_TYPE);
+}
 
-	return p;
+static char* acpi_pcc_read_ac_max_brightness(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_AC_MAX_BRIGHT);
 }
 
-static unsigned long
-write_mute(const char* buffer, unsigned long count)
+static char* acpi_pcc_read_ac_min_brightness(char* p) 
 {
-	int value;
+	return acpi_pcc_read_sinf_field(p, SINF_AC_MIN_BRIGHT);
+}
+
+static char* acpi_pcc_read_ac_brightness(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_AC_CUR_BRIGHT);
+}
+
+static char* acpi_pcc_read_dc_max_brightness(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_DC_MAX_BRIGHT);
+}
+
+static char* acpi_pcc_read_dc_min_brightness(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_DC_MIN_BRIGHT);
+}
+
+static char* acpi_pcc_read_dc_brightness(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_DC_CUR_BRIGHT);
+}
+
+static char* acpi_pcc_read_mute(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_MUTE);
+}
+
+static char* acpi_pcc_read_env_state(char* p) 
+{
+	return acpi_pcc_read_sinf_field(p, SINF_ENV_STATE);
+}
+
+static unsigned long acpi_pcc_write_mute(const char* buffer, 
+					 unsigned long count)
+{
+	u32 value;
 
 	if (sscanf(buffer, "%i", &value) == 1 && value >= 0 && value <= 1) {
-		write_sset(8, value);
+		write_sset(SINF_MUTE, value);
 	}
 
 	return count;
 }
 
-static unsigned long
-acpi_pcc_write_brightness(const char* buffer, unsigned long count)
-{
-	int value1, value2;
+static unsigned long acpi_pcc_write_brightness(const char* buffer,
+					       unsigned long count,
+					       int min_index, int max_index,
+					       int cur_index)
+{
+	u32 bright;
+	u32* sinf;
+
+	if (!(sinf = kmalloc(sizeof(u32) * num_sifr, GFP_KERNEL))) {
+		printk(KERN_INFO LOGPREFIX "Couldn't allocate %i bytes\n", 
+		       sizeof(u32) * num_sifr);
+		return count;
+	}
+
+	if (!acpi_pcc_retrieve_biosdata(sinf)) {
+		printk(KERN_INFO LOGPREFIX "Couldn't retrieve BIOS data\n");
+		goto end;
+	}
+	
+	if (!sscanf(buffer, "%i", &bright)) {
+		printk(KERN_INFO LOGPREFIX "Invalid DC brightness\n");
+		goto end;
+	}
 
-	if (sscanf(buffer, "%i,%i", &value1, &value2) == 2 && value1 >= 0 && value1 < 2 && value2 >=0 && value2 < 20) {
-		write_sset((value1 == 1)?7:4, value2);
-	} else
-		printk("write_brightness error\n");
+	if (bright >= sinf[min_index] && bright <= sinf[max_index]) {
+		write_sset(cur_index, bright);
+	}
 
+end: 
+	kfree(sinf);
 	return count;
 }
 
-static char*
-acpi_pcc_read_version(char* p)
+
+static unsigned long acpi_pcc_write_ac_brightness(const char* buffer, 
+						  unsigned long count)
+{
+	return acpi_pcc_write_brightness(buffer, count, SINF_AC_MIN_BRIGHT, 
+					 SINF_AC_MAX_BRIGHT, 
+					 SINF_AC_CUR_BRIGHT);
+}
+
+static unsigned long acpi_pcc_write_dc_brightness(const char* buffer, 
+						  unsigned long count)
+{
+	return acpi_pcc_write_brightness(buffer, count, SINF_DC_MIN_BRIGHT, 
+					 SINF_DC_MAX_BRIGHT, 
+					 SINF_DC_CUR_BRIGHT);
+}
+
+static char* acpi_pcc_read_version(char* p)
 {
-	p += sprintf(p, "%s version %s\n", ACPI_HOTKEY_DRIVER_NAME, ACPI_PCC_VERSION);
+	p += sprintf(p, "%s version %s\n", ACPI_PCC_DRIVER_NAME, 
+		     ACPI_PCC_VERSION);
+	p += sprintf(p, "%i functions\n", num_sifr);
 	return p;
 }
 
 
 /* hotkey driver */
-static int
-acpi_pcc_hotkey_get_key(struct acpi_hotkey *hotkey)
+static int acpi_pcc_hotkey_get_key(struct acpi_hotkey *hotkey)
 {
 	int result;
 	int status;
 
 	status = read_acpi_int(hotkey->handle, METHOD_HKEY_QUERY, &result);
-	if (!status) {
+	if (status > 0) {
 		printk(KERN_INFO LOGPREFIX "error getting hotkey status\n");
-	} else
+	} else {
 		hotkey->status = result;
+	}
 
 	return (status);
 }
@@ -369,8 +446,9 @@
 
 	switch(event) {
 	case HKEY_NOTIFY:
-		if (acpi_pcc_hotkey_get_key(hotkey))
+		if (acpi_pcc_hotkey_get_key(hotkey)) {
 			acpi_bus_generate_event(hotkey->device, event, hotkey->status);
+		}
 		break;
 	default:
 		/* nothing to do */
@@ -383,37 +461,52 @@
  * proc and module init
 */
 
+/* Note: These functions map *exactly* to the SINF/SSET functions */
 ProcItem pcc_proc_items[] =
 {
-	{ "brightness" , acpi_pcc_read_brightness , acpi_pcc_write_brightness},
-	{ "mute", read_mute, write_mute},
+	{ "num_batteries", acpi_pcc_read_num_batteries, NULL },
+	{ "lcd_type", acpi_pcc_read_lcd_type, NULL },
+	{ "ac_brightness_max" , acpi_pcc_read_ac_max_brightness, NULL },
+	{ "ac_brightness_min" , acpi_pcc_read_ac_min_brightness, NULL },
+	{ "ac_brightness" , acpi_pcc_read_ac_brightness, 
+	  acpi_pcc_write_ac_brightness},
+	{ "dc_brightness_max" , acpi_pcc_read_dc_max_brightness, NULL },
+	{ "dc_brightness_min" , acpi_pcc_read_dc_min_brightness, NULL },
+	{ "dc_brightness" , acpi_pcc_read_dc_brightness, 
+	  acpi_pcc_write_dc_brightness},
+	{ "mute", acpi_pcc_read_mute, acpi_pcc_write_mute},
 	{ "version", acpi_pcc_read_version , NULL},
+	{ "environment_state", acpi_pcc_read_env_state, NULL },
 	{ NULL 	   , NULL	  , NULL},
 };
 
-static acpi_status __init
-add_device(ProcItem *proc_items, struct proc_dir_entry* proc_entry)
+static acpi_status __init add_device(ProcItem *proc_items, 
+				     struct proc_dir_entry* proc_entry)
 {
 	struct proc_dir_entry* proc;
 	ProcItem* item;
+	int i;
 
-	for (item = proc_items; item->name; ++item)
-	{
+	for (item = proc_items, i = 0; item->name && i <= num_sifr; 
+	     ++item, ++i) {
 		proc = create_proc_read_entry(item->name,
-			S_IFREG | S_IRUGO | S_IWUSR,
-			proc_entry, (read_proc_t*)dispatch_read, item);
-		if (proc)
+					      S_IFREG | S_IRUGO | S_IWUSR,
+					      proc_entry, 
+					      (read_proc_t*)dispatch_read, 
+					      item);
+		if (proc) {
 			proc->owner = THIS_MODULE;
-		if (proc && item->write_func)
+		}
+		if (proc && item->write_func) {
 			proc->write_proc = (write_proc_t*)dispatch_write;
+		}
 	}
 
 	return(AE_OK);
 }
 
 
-static int __init
-acpi_pcc_proc_init(void)
+static int __init acpi_pcc_proc_init(void)
 {
 	acpi_status status = AE_OK;
 
@@ -430,8 +523,8 @@
 	return (status == AE_OK);
 }
 
-static acpi_status __exit
-remove_device(ProcItem *proc_items, struct proc_dir_entry* proc_entry)
+static acpi_status __exit remove_device(ProcItem *proc_items, 
+					struct proc_dir_entry* proc_entry)
 {
 	ProcItem* item;
 
@@ -441,8 +534,7 @@
 }
 
 
-static int
-acpi_pcc_hotkey_add (struct acpi_device *device)
+static int acpi_pcc_hotkey_add (struct acpi_device *device)
 {
 	acpi_status		status = AE_OK;
 	struct acpi_hotkey	*hotkey = NULL;
@@ -452,9 +544,6 @@
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	acpi_pcc_proc_init();
-	acpi_pcc_init_sinf_buffer();
-
 	hotkey = kmalloc(sizeof(struct acpi_hotkey), GFP_KERNEL);
 	if (!hotkey)
 		return_VALUE(-ENOMEM);
@@ -478,12 +567,15 @@
 		kfree(hotkey); 
 		return_VALUE(-ENODEV);
 	}
+
+	num_sifr = acpi_pcc_get_sqty();
 	
+	acpi_pcc_proc_init();
+
 	return_VALUE(0);
 }
 
-static int
-acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
+static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
 {
 	acpi_status		status = AE_OK;
 	struct acpi_hotkey	*hotkey = NULL;
@@ -511,8 +603,7 @@
 	return_VALUE(status == AE_OK);
 }
 
-static int __init
-acpi_pcc_init(void)
+static int __init acpi_pcc_init(void)
 {
 	acpi_status result = AE_OK;
  

--------------080001090605000209010907
Content-Type: text/x-patch;
 name="pcc-doc-0.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcc-doc-0.6.patch"

--- la-2.6.8.1/drivers/acpi/Kconfig	2004-08-20 13:19:49.000000000 -0700
+++ linux-2.6.8.1/drivers/acpi/Kconfig	2004-08-21 23:24:22.000000000 -0700
@@ -211,18 +211,19 @@
 	default m
 	---help---
 	  This driver adds support for access to certain system settings
-	  on panasonic Let's Note laptops. 
+	  on Panasonic Let's Note laptops. 
 
-	  On these machines, all hotkey is handled through the ACPI.
+	  On these machines, all hotkeys are handled through the ACPI.
 	  This driver is required for access to controls not covered
 	  by the general ACPI drivers, such as LCD brightness, video output,
 	  etc.
 
-	  More information about this driver will be available at
-	  <http://www.da-cha.org/letsnote/>
+          In order to use this driver, you must configure acpid to handle 
+	  hotkey events; scripts to handle these events and information about 
+	  this driver will be available at <http://www.da-cha.org/letsnote/>
 
-	  If you have a panasonic lets note laptop (such as the CF-T2, Y2,
-	  R2, W2, R3), say Y.
+	  If you have a Panasonic Let's Note laptop (such as the CF-T2, Y2,
+	  R1N, R2, W2, R3), say Y.
 
 config ACPI_DEBUG
 	bool "Debug Statements"

--------------080001090605000209010907--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
