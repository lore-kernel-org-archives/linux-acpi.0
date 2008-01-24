From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PATCH] thinkpad-acpi patches for 2.6.25
	(replaces batch 1)
Date: Thu, 24 Jan 2008 00:55:20 -0500
Message-ID: <200801240055.20906.lenb@kernel.org>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

scripts/checkpatch.pl
WARNING: line over 80 characters
#1569: FILE: drivers/misc/thinkpad_acpi.c:1280:
+               dbg_printk(TPACPI_DBG_EXIT, "restoring original hot key mask\n");

WARNING: line over 80 characters
#1573: FILE: drivers/misc/thinkpad_acpi.c:1284:
+                       printk(IBM_ERR "failed to restore hot key mask to BIOS defaults\n");

WARNING: line over 80 characters
#1582: FILE: drivers/misc/thinkpad_acpi.c:1421:
+               printk(IBM_ERR "error while trying to read hot key mask from firmware\n");

ERROR: Macros with multiple statements should be enclosed in a do - while loop
#2180: FILE: drivers/misc/thinkpad_acpi.c:849:
+       mutex_lock(&hotkey_thread_data_mutex); \

WARNING: line over 80 characters
#2313: FILE: drivers/misc/thinkpad_acpi.c:1044:
+       do { if ((mask & (1 << __scancode)) && oldn->__member != newn->__member) \

ERROR: use tabs not spaces
#2321: FILE: drivers/misc/thinkpad_acpi.c:1052:
+                                           struct tp_nvram_state *newn,$

WARNING: braces {} are not necessary for single statement blocks
#2335: FILE: drivers/misc/thinkpad_acpi.c:1066:
+               if (oldn->mute != newn->mute) {
+                       TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_MUTE);
+               }

WARNING: line over 80 characters
#2347: FILE: drivers/misc/thinkpad_acpi.c:1078:
+                               TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_VOLUMEUP);

WARNING: line over 80 characters
#2349: FILE: drivers/misc/thinkpad_acpi.c:1080:
+                               TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_VOLUMEDOWN);

ERROR: use tabs not spaces
#2424: FILE: drivers/misc/thinkpad_acpi.c:1155:
+^I^I^I^I                               mask);$

ERROR: use tabs not spaces
#2460: FILE: drivers/misc/thinkpad_acpi.c:1191:
+^I^I^I                       NULL, IBM_FILE "d");$

ERROR: need space after that ',' (ctx:VxV)
#3129: FILE: drivers/misc/thinkpad_acpi.c:174:
+#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
                     ^

ERROR: need space after that ',' (ctx:VxV)
#3130: FILE: drivers/misc/thinkpad_acpi.c:175:
+#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
                       ^

ERROR: need space after that ',' (ctx:VxV)
#3131: FILE: drivers/misc/thinkpad_acpi.c:176:
+#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
                    ^

ERROR: "foo * bar" should be "foo *bar"
#3160: FILE: drivers/misc/thinkpad_acpi.c:205:
+static int __must_check acpi_ec_read(int i, u8 * p);

WARNING: line over 80 characters
#3173: FILE: drivers/misc/thinkpad_acpi.c:218:
+#define IBM_ACPIHANDLE_INIT(object)                                            \

WARNING: line over 80 characters
#3174: FILE: drivers/misc/thinkpad_acpi.c:219:
+       drv_acpi_handle_init(#object, &object##_handle, *object##_parent,       \

ERROR: "foo * bar" should be "foo *bar"
#3187: FILE: drivers/misc/thinkpad_acpi.c:232:
+               const char __user * userbuf,

ERROR: "foo* bar" should be "foo *bar"
#3198: FILE: drivers/misc/thinkpad_acpi.c:243:
+                                               const char* name);

ERROR: "foo* bar" should be "foo *bar"
#3201: FILE: drivers/misc/thinkpad_acpi.c:246:
+static int add_to_attr_set(struct attribute_set* s, struct attribute *attr);

ERROR: "foo* bar" should be "foo *bar"
#3202: FILE: drivers/misc/thinkpad_acpi.c:247:
+static int add_many_to_attr_set(struct attribute_set* s,

ERROR: "foo* bar" should be "foo *bar"
#3207: FILE: drivers/misc/thinkpad_acpi.c:252:
+static void delete_attr_set(struct attribute_set* s, struct kobject *kobj);

WARNING: line over 80 characters
#4875: FILE: drivers/misc/thinkpad_acpi.c:536:
+#define IBM_ACPIHANDLE_INIT(object)                                            \

WARNING: line over 80 characters
#4876: FILE: drivers/misc/thinkpad_acpi.c:537:
+       drv_acpi_handle_init(#object, &object##_handle, *object##_parent,       \

ERROR: need space after that ',' (ctx:VxV)
#5432: FILE: drivers/misc/thinkpad_acpi.c:229:
+#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
                     ^

ERROR: need space after that ',' (ctx:VxV)
#5433: FILE: drivers/misc/thinkpad_acpi.c:230:
+#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
                       ^

ERROR: need space after that ',' (ctx:VxV)
#5434: FILE: drivers/misc/thinkpad_acpi.c:231:
+#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
                    ^

ERROR: "foo* bar" should be "foo *bar"
#5659: FILE: drivers/misc/thinkpad_acpi.c:908:
+static struct driver_attribute* tpacpi_driver_attributes[] = {

ERROR: need a space before the open parenthesis '('
#5682: FILE: drivers/misc/thinkpad_acpi.c:931:
+       for(i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)

ERROR: need a space before the open parenthesis '('
#5777: FILE: drivers/misc/thinkpad_acpi.c:3702:
+       for(i = 0 ; i < n; i++) {

ERROR: need spaces around that '=' (ctx:VxW)
#6294: FILE: drivers/misc/thinkpad_acpi.c:4776:
+                       rc= -EIO;
                          ^

ERROR: use tabs not spaces
#7255: FILE: drivers/misc/thinkpad_acpi.c:5706:
+                 "Enables experimental features when non-zero");$

ERROR: use tabs not spaces
#7262: FILE: drivers/misc/thinkpad_acpi.c:5713:
+                 "Attempts to load the driver even on a "$

ERROR: use tabs not spaces
#7263: FILE: drivers/misc/thinkpad_acpi.c:5714:
+                 "mis-identified ThinkPad when true");$

ERROR: use tabs not spaces
#7267: FILE: drivers/misc/thinkpad_acpi.c:5718:
+                 "Enables setting fan parameters features when true");$

ERROR: use tabs not spaces
#7271: FILE: drivers/misc/thinkpad_acpi.c:5722:
+                 "Selects brightness control strategy: "$

ERROR: use tabs not spaces
#7272: FILE: drivers/misc/thinkpad_acpi.c:5723:
+                 "0=auto, 1=EC, 2=CMOS, 3=both");$

ERROR: use tabs not spaces
#7276: FILE: drivers/misc/thinkpad_acpi.c:5727:
+                 "Enables backlight control when 1, disables when 0");$

ERROR: use tabs not spaces
#7280: FILE: drivers/misc/thinkpad_acpi.c:5731:
+                 "used for backwards compatibility with userspace, "$

ERROR: use tabs not spaces
#7281: FILE: drivers/misc/thinkpad_acpi.c:5732:
+                 "see documentation");$

ERROR: Macros with multiple statements should be enclosed in a do - while loop
#7285: FILE: drivers/misc/thinkpad_acpi.c:5735:
+       module_param_call(feature, set_ibm_param, NULL, NULL, 0); \

ERROR: use tabs not spaces
#7287: FILE: drivers/misc/thinkpad_acpi.c:5737:
+^I                 "at module load, see documentation")$

WARNING: line over 80 characters
#7471: FILE: drivers/misc/thinkpad_acpi.c:153:
+               printk(TPACPI_DEBUG "%s: " format, __func__ , ## arg); } while (0)

WARNING: line over 80 characters
#7501: FILE: drivers/misc/thinkpad_acpi.c:291:
+TPACPI_HANDLE(cmos, root, "\\UCMS",    /* R50, R50e, R50p, R51, T4x, X31, X40 */

WARNING: line over 80 characters
#7559: FILE: drivers/misc/thinkpad_acpi.c:439:
+#define TPACPI_ACPIHANDLE_INIT(object)                                         \

WARNING: line over 80 characters
#7584: FILE: drivers/misc/thinkpad_acpi.c:511:
+                       printk(TPACPI_NOTICE "another device driver is already handling %s eve
nts\n",

WARNING: line over 80 characters
#7588: FILE: drivers/misc/thinkpad_acpi.c:514:
+                       printk(TPACPI_ERR "acpi_install_notify_handler(%s) failed: %d\n",

WARNING: line over 80 characters
#7637: FILE: drivers/misc/thinkpad_acpi.c:821:
+       return snprintf(buf, PAGE_SIZE, "%s v%s\n", TPACPI_DESC, TPACPI_VERSION);

ERROR: use tabs not spaces
#7697: FILE: drivers/misc/thinkpad_acpi.c:1355:
+^I^I^I                       NULL, TPACPI_FILE "d");$

WARNING: line over 80 characters
#7701: FILE: drivers/misc/thinkpad_acpi.c:1358:
+                               printk(TPACPI_ERR "could not create kernel thread "

WARNING: line over 80 characters
#7764: FILE: drivers/misc/thinkpad_acpi.c:1885:
+                       printk(TPACPI_ERR "failed to allocate memory for key map\n");

WARNING: line over 80 characters
#7773: FILE: drivers/misc/thinkpad_acpi.c:1960:
+                       printk(TPACPI_ERR "failed to restore hot key mask to BIOS defaults\n")                     ;

WARNING: line over 80 characters
#7782: FILE: drivers/misc/thinkpad_acpi.c:1977:
+               printk(TPACPI_ERR "unknown HKEY notification event %d\n", event);

WARNING: line over 80 characters
#7818: FILE: drivers/misc/thinkpad_acpi.c:2042:
+                       printk(TPACPI_NOTICE "unhandled HKEY event 0x%04x\n", hkey);

WARNING: line over 80 characters
#7827: FILE: drivers/misc/thinkpad_acpi.c:2063:
+               printk(TPACPI_ERR "error while trying to read hot key mask from firmware\n");

WARNING: line over 80 characters
#7900: FILE: drivers/misc/thinkpad_acpi.c:2666:
+                       printk(TPACPI_ERR "video auto-switch left enabled due to error\n");

WARNING: line over 80 characters
#7909: FILE: drivers/misc/thinkpad_acpi.c:2735:
+               printk(TPACPI_ERR "video auto-switch left enabled due to error\n");

WARNING: line over 80 characters
#8129: FILE: drivers/misc/thinkpad_acpi.c:4164:
+               printk(TPACPI_INFO "detected a 16-level brightness capable ThinkPad\n");

WARNING: line over 80 characters
#8160: FILE: drivers/misc/thinkpad_acpi.c:4793:
+                       printk(TPACPI_ERR "failed to schedule the fan watchdog, "

WARNING: braces {} are not necessary for single statement blocks
#9065: FILE: drivers/misc/thinkpad_acpi.c:4358:
+                       if (mute &&
+                           (issue_thinkpad_cmos_command(TP_CMOS_VOLUME_MUTE) ||
+                            !acpi_ec_write(volume_offset, new_level + mute))) {
                                return -EIO;
+                       }

WARNING: line over 80 characters
#10318: FILE: drivers/misc/thinkpad_acpi.c:2139:
+                               hotkey_wakeup_hotunplug_complete_notify_change();

WARNING: line over 80 characters
#10326: FILE: drivers/misc/thinkpad_acpi.c:2150:
+                               hotkey_wakeup_hotunplug_complete_notify_change();

total: 32 errors, 30 warnings, 7574 lines checked



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
