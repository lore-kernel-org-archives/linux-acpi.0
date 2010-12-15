From: Lior Dotan <liodot@gmail.com>
Subject: general protection fault while suspending to RAM
Date: Wed, 15 Dec 2010 12:27:37 +0200
Message-ID: <1292408857.5006.16.camel@topaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58692 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab0LOK2n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Dec 2010 05:28:43 -0500
Received: by wyb28 with SMTP id 28so1292325wyb.19
        for <linux-acpi@vger.kernel.org>; Wed, 15 Dec 2010 02:28:42 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a ThinkPad T500, and occasionally while suspending to RAM using
'echo mem > /sys/power/state' I get a GP fault error.
I am now running 2.6.36.2 but it also happened on 2.6.35, I am not sure
about earlier kernels.
It happens regardless if the laptop is docked while suspending or
undocked.
I usually have at least 3 successful suspend cycles but last night it
happened on the first attempt after a reboot.

I've copied the last trace I've got:

general protection fault 0000 [#1] SMP
RIP acpi_ns_validate_handle 0x14/0x1d

acpi_get_data 0x40/0x73
pnp_bus_suspend 0x0/0x66
acpi_bus_get_device 0x1d/0x2e
acpi_bus_power_manageable 0xe/0x29
pnp_bus_suspend 0x0/0x66
pnpacpi_disable_resources 0x14/0x44
pnp_stop_dev 0x1f/0x57
pnp_bus_suspend 0x45/0x66
legacy_suspend 0x26/0x60
__device_suspend 0xc9/0xfe
dpm_suspend_start 0x2dc/0x3d6
suspend_devices_and_enter 0x41/0x1b6
enter_state 0xd1/0x11f
state_store 0xb1/0xce
sysfs_write_file 0xe3/0x11f
vfs_write 0xa4/0x180
sys_write 0x45/0x100
system_call_fastpath 0x16/0x1b

Let me know if you need more information.

Cheers,
Lior.

