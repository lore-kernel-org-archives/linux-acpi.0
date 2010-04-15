From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [BUG] 2.6.34-rc4: acpi boot-time oops on FSC Amilo Pa 3553
Date: Thu, 15 Apr 2010 20:25:38 +0200
Message-ID: <19399.23074.26023.534765@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:59456 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330Ab0DOS1L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Apr 2010 14:27:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Kernels up to and including 2.6.34-rc3 boot fine on my Amilo Pa 3553,
but 2.6.34-rc4 always oopses during boot in acpi.  Without a serial port
I cannot capture the entire oops, but it goes something like this:

__driver_attach
bus_for_each_dev
driver_attach
__driver_attach
bus_add_driver
acpi_device_remove
driver_register
async_thread
proc_mkdir_mode
async_thread
acpi_battery_init_async
async_thread
schedule
default_wake_function
async_thread
kthread
kthread
kernel_thread_helper
EIP: acpi_ex_read_data_from_field+0x16e

Any suggestions for revisions to try to revert?
