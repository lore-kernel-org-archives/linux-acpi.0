From: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver
Date: Sun, 22 Aug 2004 22:07:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41297BA7.3050503@linuxboxen.org>
References: <41244219.1090603@linuxboxen.org> <87zn4pl116.wl%miura@da-cha.org>
 <87n00pkqc5.wl%miura@da-cha.org> <41270B53.3060903@linuxboxen.org>
 <87d61klqzh.wl%miura@da-cha.org> <41284119.1060504@linuxboxen.org>
 <412858F0.8050406@linuxboxen.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------030501010804080103020103
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <412858F0.8050406-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
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
--------------030501010804080103020103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey all,

Well, it's time for my daily source code release... I shouldn't make a 
habit of this. The following patch is against v0.6.1, fixes a few small 
bugs, and cleans up the code some.

Also attached are perl scripts (ac_adapt.pl, hotkey.pl) to handle all of 
the hotkey events in a safe and sane manner and handle AC adapter 
connect/disconnect. The assumptions and requirements of these scripts 
are listed in the headers for them.

I've included as well the event/* files needed (ac_adapter, hotkey).

The kernel code is still missing the ability to change display device -- 
but other than that, I can't see very much missing from it.

Together, the scripts and the patch enable all of the user's hotkeys 
except suspend-to-RAM (which seems troublesome on all machines) and 
switching display device (because we don't get an event for that). The 
scripts handle changing the correct display brightness field depending 
on power status.

As a side note, I feel that this code is nearing release quality. 
Hiroshi, what is your opinion?

David Bronaugh

--------------030501010804080103020103
Content-Type: text/x-patch;
 name="pcc-0.6.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcc-0.6.2.patch"

--- la-2.6.8.1/drivers/acpi/pcc_acpi.c	2004-08-22 11:05:27.000000000 -0700
+++ linux-2.6.8.1/drivers/acpi/pcc_acpi.c	2004-08-22 13:30:54.000000000 -0700
@@ -20,9 +20,15 @@
  *---------------------------------------------------------------------------
  *
  * ChangeLog:
- *      Aug.21, 2004    David Bronaugh
- *              - v0.6.1 Fix a silly error with status checking
- *      Aug.20, 2004    David Bronaugh
+ *      Aug.22, 2004    David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
+ *              -v0.6.2 Add check on ACPI data (num_sifr)
+ *                      Coding style cleanups, better error messages/handling
+ *			Fixed an off-by-one error in memory allocation
+ *
+ *      Aug.21, 2004    David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
+ *              -v0.6.1 Fix a silly error with status checking
+ *
+ *      Aug.20, 2004    David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
  *              - v0.6  Correct brightness controls to reflect reality
  *                      based on information gleaned by Hiroshi Miura
  *                      and discussions with Hiroshi Miura
@@ -46,7 +52,7 @@
  *
  */
 
-#define ACPI_PCC_VERSION	"0.6.1"
+#define ACPI_PCC_VERSION	"0.6.2"
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -162,7 +168,7 @@
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_INFO LOGPREFIX "acpi evaluate error on %s\n", 
 		       methodName);
-		return (-EFAULT);
+		return -EFAULT;
 	}
 
 	if (out_objs[0].type == ACPI_TYPE_INTEGER) {
@@ -213,12 +219,21 @@
 	 * destination so that sscanf can be used on it safely.
 	 */
 	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if (!tmp_buffer) {
+		printk(KERN_INFO LOGPREFIX "dispatch_write: Couldn't allocate buffer");
+		return -EFAULT;
+	}
+
 	if (copy_from_user(tmp_buffer, buffer, count)) {
+		printk(KERN_INFO LOGPREFIX "dispatch_write: Couldn't copy data from userspace");
 		result = -EFAULT;
-	} else {
-		tmp_buffer[count] = 0;
-		result = item->write_func(tmp_buffer, count);
+		goto end;
 	}
+
+	tmp_buffer[count] = 0;
+	result = item->write_func(tmp_buffer, count);
+		
+end:
 	kfree(tmp_buffer);
 	return result;
 }
@@ -236,7 +251,6 @@
 				  "evaluation error HKEY.SQTY\n"));
 		return -EINVAL;
 	}
-	
 }
 
 static int acpi_pcc_retrieve_biosdata(u32* sinf) 
@@ -270,8 +284,9 @@
 		union acpi_object *element = &(hkey->package.elements[i]);
 		if (likely(element->type == ACPI_TYPE_INTEGER)) {
 			sinf[i] = element->integer.value;
-		} else 
+		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid HKEY.SINF data\n"));
+		}
 	}
 	sinf[hkey->package.count] = -1; 
 
@@ -282,9 +297,9 @@
 
 static char* acpi_pcc_read_sinf_field(char* p, int field) 
 {
-	u32* sinf;
+	u32* sinf = kmalloc(sizeof(u32) * (num_sifr + 1), GFP_KERNEL);
 
-	if (!(sinf = kmalloc(sizeof(u32) * num_sifr, GFP_KERNEL))) {
+	if (!sinf) {
 		printk(KERN_INFO LOGPREFIX "Couldn't allocate %i bytes\n", 
 		       sizeof(u32) * num_sifr);
 		return p;
@@ -369,9 +384,9 @@
 					       int cur_index)
 {
 	u32 bright;
-	u32* sinf;
+	u32* sinf = kmalloc(sizeof(u32) * (num_sifr + 1), GFP_KERNEL);
 
-	if (!(sinf = kmalloc(sizeof(u32) * num_sifr, GFP_KERNEL))) {
+	if (!sinf) {
 		printk(KERN_INFO LOGPREFIX "Couldn't allocate %i bytes\n", 
 		       sizeof(u32) * num_sifr);
 		return count;
@@ -421,7 +436,6 @@
 	return p;
 }
 
-
 /* hotkey driver */
 static int acpi_pcc_hotkey_get_key(struct acpi_hotkey *hotkey)
 {
@@ -438,14 +452,10 @@
 	return (status);
 }
 
-void
-acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
+void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_hotkey	*hotkey = (struct acpi_hotkey *) data;
 
-	if (!hotkey || !hotkey->device)
-		return;
-
 	switch(event) {
 	case HKEY_NOTIFY:
 		if (acpi_pcc_hotkey_get_key(hotkey)) {
@@ -475,11 +485,11 @@
 	{ "dc_brightness_max" , acpi_pcc_read_dc_max_brightness, NULL },
 	{ "dc_brightness_min" , acpi_pcc_read_dc_min_brightness, NULL },
 	{ "dc_brightness" , acpi_pcc_read_dc_brightness, 
-	  acpi_pcc_write_dc_brightness},
-	{ "mute", acpi_pcc_read_mute, acpi_pcc_write_mute},
-	{ "version", acpi_pcc_read_version , NULL},
+	  acpi_pcc_write_dc_brightness },
+	{ "mute", acpi_pcc_read_mute, acpi_pcc_write_mute },
+	{ "version", acpi_pcc_read_version , NULL },
 	{ "environment_state", acpi_pcc_read_env_state, NULL },
-	{ NULL 	   , NULL	  , NULL},
+	{ NULL 	   , NULL	  , NULL },
 };
 
 static acpi_status __init add_device(ProcItem *proc_items, 
@@ -504,20 +514,22 @@
 		}
 	}
 
-	return(AE_OK);
+	return AE_OK;
 }
 
-
 static int __init acpi_pcc_proc_init(void)
 {
 	acpi_status status = AE_OK;
+	acpi_pcc_dir = proc_mkdir(PROC_PCC, acpi_root_dir);
 
-	if (unlikely(!(acpi_pcc_dir = proc_mkdir(PROC_PCC, acpi_root_dir))))
+	if (unlikely(!acpi_pcc_dir)) {
+		printk(KERN_INFO LOGPREFIX "Couldn't create dir in /proc\n");
 		return -ENODEV;
+	}
 
 	acpi_pcc_dir->owner = THIS_MODULE;
 	status = add_device(pcc_proc_items, acpi_pcc_dir);
-	if (ACPI_FAILURE(status)){
+	if (ACPI_FAILURE(status)) {
 		remove_proc_entry(PROC_PCC, acpi_root_dir);
 		return -ENODEV;
 	}
@@ -530,12 +542,12 @@
 {
 	ProcItem* item;
 
-	for (item = proc_items; item->name; ++item)
+	for (item = proc_items; item->name; ++item) {
 		remove_proc_entry(item->name, proc_entry);
+	}
 	return(AE_OK);
 }
 
-
 static int acpi_pcc_hotkey_add (struct acpi_device *device)
 {
 	acpi_status		status = AE_OK;
@@ -543,12 +555,22 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_add");
 
-	if (!device)
+	if (!device) {
 		return_VALUE(-EINVAL);
+	}
+
+	num_sifr = acpi_pcc_get_sqty();
+	
+	if (num_sifr > 255) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "num_sifr too large"));
+		return_VALUE(-ENODEV);
+	}
 
 	hotkey = kmalloc(sizeof(struct acpi_hotkey), GFP_KERNEL);
-	if (!hotkey)
+	if (!hotkey) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Couldn't allocate mem for hotkey"));
 		return_VALUE(-ENOMEM);
+	}
 
 	memset(hotkey, 0, sizeof(struct acpi_hotkey));
 
@@ -570,8 +592,6 @@
 		return_VALUE(-ENODEV);
 	}
 
-	num_sifr = acpi_pcc_get_sqty();
-	
 	acpi_pcc_proc_init();
 
 	return_VALUE(0);
@@ -601,7 +621,6 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error removing notify handler\n"));
 
 	kfree(hotkey);
-
 	return_VALUE(status == AE_OK);
 }
 
@@ -611,8 +630,9 @@
  
 	ACPI_FUNCTION_TRACE("acpi_pcc_init");
 
-	if (acpi_disabled)
+	if (acpi_disabled) {
 		return_VALUE(-ENODEV);
+	}
 
 	result = acpi_bus_register_driver(&acpi_hotkey_driver);
 	if (ACPI_FAILURE(result)) {

--------------030501010804080103020103
Content-Type: text/x-perl;
 name="ac_adapt.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac_adapt.pl"

#!/usr/bin/perl -w
# AC Power Handler v1.0
# Handles AC power events for Panasonic notebooks
#
# Copyright (C) 2004 David Bronaugh
#
# Requires pcc_acpi driver
#
# This program is free software; you can redistribute it and/or modify 
# it under the terms of the GNU General Public License version 2 as 
# published by the Free Software Foundation
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

use strict;
use POSIX qw(ceil floor);

our($config);
our($power_state);

sub read_file {
  my($file) = @_;
  my($fh);
  my($contents) = "";
  if(open($fh, $file)) {
    $/ = undef;
    $contents = <$fh>;
    close($fh);
  } else {
    print "Couldn't open file " . $file . "!\n";
  }
  return $contents;
}

sub write_file {
  my($file, $contents) = @_;
  my($fh);

  if(open($fh, ">", $file)) {
    print $fh $contents;
    close($fh);
    return 1;
  } else {
    print "Couldn't open file " . $file . "!\n";
    return 0;
  }
}

sub get_pcc_field {
  my($field) = @_;
  my($file) = $config->{'pcc_path'} . "/" . $power_state . "_" . $field;

  return read_file($file);
}

sub set_pcc_field {
  my($field, $contents) = @_;
  my($file) = $config->{'pcc_path'} . "/" . $power_state . "_" . $field;

  if(!write_file($file, $contents)) {
    print "Couldn't set pcc " . $field . " field (are you root?)\n";
    return 0;
  }
  return 1;
}

sub ac_disconnect {
  $power_state = "dc";
  set_pcc_field("brightness", get_pcc_field("brightness"));
}

sub ac_connect {
  $power_state = "ac";
  set_pcc_field("brightness", get_pcc_field("brightness"));
}

my($key) = $ARGV[3];

my(%dispatch) = (
	     "00000000" => \&ac_disconnect,
	     "00000001" => \&ac_connect,
	    );

$config = {
	       "pcc_path" => "/proc/acpi/pcc",
	      };

$dispatch{$key}();

--------------030501010804080103020103
Content-Type: text/plain;
 name="ac_adapter"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac_adapter"

# /etc/acpi/events/hotkey
# This script handles hotkey events on Panasonic notebooks

event=ac_adapter.*
action=/etc/acpi/ac_adapt.pl %e

--------------030501010804080103020103
Content-Type: text/plain;
 name="hotkey"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotkey"

# /etc/acpi/events/hotkey
# This script handles hotkey events on Panasonic notebooks

event=HKEY.*
action=/etc/acpi/hotkey.pl %e

--------------030501010804080103020103
Content-Type: text/x-perl;
 name="hotkey.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotkey.pl"

#!/usr/bin/perl -w
# Hotkey handler v1.0
# Handles hotkey events for Panasonic notebooks
#
# Copyright (C) 2004 David Bronaugh
#
# This program is free software; you can redistribute it and/or modify 
# it under the terms of the GNU General Public License version 2 as 
# published by the Free Software Foundation
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

use strict;
use POSIX qw(ceil floor);

our($config);
our($power_state);

sub read_file {
  my($file) = @_;
  my($fh);
  my($contents) = "";
  if(open($fh, $file)) {
    $/ = undef;
    $contents = <$fh>;
    close($fh);
  } else {
    print "Couldn't open file " . $file . "!\n";
  }
  return $contents;
}

sub write_file {
  my($file, $contents) = @_;
  my($fh);

  if(open($fh, ">", $file)) {
    print $fh $contents;
    close($fh);
    return 1;
  } else {
    print "Couldn't open file " . $file . "!\n";
    return 0;
  }
}

sub get_amixer_control_info {
  my($control) = @_;
  my($cmd) = $config->{'mixer_program'} . " cget name='" . $control . "'";
  my(%info);
  my($fh, $field);
  my($contents) = "";
  if(open($fh, $cmd . "|")) {
    while(<$fh>) {
      chomp;
      $contents .= $_;
    }
  } else {
    print "Couldn't run command " . $cmd . "!\n";
  }

  $contents =~ m/\; ([^\s]*)/;

  foreach(split(/,/, $+)) {
    my(@foo) = split(/=/, $_);
    $info{$foo[0]} = $foo[1];
  }

  $contents =~ m/\: ([^\s]*)/;
  my(@foo) = split(/=/, $+);
  $info{$foo[0]} = [];
  @{$info{$foo[0]}} = split(/,/, $foo[1]);

  return \%info;
}

sub set_amixer_control_info {
  my($control, $values) = @_;
  my($cmd) = $config->{'mixer_program'} . " -q cset name='" . $control . "' " . $values;

  if(system($cmd) == 0) {
    return 1;
  } else {
    return 0;
  }
}

sub get_pcc_field {
  my($field) = @_;
  my($file) = $config->{'pcc_path'} . "/" . $power_state . "_" . $field;

  return read_file($file);
}

sub set_pcc_field {
  my($field, $contents) = @_;
  my($file) = $config->{'pcc_path'} . "/" . $power_state . "_" . $field;

  if(!write_file($file, $contents)) {
    print "Couldn't set pcc " . $field . " field (are you root?)\n";
    return 0;
  }
  return 1;
}

sub get_brightness {
  return (get_pcc_field("brightness_min"), get_pcc_field("brightness_max"), get_pcc_field("brightness"));
}

sub set_brightness {
  my($value) = @_;
  return set_pcc_field("brightness", $value);
}

sub get_mute {
  my($info) = get_amixer_control_info($config->{'mute_switch'});

  if($info->{'values'}[0] eq "on") {
    return 0;
  } elsif($info->{'values'}[0] eq "off") {
    return 1;
  } else {
    print "Error getting mute status!\n";
    return -1;
  }
}

sub set_mute {
  my($value) = @_;
  if($value == 0) {
    $value = "on";
  } elsif($value == 1) {
    $value = "off";
  }

  if(set_amixer_control_info($config->{'mute_switch'}, $value)) {
    return 1;
  } else {
    print "Couldn't set mute status!\n";
    return 0;
  }
}

sub get_volume {
  my($config) = @_;
  my($info) = get_amixer_control_info($config->{'volume_ctl'});

  return ($info->{'min'}, $info->{'max'}, $info->{'values'});
}

sub set_volume {
  my($values) = @_;

  return set_amixer_control_info($config->{'volume_ctl'}, join(",", @{$values}));
}

sub get_power_state {
  my($data) = read_file($config->{"ac_state"});

  if($data =~ /on-line/) {
    return "ac";
  } elsif($data =~ /off-line/) {
    return "dc";
  } else {
    print "Couldn't get power state! (is ACPI enabled?)\n";
    exit(1);
  }
}

sub adjust_brightness { 
  my($adjust) = @_;
  my($min, $max, $bright) = get_brightness($config);
  my($threshold) = $config->{'max_bright_levels'};
  my($divisor) = 1;

  $bright -= $min;

  if($max - $min > $threshold) {
    $divisor = ($max - $min) / $threshold;
  }

  $bright = ceil($bright / $divisor);
  $bright += $adjust;
  $bright = floor($bright * $divisor);

  $bright += $min;

  if($bright < $min) {
    $bright = $min;
  }

  if($bright > $max) {
    $bright = $max;
  }

  if(!set_brightness($bright)) {
    print "Couldn't adjust brightness!\n";
  }

  return;
}

sub adjust_volume {
  my($increment) = @_;
  my($min, $max, $volume) = get_volume($config);

  $volume->[0] += $increment;
  $volume->[1] += $increment;

  $volume->[0] = ($volume->[0] < $min)?$min:$volume->[0];
  $volume->[1] = ($volume->[1] < $min)?$min:$volume->[1];
  $volume->[0] = ($volume->[0] > $max)?$max:$volume->[0];
  $volume->[1] = ($volume->[1] > $max)?$max:$volume->[1];

  if(!set_volume($volume)) {
    print "Couldn't set volume!\n";
  }

  return;
}

# Functions which implement hotkey functions directly
sub down_brightness {
  adjust_brightness(-1);
}

sub up_brightness {
  adjust_brightness(1);
}

sub switch_monitor {
  #STUB
}

sub toggle_mute {
  my($mute) = get_mute();

  if($mute >= 0) {
    set_mute($mute ^ 1);
  }
}

sub volume_up {
  adjust_volume($config->{"volume_increment"})
}

sub volume_down {
  adjust_volume(-1 * $config->{"volume_increment"})
}

sub suspend_to_ram {
  # This space intentionally left blank (because it doesn't work here)
}

sub spin_down_hd {
  if(system("hdparm -q -y /dev/hda") != 0) {
    print "Error running hdparm -- is it installed?\n";
  }
}

sub suspend_to_disk {
  system("hwclock --systohc");
  write_file($config->{'suspend_control'}, "disk");
  system("hwclock --hctosys");
}

my($key) = $ARGV[3];

my(%dispatch) = (
	     "00000081" => \&down_brightness,
	     "00000082" => \&up_brightness,
	     "00000003" => \&switch_monitor,
	     "00000084" => \&toggle_mute,
	     "00000085" => \&volume_down,
	     "00000086" => \&volume_up,
	     "00000007" => \&suspend_to_ram,
	     "00000089" => \&spin_down_hd,
	     "0000000a" => \&suspend_to_disk
	    );

$config = {
	       "pcc_path" => "/proc/acpi/pcc",
	       "mixer_program" => "amixer",
	       "ac_state" => "/proc/acpi/ac_adapter/AC/state",
	       "mute_switch" => "Master Playback Switch",
	       "volume_ctl" => "Master Playback Volume",
	       "max_bright_levels" => 20,
	       "volume_increment" => 2,
	       "suspend_control" => "/sys/power/state"
	      };

$power_state = get_power_state();

$dispatch{$key}();

--------------030501010804080103020103--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
