From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [patch 09/14] acpi: cleanup, fix for potential crash of hotkey.c
Date: Wed, 16 Aug 2006 16:14:57 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1011089E9@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50500 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750866AbWHPIP3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Aug 2006 04:15:29 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, xhandle@gmail.com

 Acked!

-----Original Message-----
=46rom: akpm@osdl.org [mailto:akpm@osdl.org]=20
Sent: 2006=C4=EA8=D4=C215=C8=D5 13:37
To: Brown, Len
Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; xhandle@gmail.com; Yu, L=
uming
Subject: [patch 09/14] acpi: cleanup, fix for potential crash of hotkey=
=2Ec

=46rom: "Handle X" <xhandle@gmail.com>

While going through the code, I found out some memory leaks and potenti=
al
crashes in drivers/acpi/hotkey.c Please find the patch to fix them.

This patch does the following,

1. Fixes memory leaks in error paths of hotkey_write_config

2. Fixes freeing unallocated pointers in the error paths of hotkey_writ=
e_config

3. Uses a loop instead of linear searching for parsing the userspace
   input in get_params

4. Uses array of char * instead of passing 4 pointer parameters
   explicitly into the init_{poll_}hotkey_* static functions

Cc: Luming Yu <luming.yu@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/hotkey.c |  281 ++++++++++++++++------------------------
 1 file changed, 119 insertions(+), 162 deletions(-)

diff -puN drivers/acpi/hotkey.c~cleanup-fix-for-potential-crash-of-hotk=
eyc drivers/acpi/hotkey.c
--- a/drivers/acpi/hotkey.c~cleanup-fix-for-potential-crash-of-hotkeyc
+++ a/drivers/acpi/hotkey.c
@@ -91,6 +91,14 @@ enum {
 	HK_EVENT_ENTERRING_S5,
 };
=20
+enum conf_entry_enum {
+	bus_handle =3D 0,
+	bus_method =3D 1,
+	action_handle =3D 2,
+	method =3D 3,
+	LAST_CONF_ENTRY
+};
+
 /*  procdir we use */
 static struct proc_dir_entry *hotkey_proc_dir;
 static struct proc_dir_entry *hotkey_config;
@@ -244,19 +252,15 @@ static int hotkey_info_open_fs(struct in
=20
 static char *format_result(union acpi_object *object)
 {
-	char *buf =3D NULL;
-
-	buf =3D (char *)kmalloc(RESULT_STR_LEN, GFP_KERNEL);
-	if (buf)
-		memset(buf, 0, RESULT_STR_LEN);
-	else
-		goto do_fail;
+	char *buf;
=20
+	buf =3D kzalloc(RESULT_STR_LEN, GFP_KERNEL);
+	if (!buf)
+		return NULL;
 	/* Now, just support integer type */
 	if (object->type =3D=3D ACPI_TYPE_INTEGER)
 		sprintf(buf, "%d\n", (u32) object->integer.value);
-      do_fail:
-	return (buf);
+	return buf;
 }
=20
 static int hotkey_polling_seq_show(struct seq_file *seq, void *offset)
@@ -486,98 +490,102 @@ static void free_hotkey_device(union acp
=20
 static void free_hotkey_buffer(union acpi_hotkey *key)
 {
+	/* key would never be null, action method could be */
 	kfree(key->event_hotkey.action_method);
 }
=20
 static void free_poll_hotkey_buffer(union acpi_hotkey *key)
 {
+	/* key would never be null, others could be*/
 	kfree(key->poll_hotkey.action_method);
 	kfree(key->poll_hotkey.poll_method);
 	kfree(key->poll_hotkey.poll_result);
 }
 static int
-init_hotkey_device(union acpi_hotkey *key, char *bus_str, char *action=
_str,
-		   char *method, int std_num, int external_num)
+init_hotkey_device(union acpi_hotkey *key, char **config_entry,
+		   int std_num, int external_num)
 {
 	acpi_handle tmp_handle;
 	acpi_status status =3D AE_OK;
=20
-
 	if (std_num < 0 || IS_POLL(std_num) || !key)
 		goto do_fail;
=20
-	if (!bus_str || !action_str || !method)
+	if (!config_entry[bus_handle] || !config_entry[action_handle]
+			|| !config_entry[method])
 		goto do_fail;
=20
 	key->link.hotkey_type =3D ACPI_HOTKEY_EVENT;
 	key->link.hotkey_standard_num =3D std_num;
 	key->event_hotkey.flag =3D 0;
-	key->event_hotkey.action_method =3D method;
+	key->event_hotkey.action_method =3D config_entry[method];
=20
-	status =3D
-	    acpi_get_handle(NULL, bus_str, &(key->event_hotkey.bus_handle));
+	status =3D acpi_get_handle(NULL, config_entry[bus_handle],
+			   &(key->event_hotkey.bus_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	key->event_hotkey.external_hotkey_num =3D external_num;
-	status =3D
-	    acpi_get_handle(NULL, action_str,
+	status =3D acpi_get_handle(NULL, config_entry[action_handle],
 			    &(key->event_hotkey.action_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status =3D acpi_get_handle(key->event_hotkey.action_handle,
-				 method, &tmp_handle);
+				 config_entry[method], &tmp_handle);
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	return AE_OK;
-      do_fail:
+do_fail_zero:
+	key->event_hotkey.action_method =3D NULL;
+do_fail:
 	return -ENODEV;
 }
=20
 static int
-init_poll_hotkey_device(union acpi_hotkey *key,
-			char *poll_str,
-			char *poll_method,
-			char *action_str, char *action_method, int std_num)
+init_poll_hotkey_device(union acpi_hotkey *key, char **config_entry,
+			int std_num)
 {
 	acpi_status status =3D AE_OK;
 	acpi_handle tmp_handle;
=20
-
 	if (std_num < 0 || IS_EVENT(std_num) || !key)
 		goto do_fail;
-
-	if (!poll_str || !poll_method || !action_str || !action_method)
+	if (!config_entry[bus_handle] ||!config_entry[bus_method] ||
+		!config_entry[action_handle] || !config_entry[method])
 		goto do_fail;
=20
 	key->link.hotkey_type =3D ACPI_HOTKEY_POLLING;
 	key->link.hotkey_standard_num =3D std_num;
 	key->poll_hotkey.flag =3D 0;
-	key->poll_hotkey.poll_method =3D poll_method;
-	key->poll_hotkey.action_method =3D action_method;
+	key->poll_hotkey.poll_method =3D config_entry[bus_method];
+	key->poll_hotkey.action_method =3D config_entry[method];
=20
-	status =3D
-	    acpi_get_handle(NULL, poll_str, &(key->poll_hotkey.poll_handle));
+	status =3D acpi_get_handle(NULL, config_entry[bus_handle],
+		      &(key->poll_hotkey.poll_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status =3D acpi_get_handle(key->poll_hotkey.poll_handle,
-				 poll_method, &tmp_handle);
+				 config_entry[bus_method], &tmp_handle);
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status =3D
-	    acpi_get_handle(NULL, action_str,
+	    acpi_get_handle(NULL, config_entry[action_handle],
 			    &(key->poll_hotkey.action_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status =3D acpi_get_handle(key->poll_hotkey.action_handle,
-				 action_method, &tmp_handle);
+				 config_entry[method], &tmp_handle);
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	key->poll_hotkey.poll_result =3D
 	    (union acpi_object *)kmalloc(sizeof(union acpi_object), GFP_KERNE=
L);
 	if (!key->poll_hotkey.poll_result)
-		goto do_fail;
+		goto do_fail_zero;
 	return AE_OK;
-      do_fail:
+
+do_fail_zero:
+	key->poll_hotkey.poll_method =3D NULL;
+	key->poll_hotkey.action_method =3D NULL;
+do_fail:
 	return -ENODEV;
 }
=20
@@ -652,17 +660,18 @@ static int hotkey_poll_config_seq_show(s
 }
=20
 static int
-get_parms(char *config_record,
-	  int *cmd,
-	  char **bus_handle,
-	  char **bus_method,
-	  char **action_handle,
-	  char **method, int *internal_event_num, int *external_event_num)
+get_parms(char *config_record, int *cmd, char **config_entry,
+	       int *internal_event_num, int *external_event_num)
 {
+/* the format of *config_record =3D
+ * "1:\d+:*" : "cmd:internal_event_num"
+ * "\d+:\w+:\w+:\w+:\w+:\d+:\d+" :
+ * "cmd:bus_handle:bus_method:action_handle:method:internal_event_num:=
external_event_num"
+ */
 	char *tmp, *tmp1, count;
+	int i;
=20
 	sscanf(config_record, "%d", cmd);
-
 	if (*cmd =3D=3D 1) {
 		if (sscanf(config_record, "%d:%d", cmd, internal_event_num) !=3D
 		    2)
@@ -674,59 +683,27 @@ get_parms(char *config_record,
 	if (!tmp)
 		goto do_fail;
 	tmp++;
-	tmp1 =3D strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-
-	count =3D tmp1 - tmp;
-	*bus_handle =3D (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*bus_handle)
-		goto do_fail;
-	strncpy(*bus_handle, tmp, count);
-	*(*bus_handle + count) =3D 0;
-
-	tmp =3D tmp1;
-	tmp++;
-	tmp1 =3D strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-	count =3D tmp1 - tmp;
-	*bus_method =3D (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*bus_method)
-		goto do_fail;
-	strncpy(*bus_method, tmp, count);
-	*(*bus_method + count) =3D 0;
-
-	tmp =3D tmp1;
-	tmp++;
-	tmp1 =3D strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-	count =3D tmp1 - tmp;
-	*action_handle =3D (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*action_handle)
-		goto do_fail;
-	strncpy(*action_handle, tmp, count);
-	*(*action_handle + count) =3D 0;
-
-	tmp =3D tmp1;
-	tmp++;
-	tmp1 =3D strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-	count =3D tmp1 - tmp;
-	*method =3D (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*method)
-		goto do_fail;
-	strncpy(*method, tmp, count);
-	*(*method + count) =3D 0;
-
-	if (sscanf(tmp1 + 1, "%d:%d", internal_event_num, external_event_num)=
 <=3D
-	    0)
-		goto do_fail;
-
-	return 6;
-      do_fail:
+	for (i =3D 0; i < LAST_CONF_ENTRY; i++) {
+		tmp1 =3D strchr(tmp, ':');
+		if (!tmp1) {
+			goto do_fail;
+		}
+		count =3D tmp1 - tmp;
+		config_entry[i] =3D kzalloc(count + 1, GFP_KERNEL);
+		if (!config_entry[i])
+			goto handle_failure;
+		strncpy(config_entry[i], tmp, count);
+		tmp =3D tmp1 + 1;
+	}
+	if (sscanf(tmp, "%d:%d", internal_event_num, external_event_num) <=3D=
 0)
+		goto handle_failure;
+	if (!IS_OTHERS(*internal_event_num)) {
+		return 6;
+	}
+handle_failure:
+	while (i-- > 0)
+		kfree(config_entry[i]);
+do_fail:
 	return -1;
 }
=20
@@ -736,50 +713,34 @@ static ssize_t hotkey_write_config(struc
 				   size_t count, loff_t * data)
 {
 	char *config_record =3D NULL;
-	char *bus_handle =3D NULL;
-	char *bus_method =3D NULL;
-	char *action_handle =3D NULL;
-	char *method =3D NULL;
+	char *config_entry[LAST_CONF_ENTRY];
 	int cmd, internal_event_num, external_event_num;
 	int ret =3D 0;
-	union acpi_hotkey *key =3D NULL;
+	union acpi_hotkey *key =3D kzalloc(sizeof(union acpi_hotkey), GFP_KER=
NEL);
=20
+	if (!key)
+		return -ENOMEM;
=20
-	config_record =3D (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!config_record)
+	config_record =3D kzalloc(count + 1, GFP_KERNEL);
+	if (!config_record) {
+		kfree(key);
 		return -ENOMEM;
+	}
=20
 	if (copy_from_user(config_record, buffer, count)) {
 		kfree(config_record);
+		kfree(key);
 		printk(KERN_ERR PREFIX "Invalid data\n");
 		return -EINVAL;
 	}
-	config_record[count] =3D 0;
-
-	ret =3D get_parms(config_record,
-			&cmd,
-			&bus_handle,
-			&bus_method,
-			&action_handle,
-			&method, &internal_event_num, &external_event_num);
-
+	ret =3D get_parms(config_record, &cmd, config_entry,
+		       &internal_event_num, &external_event_num);
 	kfree(config_record);
-	if (IS_OTHERS(internal_event_num))
-		goto do_fail;
 	if (ret !=3D 6) {
-	      do_fail:
-		kfree(bus_handle);
-		kfree(bus_method);
-		kfree(action_handle);
-		kfree(method);
 		printk(KERN_ERR PREFIX "Invalid data format ret=3D%d\n", ret);
 		return -EINVAL;
 	}
=20
-	key =3D kmalloc(sizeof(union acpi_hotkey), GFP_KERNEL);
-	if (!key)
-		goto do_fail;
-	memset(key, 0, sizeof(union acpi_hotkey));
 	if (cmd =3D=3D 1) {
 		union acpi_hotkey *tmp =3D NULL;
 		tmp =3D get_hotkey_by_event(&global_hotkey_list,
@@ -791,34 +752,19 @@ static ssize_t hotkey_write_config(struc
 		goto cont_cmd;
 	}
 	if (IS_EVENT(internal_event_num)) {
-		kfree(bus_method);
-		ret =3D init_hotkey_device(key, bus_handle, action_handle, method,
-					 internal_event_num,
-					 external_event_num);
-	} else
-		ret =3D init_poll_hotkey_device(key, bus_handle, bus_method,
-					      action_handle, method,
-					      internal_event_num);
-	if (ret) {
-		kfree(bus_handle);
-		kfree(action_handle);
-		if (IS_EVENT(internal_event_num))
-			free_hotkey_buffer(key);
-		else
-			free_poll_hotkey_buffer(key);
-		kfree(key);
-		printk(KERN_ERR PREFIX "Invalid hotkey\n");
-		return -EINVAL;
+		if (init_hotkey_device(key, config_entry,
+			internal_event_num, external_event_num))
+			goto init_hotkey_fail;
+	} else {
+		if (init_poll_hotkey_device(key, config_entry,
+			       internal_event_num))
+			goto init_poll_hotkey_fail;
 	}
-
-      cont_cmd:
-	kfree(bus_handle);
-	kfree(action_handle);
-
+cont_cmd:
 	switch (cmd) {
 	case 0:
-		if (get_hotkey_by_event
-		    (&global_hotkey_list, key->link.hotkey_standard_num))
+		if (get_hotkey_by_event(&global_hotkey_list,
+				key->link.hotkey_standard_num))
 			goto fail_out;
 		else
 			hotkey_add(key);
@@ -827,6 +773,7 @@ static ssize_t hotkey_write_config(struc
 		hotkey_remove(key);
 		break;
 	case 2:
+		/* key is kfree()ed if matched*/
 		if (hotkey_update(key))
 			goto fail_out;
 		break;
@@ -835,11 +782,22 @@ static ssize_t hotkey_write_config(struc
 		break;
 	}
 	return count;
-      fail_out:
-	if (IS_EVENT(internal_event_num))
-		free_hotkey_buffer(key);
-	else
-		free_poll_hotkey_buffer(key);
+
+init_poll_hotkey_fail:		/* failed init_poll_hotkey_device */
+	kfree(config_entry[bus_method]);
+	config_entry[bus_method] =3D NULL;
+init_hotkey_fail:		/* failed init_hotkey_device */
+	kfree(config_entry[method]);
+fail_out:
+	kfree(config_entry[bus_handle]);
+	kfree(config_entry[action_handle]);
+	/* No double free since elements =3DNULL for error cases */
+	if (IS_EVENT(internal_event_num)) {
+		if (config_entry[bus_method])
+			kfree(config_entry[bus_method]);
+		free_hotkey_buffer(key);	/* frees [method] */
+	} else
+		free_poll_hotkey_buffer(key);  /* frees [bus_method]+[method] */
 	kfree(key);
 	printk(KERN_ERR PREFIX "invalid key\n");
 	return -EINVAL;
@@ -923,10 +881,9 @@ static ssize_t hotkey_execute_aml_method
 	union acpi_hotkey *key;
=20
=20
-	arg =3D (char *)kmalloc(count + 1, GFP_KERNEL);
+	arg =3D kzalloc(count + 1, GFP_KERNEL);
 	if (!arg)
 		return -ENOMEM;
-	arg[count] =3D 0;
=20
 	if (copy_from_user(arg, buffer, count)) {
 		kfree(arg);
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
