From: Marco Walther <Marco.Walther-xsfywfwIY+M@public.gmane.org>
Subject: Re: ACPI 20030109 + Kernel 2.4.21-pre3
Date: Thu, 16 Jan 2003 10:42:12 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15910.64772.328110.837406@jena.eng.sun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NaD9E5Rj2b"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--NaD9E5Rj2b
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Margit,

sorry I just subscribed to this list but I can at least help you one
step further;-) I'll append a patch for your acpiphp_glue.c compile
problem.  I make no guaranty that this is in any way correct but at
least it compiles;-)

But I've another problem with the 2.4.21-pre3+acpi-20030109
combination. A lot of values in the /proc FS for my Dell Inspiron8200
(P4m 1600 - Bios A7) are zero (or the equivalent) and ACPI misses my
two fans completly.  What do I do wrong?

Thanks,
-- Marco

-------- Information in /proc/acpi ----------------------------------------
feather:~ # uname -a
Linux feather 2.4.21-pre3 #1 Wed Jan 15 18:20:44 PST 2003 i686 unknown
feather:~ # lsmod
Module                  Size  Used by    Not tainted
thermal                 8096   0  (unused)
processor              10168   0  [thermal]
fan                     2016   0  (unused)
button                  3084   0  (unused)
battery                 6816   0  (unused)
ac                      2240   0  (unused)
videodev                6080   0  (autoclean)
sr_mod                 14360   0  (autoclean) (unused)
ipv6                  153556  -1  (autoclean)
ipt_TCPMSS              2360   1  (autoclean)
ipt_TOS                 1048  11  (autoclean)
ipt_state                568  58  (autoclean)
ipt_LOG                 3384  53  (autoclean)
ds                      6984   4 
yenta_socket           10688   2 
pcmcia_core            43168   0  [ds yenta_socket]
af_packet              13704   1  (autoclean)
joydev                  6112   0  (unused)
evdev                   4640   0  (unused)
input                   3360   0  [joydev evdev]
usb-uhci               23500   0  (unused)
usbcore                62400   1  [usb-uhci]
3c59x                  27792   1  (autoclean)
i810_audio             25224   0  (autoclean)
ac97_codec             11112   0  (autoclean) [i810_audio]
soundcore               3652   2  (autoclean) [i810_audio]
ipt_REJECT              3000   3  (autoclean)
iptable_mangle          2168   1  (autoclean)
iptable_filter          1740   1  (autoclean)
ip_nat_ftp              3184   0  (unused)
iptable_nat            15704   1  [ip_nat_ftp]
ip_conntrack_ftp        4176   1 
ip_conntrack           18880   3  [ipt_state ip_nat_ftp iptable_nat ip_conntrack_ftp]
ip_tables              12152  10  [ipt_TCPMSS ipt_TOS ipt_state ipt_LOG ipt_REJECT iptable_mangle iptable_filter iptable_nat]
serial                 47908   0  (autoclean)
isa-pnp                32612   0  (autoclean) [serial]
ide-scsi               10352   0 
scsi_mod               56372   2  [sr_mod ide-scsi]
feather:/proc/acpi # ls
.           alarm    dsdt                 fadt  power_resource  thermal_zone
..          battery  embedded_controller  fan   processor
ac_adapter  button   event                info  sleep
feather:/proc/acpi # cat alarm
2003-01-16 09:13:23
feather:/proc/acpi # cat info
version:                 20030109
states:                  S0 S1 S3 S4 S5
feather:/proc/acpi # cat sleep
S0 S1 S3 S4 S5
feather:/proc/acpi # cd ac_adapter/
feather:/proc/acpi/ac_adapter # ls
.  ..  AC
feather:/proc/acpi/ac_adapter # cd AC/
feather:/proc/acpi/ac_adapter/AC # ls
.  ..  state
feather:/proc/acpi/ac_adapter/AC # cat state
state:                   on-line
feather:/proc/acpi/ac_adapter/AC # cd ../../battery/
feather:/proc/acpi/battery # ls
.  ..  BAT0  BAT1
feather:/proc/acpi/battery # cd BAT0
feather:/proc/acpi/battery/BAT0 # ls
.  ..  alarm  info  state
feather:/proc/acpi/battery/BAT0 # cat alarm
alarm:                   unsupported
feather:/proc/acpi/battery/BAT0 # cat info
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      non-rechargeable
design voltage:          0 mV
design capacity warning: 0 mWh
design capacity low:     0 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  0 mWh
model number:
serial number:
battery type:
OEM info:
feather:/proc/acpi/battery/BAT0 # cat state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      0 mAh
present voltage:         0 mV

### Same values for BAT1

feather:/proc/acpi/battery/BAT0 # cd ../../button/
feather:/proc/acpi/button # ls
.  ..  lid  power  sleep
feather:/proc/acpi/button # cd lid/
feather:/proc/acpi/button/lid # ls
.  ..  LID
feather:/proc/acpi/button/lid # cd LID/
feather:/proc/acpi/button/lid/LID # ls
.  ..  info  state
feather:/proc/acpi/button/lid/LID # cat info
type:                    Lid Switch
feather:/proc/acpi/button/lid/LID # cat state
state:      open
feather:/proc/acpi/button/lid/LID # cd ../../power/PBTN/
feather:/proc/acpi/button/power/PBTN # ls
.  ..  info
feather:/proc/acpi/button/power/PBTN # cat info
type:                    Power Button (CM)
feather:/proc/acpi/button/power/PBTN # cd ../../sleep/SBTN/
feather:/proc/acpi/button/sleep/SBTN # cat info
type:                    Sleep Button (CM)
feather:/proc/acpi/button/sleep/SBTN # cd ../../../embedded_controller/
feather:/proc/acpi/embedded_controller # ls
.  ..
feather:/proc/acpi/embedded_controller # cd ../fan/
feather:/proc/acpi/fan # ls
.  ..
feather:/proc/acpi/fan # cd ../power_resource/
feather:/proc/acpi/power_resource # ls
.  ..  PADA
feather:/proc/acpi/power_resource # cd PADA/
feather:/proc/acpi/power_resource/PADA # ls
.  ..  state
feather:/proc/acpi/power_resource/PADA # cat state
state:                   on
system level:            S0
order:                   0
reference count:         0
feather:/proc/acpi/power_resource/PADA # cd ../../processor/
feather:/proc/acpi/processor # ls
.  ..  CPU0
feather:/proc/acpi/processor # cd CPU0/
feather:/proc/acpi/processor/CPU0 # ls
.  ..  info  limit  performance  power  throttling
feather:/proc/acpi/processor/CPU0 # cat info
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
performance management:  yes
limit interface:         yes
feather:/proc/acpi/processor/CPU0 # cat limit
active limit:            P0:T0
platform limit:          P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
feather:/proc/acpi/processor/CPU0 # cat performance
state count:             2
active state:            P0
states:
   *P0:                  2 MHz, 0 mW, 0 uS
    P1:                  0 MHz, 0 mW, 0 uS
feather:/proc/acpi/processor/CPU0 # cat power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00000010]
   *C2:                  promotion[--] demotion[C1] latency[050] usage[00103129]
    C3:                  <not supported>
feather:/proc/acpi/processor/CPU0 # cat throttling
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%
feather:/proc/acpi/processor/CPU0 # cd ../../thermal_zone/
feather:/proc/acpi/thermal_zone # ls
.  ..  THM
feather:/proc/acpi/thermal_zone # cd THM/
feather:/proc/acpi/thermal_zone/THM # ls
.  ..  cooling_mode  polling_frequency  state  temperature  trip_points
feather:/proc/acpi/thermal_zone/THM # cat cooling_mode
<not supported>
feather:/proc/acpi/thermal_zone/THM # cat polling_frequency
<polling disabled>
feather:/proc/acpi/thermal_zone/THM # cat state
state:                   ok
feather:/proc/acpi/thermal_zone/THM # cat temperature
temperature:             25 C
feather:/proc/acpi/thermal_zone/THM # cat trip_points
critical (S5):           94 C

---------------------------------------------------------------------------



--NaD9E5Rj2b
Content-Type: text/plain
Content-Description: acpiphp_glue.c diff
Content-Disposition: inline;
	filename="diff"
Content-Transfer-Encoding: 7bit

--- drivers/hotplug/acpiphp_glue.c~	2003-01-15 16:03:31.000000000 -0800
+++ drivers/hotplug/acpiphp_glue.c	2003-01-15 18:38:13.000000000 -0800
@@ -230,11 +230,11 @@
  * TBD: _TRA, etc.
  */
 static void
-decode_acpi_resource (acpi_resource *resource, struct acpiphp_bridge *bridge)
+decode_acpi_resource (struct acpi_resource *resource, struct acpiphp_bridge *bridge)
 {
-	acpi_resource_address16 *address16_data;
-	acpi_resource_address32 *address32_data;
-	acpi_resource_address64 *address64_data;
+	struct acpi_resource_address16 *address16_data;
+	struct acpi_resource_address32 *address32_data;
+	struct acpi_resource_address64 *address64_data;
 	struct pci_resource *res;
 
 	u32 resource_type, producer_consumer, address_length;
@@ -252,7 +252,7 @@
 
 		switch (resource->id) {
 		case ACPI_RSTYPE_ADDRESS16:
-			address16_data = (acpi_resource_address16 *)&resource->data;
+			address16_data = (struct acpi_resource_address16 *)&resource->data;
 			resource_type = address16_data->resource_type;
 			producer_consumer = address16_data->producer_consumer;
 			min_address_range = address16_data->min_address_range;
@@ -264,7 +264,7 @@
 			break;
 
 		case ACPI_RSTYPE_ADDRESS32:
-			address32_data = (acpi_resource_address32 *)&resource->data;
+			address32_data = (struct acpi_resource_address32 *)&resource->data;
 			resource_type = address32_data->resource_type;
 			producer_consumer = address32_data->producer_consumer;
 			min_address_range = address32_data->min_address_range;
@@ -276,7 +276,7 @@
 			break;
 
 		case ACPI_RSTYPE_ADDRESS64:
-			address64_data = (acpi_resource_address64 *)&resource->data;
+			address64_data = (struct acpi_resource_address64 *)&resource->data;
 			resource_type = address64_data->resource_type;
 			producer_consumer = address64_data->producer_consumer;
 			min_address_range = address64_data->min_address_range;
@@ -296,7 +296,7 @@
 			break;
 		}
 
-		resource = (acpi_resource *)((char*)resource + resource->length);
+		resource = (struct acpi_resource *)((char*)resource + resource->length);
 
 		if (found && producer_consumer == ACPI_PRODUCER && address_length > 0) {
 			switch (resource_type) {
@@ -390,12 +390,12 @@
 {
 	acpi_status status;
 #if ACPI_CA_VERSION < 0x20020201
-	acpi_buffer buffer;
+	struct acpi_buffer buffer;
 #else
-	acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
-			       .pointer = NULL};
+	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
+				      .pointer = NULL};
 #endif
-	acpi_object *package;
+	union acpi_object *package;
 	int i;
 
 	/* default numbers */
@@ -425,7 +425,7 @@
 		return;
 	}
 
-	package = (acpi_object *) buffer.pointer;
+	package = (union acpi_object *) buffer.pointer;
 
 	if (!package || package->type != ACPI_TYPE_PACKAGE ||
 	    package->package.count != 4 || !package->package.elements) {
@@ -495,10 +495,10 @@
 {
 	acpi_status status;
 #if ACPI_CA_VERSION < 0x20020201
-	acpi_buffer buffer;
+	struct acpi_buffer buffer;
 #else
-	acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
-			       .pointer = NULL};
+	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
+				      .pointer = NULL};
 #endif
 	struct acpiphp_bridge *bridge;
 
@@ -807,10 +807,10 @@
 find_host_bridge (acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-	acpi_device_info info;
+	struct acpi_device_info info;
 	char objname[5];
-	acpi_buffer buffer = { .length = sizeof(objname),
-			       .pointer = objname };
+	struct acpi_buffer buffer = { .length = sizeof(objname),
+				      .pointer = objname };
 
 	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status)) {
@@ -872,8 +872,8 @@
 	acpi_status status;
 	struct acpiphp_func *func;
 	struct list_head *l;
-	acpi_object_list arg_list;
-	acpi_object arg;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
 
 	int retval = 0;
 
@@ -1101,8 +1101,8 @@
 {
 	struct acpiphp_bridge *bridge;
 	char objname[64];
-	acpi_buffer buffer = { .length = sizeof(objname),
-			       .pointer = objname };
+	struct acpi_buffer buffer = { .length = sizeof(objname),
+				      .pointer = objname };
 
 	bridge = (struct acpiphp_bridge *)context;
 
@@ -1152,8 +1152,8 @@
 {
 	struct acpiphp_func *func;
 	char objname[64];
-	acpi_buffer buffer = { .length = sizeof(objname),
-			       .pointer = objname };
+	struct acpi_buffer buffer = { .length = sizeof(objname),
+				      .pointer = objname };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 

--NaD9E5Rj2b--

-- 


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
