From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH] Generic Hotkey driver interface
Date: Tue, 9 Nov 2004 23:25:20 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC040@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4C670.5334B712"
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
To: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>, Julien Lerouge <julien.lerouge-GANU6spQydw@public.gmane.org>
Cc: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4C670.5334B712
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

  To consolidate the hotkey implementation in ACPI subsystem,=20
I tried to implement a generic hotkey driver under ACPI.
I hope you can give it a review. Thanks in advances for any
comments.

  The basic idea is to supply configurable interface
to userspace, thus user can configure the generic
hotkey driver to work for their specific laptop model.

  Please note, the code is trying to prove the concept
is feasible. So there are large room to improve, including
bugs need to be fixed, redundant code need to be clean up,
critical section need to be protected by lock or semaphore,
memory leak need to be fix up, interfaces need to be revised.

  The code is inspired by Karol Kozimor, Borislav Deianov,
Hiroshi Miura, Julien Lerouge, Alex Williamson,  and Len.

Thanks,
Luming


diff -BruN orig/Documentation/acpi-hotkey.txt
2.6/Documentation/acpi-hotkey.txt
--- orig/Documentation/acpi-hotkey.txt	1970-01-01 08:00:00.000000000
+0800
+++ 2.6/Documentation/acpi-hotkey.txt	2004-11-09 23:07:25.000000000
+0800
@@ -0,0 +1,35 @@
+The enclosed hotkey.c implement:
+1. /proc/acpi/hotkey/event_config=20
+(event based hotkey or event config interface):
+a. add a  event based hotkey(event) :=20
+echo "0:bus::action:method:num:num" > event_config
+
+b. delete a event based hotkey(event):=20
+echo "1:::::num:num" > event_config
+
+c.  modify a event based hotkey(event):   =20
+echo "2:bus::action:method:num:num" > event_config
+
+2. /proc/acpi/hotkey/pl_config=20
+(polling based hotkey or event config interface):
+a.add a polling based hotkey(event) : =09
+echo "0:bus:method:action:method:num" > polling_config
+this adding command will create a proc file=20
+/proc/acpi/hotkey/method, which is used to get=20
+result of polling.
+
+b.delete a polling based hotkey(event): =09
+echo "1:::::num" > ev_config
+
+c.modify a polling based hotkey(event):   =20
+echo "2:bus:method:action:method:num" > pl_config
+
+3./proc/acpi/hotkey/action=20
+(interface to call aml method associated with a=20
+specific hotkey(event))
+echo "event_num:event_type:event_argument" >=20
+	/proc/acpi/hotkey/action.
+The result of the execution of this aml method is=20
+attached to /proc/acpi/hotkey/polling_method.
+You can use command "cat /proc/acpi/hotkey/polling_method"=20
+to get it.
diff -BruN orig/drivers/acpi/hotkey.c 2.6/drivers/acpi/hotkey.c
--- orig/drivers/acpi/hotkey.c	1970-01-01 08:00:00.000000000 +0800
+++ 2.6/drivers/acpi/hotkey.c	2004-11-09 23:18:40.000000000 +0800
@@ -0,0 +1,1034 @@
+/*=20
+ *  hotkey.c - ACPI Hotkey Driver ($Revision:$)
+ *
+ *  Copyright (C) 2004 Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License as published
by
+ *  the Free Software Foundation; either version 2 of the License, or
(at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
along
+ *  with this program; if not, write to the Free Software Foundation,
Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~
+ */=20
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/kmod.h>
+#include <linux/seq_file.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
+
+#define HOTKEY_ACPI_VERSION "0.1"
+
+#define HOTKEY_PROC "hotkey"
+#define HOTKEY_EV_CONFIG    "ev_config"
+#define HOTKEY_PL_CONFIG    "pl_config"
+#define HOTKEY_ACTION   "action"
+#define HOTKEY_INFO "info"
+
+#define ACPI_HOTK_NAME          "Generic Hotkey Driver"
+#define ACPI_HOTK_CLASS         "Hotkey"
+#define ACPI_HOTK_DEVICE_NAME   "Hotkey"
+#define ACPI_HOTK_HID           "Unknown?"
+#define ACPI_HOTKEY_COMPONENT   0x20000000
+
+#define ACPI_HOTKEY_EVENT   0x1
+#define ACPI_HOTKEY_POLLING 0x2
+#define ACPI_UNDEFINED_EVENT    0xf
+
+#define MAX_CONFIG_RECORD_LEN   80
+#define MAX_NAME_PATH_LEN   80
+#define MAX_CALL_PARM       80
+
+#define IS_EV_EVENT(e)       0xff                 /* ((e) & 0x40000000)
*/=20
+#define IS_PL_EVENT(e)      0xff                  /* (~((e) &
0x40000000))  */=20
+
+#define _COMPONENT              ACPI_HOTKEY_COMPONENT
+ACPI_MODULE_NAME("acpi_hotkey")
+
+MODULE_AUTHOR("luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org");
+MODULE_DESCRIPTION(ACPI_HOTK_NAME);
+MODULE_LICENSE("GPL");
+
+/*  standardized internal hotkey number/event  */=20
+enum
+{
+    /* Video Extension event */=20
+    HK_EVENT_CYCLE_OUTPUT_DEVICE =3D 0x80,
+    HK_EVENT_OUTPUT_DEVICE_STATUS_CHANGE,
+    HK_EVENT_CYCLE_DISPLAY_OUTPUT,
+    HK_EVENT_NEXT_DISPLAY_OUTPUT,
+    HK_EVENT_PREVIOUS_DISPLAY_OUTPUT,
+    HK_EVENT_CYCLE_BRIGHTNESS,
+    HK_EVENT_INCREASE_BRIGHTNESS,
+    HK_EVENT_DECREASE_BRIGHTNESS,
+    HK_EVENT_ZERO_BRIGHTNESS,
+    HK_EVENT_DISPLAY_DEVICE_OFF,
+
+    /* Snd Card event */=20
+    HK_EVENT_VOLUME_MUTE,
+    HK_EVENT_VOLUME_INCLREASE,
+    HK_EVENT_VOLUME_DECREASE,
+
+    /* running state control */=20
+    HK_EVENT_ENTERRING_S3,
+    HK_EVENT_ENTERRING_S4,
+    HK_EVENT_ENTERRING_S5,
+};
+
+/*  procdir we use */=20
+static struct proc_dir_entry *hotkey_proc_dir;
+static struct proc_dir_entry *hotkey_config;
+static struct proc_dir_entry *hotkey_pl_config;
+static struct proc_dir_entry *hotkey_action;
+static struct proc_dir_entry *hotkey_info;
+
+/* linkage for all type of hotkey */=20
+struct acpi_hotkey_link
+{
+    struct list_head entries;
+    int hk_type;                                  /* event or polling
based hotkey  */=20
+    int hk_std_num;                               /* standardized
hotkey(event) number */=20
+};
+
+/* event based hotkey */=20
+struct acpi_event_hotkey
+{
+    struct acpi_hotkey_link hk_lnk;
+    int flag;
+    acpi_handle bus_handle;                       /* bus to install
notify handler */=20
+    int ext_hk_num;                               /* external
hotkey/event number */=20
+    acpi_handle act_handle;                       /* acpi handle
attached aml action method */=20
+    char *act_method;                             /* action method */=20
+};
+
+/*=20
+ * There are two ways to poll status
+ * 1. directy call read_xxx method, without any arguments passed in
+ * 2. call write_xxx method, with arguments passed in, you need
+ * the result is saved in acpi_polling_hotkey.pl_result.
+ * anthoer read command through polling interface.
+ *
+ */=20
+
+/* polling based hotkey */=20
+struct acpi_polling_hotkey
+{
+    struct acpi_hotkey_link hk_lnk;
+    int flag;
+    acpi_handle poll_handle;                      /* acpi handle
attached polling method */=20
+    char *poll_method;                            /* poll method */=20
+    acpi_handle act_handle;                       /* acpi handle
attached action method */=20
+    char *act_method;                             /* action method */=20
+    void *pl_result;                              /* polling_result */=20
+    struct proc_dir_entry *proc;
+};
+
+/* hotkey object union */=20
+union acpi_hotkey
+{
+    struct list_head entries;
+    struct acpi_hotkey_link lnk;
+    struct acpi_event_hotkey ev_hk;
+    struct acpi_polling_hotkey pl_hk;
+};
+
+/* hotkey object list */=20
+struct acpi_hotkey_list
+{
+    struct list_head *entries;
+    int count;
+};
+
+static int auto_hotkey_add(struct acpi_device *device);
+static int auto_hotkey_remove(struct acpi_device *device, int type);
+
+static struct acpi_driver hotkey_driver =3D
+{
+    .name =3D ACPI_HOTK_NAME,
+    .class =3D ACPI_HOTK_CLASS,
+    .ids =3D ACPI_HOTK_HID,
+    .ops =3D
+    {
+        .add =3D auto_hotkey_add,
+        .remove =3D auto_hotkey_remove,
+    },
+};
+
+static int hotkey_open_config(struct inode *inode, struct file *file);
+static ssize_t hotkey_write_config(struct file *file,
+const char __user * buffer, size_t count,
+loff_t * data);
+static ssize_t hotkey_write_pl_config(struct file *file,
+const char __user * buffer, size_t count,
+loff_t * data);
+static int hotkey_info_open_fs(struct inode *inode, struct file *file);
+static int hotkey_action_open_fs(struct inode *inode, struct file
*file);
+static ssize_t hotkey_execute_aml_method(struct file *file,
+const char __user * buffer,
+size_t count, loff_t * data);
+static int hotkey_config_seq_show(struct seq_file *seq, void *offset);
+static int hotkey_polling_open_fs(struct inode *inode, struct file
*file);
+
+/* event based config */=20
+static struct file_operations hotkey_config_fops =3D
+{
+    .open =3D hotkey_open_config,
+    .read =3D seq_read,
+    .write =3D hotkey_write_config,
+    .llseek =3D seq_lseek,
+    .release =3D single_release,
+};
+
+/* polling based config */=20
+static struct file_operations hotkey_pl_config_fops =3D
+{
+    .open =3D hotkey_open_config,
+    .read =3D seq_read,
+    .write =3D hotkey_write_pl_config,
+    .llseek =3D seq_lseek,
+    .release =3D single_release,
+};
+
+/* hotkey driver info */=20
+static struct file_operations hotkey_info_fops =3D
+{
+    .open =3D hotkey_info_open_fs,
+    .read =3D seq_read,
+    .llseek =3D seq_lseek,
+    .release =3D single_release,
+};
+
+/* action */=20
+static struct file_operations hotkey_action_fops =3D
+{
+    .open =3D hotkey_action_open_fs,
+    .read =3D seq_read,
+    .write =3D hotkey_execute_aml_method,
+    .llseek =3D seq_lseek,
+    .release =3D single_release,
+};
+
+/* polling results */=20
+static struct file_operations hotkey_polling_fops =3D
+{
+    .open =3D hotkey_polling_open_fs,
+    .read =3D seq_read,
+    .llseek =3D seq_lseek,
+    .release =3D single_release,
+};
+
+struct acpi_hotkey_list hotkey_list;              /* link all ev or pl
hotkey  */=20
+struct list_head hotkey_entries;                  /* head of the list
of hotkey_list */=20
+
+static int hotkey_info_seq_show(struct seq_file *seq, void *offset)
+{
+    ACPI_FUNCTION_TRACE("hotkey_info_seq_show");
+
+    seq_printf(seq, "Hotkey generic driver ver: %s",
HOTKEY_ACPI_VERSION);
+
+    return_VALUE(0);
+}
+
+
+static int hotkey_info_open_fs(struct inode *inode, struct file *file)
+{
+    return single_open(file, hotkey_info_seq_show, PDE(inode)->data);
+}
+
+
+static char *format_result(union acpi_object *object)
+{
+    char *buf =3D (char *)kmalloc(sizeof(union acpi_object), =
GFP_KERNEL);
+
+    memset(buf, 0, sizeof(union acpi_object));
+
+    /* Now, just support integer type */=20
+    if (object->type =3D=3D ACPI_TYPE_INTEGER)
+        sprintf(buf, "%d", object->integer.value);
+
+    return buf;
+}
+
+
+static int hotkey_polling_seq_show(struct seq_file *seq, void *offset)
+{
+    struct acpi_polling_hotkey *pl_hk =3D
+        (struct acpi_polling_hotkey *)seq->private;
+
+    ACPI_FUNCTION_TRACE("hotkey_polling_seq_show");
+
+    if (pl_hk->pl_result)
+        seq_printf(seq, "%s", format_result(pl_hk->pl_result));
+
+    return_VALUE(0);
+}
+
+
+static int hotkey_polling_open_fs(struct inode *inode, struct file
*file)
+{
+    return single_open(file, hotkey_polling_seq_show,
PDE(inode)->data);
+}
+
+
+static int hotkey_action_open_fs(struct inode *inode, struct file
*file)
+{
+    return single_open(file, hotkey_info_seq_show, PDE(inode)->data);
+}
+
+
+/* Mapping external hotkey number to standardized hotkey event num */=20
+static int hotkey_get_internal_event(int event, struct acpi_hotkey_list
*list)
+{
+    struct list_head *entries, *next;
+    int val =3D 0;
+
+    ACPI_FUNCTION_TRACE("hotkey_get_internal_event");
+
+    list_for_each_safe(entries, next, list->entries)
+    {
+        union acpi_hotkey *key =3D
+            container_of(entries, union acpi_hotkey, entries);
+        if (key->lnk.hk_type =3D=3D ACPI_HOTKEY_EVENT
+            && key->ev_hk.ext_hk_num =3D=3D event)
+            val =3D key->lnk.hk_std_num;
+        else
+            val =3D -1;
+    }
+
+    return_VALUE(val);
+}
+
+
+static void
+acpi_hotkey_notify_handler(acpi_handle handle, u32 event, void *data)
+{
+    /* union acpi_hotkey     *key =3D (union acpi_hotkey *) data; */=20
+    struct acpi_device *device =3D NULL;
+    u32 internal_event;
+
+    ACPI_FUNCTION_TRACE("acpi_hotkey_notify_handler");
+
+    if (acpi_bus_get_device(handle, &device))
+        return_VOID;
+
+    internal_event =3D hotkey_get_internal_event(event, &hotkey_list);
+    acpi_bus_generate_event(device, internal_event, 0);
+
+    return_VOID;
+}
+
+
+/* Need to invent automatically hotkey add method */=20
+static int auto_hotkey_add(struct acpi_device *device)
+{
+    /* Implement me */=20
+    return 0;
+}
+
+
+/* Need to invent automatically hotkey remove method */=20
+static int auto_hotkey_remove(struct acpi_device *device, int type)
+{
+    /* Implement me */=20
+    return 0;
+}
+
+
+/* Create a proc file for each polling method */=20
+static int create_polling_proc(union acpi_hotkey *device)
+{
+    struct proc_dir_entry *proc;
+
+    mode_t mode =3D S_IFREG | S_IRUGO | S_IWUGO;
+
+    proc =3D create_proc_entry(device->pl_hk.act_method,
+        mode, hotkey_proc_dir);
+
+    if (!proc)
+    {
+        printk(KERN_ERR "Hotkey: Unable to create %s entry\n",
+            device->pl_hk.poll_method);
+        return (-ENODEV);
+    }
+    else
+    {
+        proc->proc_fops =3D &hotkey_polling_fops;
+        proc->owner =3D THIS_MODULE;
+        proc->data =3D device;
+        proc->uid =3D 0;
+        proc->gid =3D 0;
+        device->pl_hk.proc =3D proc;
+    }
+}
+
+
+static int is_valid_acpi_path(const char *pathname)
+{
+    acpi_handle handle;
+    acpi_status status;
+
+    status =3D acpi_get_handle(NULL, (char *)pathname, &handle);
+    return !ACPI_FAILURE(status);
+}
+
+
+static int is_valid_hotkey(union acpi_hotkey *device)
+{
+    /* Implement valid check */=20
+    return TRUE;
+}
+
+
+static int hotkey_add(union acpi_hotkey *device)
+{
+    int status =3D 0;
+
+    if (device->lnk.hk_type =3D=3D ACPI_HOTKEY_EVENT)
+        status =3D =
acpi_install_notify_handler(device->ev_hk.bus_handle,
+            ACPI_DEVICE_NOTIFY,
+            acpi_hotkey_notify_handler,
+            device);
+    else                                          /* Add polling hotkey
*/=20
+        create_polling_proc(device);
+
+    hotkey_list.count++;
+
+    printk("hotkey_list.count++ =3D %d\n", hotkey_list.count);
+    list_add_tail(&device->lnk.entries, hotkey_list.entries);
+
+    return status;
+}
+
+
+static int hotkey_remove(union acpi_hotkey *device)
+{
+    struct list_head *entries, *next;
+
+    ACPI_FUNCTION_TRACE("hotkey_update");
+
+    list_for_each_safe(entries, next, hotkey_list.entries)
+    {
+        union acpi_hotkey *key =3D
+            container_of(entries, union acpi_hotkey, entries);
+        if (key->lnk.hk_std_num =3D=3D device->lnk.hk_std_num)
+        {
+            list_del(&key->lnk.entries);
+            remove_proc_entry(key->pl_hk.act_method,
+                hotkey_proc_dir);
+            hotkey_list.count--;
+            break;
+        }
+    }
+    return 0;
+}
+
+
+static void hotkey_update(union acpi_hotkey *hk)
+{
+    struct list_head *entries, *next;
+
+    ACPI_FUNCTION_TRACE("hotkey_update");
+
+    list_for_each_safe(entries, next, hotkey_list.entries)
+    {
+        union acpi_hotkey *key =3D
+            container_of(entries, union acpi_hotkey, entries);
+        if (key->lnk.hk_std_num =3D=3D hk->lnk.hk_std_num)
+        {
+            key->ev_hk.bus_handle =3D hk->ev_hk.bus_handle;
+            key->ev_hk.ext_hk_num =3D hk->ev_hk.ext_hk_num;
+            key->ev_hk.act_handle =3D hk->ev_hk.act_handle;
+            key->ev_hk.act_method =3D hk->ev_hk.act_method;
+            break;
+        }
+    }
+
+    return_VOID;
+}
+
+
+static void free_hotkey_device(union acpi_hotkey *key)
+{
+}
+
+
+static int
+init_hotkey_device(union acpi_hotkey *key,
+char *bus_str,
+char *action_str, char *method, int std_num, int ext_num)
+{
+    key->lnk.hk_type =3D ACPI_HOTKEY_EVENT;
+    key->lnk.hk_std_num =3D std_num;
+    key->ev_hk.flag =3D 0;
+    if (is_valid_acpi_path(bus_str))
+        acpi_get_handle((acpi_handle) 0,
+            bus_str, &(key->ev_hk.bus_handle));
+    key->ev_hk.ext_hk_num =3D ext_num;
+    if (is_valid_acpi_path(action_str))
+        acpi_get_handle((acpi_handle) 0,
+            action_str, &(key->ev_hk.act_handle));
+    key->ev_hk.act_method =3D method;
+    return (is_valid_hotkey(key));
+}
+
+
+static int
+init_pl_hotkey_device(union acpi_hotkey *key,
+char *poll_str,
+char *poll_mtd,
+char *action_str, char *action_mtd, int std_num)
+{
+    key->lnk.hk_type =3D ACPI_HOTKEY_POLLING;
+    key->lnk.hk_std_num =3D std_num;
+    key->pl_hk.flag =3D 0;
+    if (is_valid_acpi_path(poll_str))
+        acpi_get_handle((acpi_handle) 0,
+            poll_str, &(key->pl_hk.poll_handle));
+    key->pl_hk.poll_method =3D poll_mtd;
+    if (is_valid_acpi_path(action_str))
+        acpi_get_handle((acpi_handle) 0,
+            action_str, &(key->pl_hk.act_handle));
+    key->pl_hk.act_method =3D action_mtd;
+    key->pl_hk.pl_result =3D
+        (union acpi_object *)kmalloc(sizeof(union acpi_object),
GFP_KERNEL);
+    return (is_valid_hotkey(key));
+}
+
+
+static int check_hotkey_valid(union acpi_hotkey *key,
+struct acpi_hotkey_list *list)
+{
+    return 1;
+}
+
+
+static int hotkey_open_config(struct inode *inode, struct file *file)
+{
+    return single_open(file, hotkey_config_seq_show, PDE(inode)->data);
+}
+
+
+static int hotkey_config_seq_show(struct seq_file *seq, void *offset)
+{
+                                                  /* (struct
acpi_hotkey_list *)seq->private; */=20
+    struct acpi_hotkey_list *hk_list =3D &hotkey_list;
+    struct list_head *entries, *next;
+    char bus_name[ACPI_PATHNAME_MAX] =3D { 0 };
+    char act_name[ACPI_PATHNAME_MAX] =3D { 0 };
+    struct acpi_buffer bus =3D { ACPI_PATHNAME_MAX, bus_name };
+    struct acpi_buffer act =3D { ACPI_PATHNAME_MAX, act_name };
+
+    ACPI_FUNCTION_TRACE(("hotkey_config_seq_show"));
+
+    if (!hk_list)
+        goto end;
+
+    list_for_each_safe(entries, next, hk_list->entries)
+    {
+        union acpi_hotkey *key =3D
+            container_of(entries, union acpi_hotkey, entries);
+        if (key->lnk.hk_type =3D=3D ACPI_HOTKEY_EVENT)
+        {
+            acpi_get_name(key->ev_hk.bus_handle, ACPI_NAME_TYPE_MAX,
+                &bus);
+            acpi_get_name(key->ev_hk.act_handle, ACPI_NAME_TYPE_MAX,
+                &act);
+            seq_printf(seq, "%s:%s:%s:%d:%d", bus_name, act_name,
+                key->ev_hk.act_method, key->lnk.hk_std_num,
+                key->ev_hk.ext_hk_num);
+        }                                         /*
ACPI_HOTKEY_POLLING */=20
+        else
+        {
+            acpi_get_name(key->pl_hk.poll_handle,
+                ACPI_NAME_TYPE_MAX, &bus);
+            acpi_get_name(key->pl_hk.act_handle, ACPI_NAME_TYPE_MAX,
+                &act);
+            seq_printf(seq, "%s:%s:%s:%s:%d", bus_name,
+                key->pl_hk.poll_method, act_name,
+                key->pl_hk.act_method, key->lnk.hk_std_num);
+        }
+    }
+    seq_puts(seq, "\n");
+    end:
+    return_VALUE(0);
+}
+
+
+static int
+get_parms(char *config_record,
+int *cmd,
+char *bus_handle,
+char *bus_method,
+char *action_handle,
+char *method, int *internal_event_num, int *external_event_num)
+{
+    char *tmp, *tmp1;
+    sscanf(config_record, "%d", cmd);
+
+    tmp =3D strchr(config_record, ':');
+    tmp++;
+    tmp1 =3D strchr(tmp, ':');
+    strncpy(bus_handle, tmp, tmp1 - tmp);
+    bus_handle[tmp1 - tmp] =3D 0;
+
+    tmp =3D tmp1;
+    tmp++;
+    tmp1 =3D strchr(tmp, ':');
+    strncpy(bus_method, tmp, tmp1 - tmp);
+    bus_method[tmp1 - tmp] =3D 0;
+
+    tmp =3D tmp1;
+    tmp++;
+    tmp1 =3D strchr(tmp, ':');
+    strncpy(action_handle, tmp, tmp1 - tmp);
+    action_handle[tmp1 - tmp] =3D 0;
+
+    tmp =3D tmp1;
+    tmp++;
+    tmp1 =3D strchr(tmp, ':');
+    strncpy(method, tmp, tmp1 - tmp);
+    method[tmp1 - tmp] =3D 0;
+
+    sscanf(tmp1 + 1, "%d:%d", internal_event_num, external_event_num);
+    return 6;
+}
+
+
+/*  count is length for one input record */=20
+static ssize_t hotkey_write_config(struct file *file,
+const char __user * buffer, size_t count,
+loff_t * data)
+{
+    struct seq_file *m =3D (struct seq_file *)file->private_data;
+                                                  /* (struct
acpi_hotkey_list *)seq->private; */=20
+    struct acpi_hotkey_list *hk_list =3D &hotkey_list;
+    char config_record[MAX_CONFIG_RECORD_LEN];
+    char bus_handle[MAX_NAME_PATH_LEN];
+    char bus_method[MAX_NAME_PATH_LEN];
+    char action_handle[MAX_NAME_PATH_LEN];
+    char method[20];
+    int cmd, internal_event_num, external_event_num;
+    int ret =3D 0;
+    union acpi_hotkey *key =3D NULL;
+
+    ACPI_FUNCTION_TRACE("hotkey_write_config");
+
+    if (!hk_list || count > MAX_CONFIG_RECORD_LEN)
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid arguments\n"));
+        return_VALUE(-EINVAL);
+    }
+
+    if (copy_from_user(config_record, buffer, count))
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data \n"));
+        return_VALUE(-EINVAL);
+    }
+    config_record[count] =3D '\0';
+    ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "config_str: %s", config_record));
+
+    ret =3D get_parms(config_record,
+	/*	=20
+          ret =3D sscanf(config_record,
+                          "%d:%s:%s:%s:%d:%d",
+			  */
+        &cmd,
+        bus_handle,
+        bus_method,
+        action_handle,
+        method, &internal_event_num, &external_event_num);
+    if (ret !=3D 6)
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data format
ret=3D%d\n",
+            ret));
+        return_VALUE(-EINVAL);
+    }
+
+    key =3D kmalloc(sizeof(union acpi_hotkey), GFP_KERNEL);
+    ret =3D init_hotkey_device(key, bus_handle, action_handle, method,
+        internal_event_num, external_event_num);
+
+    if (ret || check_hotkey_valid(key, &hotkey_list))
+    {
+        free_hotkey_device(key);
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid hotkey \n"));
+        return_VALUE(-EINVAL);
+    }
+    switch (cmd)
+    {
+        case 0:
+            hotkey_add(key);
+            break;
+        case 1:
+            hotkey_remove(key);
+            break;
+        case 2:
+            hotkey_update(key);
+            break;
+        default:
+            break;
+    }
+    return_VALUE(count);
+}
+
+
+/*  count is length for one input record */=20
+static ssize_t hotkey_write_pl_config(struct file *file,
+const char __user * buffer, size_t count,
+loff_t * data)
+{
+    struct seq_file *m =3D (struct seq_file *)file->private_data;
+    struct acpi_hotkey_list *hk_list =3D
+        (struct acpi_hotkey_list *)m->private;
+
+    char config_record[MAX_CONFIG_RECORD_LEN];
+    char polling_handle[MAX_NAME_PATH_LEN];
+    char action_handle[MAX_NAME_PATH_LEN];
+    char poll_method[20], action_method[20];
+    int ret, internal_event_num, cmd, external_event_num;
+    union acpi_hotkey *key =3D NULL;
+
+    ACPI_FUNCTION_TRACE("hotkey_write_config");
+
+    if (!hk_list || count > MAX_CONFIG_RECORD_LEN)
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid arguments\n"));
+        return_VALUE(-EINVAL);
+    }
+
+    if (copy_from_user(config_record, buffer, count))
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data \n"));
+        return_VALUE(-EINVAL);
+    }
+    config_record[count] =3D '\0';
+
+    ret =3D get_parms(config_record,
+        &cmd,
+        polling_handle,
+        poll_method,
+        action_handle,
+        action_method,
+        &internal_event_num, &external_event_num);
+
+    if (ret !=3D 6)
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data format\n"));
+        return_VALUE(-EINVAL);
+    }
+
+    key =3D kmalloc(sizeof(union acpi_hotkey), GFP_KERNEL);
+    ret =3D init_pl_hotkey_device(key, polling_handle, poll_method,
+        action_handle, action_method,
+        internal_event_num);
+    if (ret || check_hotkey_valid(key, &hotkey_list))
+    {
+        free_hotkey_device(key);
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid hotkey \n"));
+        return_VALUE(-EINVAL);
+    }
+    switch (cmd)
+    {
+        case 0:
+            hotkey_add(key);
+            break;
+        case 1:
+            hotkey_remove(key);
+            break;
+        case 2:
+            hotkey_update(key);
+            break;
+        default:
+            break;
+    }
+    return_VALUE(count);
+}
+
+
+/* =20
+ * This function evaluates an ACPI method, given an int as parameter,
the
+ * method is searched within the scope of the handle, can be NULL. The
output
+ * of the method is written is output, which can also be NULL
+ *
+ * returns 1 if write is successful, 0 else.
+ */=20
+static int write_acpi_int(acpi_handle handle, const char *method, int
val,
+struct acpi_buffer *output)
+{
+    struct acpi_object_list params;               /* list of input
parameters (an int here) */
+    union acpi_object in_obj;                     /* the only param we
use */
+    acpi_status status;
+
+    ACPI_FUNCTION_TRACE("write_acpi_int");
+    params.count =3D 1;
+    params.pointer =3D &in_obj;
+    in_obj.type =3D ACPI_TYPE_INTEGER;
+    in_obj.integer.value =3D val;
+
+    status =3D acpi_evaluate_object(handle, (char *)method, &params,
output);
+
+    return_VALUE(status =3D=3D AE_OK);
+}
+
+
+static int read_acpi_int(acpi_handle handle, const char *method, int
*val)
+{
+    struct acpi_buffer output;
+    union acpi_object out_obj;
+    acpi_status status;
+
+    output.length =3D sizeof(out_obj);
+    output.pointer =3D &out_obj;
+
+    status =3D acpi_evaluate_object(handle, (char *)method, NULL,
&output);
+    *val =3D out_obj.integer.value;
+    return (status =3D=3D AE_OK) && (out_obj.type =3D=3D =
ACPI_TYPE_INTEGER);
+}
+
+
+static acpi_handle
+get_handle_from_hotkeylist(struct acpi_hotkey_list *hk_list, int
event_num)
+{
+    struct list_head *entries, *next;
+
+    list_for_each_safe(entries, next, hk_list->entries)
+    {
+        union acpi_hotkey *key =3D
+            container_of(entries, union acpi_hotkey, entries);
+        if (key->lnk.hk_type =3D=3D ACPI_HOTKEY_EVENT
+            && key->lnk.hk_std_num =3D=3D event_num)
+        {
+            return (key->ev_hk.act_handle);
+        }
+    }
+    return NULL;
+}
+
+
+static
+char *get_method_from_hotkeylist(struct acpi_hotkey_list *hk_list,
+int event_num)
+{
+    struct list_head *entries, *next;
+
+    list_for_each_safe(entries, next, hk_list->entries)
+    {
+        union acpi_hotkey *key =3D
+            container_of(entries, union acpi_hotkey, entries);
+
+        if (key->lnk.hk_type =3D=3D ACPI_HOTKEY_EVENT &&
+            key->lnk.hk_std_num =3D=3D event_num)
+        {
+            return (key->ev_hk.act_method);
+        }
+    }
+    return NULL;
+}
+
+
+static
+struct acpi_polling_hotkey *get_hotkey_by_evt(struct acpi_hotkey_list
*hk_list,
+int evt)
+{
+    struct list_head *entries, *next;
+
+    list_for_each_safe(entries, next, hk_list->entries)
+    {
+        union acpi_hotkey *key =3D
+            container_of(entries, union acpi_hotkey, entries);
+        if (key->lnk.hk_type =3D=3D ACPI_HOTKEY_POLLING
+            && key->lnk.hk_std_num =3D=3D evt)
+        {
+            return (&key->pl_hk);
+        }
+    }
+    return NULL;
+}
+
+
+/* =20
+ * user call AML method interface:
+ * Call convention:
+ * echo "event_num: arg type : value"
+ * example: echo "1:1:30" > /proc/acpi/action
+ * Just support 1 integer arg passing to AML method
+ */=20
+
+static ssize_t hotkey_execute_aml_method(struct file *file,
+const char __user * buffer,
+size_t count, loff_t * data)
+{
+    struct seq_file *m =3D (struct seq_file *)file->private_data;
+                                                  /* (struct
acpi_hotkey_list *) m->private; */=20
+    struct acpi_hotkey_list *hk_list =3D &hotkey_list;
+    char arg[MAX_CALL_PARM];
+    int evt, type, value;
+
+    char *method;
+    acpi_handle handle;
+
+    ACPI_FUNCTION_TRACE("hotkey_execte_action");
+
+    if (!hk_list || count > MAX_CALL_PARM)
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument 1"));
+        return_VALUE(-EINVAL);
+    }
+
+    if (copy_from_user(arg, buffer, count))
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument 2"));
+        return_VALUE(-EINVAL);
+    }
+
+    arg[count] =3D '\0';
+
+    if (sscanf(arg, "%d:%d:%d", &evt, &type, &value) !=3D 3)
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument 3"));
+        return_VALUE(-EINVAL);
+    }
+
+    if (type =3D=3D ACPI_TYPE_INTEGER)
+    {
+        handle =3D get_handle_from_hotkeylist(hk_list, evt);
+        method =3D get_method_from_hotkeylist(hk_list, evt);
+        if (IS_EV_EVENT(evt))
+            write_acpi_int(handle, method, value, NULL);
+        else if (IS_PL_EVENT(evt))
+        {
+            struct acpi_polling_hotkey *hk;
+            hk =3D (struct acpi_polling_hotkey *)
+                get_hotkey_by_evt(&hotkey_list, evt);
+            read_acpi_int(handle, method, hk->pl_result);
+        }
+    }
+    else
+    {
+        ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Not supported"));
+        return_VALUE(-EINVAL);
+    }
+
+    return_VALUE(count);
+}
+
+
+static int __init hotkey_init(void)
+{
+    int result;
+    mode_t mode =3D S_IFREG | S_IRUGO | S_IWUGO;
+
+    hotkey_proc_dir =3D proc_mkdir(HOTKEY_PROC, acpi_root_dir);
+    if (!hotkey_proc_dir)
+    {
+        printk(KERN_ERR "Hotkey: Unable to create %s entry\n",
+            HOTKEY_PROC);
+        return (-ENODEV);
+    }
+    hotkey_proc_dir->owner =3D THIS_MODULE;
+
+    hotkey_config =3D
+        create_proc_entry(HOTKEY_EV_CONFIG, mode, hotkey_proc_dir);
+    if (!hotkey_config)
+    {
+        printk(KERN_ERR "Hotkey: Unable to create %s entry\n",
+            HOTKEY_EV_CONFIG);
+        return (-ENODEV);
+    }
+    else
+    {
+        hotkey_config->proc_fops =3D &hotkey_config_fops;
+        hotkey_config->data =3D &hotkey_list;
+        hotkey_config->owner =3D THIS_MODULE;
+        hotkey_config->uid =3D 0;
+        hotkey_config->gid =3D 0;
+    }
+
+    hotkey_pl_config =3D
+        create_proc_entry(HOTKEY_PL_CONFIG, mode, hotkey_proc_dir);
+    if (!hotkey_pl_config)
+    {
+        printk(KERN_ERR "Hotkey: Unable to create %s entry\n",
+            HOTKEY_EV_CONFIG);
+        return (-ENODEV);
+    }
+    else
+    {
+        hotkey_pl_config->proc_fops =3D &hotkey_pl_config_fops;
+        hotkey_pl_config->data =3D &hotkey_list;
+        hotkey_pl_config->owner =3D THIS_MODULE;
+        hotkey_pl_config->uid =3D 0;
+        hotkey_pl_config->gid =3D 0;
+    }
+
+    hotkey_action =3D create_proc_entry(HOTKEY_ACTION, mode,
hotkey_proc_dir);
+    if (!hotkey_action)
+    {
+        printk(KERN_ERR "Hotkey: Unable to create %s entry\n",
+            HOTKEY_ACTION);
+        return (-ENODEV);
+    }
+    else
+    {
+        hotkey_action->proc_fops =3D &hotkey_action_fops;
+        hotkey_action->owner =3D THIS_MODULE;
+        hotkey_action->uid =3D 0;
+        hotkey_action->gid =3D 0;
+    }
+
+    hotkey_info =3D create_proc_entry(HOTKEY_INFO, mode,
hotkey_proc_dir);
+    if (!hotkey_info)
+    {
+        printk(KERN_ERR "Hotkey: Unable to create %s entry\n",
+            HOTKEY_INFO);
+        return (-ENODEV);
+    }
+    else
+    {
+        hotkey_info->proc_fops =3D &hotkey_info_fops;
+        hotkey_info->owner =3D THIS_MODULE;
+        hotkey_info->uid =3D 0;
+        hotkey_info->gid =3D 0;
+    }
+
+    result =3D acpi_bus_register_driver(&hotkey_driver);
+    if (result < 0)
+    {
+        remove_proc_entry(HOTKEY_PROC, acpi_root_dir);
+        return (-ENODEV);
+    }
+    hotkey_list.count =3D 0;
+    hotkey_list.entries =3D &hotkey_entries;
+
+    INIT_LIST_HEAD(&hotkey_entries);
+
+    return (0);
+}
+
+
+static void __exit hotkey_exit(void)
+{
+    acpi_bus_unregister_driver(&hotkey_driver);
+    remove_proc_entry(HOTKEY_PROC, acpi_root_dir);
+    return;
+}
+
+
+module_init(hotkey_init);
+module_exit(hotkey_exit);
diff -BruN orig/drivers/acpi/Makefile 2.6/drivers/acpi/Makefile
--- orig/drivers/acpi/Makefile	2004-11-09 23:10:07.000000000 +0800
+++ 2.6/drivers/acpi/Makefile	2004-11-09 23:08:01.000000000 +0800
@@ -38,7 +38,7 @@
 obj-$(CONFIG_ACPI_BUTTON)	+=3D button.o
 obj-$(CONFIG_ACPI_EC)		+=3D ec.o
 obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
-obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
+obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o hotkey.o
 obj-$(CONFIG_ACPI_PCI)		+=3D pci_root.o pci_link.o pci_irq.o
pci_bind.o
 obj-$(CONFIG_ACPI_POWER)	+=3D power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+=3D processor.o

Thanks
Luming

------_=_NextPart_001_01C4C670.5334B712
Content-Type: application/octet-stream;
	name="hotkey.patch"
Content-Transfer-Encoding: base64
Content-Description: hotkey.patch
Content-Disposition: attachment;
	filename="hotkey.patch"

ZGlmZiAtQnJ1TiBvcmlnL0RvY3VtZW50YXRpb24vYWNwaS1ob3RrZXkudHh0IDIuNi9Eb2N1bWVu
dGF0aW9uL2FjcGktaG90a2V5LnR4dA0KLS0tIG9yaWcvRG9jdW1lbnRhdGlvbi9hY3BpLWhvdGtl
eS50eHQJMTk3MC0wMS0wMSAwODowMDowMC4wMDAwMDAwMDAgKzA4MDANCisrKyAyLjYvRG9jdW1l
bnRhdGlvbi9hY3BpLWhvdGtleS50eHQJMjAwNC0xMS0wOSAyMzowNzoyNS4wMDAwMDAwMDAgKzA4
MDANCkBAIC0wLDAgKzEsMzUgQEANCitUaGUgZW5jbG9zZWQgaG90a2V5LmMgaW1wbGVtZW50Og0K
KzEuIC9wcm9jL2FjcGkvaG90a2V5L2V2ZW50X2NvbmZpZyANCisoZXZlbnQgYmFzZWQgaG90a2V5
IG9yIGV2ZW50IGNvbmZpZyBpbnRlcmZhY2UpOg0KK2EuIGFkZCBhICBldmVudCBiYXNlZCBob3Rr
ZXkoZXZlbnQpIDogDQorZWNobyAiMDpidXM6OmFjdGlvbjptZXRob2Q6bnVtOm51bSIgPiBldmVu
dF9jb25maWcNCisNCitiLiBkZWxldGUgYSBldmVudCBiYXNlZCBob3RrZXkoZXZlbnQpOiANCitl
Y2hvICIxOjo6OjpudW06bnVtIiA+IGV2ZW50X2NvbmZpZw0KKw0KK2MuICBtb2RpZnkgYSBldmVu
dCBiYXNlZCBob3RrZXkoZXZlbnQpOiAgICANCitlY2hvICIyOmJ1czo6YWN0aW9uOm1ldGhvZDpu
dW06bnVtIiA+IGV2ZW50X2NvbmZpZw0KKw0KKzIuIC9wcm9jL2FjcGkvaG90a2V5L3BsX2NvbmZp
ZyANCisocG9sbGluZyBiYXNlZCBob3RrZXkgb3IgZXZlbnQgY29uZmlnIGludGVyZmFjZSk6DQor
YS5hZGQgYSBwb2xsaW5nIGJhc2VkIGhvdGtleShldmVudCkgOiAJDQorZWNobyAiMDpidXM6bWV0
aG9kOmFjdGlvbjptZXRob2Q6bnVtIiA+IHBvbGxpbmdfY29uZmlnDQordGhpcyBhZGRpbmcgY29t
bWFuZCB3aWxsIGNyZWF0ZSBhIHByb2MgZmlsZSANCisvcHJvYy9hY3BpL2hvdGtleS9tZXRob2Qs
IHdoaWNoIGlzIHVzZWQgdG8gZ2V0IA0KK3Jlc3VsdCBvZiBwb2xsaW5nLg0KKw0KK2IuZGVsZXRl
IGEgcG9sbGluZyBiYXNlZCBob3RrZXkoZXZlbnQpOiAJDQorZWNobyAiMTo6Ojo6bnVtIiA+IGV2
X2NvbmZpZw0KKw0KK2MubW9kaWZ5IGEgcG9sbGluZyBiYXNlZCBob3RrZXkoZXZlbnQpOiAgICAN
CitlY2hvICIyOmJ1czptZXRob2Q6YWN0aW9uOm1ldGhvZDpudW0iID4gcGxfY29uZmlnDQorDQor
My4vcHJvYy9hY3BpL2hvdGtleS9hY3Rpb24gDQorKGludGVyZmFjZSB0byBjYWxsIGFtbCBtZXRo
b2QgYXNzb2NpYXRlZCB3aXRoIGEgDQorc3BlY2lmaWMgaG90a2V5KGV2ZW50KSkNCitlY2hvICJl
dmVudF9udW06ZXZlbnRfdHlwZTpldmVudF9hcmd1bWVudCIgPiANCisJL3Byb2MvYWNwaS9ob3Rr
ZXkvYWN0aW9uLg0KK1RoZSByZXN1bHQgb2YgdGhlIGV4ZWN1dGlvbiBvZiB0aGlzIGFtbCBtZXRo
b2QgaXMgDQorYXR0YWNoZWQgdG8gL3Byb2MvYWNwaS9ob3RrZXkvcG9sbGluZ19tZXRob2QuDQor
WW91IGNhbiB1c2UgY29tbWFuZCAiY2F0IC9wcm9jL2FjcGkvaG90a2V5L3BvbGxpbmdfbWV0aG9k
IiANCit0byBnZXQgaXQuDQpkaWZmIC1CcnVOIG9yaWcvZHJpdmVycy9hY3BpL2hvdGtleS5jIDIu
Ni9kcml2ZXJzL2FjcGkvaG90a2V5LmMNCi0tLSBvcmlnL2RyaXZlcnMvYWNwaS9ob3RrZXkuYwkx
OTcwLTAxLTAxIDA4OjAwOjAwLjAwMDAwMDAwMCArMDgwMA0KKysrIDIuNi9kcml2ZXJzL2FjcGkv
aG90a2V5LmMJMjAwNC0xMS0wOSAyMzoxODo0MC4wMDAwMDAwMDAgKzA4MDANCkBAIC0wLDAgKzEs
MTAzNCBAQA0KKy8qIA0KKyAqICBob3RrZXkuYyAtIEFDUEkgSG90a2V5IERyaXZlciAoJFJldmlz
aW9uOiQpDQorICoNCisgKiAgQ29weXJpZ2h0IChDKSAyMDA0IEx1bWluZyBZdSA8bHVtaW5nLnl1
QGludGVsLmNvbT4NCisgKg0KKyAqIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQorICoNCisgKiAgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkNCisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhcyBwdWJsaXNoZWQgYnkNCisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0DQorICogIHlvdXIgb3B0
aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCisgKg0KKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0DQorICogIFdJVEhP
VVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCisg
KiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAg
U2VlIHRoZSBHTlUNCisgKiAgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxz
Lg0KKyAqDQorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nDQorICogIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBu
b3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sDQorICogIDU5
IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24sIE1BIDAyMTExLTEzMDcgVVNBLg0KKyAq
DQorICogfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCisgKi8gDQorI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
Pg0KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0K
KyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9wcm9jX2ZzLmg+DQor
I2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQorI2luY2x1ZGUgPGxpbnV4L2ttb2QuaD4NCisjaW5j
bHVkZSA8bGludXgvc2VxX2ZpbGUuaD4NCisjaW5jbHVkZSA8YWNwaS9hY3BpX2RyaXZlcnMuaD4N
CisjaW5jbHVkZSA8YWNwaS9hY3BpX2J1cy5oPg0KKyNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPg0K
Kw0KKyNkZWZpbmUgSE9US0VZX0FDUElfVkVSU0lPTiAiMC4xIg0KKw0KKyNkZWZpbmUgSE9US0VZ
X1BST0MgImhvdGtleSINCisjZGVmaW5lIEhPVEtFWV9FVl9DT05GSUcgICAgImV2X2NvbmZpZyIN
CisjZGVmaW5lIEhPVEtFWV9QTF9DT05GSUcgICAgInBsX2NvbmZpZyINCisjZGVmaW5lIEhPVEtF
WV9BQ1RJT04gICAiYWN0aW9uIg0KKyNkZWZpbmUgSE9US0VZX0lORk8gImluZm8iDQorDQorI2Rl
ZmluZSBBQ1BJX0hPVEtfTkFNRSAgICAgICAgICAiR2VuZXJpYyBIb3RrZXkgRHJpdmVyIg0KKyNk
ZWZpbmUgQUNQSV9IT1RLX0NMQVNTICAgICAgICAgIkhvdGtleSINCisjZGVmaW5lIEFDUElfSE9U
S19ERVZJQ0VfTkFNRSAgICJIb3RrZXkiDQorI2RlZmluZSBBQ1BJX0hPVEtfSElEICAgICAgICAg
ICAiVW5rbm93bj8iDQorI2RlZmluZSBBQ1BJX0hPVEtFWV9DT01QT05FTlQgICAweDIwMDAwMDAw
DQorDQorI2RlZmluZSBBQ1BJX0hPVEtFWV9FVkVOVCAgIDB4MQ0KKyNkZWZpbmUgQUNQSV9IT1RL
RVlfUE9MTElORyAweDINCisjZGVmaW5lIEFDUElfVU5ERUZJTkVEX0VWRU5UICAgIDB4Zg0KKw0K
KyNkZWZpbmUgTUFYX0NPTkZJR19SRUNPUkRfTEVOICAgODANCisjZGVmaW5lIE1BWF9OQU1FX1BB
VEhfTEVOICAgODANCisjZGVmaW5lIE1BWF9DQUxMX1BBUk0gICAgICAgODANCisNCisjZGVmaW5l
IElTX0VWX0VWRU5UKGUpICAgICAgIDB4ZmYgICAgICAgICAgICAgICAgIC8qICgoZSkgJiAweDQw
MDAwMDAwKSAgKi8gDQorI2RlZmluZSBJU19QTF9FVkVOVChlKSAgICAgIDB4ZmYgICAgICAgICAg
ICAgICAgICAvKiAofigoZSkgJiAweDQwMDAwMDAwKSkgICovIA0KKw0KKyNkZWZpbmUgX0NPTVBP
TkVOVCAgICAgICAgICAgICAgQUNQSV9IT1RLRVlfQ09NUE9ORU5UDQorQUNQSV9NT0RVTEVfTkFN
RSgiYWNwaV9ob3RrZXkiKQ0KKw0KK01PRFVMRV9BVVRIT1IoImx1bWluZy55dUBpbnRlbC5jb20i
KTsNCitNT0RVTEVfREVTQ1JJUFRJT04oQUNQSV9IT1RLX05BTUUpOw0KK01PRFVMRV9MSUNFTlNF
KCJHUEwiKTsNCisNCisvKiAgc3RhbmRhcmRpemVkIGludGVybmFsIGhvdGtleSBudW1iZXIvZXZl
bnQgICovIA0KK2VudW0NCit7DQorICAgIC8qIFZpZGVvIEV4dGVuc2lvbiBldmVudCAqLyANCisg
ICAgSEtfRVZFTlRfQ1lDTEVfT1VUUFVUX0RFVklDRSA9IDB4ODAsDQorICAgIEhLX0VWRU5UX09V
VFBVVF9ERVZJQ0VfU1RBVFVTX0NIQU5HRSwNCisgICAgSEtfRVZFTlRfQ1lDTEVfRElTUExBWV9P
VVRQVVQsDQorICAgIEhLX0VWRU5UX05FWFRfRElTUExBWV9PVVRQVVQsDQorICAgIEhLX0VWRU5U
X1BSRVZJT1VTX0RJU1BMQVlfT1VUUFVULA0KKyAgICBIS19FVkVOVF9DWUNMRV9CUklHSFRORVNT
LA0KKyAgICBIS19FVkVOVF9JTkNSRUFTRV9CUklHSFRORVNTLA0KKyAgICBIS19FVkVOVF9ERUNS
RUFTRV9CUklHSFRORVNTLA0KKyAgICBIS19FVkVOVF9aRVJPX0JSSUdIVE5FU1MsDQorICAgIEhL
X0VWRU5UX0RJU1BMQVlfREVWSUNFX09GRiwNCisNCisgICAgLyogU25kIENhcmQgZXZlbnQgKi8g
DQorICAgIEhLX0VWRU5UX1ZPTFVNRV9NVVRFLA0KKyAgICBIS19FVkVOVF9WT0xVTUVfSU5DTFJF
QVNFLA0KKyAgICBIS19FVkVOVF9WT0xVTUVfREVDUkVBU0UsDQorDQorICAgIC8qIHJ1bm5pbmcg
c3RhdGUgY29udHJvbCAqLyANCisgICAgSEtfRVZFTlRfRU5URVJSSU5HX1MzLA0KKyAgICBIS19F
VkVOVF9FTlRFUlJJTkdfUzQsDQorICAgIEhLX0VWRU5UX0VOVEVSUklOR19TNSwNCit9Ow0KKw0K
Ky8qICBwcm9jZGlyIHdlIHVzZSAqLyANCitzdGF0aWMgc3RydWN0IHByb2NfZGlyX2VudHJ5ICpo
b3RrZXlfcHJvY19kaXI7DQorc3RhdGljIHN0cnVjdCBwcm9jX2Rpcl9lbnRyeSAqaG90a2V5X2Nv
bmZpZzsNCitzdGF0aWMgc3RydWN0IHByb2NfZGlyX2VudHJ5ICpob3RrZXlfcGxfY29uZmlnOw0K
K3N0YXRpYyBzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKmhvdGtleV9hY3Rpb247DQorc3RhdGljIHN0
cnVjdCBwcm9jX2Rpcl9lbnRyeSAqaG90a2V5X2luZm87DQorDQorLyogbGlua2FnZSBmb3IgYWxs
IHR5cGUgb2YgaG90a2V5ICovIA0KK3N0cnVjdCBhY3BpX2hvdGtleV9saW5rDQorew0KKyAgICBz
dHJ1Y3QgbGlzdF9oZWFkIGVudHJpZXM7DQorICAgIGludCBoa190eXBlOyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiBldmVudCBvciBwb2xsaW5nIGJhc2VkIGhvdGtleSAgKi8g
DQorICAgIGludCBoa19zdGRfbnVtOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBz
dGFuZGFyZGl6ZWQgaG90a2V5KGV2ZW50KSBudW1iZXIgKi8gDQorfTsNCisNCisvKiBldmVudCBi
YXNlZCBob3RrZXkgKi8gDQorc3RydWN0IGFjcGlfZXZlbnRfaG90a2V5DQorew0KKyAgICBzdHJ1
Y3QgYWNwaV9ob3RrZXlfbGluayBoa19sbms7DQorICAgIGludCBmbGFnOw0KKyAgICBhY3BpX2hh
bmRsZSBidXNfaGFuZGxlOyAgICAgICAgICAgICAgICAgICAgICAgLyogYnVzIHRvIGluc3RhbGwg
bm90aWZ5IGhhbmRsZXIgKi8gDQorICAgIGludCBleHRfaGtfbnVtOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBleHRlcm5hbCBob3RrZXkvZXZlbnQgbnVtYmVyICovIA0KKyAgICBh
Y3BpX2hhbmRsZSBhY3RfaGFuZGxlOyAgICAgICAgICAgICAgICAgICAgICAgLyogYWNwaSBoYW5k
bGUgYXR0YWNoZWQgYW1sIGFjdGlvbiBtZXRob2QgKi8gDQorICAgIGNoYXIgKmFjdF9tZXRob2Q7
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBhY3Rpb24gbWV0aG9kICovIA0KK307DQor
DQorLyogDQorICogVGhlcmUgYXJlIHR3byB3YXlzIHRvIHBvbGwgc3RhdHVzDQorICogMS4gZGly
ZWN0eSBjYWxsIHJlYWRfeHh4IG1ldGhvZCwgd2l0aG91dCBhbnkgYXJndW1lbnRzIHBhc3NlZCBp
bg0KKyAqIDIuIGNhbGwgd3JpdGVfeHh4IG1ldGhvZCwgd2l0aCBhcmd1bWVudHMgcGFzc2VkIGlu
LCB5b3UgbmVlZA0KKyAqIHRoZSByZXN1bHQgaXMgc2F2ZWQgaW4gYWNwaV9wb2xsaW5nX2hvdGtl
eS5wbF9yZXN1bHQuDQorICogYW50aG9lciByZWFkIGNvbW1hbmQgdGhyb3VnaCBwb2xsaW5nIGlu
dGVyZmFjZS4NCisgKg0KKyAqLyANCisNCisvKiBwb2xsaW5nIGJhc2VkIGhvdGtleSAqLyANCitz
dHJ1Y3QgYWNwaV9wb2xsaW5nX2hvdGtleQ0KK3sNCisgICAgc3RydWN0IGFjcGlfaG90a2V5X2xp
bmsgaGtfbG5rOw0KKyAgICBpbnQgZmxhZzsNCisgICAgYWNwaV9oYW5kbGUgcG9sbF9oYW5kbGU7
ICAgICAgICAgICAgICAgICAgICAgIC8qIGFjcGkgaGFuZGxlIGF0dGFjaGVkIHBvbGxpbmcgbWV0
aG9kICovIA0KKyAgICBjaGFyICpwb2xsX21ldGhvZDsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyogcG9sbCBtZXRob2QgKi8gDQorICAgIGFjcGlfaGFuZGxlIGFjdF9oYW5kbGU7ICAgICAg
ICAgICAgICAgICAgICAgICAvKiBhY3BpIGhhbmRsZSBhdHRhY2hlZCBhY3Rpb24gbWV0aG9kICov
IA0KKyAgICBjaGFyICphY3RfbWV0aG9kOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyog
YWN0aW9uIG1ldGhvZCAqLyANCisgICAgdm9pZCAqcGxfcmVzdWx0OyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC8qIHBvbGxpbmdfcmVzdWx0ICovIA0KKyAgICBzdHJ1Y3QgcHJvY19kaXJf
ZW50cnkgKnByb2M7DQorfTsNCisNCisvKiBob3RrZXkgb2JqZWN0IHVuaW9uICovIA0KK3VuaW9u
IGFjcGlfaG90a2V5DQorew0KKyAgICBzdHJ1Y3QgbGlzdF9oZWFkIGVudHJpZXM7DQorICAgIHN0
cnVjdCBhY3BpX2hvdGtleV9saW5rIGxuazsNCisgICAgc3RydWN0IGFjcGlfZXZlbnRfaG90a2V5
IGV2X2hrOw0KKyAgICBzdHJ1Y3QgYWNwaV9wb2xsaW5nX2hvdGtleSBwbF9oazsNCit9Ow0KKw0K
Ky8qIGhvdGtleSBvYmplY3QgbGlzdCAqLyANCitzdHJ1Y3QgYWNwaV9ob3RrZXlfbGlzdA0KK3sN
CisgICAgc3RydWN0IGxpc3RfaGVhZCAqZW50cmllczsNCisgICAgaW50IGNvdW50Ow0KK307DQor
DQorc3RhdGljIGludCBhdXRvX2hvdGtleV9hZGQoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2Up
Ow0KK3N0YXRpYyBpbnQgYXV0b19ob3RrZXlfcmVtb3ZlKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2
aWNlLCBpbnQgdHlwZSk7DQorDQorc3RhdGljIHN0cnVjdCBhY3BpX2RyaXZlciBob3RrZXlfZHJp
dmVyID0NCit7DQorICAgIC5uYW1lID0gQUNQSV9IT1RLX05BTUUsDQorICAgIC5jbGFzcyA9IEFD
UElfSE9US19DTEFTUywNCisgICAgLmlkcyA9IEFDUElfSE9US19ISUQsDQorICAgIC5vcHMgPQ0K
KyAgICB7DQorICAgICAgICAuYWRkID0gYXV0b19ob3RrZXlfYWRkLA0KKyAgICAgICAgLnJlbW92
ZSA9IGF1dG9faG90a2V5X3JlbW92ZSwNCisgICAgfSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQgaG90
a2V5X29wZW5fY29uZmlnKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKTsN
CitzdGF0aWMgc3NpemVfdCBob3RrZXlfd3JpdGVfY29uZmlnKHN0cnVjdCBmaWxlICpmaWxlLA0K
K2NvbnN0IGNoYXIgX191c2VyICogYnVmZmVyLCBzaXplX3QgY291bnQsDQorbG9mZl90ICogZGF0
YSk7DQorc3RhdGljIHNzaXplX3QgaG90a2V5X3dyaXRlX3BsX2NvbmZpZyhzdHJ1Y3QgZmlsZSAq
ZmlsZSwNCitjb25zdCBjaGFyIF9fdXNlciAqIGJ1ZmZlciwgc2l6ZV90IGNvdW50LA0KK2xvZmZf
dCAqIGRhdGEpOw0KK3N0YXRpYyBpbnQgaG90a2V5X2luZm9fb3Blbl9mcyhzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSk7DQorc3RhdGljIGludCBob3RrZXlfYWN0aW9uX29w
ZW5fZnMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpOw0KK3N0YXRpYyBz
c2l6ZV90IGhvdGtleV9leGVjdXRlX2FtbF9tZXRob2Qoc3RydWN0IGZpbGUgKmZpbGUsDQorY29u
c3QgY2hhciBfX3VzZXIgKiBidWZmZXIsDQorc2l6ZV90IGNvdW50LCBsb2ZmX3QgKiBkYXRhKTsN
CitzdGF0aWMgaW50IGhvdGtleV9jb25maWdfc2VxX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEs
IHZvaWQgKm9mZnNldCk7DQorc3RhdGljIGludCBob3RrZXlfcG9sbGluZ19vcGVuX2ZzKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKTsNCisNCisvKiBldmVudCBiYXNlZCBj
b25maWcgKi8gDQorc3RhdGljIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgaG90a2V5X2NvbmZpZ19m
b3BzID0NCit7DQorICAgIC5vcGVuID0gaG90a2V5X29wZW5fY29uZmlnLA0KKyAgICAucmVhZCA9
IHNlcV9yZWFkLA0KKyAgICAud3JpdGUgPSBob3RrZXlfd3JpdGVfY29uZmlnLA0KKyAgICAubGxz
ZWVrID0gc2VxX2xzZWVrLA0KKyAgICAucmVsZWFzZSA9IHNpbmdsZV9yZWxlYXNlLA0KK307DQor
DQorLyogcG9sbGluZyBiYXNlZCBjb25maWcgKi8gDQorc3RhdGljIHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgaG90a2V5X3BsX2NvbmZpZ19mb3BzID0NCit7DQorICAgIC5vcGVuID0gaG90a2V5X29w
ZW5fY29uZmlnLA0KKyAgICAucmVhZCA9IHNlcV9yZWFkLA0KKyAgICAud3JpdGUgPSBob3RrZXlf
d3JpdGVfcGxfY29uZmlnLA0KKyAgICAubGxzZWVrID0gc2VxX2xzZWVrLA0KKyAgICAucmVsZWFz
ZSA9IHNpbmdsZV9yZWxlYXNlLA0KK307DQorDQorLyogaG90a2V5IGRyaXZlciBpbmZvICovIA0K
K3N0YXRpYyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGhvdGtleV9pbmZvX2ZvcHMgPQ0KK3sNCisg
ICAgLm9wZW4gPSBob3RrZXlfaW5mb19vcGVuX2ZzLA0KKyAgICAucmVhZCA9IHNlcV9yZWFkLA0K
KyAgICAubGxzZWVrID0gc2VxX2xzZWVrLA0KKyAgICAucmVsZWFzZSA9IHNpbmdsZV9yZWxlYXNl
LA0KK307DQorDQorLyogYWN0aW9uICovIA0KK3N0YXRpYyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25z
IGhvdGtleV9hY3Rpb25fZm9wcyA9DQorew0KKyAgICAub3BlbiA9IGhvdGtleV9hY3Rpb25fb3Bl
bl9mcywNCisgICAgLnJlYWQgPSBzZXFfcmVhZCwNCisgICAgLndyaXRlID0gaG90a2V5X2V4ZWN1
dGVfYW1sX21ldGhvZCwNCisgICAgLmxsc2VlayA9IHNlcV9sc2VlaywNCisgICAgLnJlbGVhc2Ug
PSBzaW5nbGVfcmVsZWFzZSwNCit9Ow0KKw0KKy8qIHBvbGxpbmcgcmVzdWx0cyAqLyANCitzdGF0
aWMgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBob3RrZXlfcG9sbGluZ19mb3BzID0NCit7DQorICAg
IC5vcGVuID0gaG90a2V5X3BvbGxpbmdfb3Blbl9mcywNCisgICAgLnJlYWQgPSBzZXFfcmVhZCwN
CisgICAgLmxsc2VlayA9IHNlcV9sc2VlaywNCisgICAgLnJlbGVhc2UgPSBzaW5nbGVfcmVsZWFz
ZSwNCit9Ow0KKw0KK3N0cnVjdCBhY3BpX2hvdGtleV9saXN0IGhvdGtleV9saXN0OyAgICAgICAg
ICAgICAgLyogbGluayBhbGwgZXYgb3IgcGwgaG90a2V5ICAqLyANCitzdHJ1Y3QgbGlzdF9oZWFk
IGhvdGtleV9lbnRyaWVzOyAgICAgICAgICAgICAgICAgIC8qIGhlYWQgb2YgdGhlIGxpc3Qgb2Yg
aG90a2V5X2xpc3QgKi8gDQorDQorc3RhdGljIGludCBob3RrZXlfaW5mb19zZXFfc2hvdyhzdHJ1
Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqb2Zmc2V0KQ0KK3sNCisgICAgQUNQSV9GVU5DVElPTl9U
UkFDRSgiaG90a2V5X2luZm9fc2VxX3Nob3ciKTsNCisNCisgICAgc2VxX3ByaW50ZihzZXEsICJI
b3RrZXkgZ2VuZXJpYyBkcml2ZXIgdmVyOiAlcyIsIEhPVEtFWV9BQ1BJX1ZFUlNJT04pOw0KKw0K
KyAgICByZXR1cm5fVkFMVUUoMCk7DQorfQ0KKw0KKw0KK3N0YXRpYyBpbnQgaG90a2V5X2luZm9f
b3Blbl9mcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkNCit7DQorICAg
IHJldHVybiBzaW5nbGVfb3BlbihmaWxlLCBob3RrZXlfaW5mb19zZXFfc2hvdywgUERFKGlub2Rl
KS0+ZGF0YSk7DQorfQ0KKw0KKw0KK3N0YXRpYyBjaGFyICpmb3JtYXRfcmVzdWx0KHVuaW9uIGFj
cGlfb2JqZWN0ICpvYmplY3QpDQorew0KKyAgICBjaGFyICpidWYgPSAoY2hhciAqKWttYWxsb2Mo
c2l6ZW9mKHVuaW9uIGFjcGlfb2JqZWN0KSwgR0ZQX0tFUk5FTCk7DQorDQorICAgIG1lbXNldChi
dWYsIDAsIHNpemVvZih1bmlvbiBhY3BpX29iamVjdCkpOw0KKw0KKyAgICAvKiBOb3csIGp1c3Qg
c3VwcG9ydCBpbnRlZ2VyIHR5cGUgKi8gDQorICAgIGlmIChvYmplY3QtPnR5cGUgPT0gQUNQSV9U
WVBFX0lOVEVHRVIpDQorICAgICAgICBzcHJpbnRmKGJ1ZiwgIiVkIiwgb2JqZWN0LT5pbnRlZ2Vy
LnZhbHVlKTsNCisNCisgICAgcmV0dXJuIGJ1ZjsNCit9DQorDQorDQorc3RhdGljIGludCBob3Rr
ZXlfcG9sbGluZ19zZXFfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqb2Zmc2V0KQ0K
K3sNCisgICAgc3RydWN0IGFjcGlfcG9sbGluZ19ob3RrZXkgKnBsX2hrID0NCisgICAgICAgIChz
dHJ1Y3QgYWNwaV9wb2xsaW5nX2hvdGtleSAqKXNlcS0+cHJpdmF0ZTsNCisNCisgICAgQUNQSV9G
VU5DVElPTl9UUkFDRSgiaG90a2V5X3BvbGxpbmdfc2VxX3Nob3ciKTsNCisNCisgICAgaWYgKHBs
X2hrLT5wbF9yZXN1bHQpDQorICAgICAgICBzZXFfcHJpbnRmKHNlcSwgIiVzIiwgZm9ybWF0X3Jl
c3VsdChwbF9oay0+cGxfcmVzdWx0KSk7DQorDQorICAgIHJldHVybl9WQUxVRSgwKTsNCit9DQor
DQorDQorc3RhdGljIGludCBob3RrZXlfcG9sbGluZ19vcGVuX2ZzKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KK3sNCisgICAgcmV0dXJuIHNpbmdsZV9vcGVuKGZpbGUs
IGhvdGtleV9wb2xsaW5nX3NlcV9zaG93LCBQREUoaW5vZGUpLT5kYXRhKTsNCit9DQorDQorDQor
c3RhdGljIGludCBob3RrZXlfYWN0aW9uX29wZW5fZnMoc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGZpbGUgKmZpbGUpDQorew0KKyAgICByZXR1cm4gc2luZ2xlX29wZW4oZmlsZSwgaG90a2V5
X2luZm9fc2VxX3Nob3csIFBERShpbm9kZSktPmRhdGEpOw0KK30NCisNCisNCisvKiBNYXBwaW5n
IGV4dGVybmFsIGhvdGtleSBudW1iZXIgdG8gc3RhbmRhcmRpemVkIGhvdGtleSBldmVudCBudW0g
Ki8gDQorc3RhdGljIGludCBob3RrZXlfZ2V0X2ludGVybmFsX2V2ZW50KGludCBldmVudCwgc3Ry
dWN0IGFjcGlfaG90a2V5X2xpc3QgKmxpc3QpDQorew0KKyAgICBzdHJ1Y3QgbGlzdF9oZWFkICpl
bnRyaWVzLCAqbmV4dDsNCisgICAgaW50IHZhbCA9IDA7DQorDQorICAgIEFDUElfRlVOQ1RJT05f
VFJBQ0UoImhvdGtleV9nZXRfaW50ZXJuYWxfZXZlbnQiKTsNCisNCisgICAgbGlzdF9mb3JfZWFj
aF9zYWZlKGVudHJpZXMsIG5leHQsIGxpc3QtPmVudHJpZXMpDQorICAgIHsNCisgICAgICAgIHVu
aW9uIGFjcGlfaG90a2V5ICprZXkgPQ0KKyAgICAgICAgICAgIGNvbnRhaW5lcl9vZihlbnRyaWVz
LCB1bmlvbiBhY3BpX2hvdGtleSwgZW50cmllcyk7DQorICAgICAgICBpZiAoa2V5LT5sbmsuaGtf
dHlwZSA9PSBBQ1BJX0hPVEtFWV9FVkVOVA0KKyAgICAgICAgICAgICYmIGtleS0+ZXZfaGsuZXh0
X2hrX251bSA9PSBldmVudCkNCisgICAgICAgICAgICB2YWwgPSBrZXktPmxuay5oa19zdGRfbnVt
Ow0KKyAgICAgICAgZWxzZQ0KKyAgICAgICAgICAgIHZhbCA9IC0xOw0KKyAgICB9DQorDQorICAg
IHJldHVybl9WQUxVRSh2YWwpOw0KK30NCisNCisNCitzdGF0aWMgdm9pZA0KK2FjcGlfaG90a2V5
X25vdGlmeV9oYW5kbGVyKGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyIGV2ZW50LCB2b2lkICpkYXRh
KQ0KK3sNCisgICAgLyogdW5pb24gYWNwaV9ob3RrZXkgICAgICprZXkgPSAodW5pb24gYWNwaV9o
b3RrZXkgKikgZGF0YTsgKi8gDQorICAgIHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlID0gTlVM
TDsNCisgICAgdTMyIGludGVybmFsX2V2ZW50Ow0KKw0KKyAgICBBQ1BJX0ZVTkNUSU9OX1RSQUNF
KCJhY3BpX2hvdGtleV9ub3RpZnlfaGFuZGxlciIpOw0KKw0KKyAgICBpZiAoYWNwaV9idXNfZ2V0
X2RldmljZShoYW5kbGUsICZkZXZpY2UpKQ0KKyAgICAgICAgcmV0dXJuX1ZPSUQ7DQorDQorICAg
IGludGVybmFsX2V2ZW50ID0gaG90a2V5X2dldF9pbnRlcm5hbF9ldmVudChldmVudCwgJmhvdGtl
eV9saXN0KTsNCisgICAgYWNwaV9idXNfZ2VuZXJhdGVfZXZlbnQoZGV2aWNlLCBpbnRlcm5hbF9l
dmVudCwgMCk7DQorDQorICAgIHJldHVybl9WT0lEOw0KK30NCisNCisNCisvKiBOZWVkIHRvIGlu
dmVudCBhdXRvbWF0aWNhbGx5IGhvdGtleSBhZGQgbWV0aG9kICovIA0KK3N0YXRpYyBpbnQgYXV0
b19ob3RrZXlfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKQ0KK3sNCisgICAgLyogSW1w
bGVtZW50IG1lICovIA0KKyAgICByZXR1cm4gMDsNCit9DQorDQorDQorLyogTmVlZCB0byBpbnZl
bnQgYXV0b21hdGljYWxseSBob3RrZXkgcmVtb3ZlIG1ldGhvZCAqLyANCitzdGF0aWMgaW50IGF1
dG9faG90a2V5X3JlbW92ZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHR5cGUpDQor
ew0KKyAgICAvKiBJbXBsZW1lbnQgbWUgKi8gDQorICAgIHJldHVybiAwOw0KK30NCisNCisNCisv
KiBDcmVhdGUgYSBwcm9jIGZpbGUgZm9yIGVhY2ggcG9sbGluZyBtZXRob2QgKi8gDQorc3RhdGlj
IGludCBjcmVhdGVfcG9sbGluZ19wcm9jKHVuaW9uIGFjcGlfaG90a2V5ICpkZXZpY2UpDQorew0K
KyAgICBzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKnByb2M7DQorDQorICAgIG1vZGVfdCBtb2RlID0g
U19JRlJFRyB8IFNfSVJVR08gfCBTX0lXVUdPOw0KKw0KKyAgICBwcm9jID0gY3JlYXRlX3Byb2Nf
ZW50cnkoZGV2aWNlLT5wbF9oay5hY3RfbWV0aG9kLA0KKyAgICAgICAgbW9kZSwgaG90a2V5X3By
b2NfZGlyKTsNCisNCisgICAgaWYgKCFwcm9jKQ0KKyAgICB7DQorICAgICAgICBwcmludGsoS0VS
Tl9FUlIgIkhvdGtleTogVW5hYmxlIHRvIGNyZWF0ZSAlcyBlbnRyeVxuIiwNCisgICAgICAgICAg
ICBkZXZpY2UtPnBsX2hrLnBvbGxfbWV0aG9kKTsNCisgICAgICAgIHJldHVybiAoLUVOT0RFVik7
DQorICAgIH0NCisgICAgZWxzZQ0KKyAgICB7DQorICAgICAgICBwcm9jLT5wcm9jX2ZvcHMgPSAm
aG90a2V5X3BvbGxpbmdfZm9wczsNCisgICAgICAgIHByb2MtPm93bmVyID0gVEhJU19NT0RVTEU7
DQorICAgICAgICBwcm9jLT5kYXRhID0gZGV2aWNlOw0KKyAgICAgICAgcHJvYy0+dWlkID0gMDsN
CisgICAgICAgIHByb2MtPmdpZCA9IDA7DQorICAgICAgICBkZXZpY2UtPnBsX2hrLnByb2MgPSBw
cm9jOw0KKyAgICB9DQorfQ0KKw0KKw0KK3N0YXRpYyBpbnQgaXNfdmFsaWRfYWNwaV9wYXRoKGNv
bnN0IGNoYXIgKnBhdGhuYW1lKQ0KK3sNCisgICAgYWNwaV9oYW5kbGUgaGFuZGxlOw0KKyAgICBh
Y3BpX3N0YXR1cyBzdGF0dXM7DQorDQorICAgIHN0YXR1cyA9IGFjcGlfZ2V0X2hhbmRsZShOVUxM
LCAoY2hhciAqKXBhdGhuYW1lLCAmaGFuZGxlKTsNCisgICAgcmV0dXJuICFBQ1BJX0ZBSUxVUkUo
c3RhdHVzKTsNCit9DQorDQorDQorc3RhdGljIGludCBpc192YWxpZF9ob3RrZXkodW5pb24gYWNw
aV9ob3RrZXkgKmRldmljZSkNCit7DQorICAgIC8qIEltcGxlbWVudCB2YWxpZCBjaGVjayAqLyAN
CisgICAgcmV0dXJuIFRSVUU7DQorfQ0KKw0KKw0KK3N0YXRpYyBpbnQgaG90a2V5X2FkZCh1bmlv
biBhY3BpX2hvdGtleSAqZGV2aWNlKQ0KK3sNCisgICAgaW50IHN0YXR1cyA9IDA7DQorDQorICAg
IGlmIChkZXZpY2UtPmxuay5oa190eXBlID09IEFDUElfSE9US0VZX0VWRU5UKQ0KKyAgICAgICAg
c3RhdHVzID0gYWNwaV9pbnN0YWxsX25vdGlmeV9oYW5kbGVyKGRldmljZS0+ZXZfaGsuYnVzX2hh
bmRsZSwNCisgICAgICAgICAgICBBQ1BJX0RFVklDRV9OT1RJRlksDQorICAgICAgICAgICAgYWNw
aV9ob3RrZXlfbm90aWZ5X2hhbmRsZXIsDQorICAgICAgICAgICAgZGV2aWNlKTsNCisgICAgZWxz
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIEFkZCBwb2xsaW5n
IGhvdGtleSAqLyANCisgICAgICAgIGNyZWF0ZV9wb2xsaW5nX3Byb2MoZGV2aWNlKTsNCisNCisg
ICAgaG90a2V5X2xpc3QuY291bnQrKzsNCisNCisgICAgcHJpbnRrKCJob3RrZXlfbGlzdC5jb3Vu
dCsrID0gJWRcbiIsIGhvdGtleV9saXN0LmNvdW50KTsNCisgICAgbGlzdF9hZGRfdGFpbCgmZGV2
aWNlLT5sbmsuZW50cmllcywgaG90a2V5X2xpc3QuZW50cmllcyk7DQorDQorICAgIHJldHVybiBz
dGF0dXM7DQorfQ0KKw0KKw0KK3N0YXRpYyBpbnQgaG90a2V5X3JlbW92ZSh1bmlvbiBhY3BpX2hv
dGtleSAqZGV2aWNlKQ0KK3sNCisgICAgc3RydWN0IGxpc3RfaGVhZCAqZW50cmllcywgKm5leHQ7
DQorDQorICAgIEFDUElfRlVOQ1RJT05fVFJBQ0UoImhvdGtleV91cGRhdGUiKTsNCisNCisgICAg
bGlzdF9mb3JfZWFjaF9zYWZlKGVudHJpZXMsIG5leHQsIGhvdGtleV9saXN0LmVudHJpZXMpDQor
ICAgIHsNCisgICAgICAgIHVuaW9uIGFjcGlfaG90a2V5ICprZXkgPQ0KKyAgICAgICAgICAgIGNv
bnRhaW5lcl9vZihlbnRyaWVzLCB1bmlvbiBhY3BpX2hvdGtleSwgZW50cmllcyk7DQorICAgICAg
ICBpZiAoa2V5LT5sbmsuaGtfc3RkX251bSA9PSBkZXZpY2UtPmxuay5oa19zdGRfbnVtKQ0KKyAg
ICAgICAgew0KKyAgICAgICAgICAgIGxpc3RfZGVsKCZrZXktPmxuay5lbnRyaWVzKTsNCisgICAg
ICAgICAgICByZW1vdmVfcHJvY19lbnRyeShrZXktPnBsX2hrLmFjdF9tZXRob2QsDQorICAgICAg
ICAgICAgICAgIGhvdGtleV9wcm9jX2Rpcik7DQorICAgICAgICAgICAgaG90a2V5X2xpc3QuY291
bnQtLTsNCisgICAgICAgICAgICBicmVhazsNCisgICAgICAgIH0NCisgICAgfQ0KKyAgICByZXR1
cm4gMDsNCit9DQorDQorDQorc3RhdGljIHZvaWQgaG90a2V5X3VwZGF0ZSh1bmlvbiBhY3BpX2hv
dGtleSAqaGspDQorew0KKyAgICBzdHJ1Y3QgbGlzdF9oZWFkICplbnRyaWVzLCAqbmV4dDsNCisN
CisgICAgQUNQSV9GVU5DVElPTl9UUkFDRSgiaG90a2V5X3VwZGF0ZSIpOw0KKw0KKyAgICBsaXN0
X2Zvcl9lYWNoX3NhZmUoZW50cmllcywgbmV4dCwgaG90a2V5X2xpc3QuZW50cmllcykNCisgICAg
ew0KKyAgICAgICAgdW5pb24gYWNwaV9ob3RrZXkgKmtleSA9DQorICAgICAgICAgICAgY29udGFp
bmVyX29mKGVudHJpZXMsIHVuaW9uIGFjcGlfaG90a2V5LCBlbnRyaWVzKTsNCisgICAgICAgIGlm
IChrZXktPmxuay5oa19zdGRfbnVtID09IGhrLT5sbmsuaGtfc3RkX251bSkNCisgICAgICAgIHsN
CisgICAgICAgICAgICBrZXktPmV2X2hrLmJ1c19oYW5kbGUgPSBoay0+ZXZfaGsuYnVzX2hhbmRs
ZTsNCisgICAgICAgICAgICBrZXktPmV2X2hrLmV4dF9oa19udW0gPSBoay0+ZXZfaGsuZXh0X2hr
X251bTsNCisgICAgICAgICAgICBrZXktPmV2X2hrLmFjdF9oYW5kbGUgPSBoay0+ZXZfaGsuYWN0
X2hhbmRsZTsNCisgICAgICAgICAgICBrZXktPmV2X2hrLmFjdF9tZXRob2QgPSBoay0+ZXZfaGsu
YWN0X21ldGhvZDsNCisgICAgICAgICAgICBicmVhazsNCisgICAgICAgIH0NCisgICAgfQ0KKw0K
KyAgICByZXR1cm5fVk9JRDsNCit9DQorDQorDQorc3RhdGljIHZvaWQgZnJlZV9ob3RrZXlfZGV2
aWNlKHVuaW9uIGFjcGlfaG90a2V5ICprZXkpDQorew0KK30NCisNCisNCitzdGF0aWMgaW50DQor
aW5pdF9ob3RrZXlfZGV2aWNlKHVuaW9uIGFjcGlfaG90a2V5ICprZXksDQorY2hhciAqYnVzX3N0
ciwNCitjaGFyICphY3Rpb25fc3RyLCBjaGFyICptZXRob2QsIGludCBzdGRfbnVtLCBpbnQgZXh0
X251bSkNCit7DQorICAgIGtleS0+bG5rLmhrX3R5cGUgPSBBQ1BJX0hPVEtFWV9FVkVOVDsNCisg
ICAga2V5LT5sbmsuaGtfc3RkX251bSA9IHN0ZF9udW07DQorICAgIGtleS0+ZXZfaGsuZmxhZyA9
IDA7DQorICAgIGlmIChpc192YWxpZF9hY3BpX3BhdGgoYnVzX3N0cikpDQorICAgICAgICBhY3Bp
X2dldF9oYW5kbGUoKGFjcGlfaGFuZGxlKSAwLA0KKyAgICAgICAgICAgIGJ1c19zdHIsICYoa2V5
LT5ldl9oay5idXNfaGFuZGxlKSk7DQorICAgIGtleS0+ZXZfaGsuZXh0X2hrX251bSA9IGV4dF9u
dW07DQorICAgIGlmIChpc192YWxpZF9hY3BpX3BhdGgoYWN0aW9uX3N0cikpDQorICAgICAgICBh
Y3BpX2dldF9oYW5kbGUoKGFjcGlfaGFuZGxlKSAwLA0KKyAgICAgICAgICAgIGFjdGlvbl9zdHIs
ICYoa2V5LT5ldl9oay5hY3RfaGFuZGxlKSk7DQorICAgIGtleS0+ZXZfaGsuYWN0X21ldGhvZCA9
IG1ldGhvZDsNCisgICAgcmV0dXJuIChpc192YWxpZF9ob3RrZXkoa2V5KSk7DQorfQ0KKw0KKw0K
K3N0YXRpYyBpbnQNCitpbml0X3BsX2hvdGtleV9kZXZpY2UodW5pb24gYWNwaV9ob3RrZXkgKmtl
eSwNCitjaGFyICpwb2xsX3N0ciwNCitjaGFyICpwb2xsX210ZCwNCitjaGFyICphY3Rpb25fc3Ry
LCBjaGFyICphY3Rpb25fbXRkLCBpbnQgc3RkX251bSkNCit7DQorICAgIGtleS0+bG5rLmhrX3R5
cGUgPSBBQ1BJX0hPVEtFWV9QT0xMSU5HOw0KKyAgICBrZXktPmxuay5oa19zdGRfbnVtID0gc3Rk
X251bTsNCisgICAga2V5LT5wbF9oay5mbGFnID0gMDsNCisgICAgaWYgKGlzX3ZhbGlkX2FjcGlf
cGF0aChwb2xsX3N0cikpDQorICAgICAgICBhY3BpX2dldF9oYW5kbGUoKGFjcGlfaGFuZGxlKSAw
LA0KKyAgICAgICAgICAgIHBvbGxfc3RyLCAmKGtleS0+cGxfaGsucG9sbF9oYW5kbGUpKTsNCisg
ICAga2V5LT5wbF9oay5wb2xsX21ldGhvZCA9IHBvbGxfbXRkOw0KKyAgICBpZiAoaXNfdmFsaWRf
YWNwaV9wYXRoKGFjdGlvbl9zdHIpKQ0KKyAgICAgICAgYWNwaV9nZXRfaGFuZGxlKChhY3BpX2hh
bmRsZSkgMCwNCisgICAgICAgICAgICBhY3Rpb25fc3RyLCAmKGtleS0+cGxfaGsuYWN0X2hhbmRs
ZSkpOw0KKyAgICBrZXktPnBsX2hrLmFjdF9tZXRob2QgPSBhY3Rpb25fbXRkOw0KKyAgICBrZXkt
PnBsX2hrLnBsX3Jlc3VsdCA9DQorICAgICAgICAodW5pb24gYWNwaV9vYmplY3QgKilrbWFsbG9j
KHNpemVvZih1bmlvbiBhY3BpX29iamVjdCksIEdGUF9LRVJORUwpOw0KKyAgICByZXR1cm4gKGlz
X3ZhbGlkX2hvdGtleShrZXkpKTsNCit9DQorDQorDQorc3RhdGljIGludCBjaGVja19ob3RrZXlf
dmFsaWQodW5pb24gYWNwaV9ob3RrZXkgKmtleSwNCitzdHJ1Y3QgYWNwaV9ob3RrZXlfbGlzdCAq
bGlzdCkNCit7DQorICAgIHJldHVybiAxOw0KK30NCisNCisNCitzdGF0aWMgaW50IGhvdGtleV9v
cGVuX2NvbmZpZyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkNCit7DQor
ICAgIHJldHVybiBzaW5nbGVfb3BlbihmaWxlLCBob3RrZXlfY29uZmlnX3NlcV9zaG93LCBQREUo
aW5vZGUpLT5kYXRhKTsNCit9DQorDQorDQorc3RhdGljIGludCBob3RrZXlfY29uZmlnX3NlcV9z
aG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICpvZmZzZXQpDQorew0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogKHN0cnVjdCBhY3BpX2hv
dGtleV9saXN0ICopc2VxLT5wcml2YXRlOyAqLyANCisgICAgc3RydWN0IGFjcGlfaG90a2V5X2xp
c3QgKmhrX2xpc3QgPSAmaG90a2V5X2xpc3Q7DQorICAgIHN0cnVjdCBsaXN0X2hlYWQgKmVudHJp
ZXMsICpuZXh0Ow0KKyAgICBjaGFyIGJ1c19uYW1lW0FDUElfUEFUSE5BTUVfTUFYXSA9IHsgMCB9
Ow0KKyAgICBjaGFyIGFjdF9uYW1lW0FDUElfUEFUSE5BTUVfTUFYXSA9IHsgMCB9Ow0KKyAgICBz
dHJ1Y3QgYWNwaV9idWZmZXIgYnVzID0geyBBQ1BJX1BBVEhOQU1FX01BWCwgYnVzX25hbWUgfTsN
CisgICAgc3RydWN0IGFjcGlfYnVmZmVyIGFjdCA9IHsgQUNQSV9QQVRITkFNRV9NQVgsIGFjdF9u
YW1lIH07DQorDQorICAgIEFDUElfRlVOQ1RJT05fVFJBQ0UoKCJob3RrZXlfY29uZmlnX3NlcV9z
aG93IikpOw0KKw0KKyAgICBpZiAoIWhrX2xpc3QpDQorICAgICAgICBnb3RvIGVuZDsNCisNCisg
ICAgbGlzdF9mb3JfZWFjaF9zYWZlKGVudHJpZXMsIG5leHQsIGhrX2xpc3QtPmVudHJpZXMpDQor
ICAgIHsNCisgICAgICAgIHVuaW9uIGFjcGlfaG90a2V5ICprZXkgPQ0KKyAgICAgICAgICAgIGNv
bnRhaW5lcl9vZihlbnRyaWVzLCB1bmlvbiBhY3BpX2hvdGtleSwgZW50cmllcyk7DQorICAgICAg
ICBpZiAoa2V5LT5sbmsuaGtfdHlwZSA9PSBBQ1BJX0hPVEtFWV9FVkVOVCkNCisgICAgICAgIHsN
CisgICAgICAgICAgICBhY3BpX2dldF9uYW1lKGtleS0+ZXZfaGsuYnVzX2hhbmRsZSwgQUNQSV9O
QU1FX1RZUEVfTUFYLA0KKyAgICAgICAgICAgICAgICAmYnVzKTsNCisgICAgICAgICAgICBhY3Bp
X2dldF9uYW1lKGtleS0+ZXZfaGsuYWN0X2hhbmRsZSwgQUNQSV9OQU1FX1RZUEVfTUFYLA0KKyAg
ICAgICAgICAgICAgICAmYWN0KTsNCisgICAgICAgICAgICBzZXFfcHJpbnRmKHNlcSwgIiVzOiVz
OiVzOiVkOiVkIiwgYnVzX25hbWUsIGFjdF9uYW1lLA0KKyAgICAgICAgICAgICAgICBrZXktPmV2
X2hrLmFjdF9tZXRob2QsIGtleS0+bG5rLmhrX3N0ZF9udW0sDQorICAgICAgICAgICAgICAgIGtl
eS0+ZXZfaGsuZXh0X2hrX251bSk7DQorICAgICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAvKiBBQ1BJX0hPVEtFWV9QT0xMSU5HICovIA0KKyAgICAgICAgZWxz
ZQ0KKyAgICAgICAgew0KKyAgICAgICAgICAgIGFjcGlfZ2V0X25hbWUoa2V5LT5wbF9oay5wb2xs
X2hhbmRsZSwNCisgICAgICAgICAgICAgICAgQUNQSV9OQU1FX1RZUEVfTUFYLCAmYnVzKTsNCisg
ICAgICAgICAgICBhY3BpX2dldF9uYW1lKGtleS0+cGxfaGsuYWN0X2hhbmRsZSwgQUNQSV9OQU1F
X1RZUEVfTUFYLA0KKyAgICAgICAgICAgICAgICAmYWN0KTsNCisgICAgICAgICAgICBzZXFfcHJp
bnRmKHNlcSwgIiVzOiVzOiVzOiVzOiVkIiwgYnVzX25hbWUsDQorICAgICAgICAgICAgICAgIGtl
eS0+cGxfaGsucG9sbF9tZXRob2QsIGFjdF9uYW1lLA0KKyAgICAgICAgICAgICAgICBrZXktPnBs
X2hrLmFjdF9tZXRob2QsIGtleS0+bG5rLmhrX3N0ZF9udW0pOw0KKyAgICAgICAgfQ0KKyAgICB9
DQorICAgIHNlcV9wdXRzKHNlcSwgIlxuIik7DQorICAgIGVuZDoNCisgICAgcmV0dXJuX1ZBTFVF
KDApOw0KK30NCisNCisNCitzdGF0aWMgaW50DQorZ2V0X3Bhcm1zKGNoYXIgKmNvbmZpZ19yZWNv
cmQsDQoraW50ICpjbWQsDQorY2hhciAqYnVzX2hhbmRsZSwNCitjaGFyICpidXNfbWV0aG9kLA0K
K2NoYXIgKmFjdGlvbl9oYW5kbGUsDQorY2hhciAqbWV0aG9kLCBpbnQgKmludGVybmFsX2V2ZW50
X251bSwgaW50ICpleHRlcm5hbF9ldmVudF9udW0pDQorew0KKyAgICBjaGFyICp0bXAsICp0bXAx
Ow0KKyAgICBzc2NhbmYoY29uZmlnX3JlY29yZCwgIiVkIiwgY21kKTsNCisNCisgICAgdG1wID0g
c3RyY2hyKGNvbmZpZ19yZWNvcmQsICc6Jyk7DQorICAgIHRtcCsrOw0KKyAgICB0bXAxID0gc3Ry
Y2hyKHRtcCwgJzonKTsNCisgICAgc3RybmNweShidXNfaGFuZGxlLCB0bXAsIHRtcDEgLSB0bXAp
Ow0KKyAgICBidXNfaGFuZGxlW3RtcDEgLSB0bXBdID0gMDsNCisNCisgICAgdG1wID0gdG1wMTsN
CisgICAgdG1wKys7DQorICAgIHRtcDEgPSBzdHJjaHIodG1wLCAnOicpOw0KKyAgICBzdHJuY3B5
KGJ1c19tZXRob2QsIHRtcCwgdG1wMSAtIHRtcCk7DQorICAgIGJ1c19tZXRob2RbdG1wMSAtIHRt
cF0gPSAwOw0KKw0KKyAgICB0bXAgPSB0bXAxOw0KKyAgICB0bXArKzsNCisgICAgdG1wMSA9IHN0
cmNocih0bXAsICc6Jyk7DQorICAgIHN0cm5jcHkoYWN0aW9uX2hhbmRsZSwgdG1wLCB0bXAxIC0g
dG1wKTsNCisgICAgYWN0aW9uX2hhbmRsZVt0bXAxIC0gdG1wXSA9IDA7DQorDQorICAgIHRtcCA9
IHRtcDE7DQorICAgIHRtcCsrOw0KKyAgICB0bXAxID0gc3RyY2hyKHRtcCwgJzonKTsNCisgICAg
c3RybmNweShtZXRob2QsIHRtcCwgdG1wMSAtIHRtcCk7DQorICAgIG1ldGhvZFt0bXAxIC0gdG1w
XSA9IDA7DQorDQorICAgIHNzY2FuZih0bXAxICsgMSwgIiVkOiVkIiwgaW50ZXJuYWxfZXZlbnRf
bnVtLCBleHRlcm5hbF9ldmVudF9udW0pOw0KKyAgICByZXR1cm4gNjsNCit9DQorDQorDQorLyog
IGNvdW50IGlzIGxlbmd0aCBmb3Igb25lIGlucHV0IHJlY29yZCAqLyANCitzdGF0aWMgc3NpemVf
dCBob3RrZXlfd3JpdGVfY29uZmlnKHN0cnVjdCBmaWxlICpmaWxlLA0KK2NvbnN0IGNoYXIgX191
c2VyICogYnVmZmVyLCBzaXplX3QgY291bnQsDQorbG9mZl90ICogZGF0YSkNCit7DQorICAgIHN0
cnVjdCBzZXFfZmlsZSAqbSA9IChzdHJ1Y3Qgc2VxX2ZpbGUgKilmaWxlLT5wcml2YXRlX2RhdGE7
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiAo
c3RydWN0IGFjcGlfaG90a2V5X2xpc3QgKilzZXEtPnByaXZhdGU7ICovIA0KKyAgICBzdHJ1Y3Qg
YWNwaV9ob3RrZXlfbGlzdCAqaGtfbGlzdCA9ICZob3RrZXlfbGlzdDsNCisgICAgY2hhciBjb25m
aWdfcmVjb3JkW01BWF9DT05GSUdfUkVDT1JEX0xFTl07DQorICAgIGNoYXIgYnVzX2hhbmRsZVtN
QVhfTkFNRV9QQVRIX0xFTl07DQorICAgIGNoYXIgYnVzX21ldGhvZFtNQVhfTkFNRV9QQVRIX0xF
Tl07DQorICAgIGNoYXIgYWN0aW9uX2hhbmRsZVtNQVhfTkFNRV9QQVRIX0xFTl07DQorICAgIGNo
YXIgbWV0aG9kWzIwXTsNCisgICAgaW50IGNtZCwgaW50ZXJuYWxfZXZlbnRfbnVtLCBleHRlcm5h
bF9ldmVudF9udW07DQorICAgIGludCByZXQgPSAwOw0KKyAgICB1bmlvbiBhY3BpX2hvdGtleSAq
a2V5ID0gTlVMTDsNCisNCisgICAgQUNQSV9GVU5DVElPTl9UUkFDRSgiaG90a2V5X3dyaXRlX2Nv
bmZpZyIpOw0KKw0KKyAgICBpZiAoIWhrX2xpc3QgfHwgY291bnQgPiBNQVhfQ09ORklHX1JFQ09S
RF9MRU4pDQorICAgIHsNCisgICAgICAgIEFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfRVJST1Is
ICJJbnZhbGlkIGFyZ3VtZW50c1xuIikpOw0KKyAgICAgICAgcmV0dXJuX1ZBTFVFKC1FSU5WQUwp
Ow0KKyAgICB9DQorDQorICAgIGlmIChjb3B5X2Zyb21fdXNlcihjb25maWdfcmVjb3JkLCBidWZm
ZXIsIGNvdW50KSkNCisgICAgew0KKyAgICAgICAgQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9F
UlJPUiwgIkludmFsaWQgZGF0YSBcbiIpKTsNCisgICAgICAgIHJldHVybl9WQUxVRSgtRUlOVkFM
KTsNCisgICAgfQ0KKyAgICBjb25maWdfcmVjb3JkW2NvdW50XSA9ICdcMCc7DQorICAgIEFDUElf
REVCVUdfUFJJTlQoKEFDUElfREJfRVJST1IsICJjb25maWdfc3RyOiAlcyIsIGNvbmZpZ19yZWNv
cmQpKTsNCisNCisgICAgcmV0ID0gZ2V0X3Bhcm1zKGNvbmZpZ19yZWNvcmQsDQorCS8qCSANCisg
ICAgICAgICAgcmV0ID0gc3NjYW5mKGNvbmZpZ19yZWNvcmQsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAiJWQ6JXM6JXM6JXM6JWQ6JWQiLA0KKwkJCSAgKi8NCisgICAgICAgICZjbWQsDQor
ICAgICAgICBidXNfaGFuZGxlLA0KKyAgICAgICAgYnVzX21ldGhvZCwNCisgICAgICAgIGFjdGlv
bl9oYW5kbGUsDQorICAgICAgICBtZXRob2QsICZpbnRlcm5hbF9ldmVudF9udW0sICZleHRlcm5h
bF9ldmVudF9udW0pOw0KKyAgICBpZiAocmV0ICE9IDYpDQorICAgIHsNCisgICAgICAgIEFDUElf
REVCVUdfUFJJTlQoKEFDUElfREJfRVJST1IsICJJbnZhbGlkIGRhdGEgZm9ybWF0IHJldD0lZFxu
IiwNCisgICAgICAgICAgICByZXQpKTsNCisgICAgICAgIHJldHVybl9WQUxVRSgtRUlOVkFMKTsN
CisgICAgfQ0KKw0KKyAgICBrZXkgPSBrbWFsbG9jKHNpemVvZih1bmlvbiBhY3BpX2hvdGtleSks
IEdGUF9LRVJORUwpOw0KKyAgICByZXQgPSBpbml0X2hvdGtleV9kZXZpY2Uoa2V5LCBidXNfaGFu
ZGxlLCBhY3Rpb25faGFuZGxlLCBtZXRob2QsDQorICAgICAgICBpbnRlcm5hbF9ldmVudF9udW0s
IGV4dGVybmFsX2V2ZW50X251bSk7DQorDQorICAgIGlmIChyZXQgfHwgY2hlY2tfaG90a2V5X3Zh
bGlkKGtleSwgJmhvdGtleV9saXN0KSkNCisgICAgew0KKyAgICAgICAgZnJlZV9ob3RrZXlfZGV2
aWNlKGtleSk7DQorICAgICAgICBBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJX0RCX0VSUk9SLCAiSW52
YWxpZCBob3RrZXkgXG4iKSk7DQorICAgICAgICByZXR1cm5fVkFMVUUoLUVJTlZBTCk7DQorICAg
IH0NCisgICAgc3dpdGNoIChjbWQpDQorICAgIHsNCisgICAgICAgIGNhc2UgMDoNCisgICAgICAg
ICAgICBob3RrZXlfYWRkKGtleSk7DQorICAgICAgICAgICAgYnJlYWs7DQorICAgICAgICBjYXNl
IDE6DQorICAgICAgICAgICAgaG90a2V5X3JlbW92ZShrZXkpOw0KKyAgICAgICAgICAgIGJyZWFr
Ow0KKyAgICAgICAgY2FzZSAyOg0KKyAgICAgICAgICAgIGhvdGtleV91cGRhdGUoa2V5KTsNCisg
ICAgICAgICAgICBicmVhazsNCisgICAgICAgIGRlZmF1bHQ6DQorICAgICAgICAgICAgYnJlYWs7
DQorICAgIH0NCisgICAgcmV0dXJuX1ZBTFVFKGNvdW50KTsNCit9DQorDQorDQorLyogIGNvdW50
IGlzIGxlbmd0aCBmb3Igb25lIGlucHV0IHJlY29yZCAqLyANCitzdGF0aWMgc3NpemVfdCBob3Rr
ZXlfd3JpdGVfcGxfY29uZmlnKHN0cnVjdCBmaWxlICpmaWxlLA0KK2NvbnN0IGNoYXIgX191c2Vy
ICogYnVmZmVyLCBzaXplX3QgY291bnQsDQorbG9mZl90ICogZGF0YSkNCit7DQorICAgIHN0cnVj
dCBzZXFfZmlsZSAqbSA9IChzdHJ1Y3Qgc2VxX2ZpbGUgKilmaWxlLT5wcml2YXRlX2RhdGE7DQor
ICAgIHN0cnVjdCBhY3BpX2hvdGtleV9saXN0ICpoa19saXN0ID0NCisgICAgICAgIChzdHJ1Y3Qg
YWNwaV9ob3RrZXlfbGlzdCAqKW0tPnByaXZhdGU7DQorDQorICAgIGNoYXIgY29uZmlnX3JlY29y
ZFtNQVhfQ09ORklHX1JFQ09SRF9MRU5dOw0KKyAgICBjaGFyIHBvbGxpbmdfaGFuZGxlW01BWF9O
QU1FX1BBVEhfTEVOXTsNCisgICAgY2hhciBhY3Rpb25faGFuZGxlW01BWF9OQU1FX1BBVEhfTEVO
XTsNCisgICAgY2hhciBwb2xsX21ldGhvZFsyMF0sIGFjdGlvbl9tZXRob2RbMjBdOw0KKyAgICBp
bnQgcmV0LCBpbnRlcm5hbF9ldmVudF9udW0sIGNtZCwgZXh0ZXJuYWxfZXZlbnRfbnVtOw0KKyAg
ICB1bmlvbiBhY3BpX2hvdGtleSAqa2V5ID0gTlVMTDsNCisNCisgICAgQUNQSV9GVU5DVElPTl9U
UkFDRSgiaG90a2V5X3dyaXRlX2NvbmZpZyIpOw0KKw0KKyAgICBpZiAoIWhrX2xpc3QgfHwgY291
bnQgPiBNQVhfQ09ORklHX1JFQ09SRF9MRU4pDQorICAgIHsNCisgICAgICAgIEFDUElfREVCVUdf
UFJJTlQoKEFDUElfREJfRVJST1IsICJJbnZhbGlkIGFyZ3VtZW50c1xuIikpOw0KKyAgICAgICAg
cmV0dXJuX1ZBTFVFKC1FSU5WQUwpOw0KKyAgICB9DQorDQorICAgIGlmIChjb3B5X2Zyb21fdXNl
cihjb25maWdfcmVjb3JkLCBidWZmZXIsIGNvdW50KSkNCisgICAgew0KKyAgICAgICAgQUNQSV9E
RUJVR19QUklOVCgoQUNQSV9EQl9FUlJPUiwgIkludmFsaWQgZGF0YSBcbiIpKTsNCisgICAgICAg
IHJldHVybl9WQUxVRSgtRUlOVkFMKTsNCisgICAgfQ0KKyAgICBjb25maWdfcmVjb3JkW2NvdW50
XSA9ICdcMCc7DQorDQorICAgIHJldCA9IGdldF9wYXJtcyhjb25maWdfcmVjb3JkLA0KKyAgICAg
ICAgJmNtZCwNCisgICAgICAgIHBvbGxpbmdfaGFuZGxlLA0KKyAgICAgICAgcG9sbF9tZXRob2Qs
DQorICAgICAgICBhY3Rpb25faGFuZGxlLA0KKyAgICAgICAgYWN0aW9uX21ldGhvZCwNCisgICAg
ICAgICZpbnRlcm5hbF9ldmVudF9udW0sICZleHRlcm5hbF9ldmVudF9udW0pOw0KKw0KKyAgICBp
ZiAocmV0ICE9IDYpDQorICAgIHsNCisgICAgICAgIEFDUElfREVCVUdfUFJJTlQoKEFDUElfREJf
RVJST1IsICJJbnZhbGlkIGRhdGEgZm9ybWF0XG4iKSk7DQorICAgICAgICByZXR1cm5fVkFMVUUo
LUVJTlZBTCk7DQorICAgIH0NCisNCisgICAga2V5ID0ga21hbGxvYyhzaXplb2YodW5pb24gYWNw
aV9ob3RrZXkpLCBHRlBfS0VSTkVMKTsNCisgICAgcmV0ID0gaW5pdF9wbF9ob3RrZXlfZGV2aWNl
KGtleSwgcG9sbGluZ19oYW5kbGUsIHBvbGxfbWV0aG9kLA0KKyAgICAgICAgYWN0aW9uX2hhbmRs
ZSwgYWN0aW9uX21ldGhvZCwNCisgICAgICAgIGludGVybmFsX2V2ZW50X251bSk7DQorICAgIGlm
IChyZXQgfHwgY2hlY2tfaG90a2V5X3ZhbGlkKGtleSwgJmhvdGtleV9saXN0KSkNCisgICAgew0K
KyAgICAgICAgZnJlZV9ob3RrZXlfZGV2aWNlKGtleSk7DQorICAgICAgICBBQ1BJX0RFQlVHX1BS
SU5UKChBQ1BJX0RCX0VSUk9SLCAiSW52YWxpZCBob3RrZXkgXG4iKSk7DQorICAgICAgICByZXR1
cm5fVkFMVUUoLUVJTlZBTCk7DQorICAgIH0NCisgICAgc3dpdGNoIChjbWQpDQorICAgIHsNCisg
ICAgICAgIGNhc2UgMDoNCisgICAgICAgICAgICBob3RrZXlfYWRkKGtleSk7DQorICAgICAgICAg
ICAgYnJlYWs7DQorICAgICAgICBjYXNlIDE6DQorICAgICAgICAgICAgaG90a2V5X3JlbW92ZShr
ZXkpOw0KKyAgICAgICAgICAgIGJyZWFrOw0KKyAgICAgICAgY2FzZSAyOg0KKyAgICAgICAgICAg
IGhvdGtleV91cGRhdGUoa2V5KTsNCisgICAgICAgICAgICBicmVhazsNCisgICAgICAgIGRlZmF1
bHQ6DQorICAgICAgICAgICAgYnJlYWs7DQorICAgIH0NCisgICAgcmV0dXJuX1ZBTFVFKGNvdW50
KTsNCit9DQorDQorDQorLyogIA0KKyAqIFRoaXMgZnVuY3Rpb24gZXZhbHVhdGVzIGFuIEFDUEkg
bWV0aG9kLCBnaXZlbiBhbiBpbnQgYXMgcGFyYW1ldGVyLCB0aGUNCisgKiBtZXRob2QgaXMgc2Vh
cmNoZWQgd2l0aGluIHRoZSBzY29wZSBvZiB0aGUgaGFuZGxlLCBjYW4gYmUgTlVMTC4gVGhlIG91
dHB1dA0KKyAqIG9mIHRoZSBtZXRob2QgaXMgd3JpdHRlbiBpcyBvdXRwdXQsIHdoaWNoIGNhbiBh
bHNvIGJlIE5VTEwNCisgKg0KKyAqIHJldHVybnMgMSBpZiB3cml0ZSBpcyBzdWNjZXNzZnVsLCAw
IGVsc2UuDQorICovIA0KK3N0YXRpYyBpbnQgd3JpdGVfYWNwaV9pbnQoYWNwaV9oYW5kbGUgaGFu
ZGxlLCBjb25zdCBjaGFyICptZXRob2QsIGludCB2YWwsDQorc3RydWN0IGFjcGlfYnVmZmVyICpv
dXRwdXQpDQorew0KKyAgICBzdHJ1Y3QgYWNwaV9vYmplY3RfbGlzdCBwYXJhbXM7ICAgICAgICAg
ICAgICAgLyogbGlzdCBvZiBpbnB1dCBwYXJhbWV0ZXJzIChhbiBpbnQgaGVyZSkgKi8NCisgICAg
dW5pb24gYWNwaV9vYmplY3QgaW5fb2JqOyAgICAgICAgICAgICAgICAgICAgIC8qIHRoZSBvbmx5
IHBhcmFtIHdlIHVzZSAqLw0KKyAgICBhY3BpX3N0YXR1cyBzdGF0dXM7DQorDQorICAgIEFDUElf
RlVOQ1RJT05fVFJBQ0UoIndyaXRlX2FjcGlfaW50Iik7DQorICAgIHBhcmFtcy5jb3VudCA9IDE7
DQorICAgIHBhcmFtcy5wb2ludGVyID0gJmluX29iajsNCisgICAgaW5fb2JqLnR5cGUgPSBBQ1BJ
X1RZUEVfSU5URUdFUjsNCisgICAgaW5fb2JqLmludGVnZXIudmFsdWUgPSB2YWw7DQorDQorICAg
IHN0YXR1cyA9IGFjcGlfZXZhbHVhdGVfb2JqZWN0KGhhbmRsZSwgKGNoYXIgKiltZXRob2QsICZw
YXJhbXMsIG91dHB1dCk7DQorDQorICAgIHJldHVybl9WQUxVRShzdGF0dXMgPT0gQUVfT0spOw0K
K30NCisNCisNCitzdGF0aWMgaW50IHJlYWRfYWNwaV9pbnQoYWNwaV9oYW5kbGUgaGFuZGxlLCBj
b25zdCBjaGFyICptZXRob2QsIGludCAqdmFsKQ0KK3sNCisgICAgc3RydWN0IGFjcGlfYnVmZmVy
IG91dHB1dDsNCisgICAgdW5pb24gYWNwaV9vYmplY3Qgb3V0X29iajsNCisgICAgYWNwaV9zdGF0
dXMgc3RhdHVzOw0KKw0KKyAgICBvdXRwdXQubGVuZ3RoID0gc2l6ZW9mKG91dF9vYmopOw0KKyAg
ICBvdXRwdXQucG9pbnRlciA9ICZvdXRfb2JqOw0KKw0KKyAgICBzdGF0dXMgPSBhY3BpX2V2YWx1
YXRlX29iamVjdChoYW5kbGUsIChjaGFyICopbWV0aG9kLCBOVUxMLCAmb3V0cHV0KTsNCisgICAg
KnZhbCA9IG91dF9vYmouaW50ZWdlci52YWx1ZTsNCisgICAgcmV0dXJuIChzdGF0dXMgPT0gQUVf
T0spICYmIChvdXRfb2JqLnR5cGUgPT0gQUNQSV9UWVBFX0lOVEVHRVIpOw0KK30NCisNCisNCitz
dGF0aWMgYWNwaV9oYW5kbGUNCitnZXRfaGFuZGxlX2Zyb21faG90a2V5bGlzdChzdHJ1Y3QgYWNw
aV9ob3RrZXlfbGlzdCAqaGtfbGlzdCwgaW50IGV2ZW50X251bSkNCit7DQorICAgIHN0cnVjdCBs
aXN0X2hlYWQgKmVudHJpZXMsICpuZXh0Ow0KKw0KKyAgICBsaXN0X2Zvcl9lYWNoX3NhZmUoZW50
cmllcywgbmV4dCwgaGtfbGlzdC0+ZW50cmllcykNCisgICAgew0KKyAgICAgICAgdW5pb24gYWNw
aV9ob3RrZXkgKmtleSA9DQorICAgICAgICAgICAgY29udGFpbmVyX29mKGVudHJpZXMsIHVuaW9u
IGFjcGlfaG90a2V5LCBlbnRyaWVzKTsNCisgICAgICAgIGlmIChrZXktPmxuay5oa190eXBlID09
IEFDUElfSE9US0VZX0VWRU5UDQorICAgICAgICAgICAgJiYga2V5LT5sbmsuaGtfc3RkX251bSA9
PSBldmVudF9udW0pDQorICAgICAgICB7DQorICAgICAgICAgICAgcmV0dXJuIChrZXktPmV2X2hr
LmFjdF9oYW5kbGUpOw0KKyAgICAgICAgfQ0KKyAgICB9DQorICAgIHJldHVybiBOVUxMOw0KK30N
CisNCisNCitzdGF0aWMNCitjaGFyICpnZXRfbWV0aG9kX2Zyb21faG90a2V5bGlzdChzdHJ1Y3Qg
YWNwaV9ob3RrZXlfbGlzdCAqaGtfbGlzdCwNCitpbnQgZXZlbnRfbnVtKQ0KK3sNCisgICAgc3Ry
dWN0IGxpc3RfaGVhZCAqZW50cmllcywgKm5leHQ7DQorDQorICAgIGxpc3RfZm9yX2VhY2hfc2Fm
ZShlbnRyaWVzLCBuZXh0LCBoa19saXN0LT5lbnRyaWVzKQ0KKyAgICB7DQorICAgICAgICB1bmlv
biBhY3BpX2hvdGtleSAqa2V5ID0NCisgICAgICAgICAgICBjb250YWluZXJfb2YoZW50cmllcywg
dW5pb24gYWNwaV9ob3RrZXksIGVudHJpZXMpOw0KKw0KKyAgICAgICAgaWYgKGtleS0+bG5rLmhr
X3R5cGUgPT0gQUNQSV9IT1RLRVlfRVZFTlQgJiYNCisgICAgICAgICAgICBrZXktPmxuay5oa19z
dGRfbnVtID09IGV2ZW50X251bSkNCisgICAgICAgIHsNCisgICAgICAgICAgICByZXR1cm4gKGtl
eS0+ZXZfaGsuYWN0X21ldGhvZCk7DQorICAgICAgICB9DQorICAgIH0NCisgICAgcmV0dXJuIE5V
TEw7DQorfQ0KKw0KKw0KK3N0YXRpYw0KK3N0cnVjdCBhY3BpX3BvbGxpbmdfaG90a2V5ICpnZXRf
aG90a2V5X2J5X2V2dChzdHJ1Y3QgYWNwaV9ob3RrZXlfbGlzdCAqaGtfbGlzdCwNCitpbnQgZXZ0
KQ0KK3sNCisgICAgc3RydWN0IGxpc3RfaGVhZCAqZW50cmllcywgKm5leHQ7DQorDQorICAgIGxp
c3RfZm9yX2VhY2hfc2FmZShlbnRyaWVzLCBuZXh0LCBoa19saXN0LT5lbnRyaWVzKQ0KKyAgICB7
DQorICAgICAgICB1bmlvbiBhY3BpX2hvdGtleSAqa2V5ID0NCisgICAgICAgICAgICBjb250YWlu
ZXJfb2YoZW50cmllcywgdW5pb24gYWNwaV9ob3RrZXksIGVudHJpZXMpOw0KKyAgICAgICAgaWYg
KGtleS0+bG5rLmhrX3R5cGUgPT0gQUNQSV9IT1RLRVlfUE9MTElORw0KKyAgICAgICAgICAgICYm
IGtleS0+bG5rLmhrX3N0ZF9udW0gPT0gZXZ0KQ0KKyAgICAgICAgew0KKyAgICAgICAgICAgIHJl
dHVybiAoJmtleS0+cGxfaGspOw0KKyAgICAgICAgfQ0KKyAgICB9DQorICAgIHJldHVybiBOVUxM
Ow0KK30NCisNCisNCisvKiAgDQorICogdXNlciBjYWxsIEFNTCBtZXRob2QgaW50ZXJmYWNlOg0K
KyAqIENhbGwgY29udmVudGlvbjoNCisgKiBlY2hvICJldmVudF9udW06IGFyZyB0eXBlIDogdmFs
dWUiDQorICogZXhhbXBsZTogZWNobyAiMToxOjMwIiA+IC9wcm9jL2FjcGkvYWN0aW9uDQorICog
SnVzdCBzdXBwb3J0IDEgaW50ZWdlciBhcmcgcGFzc2luZyB0byBBTUwgbWV0aG9kDQorICovIA0K
Kw0KK3N0YXRpYyBzc2l6ZV90IGhvdGtleV9leGVjdXRlX2FtbF9tZXRob2Qoc3RydWN0IGZpbGUg
KmZpbGUsDQorY29uc3QgY2hhciBfX3VzZXIgKiBidWZmZXIsDQorc2l6ZV90IGNvdW50LCBsb2Zm
X3QgKiBkYXRhKQ0KK3sNCisgICAgc3RydWN0IHNlcV9maWxlICptID0gKHN0cnVjdCBzZXFfZmls
ZSAqKWZpbGUtPnByaXZhdGVfZGF0YTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC8qIChzdHJ1Y3QgYWNwaV9ob3RrZXlfbGlzdCAqKSBtLT5wcml2
YXRlOyAqLyANCisgICAgc3RydWN0IGFjcGlfaG90a2V5X2xpc3QgKmhrX2xpc3QgPSAmaG90a2V5
X2xpc3Q7DQorICAgIGNoYXIgYXJnW01BWF9DQUxMX1BBUk1dOw0KKyAgICBpbnQgZXZ0LCB0eXBl
LCB2YWx1ZTsNCisNCisgICAgY2hhciAqbWV0aG9kOw0KKyAgICBhY3BpX2hhbmRsZSBoYW5kbGU7
DQorDQorICAgIEFDUElfRlVOQ1RJT05fVFJBQ0UoImhvdGtleV9leGVjdGVfYWN0aW9uIik7DQor
DQorICAgIGlmICghaGtfbGlzdCB8fCBjb3VudCA+IE1BWF9DQUxMX1BBUk0pDQorICAgIHsNCisg
ICAgICAgIEFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfRVJST1IsICJJbnZhbGlkIGFyZ3VtZW50
IDEiKSk7DQorICAgICAgICByZXR1cm5fVkFMVUUoLUVJTlZBTCk7DQorICAgIH0NCisNCisgICAg
aWYgKGNvcHlfZnJvbV91c2VyKGFyZywgYnVmZmVyLCBjb3VudCkpDQorICAgIHsNCisgICAgICAg
IEFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfRVJST1IsICJJbnZhbGlkIGFyZ3VtZW50IDIiKSk7
DQorICAgICAgICByZXR1cm5fVkFMVUUoLUVJTlZBTCk7DQorICAgIH0NCisNCisgICAgYXJnW2Nv
dW50XSA9ICdcMCc7DQorDQorICAgIGlmIChzc2NhbmYoYXJnLCAiJWQ6JWQ6JWQiLCAmZXZ0LCAm
dHlwZSwgJnZhbHVlKSAhPSAzKQ0KKyAgICB7DQorICAgICAgICBBQ1BJX0RFQlVHX1BSSU5UKChB
Q1BJX0RCX0VSUk9SLCAiSW52YWxpZCBhcmd1bWVudCAzIikpOw0KKyAgICAgICAgcmV0dXJuX1ZB
TFVFKC1FSU5WQUwpOw0KKyAgICB9DQorDQorICAgIGlmICh0eXBlID09IEFDUElfVFlQRV9JTlRF
R0VSKQ0KKyAgICB7DQorICAgICAgICBoYW5kbGUgPSBnZXRfaGFuZGxlX2Zyb21faG90a2V5bGlz
dChoa19saXN0LCBldnQpOw0KKyAgICAgICAgbWV0aG9kID0gZ2V0X21ldGhvZF9mcm9tX2hvdGtl
eWxpc3QoaGtfbGlzdCwgZXZ0KTsNCisgICAgICAgIGlmIChJU19FVl9FVkVOVChldnQpKQ0KKyAg
ICAgICAgICAgIHdyaXRlX2FjcGlfaW50KGhhbmRsZSwgbWV0aG9kLCB2YWx1ZSwgTlVMTCk7DQor
ICAgICAgICBlbHNlIGlmIChJU19QTF9FVkVOVChldnQpKQ0KKyAgICAgICAgew0KKyAgICAgICAg
ICAgIHN0cnVjdCBhY3BpX3BvbGxpbmdfaG90a2V5ICpoazsNCisgICAgICAgICAgICBoayA9IChz
dHJ1Y3QgYWNwaV9wb2xsaW5nX2hvdGtleSAqKQ0KKyAgICAgICAgICAgICAgICBnZXRfaG90a2V5
X2J5X2V2dCgmaG90a2V5X2xpc3QsIGV2dCk7DQorICAgICAgICAgICAgcmVhZF9hY3BpX2ludCho
YW5kbGUsIG1ldGhvZCwgaGstPnBsX3Jlc3VsdCk7DQorICAgICAgICB9DQorICAgIH0NCisgICAg
ZWxzZQ0KKyAgICB7DQorICAgICAgICBBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJX0RCX0VSUk9SLCAi
Tm90IHN1cHBvcnRlZCIpKTsNCisgICAgICAgIHJldHVybl9WQUxVRSgtRUlOVkFMKTsNCisgICAg
fQ0KKw0KKyAgICByZXR1cm5fVkFMVUUoY291bnQpOw0KK30NCisNCisNCitzdGF0aWMgaW50IF9f
aW5pdCBob3RrZXlfaW5pdCh2b2lkKQ0KK3sNCisgICAgaW50IHJlc3VsdDsNCisgICAgbW9kZV90
IG1vZGUgPSBTX0lGUkVHIHwgU19JUlVHTyB8IFNfSVdVR087DQorDQorICAgIGhvdGtleV9wcm9j
X2RpciA9IHByb2NfbWtkaXIoSE9US0VZX1BST0MsIGFjcGlfcm9vdF9kaXIpOw0KKyAgICBpZiAo
IWhvdGtleV9wcm9jX2RpcikNCisgICAgew0KKyAgICAgICAgcHJpbnRrKEtFUk5fRVJSICJIb3Rr
ZXk6IFVuYWJsZSB0byBjcmVhdGUgJXMgZW50cnlcbiIsDQorICAgICAgICAgICAgSE9US0VZX1BS
T0MpOw0KKyAgICAgICAgcmV0dXJuICgtRU5PREVWKTsNCisgICAgfQ0KKyAgICBob3RrZXlfcHJv
Y19kaXItPm93bmVyID0gVEhJU19NT0RVTEU7DQorDQorICAgIGhvdGtleV9jb25maWcgPQ0KKyAg
ICAgICAgY3JlYXRlX3Byb2NfZW50cnkoSE9US0VZX0VWX0NPTkZJRywgbW9kZSwgaG90a2V5X3By
b2NfZGlyKTsNCisgICAgaWYgKCFob3RrZXlfY29uZmlnKQ0KKyAgICB7DQorICAgICAgICBwcmlu
dGsoS0VSTl9FUlIgIkhvdGtleTogVW5hYmxlIHRvIGNyZWF0ZSAlcyBlbnRyeVxuIiwNCisgICAg
ICAgICAgICBIT1RLRVlfRVZfQ09ORklHKTsNCisgICAgICAgIHJldHVybiAoLUVOT0RFVik7DQor
ICAgIH0NCisgICAgZWxzZQ0KKyAgICB7DQorICAgICAgICBob3RrZXlfY29uZmlnLT5wcm9jX2Zv
cHMgPSAmaG90a2V5X2NvbmZpZ19mb3BzOw0KKyAgICAgICAgaG90a2V5X2NvbmZpZy0+ZGF0YSA9
ICZob3RrZXlfbGlzdDsNCisgICAgICAgIGhvdGtleV9jb25maWctPm93bmVyID0gVEhJU19NT0RV
TEU7DQorICAgICAgICBob3RrZXlfY29uZmlnLT51aWQgPSAwOw0KKyAgICAgICAgaG90a2V5X2Nv
bmZpZy0+Z2lkID0gMDsNCisgICAgfQ0KKw0KKyAgICBob3RrZXlfcGxfY29uZmlnID0NCisgICAg
ICAgIGNyZWF0ZV9wcm9jX2VudHJ5KEhPVEtFWV9QTF9DT05GSUcsIG1vZGUsIGhvdGtleV9wcm9j
X2Rpcik7DQorICAgIGlmICghaG90a2V5X3BsX2NvbmZpZykNCisgICAgew0KKyAgICAgICAgcHJp
bnRrKEtFUk5fRVJSICJIb3RrZXk6IFVuYWJsZSB0byBjcmVhdGUgJXMgZW50cnlcbiIsDQorICAg
ICAgICAgICAgSE9US0VZX0VWX0NPTkZJRyk7DQorICAgICAgICByZXR1cm4gKC1FTk9ERVYpOw0K
KyAgICB9DQorICAgIGVsc2UNCisgICAgew0KKyAgICAgICAgaG90a2V5X3BsX2NvbmZpZy0+cHJv
Y19mb3BzID0gJmhvdGtleV9wbF9jb25maWdfZm9wczsNCisgICAgICAgIGhvdGtleV9wbF9jb25m
aWctPmRhdGEgPSAmaG90a2V5X2xpc3Q7DQorICAgICAgICBob3RrZXlfcGxfY29uZmlnLT5vd25l
ciA9IFRISVNfTU9EVUxFOw0KKyAgICAgICAgaG90a2V5X3BsX2NvbmZpZy0+dWlkID0gMDsNCisg
ICAgICAgIGhvdGtleV9wbF9jb25maWctPmdpZCA9IDA7DQorICAgIH0NCisNCisgICAgaG90a2V5
X2FjdGlvbiA9IGNyZWF0ZV9wcm9jX2VudHJ5KEhPVEtFWV9BQ1RJT04sIG1vZGUsIGhvdGtleV9w
cm9jX2Rpcik7DQorICAgIGlmICghaG90a2V5X2FjdGlvbikNCisgICAgew0KKyAgICAgICAgcHJp
bnRrKEtFUk5fRVJSICJIb3RrZXk6IFVuYWJsZSB0byBjcmVhdGUgJXMgZW50cnlcbiIsDQorICAg
ICAgICAgICAgSE9US0VZX0FDVElPTik7DQorICAgICAgICByZXR1cm4gKC1FTk9ERVYpOw0KKyAg
ICB9DQorICAgIGVsc2UNCisgICAgew0KKyAgICAgICAgaG90a2V5X2FjdGlvbi0+cHJvY19mb3Bz
ID0gJmhvdGtleV9hY3Rpb25fZm9wczsNCisgICAgICAgIGhvdGtleV9hY3Rpb24tPm93bmVyID0g
VEhJU19NT0RVTEU7DQorICAgICAgICBob3RrZXlfYWN0aW9uLT51aWQgPSAwOw0KKyAgICAgICAg
aG90a2V5X2FjdGlvbi0+Z2lkID0gMDsNCisgICAgfQ0KKw0KKyAgICBob3RrZXlfaW5mbyA9IGNy
ZWF0ZV9wcm9jX2VudHJ5KEhPVEtFWV9JTkZPLCBtb2RlLCBob3RrZXlfcHJvY19kaXIpOw0KKyAg
ICBpZiAoIWhvdGtleV9pbmZvKQ0KKyAgICB7DQorICAgICAgICBwcmludGsoS0VSTl9FUlIgIkhv
dGtleTogVW5hYmxlIHRvIGNyZWF0ZSAlcyBlbnRyeVxuIiwNCisgICAgICAgICAgICBIT1RLRVlf
SU5GTyk7DQorICAgICAgICByZXR1cm4gKC1FTk9ERVYpOw0KKyAgICB9DQorICAgIGVsc2UNCisg
ICAgew0KKyAgICAgICAgaG90a2V5X2luZm8tPnByb2NfZm9wcyA9ICZob3RrZXlfaW5mb19mb3Bz
Ow0KKyAgICAgICAgaG90a2V5X2luZm8tPm93bmVyID0gVEhJU19NT0RVTEU7DQorICAgICAgICBo
b3RrZXlfaW5mby0+dWlkID0gMDsNCisgICAgICAgIGhvdGtleV9pbmZvLT5naWQgPSAwOw0KKyAg
ICB9DQorDQorICAgIHJlc3VsdCA9IGFjcGlfYnVzX3JlZ2lzdGVyX2RyaXZlcigmaG90a2V5X2Ry
aXZlcik7DQorICAgIGlmIChyZXN1bHQgPCAwKQ0KKyAgICB7DQorICAgICAgICByZW1vdmVfcHJv
Y19lbnRyeShIT1RLRVlfUFJPQywgYWNwaV9yb290X2Rpcik7DQorICAgICAgICByZXR1cm4gKC1F
Tk9ERVYpOw0KKyAgICB9DQorICAgIGhvdGtleV9saXN0LmNvdW50ID0gMDsNCisgICAgaG90a2V5
X2xpc3QuZW50cmllcyA9ICZob3RrZXlfZW50cmllczsNCisNCisgICAgSU5JVF9MSVNUX0hFQUQo
JmhvdGtleV9lbnRyaWVzKTsNCisNCisgICAgcmV0dXJuICgwKTsNCit9DQorDQorDQorc3RhdGlj
IHZvaWQgX19leGl0IGhvdGtleV9leGl0KHZvaWQpDQorew0KKyAgICBhY3BpX2J1c191bnJlZ2lz
dGVyX2RyaXZlcigmaG90a2V5X2RyaXZlcik7DQorICAgIHJlbW92ZV9wcm9jX2VudHJ5KEhPVEtF
WV9QUk9DLCBhY3BpX3Jvb3RfZGlyKTsNCisgICAgcmV0dXJuOw0KK30NCisNCisNCittb2R1bGVf
aW5pdChob3RrZXlfaW5pdCk7DQorbW9kdWxlX2V4aXQoaG90a2V5X2V4aXQpOw0KZGlmZiAtQnJ1
TiBvcmlnL2RyaXZlcnMvYWNwaS9NYWtlZmlsZSAyLjYvZHJpdmVycy9hY3BpL01ha2VmaWxlDQot
LS0gb3JpZy9kcml2ZXJzL2FjcGkvTWFrZWZpbGUJMjAwNC0xMS0wOSAyMzoxMDowNy4wMDAwMDAw
MDAgKzA4MDANCisrKyAyLjYvZHJpdmVycy9hY3BpL01ha2VmaWxlCTIwMDQtMTEtMDkgMjM6MDg6
MDEuMDAwMDAwMDAwICswODAwDQpAQCAtMzgsNyArMzgsNyBAQA0KIG9iai0kKENPTkZJR19BQ1BJ
X0JVVFRPTikJKz0gYnV0dG9uLm8NCiBvYmotJChDT05GSUdfQUNQSV9FQykJCSs9IGVjLm8NCiBv
YmotJChDT05GSUdfQUNQSV9GQU4pCQkrPSBmYW4ubw0KLW9iai0kKENPTkZJR19BQ1BJX1ZJREVP
KQkrPSB2aWRlby5vDQorb2JqLSQoQ09ORklHX0FDUElfVklERU8pCSs9IHZpZGVvLm8gaG90a2V5
Lm8NCiBvYmotJChDT05GSUdfQUNQSV9QQ0kpCQkrPSBwY2lfcm9vdC5vIHBjaV9saW5rLm8gcGNp
X2lycS5vIHBjaV9iaW5kLm8NCiBvYmotJChDT05GSUdfQUNQSV9QT1dFUikJKz0gcG93ZXIubw0K
IG9iai0kKENPTkZJR19BQ1BJX1BST0NFU1NPUikJKz0gcHJvY2Vzc29yLm8NCg==

------_=_NextPart_001_01C4C670.5334B712--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
