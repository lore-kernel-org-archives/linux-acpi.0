From: Alexander Nyberg <alexn-auIyqT/O9BSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] ACPI cleanup & __init notation
Date: Wed, 08 Dec 2004 17:39:16 +0100
Message-ID: <1102523956.665.28.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hey Len,

I looked through bits of the acpi code and thought it was pretty slim.
I've made a few symbols static and moved a prototype into header-file.
Plus marking some functions __init and the one you suggested as __initdata.
The gain isn't that much, something like 6K, but the notation may be useful
to readers. Numbers below:


Before:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 1] .text             PROGBITS         ffffffff80100000  00100000
       00000000001995e4  0000000000000000  AX       0     0     64
  [12] .data             PROGBITS         ffffffff803186c0  003186c0
       0000000000052778  0000000000000000  WA       0     0     64
  [25] .init.text        PROGBITS         ffffffff803c1000  004c1000
       000000000001e0f5  0000000000000000  AX       0     0     16
  [26] .init.data        PROGBITS         ffffffff803df100  004df100
       000000000004a950  0000000000000000  WA       0     0     32

After:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 1] .text             PROGBITS         ffffffff80100000  00100000
       0000000000198144  0000000000000000  AX       0     0     64
  [12] .data             PROGBITS         ffffffff80317200  00317200
       0000000000052800  0000000000000000  WA       0     0     64
  [25] .init.text        PROGBITS         ffffffff803bf000  004bf000
       000000000001f585  0000000000000000  AX       0     0     16
  [26] .init.data        PROGBITS         ffffffff803de5a0  004de5a0
       000000000004bd50  0000000000000000  WA       0     0     32



Signed-off-by: Alexander Nyberg <alexn-auIyqT/O9BSzQB+pC5nmwQ@public.gmane.org>

===== drivers/acpi/ac.c 1.19 vs edited =====
--- 1.19/drivers/acpi/ac.c	2004-11-02 08:40:09 +01:00
+++ edited/drivers/acpi/ac.c	2004-12-06 23:05:29 +01:00
@@ -51,8 +51,8 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_AC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-int acpi_ac_add (struct acpi_device *device);
-int acpi_ac_remove (struct acpi_device *device, int type);
+static int acpi_ac_add (struct acpi_device *device);
+static int acpi_ac_remove (struct acpi_device *device, int type);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_ac_driver = {
@@ -108,9 +108,9 @@ acpi_ac_get_state (
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ac_dir;
+static struct proc_dir_entry *acpi_ac_dir;
 
-int acpi_ac_seq_show(struct seq_file *seq, void *offset)
+static int acpi_ac_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_ac		*ac = (struct acpi_ac *) seq->private;
 
@@ -145,9 +145,7 @@ static int acpi_ac_open_fs(struct inode 
 	return single_open(file, acpi_ac_seq_show, PDE(inode)->data);
 }
 
-static int
-acpi_ac_add_fs (
-	struct acpi_device	*device)
+static int acpi_ac_add_fs (struct acpi_device *device)
 {
 	struct proc_dir_entry	*entry = NULL;
 
@@ -200,7 +198,7 @@ acpi_ac_remove_fs (
                                    Driver Model
    -------------------------------------------------------------------------- */
 
-void
+static void
 acpi_ac_notify (
 	acpi_handle		handle,
 	u32			event,
@@ -232,7 +230,7 @@ acpi_ac_notify (
 }
 
 
-int
+static int
 acpi_ac_add (
 	struct acpi_device	*device)
 {
@@ -286,7 +284,7 @@ end:
 }
 
 
-int
+static int
 acpi_ac_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -315,7 +313,7 @@ acpi_ac_remove (
 }
 
 
-int __init
+static int __init
 acpi_ac_init (void)
 {
 	int			result = 0;
@@ -337,7 +335,7 @@ acpi_ac_init (void)
 }
 
 
-void __exit
+static void __exit
 acpi_ac_exit (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_ac_exit");
===== drivers/acpi/battery.c 1.24 vs edited =====
--- 1.24/drivers/acpi/battery.c	2004-09-20 03:12:24 +02:00
+++ edited/drivers/acpi/battery.c	2004-12-06 23:15:53 +01:00
@@ -341,7 +341,8 @@ acpi_battery_check (
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_battery_dir;
+static struct proc_dir_entry *acpi_battery_dir;
+
 static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 {
 	int			result = 0;
===== drivers/acpi/bus.c 1.49 vs edited =====
--- 1.49/drivers/acpi/bus.c	2004-11-12 07:29:46 +01:00
+++ edited/drivers/acpi/bus.c	2004-12-06 23:39:37 +01:00
@@ -57,10 +57,6 @@ EXPORT_SYMBOL(acpi_root_dir);
                                 Device Management
    -------------------------------------------------------------------------- */
 
-extern void acpi_bus_data_handler (
-	acpi_handle		handle,
-	u32			function,
-	void			*context);
 int
 acpi_bus_get_device (
 	acpi_handle		handle,
===== drivers/acpi/button.c 1.26 vs edited =====
--- 1.26/drivers/acpi/button.c	2004-11-02 08:40:09 +01:00
+++ edited/drivers/acpi/button.c	2004-12-06 23:42:52 +01:00
@@ -275,7 +275,7 @@ acpi_button_remove_fs (
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
-void
+static void
 acpi_button_notify (
 	acpi_handle		handle,
 	u32			event,
@@ -302,7 +302,7 @@ acpi_button_notify (
 }
 
 
-acpi_status
+static acpi_status
 acpi_button_notify_fixed (
 	void			*data)
 {
===== drivers/acpi/debug.c 1.7 vs edited =====
--- 1.7/drivers/acpi/debug.c	2004-09-01 23:55:24 +02:00
+++ edited/drivers/acpi/debug.c	2004-12-06 23:44:34 +01:00
@@ -32,7 +32,7 @@ struct acpi_dlevel {
 };
 #define ACPI_DEBUG_INIT(v)	{ .name = #v, .value = v }
 
-const struct acpi_dlayer acpi_debug_layers[] =
+static const struct acpi_dlayer acpi_debug_layers[] =
 {
 	ACPI_DEBUG_INIT(ACPI_UTILITIES),
 	ACPI_DEBUG_INIT(ACPI_HARDWARE),
@@ -50,7 +50,7 @@ const struct acpi_dlayer acpi_debug_laye
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 };
 
-const struct acpi_dlevel acpi_debug_levels[] =
+static const struct acpi_dlevel acpi_debug_levels[] =
 {
 	ACPI_DEBUG_INIT(ACPI_LV_ERROR),
 	ACPI_DEBUG_INIT(ACPI_LV_WARN),
===== drivers/acpi/ec.c 1.38 vs edited =====
--- 1.38/drivers/acpi/ec.c	2004-11-12 07:29:46 +01:00
+++ edited/drivers/acpi/ec.c	2004-12-06 23:45:54 +01:00
@@ -490,7 +490,7 @@ acpi_ec_space_handler (
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ec_dir;
+static struct proc_dir_entry *acpi_ec_dir;
 
 
 static int
===== drivers/acpi/fan.c 1.18 vs edited =====
--- 1.18/drivers/acpi/fan.c	2004-09-20 03:59:00 +02:00
+++ edited/drivers/acpi/fan.c	2004-12-06 23:47:37 +01:00
@@ -50,8 +50,8 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_FAN_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-int acpi_fan_add (struct acpi_device *device);
-int acpi_fan_remove (struct acpi_device *device, int type);
+static int acpi_fan_add (struct acpi_device *device);
+static int acpi_fan_remove (struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_fan_driver = {
 	.name =		ACPI_FAN_DRIVER_NAME,
@@ -72,7 +72,7 @@ struct acpi_fan {
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_fan_dir;
+static struct proc_dir_entry *acpi_fan_dir;
 
 
 static int
@@ -197,7 +197,7 @@ acpi_fan_remove_fs (
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_fan_add (
 	struct acpi_device	*device)
 {
@@ -243,7 +243,7 @@ end:
 }
 
 
-int
+static int
 acpi_fan_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -265,7 +265,7 @@ acpi_fan_remove (
 }
 
 
-int __init
+static int __init
 acpi_fan_init (void)
 {
 	int			result = 0;
@@ -287,7 +287,7 @@ acpi_fan_init (void)
 }
 
 
-void __exit
+static void __exit
 acpi_fan_exit (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_fan_exit");
===== drivers/acpi/ibm_acpi.c 1.4 vs edited =====
--- 1.4/drivers/acpi/ibm_acpi.c	2004-12-01 09:13:59 +01:00
+++ edited/drivers/acpi/ibm_acpi.c	2004-12-06 23:49:40 +01:00
@@ -856,7 +856,7 @@ static int beep_write(struct ibm_struct 
 	return 0;
 }	
 		
-struct ibm_struct ibms[] = {
+static struct ibm_struct ibms[] = {
 	{
 		.name	= "driver",
 		.init	= driver_init,
===== drivers/acpi/osl.c 1.62 vs edited =====
--- 1.62/drivers/acpi/osl.c	2004-12-02 00:28:10 +01:00
+++ edited/drivers/acpi/osl.c	2004-12-08 16:44:19 +01:00
@@ -81,7 +81,7 @@ acpi_os_initialize(void)
 	return AE_OK;
 }
 
-acpi_status
+acpi_status __init
 acpi_os_initialize1(void)
 {
 	/*
@@ -228,7 +228,7 @@ acpi_os_get_physical_address(void *virt,
 
 static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
 
-acpi_status
+acpi_status __init
 acpi_os_predefined_override (const struct acpi_predefined_names *init_val,
 		             acpi_string *new_val)
 {
@@ -738,7 +738,7 @@ EXPORT_SYMBOL(acpi_os_wait_events_comple
 /*
  * Allocate the memory for a spinlock and initialize it.
  */
-acpi_status
+acpi_status __init
 acpi_os_create_lock (
 	acpi_handle	*out_handle)
 {
===== drivers/acpi/pci_bind.c 1.8 vs edited =====
--- 1.8/drivers/acpi/pci_bind.c	2004-11-12 06:25:31 +01:00
+++ edited/drivers/acpi/pci_bind.c	2004-12-06 23:57:25 +01:00
@@ -46,7 +46,7 @@ struct acpi_pci_data {
 };
 
 
-void
+static void
 acpi_pci_data_handler (
 	acpi_handle		handle,
 	u32			function,
===== drivers/acpi/power.c 1.23 vs edited =====
--- 1.23/drivers/acpi/power.c	2004-11-02 08:40:09 +01:00
+++ edited/drivers/acpi/power.c	2004-12-07 00:09:36 +01:00
@@ -58,8 +58,8 @@ ACPI_MODULE_NAME		("acpi_power")
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
-int acpi_power_add (struct acpi_device *device);
-int acpi_power_remove (struct acpi_device *device, int type);
+static int acpi_power_add (struct acpi_device *device);
+static int acpi_power_remove (struct acpi_device *device, int type);
 static int acpi_power_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_power_driver = {
@@ -479,7 +479,7 @@ end:
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_power_dir;
+static struct proc_dir_entry *acpi_power_dir;
 
 static int acpi_power_seq_show(struct seq_file *seq, void *offset)
 {
@@ -576,7 +576,7 @@ acpi_power_remove_fs (
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_power_add (
 	struct acpi_device	*device)
 {
@@ -642,7 +642,7 @@ end:
 }
 
 
-int
+static int
 acpi_power_remove (
 	struct acpi_device	*device,
 	int			type)
===== drivers/acpi/processor.c 1.72 vs edited =====
--- 1.72/drivers/acpi/processor.c	2004-12-03 08:25:47 +01:00
+++ edited/drivers/acpi/processor.c	2004-12-07 00:12:48 +01:00
@@ -149,7 +149,7 @@ static void (*pm_idle_save)(void);
                                 Errata Handling
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_processor_errata_piix4 (
 	struct pci_dev		*dev)
 {
@@ -257,7 +257,7 @@ acpi_processor_errata_piix4 (
 }
 
 
-int
+static int
 acpi_processor_errata (
 	struct acpi_processor	*pr)
 {
@@ -1916,7 +1916,7 @@ acpi_processor_get_limit_info (
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_processor_dir = NULL;
+static struct proc_dir_entry *acpi_processor_dir;
 
 static int acpi_processor_info_seq_show(struct seq_file *seq, void *offset)
 {
===== drivers/acpi/tables.c 1.26 vs edited =====
--- 1.26/drivers/acpi/tables.c	2004-08-25 00:12:20 +02:00
+++ edited/drivers/acpi/tables.c	2004-12-07 01:52:22 +01:00
@@ -74,7 +74,7 @@ struct acpi_table_sdt {
 static unsigned long		sdt_pa;		/* Physical Address */
 static unsigned long		sdt_count;	/* Table count */
 
-static struct acpi_table_sdt	sdt_entry[ACPI_MAX_TABLES];
+static struct acpi_table_sdt __initdata sdt_entry[ACPI_MAX_TABLES];
 
 void
 acpi_table_print (
===== drivers/acpi/thermal.c 1.40 vs edited =====
--- 1.40/drivers/acpi/thermal.c	2004-11-10 23:57:35 +01:00
+++ edited/drivers/acpi/thermal.c	2004-12-07 00:18:58 +01:00
@@ -773,7 +773,7 @@ acpi_thermal_check (
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_thermal_dir;
+static struct proc_dir_entry *acpi_thermal_dir;
 
 static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
 {
===== drivers/acpi/video.c 1.5 vs edited =====
--- 1.5/drivers/acpi/video.c	2004-11-11 21:59:21 +01:00
+++ edited/drivers/acpi/video.c	2004-12-07 00:23:03 +01:00
@@ -676,7 +676,7 @@ acpi_video_bus_check (
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_video_dir;
+static struct proc_dir_entry *acpi_video_dir;
 
 /* video devices */
 
===== drivers/acpi/events/evevent.c 1.27 vs edited =====
--- 1.27/drivers/acpi/events/evevent.c	2004-05-07 19:10:46 +02:00
+++ edited/drivers/acpi/events/evevent.c	2004-12-07 01:34:37 +01:00
@@ -40,7 +40,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  */
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
 
@@ -60,7 +60,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ev_initialize_events (
 	void)
 {
@@ -114,7 +114,7 @@ acpi_ev_initialize_events (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ev_install_xrupt_handlers (
 	void)
 {
@@ -161,7 +161,7 @@ acpi_ev_install_xrupt_handlers (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ev_fixed_event_initialize (
 	void)
 {
===== drivers/acpi/events/evgpeblk.c 1.19 vs edited =====
--- 1.19/drivers/acpi/events/evgpeblk.c	2004-10-23 04:22:14 +02:00
+++ edited/drivers/acpi/events/evgpeblk.c	2004-12-07 01:36:24 +01:00
@@ -40,7 +40,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  */
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
 #include <acpi/acnamesp.h>
@@ -1008,7 +1008,7 @@ acpi_ev_create_gpe_block (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ev_gpe_initialize (
 	void)
 {
===== drivers/acpi/events/evmisc.c 1.30 vs edited =====
--- 1.30/drivers/acpi/events/evmisc.c	2004-08-20 20:05:55 +02:00
+++ edited/drivers/acpi/events/evmisc.c	2004-12-07 01:36:03 +01:00
@@ -40,7 +40,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  */
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
 #include <acpi/acnamesp.h>
@@ -369,7 +369,7 @@ acpi_ev_global_lock_handler (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ev_init_global_lock_handler (void)
 {
 	acpi_status                     status;
===== drivers/acpi/events/evregion.c 1.25 vs edited =====
--- 1.25/drivers/acpi/events/evregion.c	2004-08-20 20:05:55 +02:00
+++ edited/drivers/acpi/events/evregion.c	2004-12-07 01:35:37 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
 #include <acpi/acnamesp.h>
@@ -71,7 +71,7 @@ static u8                   acpi_gbl_def
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ev_install_region_handlers (
 	void) {
 	acpi_status                     status;
@@ -143,7 +143,7 @@ unlock_and_exit:
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ev_initialize_op_regions (
 	void)
 {
===== drivers/acpi/events/evsci.c 1.16 vs edited =====
--- 1.16/drivers/acpi/events/evsci.c	2004-01-18 00:12:32 +01:00
+++ edited/drivers/acpi/events/evsci.c	2004-12-07 01:35:49 +01:00
@@ -41,7 +41,7 @@
  * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGES.
  */
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
 
@@ -145,7 +145,7 @@ acpi_ev_gpe_xrupt_handler (
  *
  ******************************************************************************/
 
-u32
+u32 __init
 acpi_ev_install_sci_handler (void)
 {
 	u32                             status = AE_OK;
===== drivers/acpi/events/evxfevnt.c 1.24 vs edited =====
--- 1.24/drivers/acpi/events/evxfevnt.c	2004-11-12 07:29:46 +01:00
+++ edited/drivers/acpi/events/evxfevnt.c	2004-12-07 01:08:39 +01:00
@@ -63,7 +63,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_enable (void)
 {
 	acpi_status                     status = AE_OK;
===== drivers/acpi/hardware/hwacpi.c 1.19 vs edited =====
--- 1.19/drivers/acpi/hardware/hwacpi.c	2004-01-18 00:12:31 +01:00
+++ edited/drivers/acpi/hardware/hwacpi.c	2004-12-07 01:36:42 +01:00
@@ -42,7 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 
 
@@ -62,7 +62,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_hw_initialize (
 	void)
 {
===== drivers/acpi/namespace/nsaccess.c 1.29 vs edited =====
--- 1.29/drivers/acpi/namespace/nsaccess.c	2004-11-06 06:44:08 +01:00
+++ edited/drivers/acpi/namespace/nsaccess.c	2004-12-07 01:36:57 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/amlcode.h>
 #include <acpi/acnamesp.h>
@@ -66,7 +66,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ns_root_initialize (void)
 {
 	acpi_status                         status;
===== drivers/acpi/namespace/nsinit.c 1.25 vs edited =====
--- 1.25/drivers/acpi/namespace/nsinit.c	2004-10-22 21:38:58 +02:00
+++ edited/drivers/acpi/namespace/nsinit.c	2004-12-08 17:03:31 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acdispat.h>
@@ -64,7 +64,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ns_initialize_objects (
 	void)
 {
@@ -126,7 +126,7 @@ acpi_ns_initialize_objects (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ns_initialize_devices (
 	void)
 {
===== drivers/acpi/namespace/nsload.c 1.23 vs edited =====
--- 1.23/drivers/acpi/namespace/nsload.c	2004-11-12 06:25:31 +01:00
+++ edited/drivers/acpi/namespace/nsload.c	2004-12-07 01:37:09 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acdispat.h>
@@ -159,7 +159,7 @@ acpi_ns_load_table (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ns_load_table_by_type (
 	acpi_table_type                 table_type)
 {
@@ -282,7 +282,7 @@ unlock_and_exit:
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ns_load_namespace (
 	void)
 {
===== drivers/acpi/tables/tbconvrt.c 1.31 vs edited =====
--- 1.31/drivers/acpi/tables/tbconvrt.c	2004-11-30 19:15:40 +01:00
+++ edited/drivers/acpi/tables/tbconvrt.c	2004-12-07 00:50:41 +01:00
@@ -108,7 +108,7 @@ acpi_tb_get_table_count (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_tb_convert_to_xsdt (
 	struct acpi_table_desc          *table_info)
 {
===== drivers/acpi/tables/tbgetall.c 1.13 vs edited =====
--- 1.13/drivers/acpi/tables/tbgetall.c	2004-01-18 00:12:31 +01:00
+++ edited/drivers/acpi/tables/tbgetall.c	2004-12-07 01:37:49 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/actables.h>
 
@@ -63,7 +63,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_tb_get_primary_table (
 	struct acpi_pointer             *address,
 	struct acpi_table_desc          *table_info)
@@ -201,7 +201,7 @@ acpi_tb_get_secondary_table (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_tb_get_required_tables (
 	void)
 {
===== drivers/acpi/tables/tbrsdt.c 1.13 vs edited =====
--- 1.13/drivers/acpi/tables/tbrsdt.c	2004-01-18 00:12:32 +01:00
+++ edited/drivers/acpi/tables/tbrsdt.c	2004-12-07 01:37:38 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/actables.h>
 
@@ -62,7 +62,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_tb_verify_rsdp (
 	struct acpi_pointer             *address)
 {
@@ -261,7 +261,7 @@ acpi_tb_validate_rsdt (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_tb_get_table_rsdt (
 	void)
 {
===== drivers/acpi/tables/tbxface.c 1.21 vs edited =====
--- 1.21/drivers/acpi/tables/tbxface.c	2004-11-12 07:29:46 +01:00
+++ edited/drivers/acpi/tables/tbxface.c	2004-12-07 00:38:06 +01:00
@@ -66,7 +66,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_load_tables (void)
 {
 	struct acpi_pointer             rsdp_address;
===== drivers/acpi/utilities/utglobal.c 1.45 vs edited =====
--- 1.45/drivers/acpi/utilities/utglobal.c	2004-11-12 07:29:47 +01:00
+++ edited/drivers/acpi/utilities/utglobal.c	2004-12-07 00:32:36 +01:00
@@ -797,7 +797,7 @@ acpi_ut_allocate_owner_id (
  *
  ***************************************************************************/
 
-void
+void __init
 acpi_ut_init_globals (
 	void)
 {
===== drivers/acpi/utilities/utinit.c 1.17 vs edited =====
--- 1.17/drivers/acpi/utilities/utinit.c	2004-01-18 00:12:32 +01:00
+++ edited/drivers/acpi/utilities/utinit.c	2004-12-07 01:38:05 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acevents.h>
@@ -65,7 +65,7 @@
  *
  ******************************************************************************/
 
-static void
+static void __init
 acpi_ut_fadt_register_error (
 	char                            *register_name,
 	u32                             value,
@@ -90,7 +90,7 @@ acpi_ut_fadt_register_error (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ut_validate_fadt (
 	void)
 {
===== drivers/acpi/utilities/utmisc.c 1.30 vs edited =====
--- 1.30/drivers/acpi/utilities/utmisc.c	2004-11-12 06:25:31 +01:00
+++ edited/drivers/acpi/utilities/utmisc.c	2004-12-07 01:38:17 +01:00
@@ -41,7 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-
+#include <linux/init.h>
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
@@ -523,7 +523,7 @@ acpi_ut_strupr (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_ut_mutex_initialize (
 	void)
 {
===== drivers/acpi/utilities/utxface.c 1.21 vs edited =====
--- 1.21/drivers/acpi/utilities/utxface.c	2004-11-12 07:29:47 +01:00
+++ edited/drivers/acpi/utilities/utxface.c	2004-12-08 17:05:04 +01:00
@@ -67,7 +67,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_initialize_subsystem (
 	void)
 {
@@ -135,7 +135,7 @@ acpi_initialize_subsystem (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_enable_subsystem (
 	u32                             flags)
 {
@@ -229,7 +229,7 @@ acpi_enable_subsystem (
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_initialize_objects (
 	u32                             flags)
 {
===== include/acpi/acpi_bus.h 1.20 vs edited =====
--- 1.20/include/acpi/acpi_bus.h	2004-10-28 08:25:07 +02:00
+++ edited/include/acpi/acpi_bus.h	2004-12-06 23:30:35 +01:00
@@ -324,6 +324,7 @@ int acpi_bus_generate_event (struct acpi
 int acpi_bus_receive_event (struct acpi_bus_event *event);
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
+void acpi_bus_data_handler (acpi_handle handle, u32 function, void *context);
 
 int acpi_match_ids (struct acpi_device	*device, char	*ids);
 int acpi_create_dir(struct acpi_device *);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
