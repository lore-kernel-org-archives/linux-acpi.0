From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V6 0/8] usb: usb port power off mechanism and expose usb port connect type
Date: Mon, 21 Jan 2013 22:17:59 +0800
Message-ID: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18570 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab3AUOUc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 09:20:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

Change since v1:
       optimize the export connect type patch and adjust the DeviceRemovalbe flag
in the rh_call_control() after GetHubDescriptor request being processed.
       move all debounce operation to usb port's runtime resume callback(). Add
did_runtime_put in the struct usb_port to call pm_runtime_get/put(portdev) paired.
       using pm_runtime_get/put(portdev) to allow or prohibit device to be power
off inside of pm qos request in the kernel side. 

Change since v2:
       Correct some link breaks. 
       Add did_runtime_put in the usb_disconnect() before calling pm_runtime_put(portdev).
       Provide two seperate functions usb_device_allow_power_off() and usb_device_prevent_power_off()
instead of just one.

Change since v3:
	Set did_runtime_put to false in usb_disconnect() when its value is true
	Add comment about "not enable port runtime pm if fail to expose port's pm qos." and call
pm_runtime_set_active(portdev) unconditionally.
	rename "usb_device_allow_prevent_power_off" with "usb_device_control_power_off"
	Modify "be power off" to "be powered off"
	Expose dev_pm_qos_flags() symbol in order to ensure usb core can compile as module. 

Resend v4:
        make patch "PM/Qos: Expose dev_pm_qos_flags symbol" as first patch to avoid compilation error during "git bisect"
        correct some comments.

Change since v4:
	use EXPORT_SYMBOL_GPL to export dev_pm_qos_flags().
	correct some unnecessary link breaks.	
	Add CONFIG_USB_SUSPEND check around usb_port_runtime_resume() and usb_port_runtime_suspend()

Change since v5:
	predefine struct usb_hub_descriptor in the /driver/usb/core/usb.h instead of including "linux/usb/ch11.h"
	move patch "PM/Qos: Expose dev_pm_qos_flags symbol" before patch "usb: add runtime pm support for usb port device"
	 where dev_pm_qos_flags() fistly is called.


This patchset is based on usb-next tree commit f4cc1834 "USB: storage: avoid scanning other targets for single target device"

This patchset is to add usb port power off mechanism and
merge with patchset "usb: expose DeviceRemovable to user space via sysfs attribute".

Patchset "usb: expose DeviceRemovable to user space via sysfs attribute".
http://marc.info/?l=linux-usb&m=135279430410171&w=2 with some link break corrects

The main discussion about usb port power off mechanism is in the following link:
http://marc.info/?l=linux-usb&m=134818340017208&w=2


USB: Set usb port's DeviceRemovable according acpi information
usb: Register usb port's acpi power resources
PM/Qos: Expose dev_pm_qos_flags symbol
usb: add runtime pm support for usb port device
usb: add usb port auto power off mechanism
usb: expose usb port's pm qos flags to user space
usb: add usb_device_allow_power_off() and usb_device_prevent_power_off() function.
usb: enable usb port device's async suspend.
