From: Oliver Neukum <oliver@neukum.org>
Subject: lockdep report during boot on 2.6.34-rc1
Date: Thu, 11 Mar 2010 07:34:55 +0100
Message-ID: <201003110734.55607.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:53470 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0CKGf3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Mar 2010 01:35:29 -0500
Received: from vanamonde.localnet (p549A1C89.dip0.t-ipconnect.de [84.154.28.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: neukum_org@smtp-out002.kontent.com)
	by smtp-out002.kontent.com (Postfix) with ESMTPSA id 233295802D89
	for <linux-acpi@vger.kernel.org>; Thu, 11 Mar 2010 07:35:28 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I got this report from lockdep booting 2.6.34-rc1 on x86_64.
What else is needed?

	Regards
		Oliver

ACPI: SSDT 00000000bff972f0 000CC (v01  PmRef  Cpu1Ist 00003000 INTL 20051117)
ACPI: SSDT 00000000bff97610 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20051117)
BUG: key ffff88013615ec60 not in .data!
------------[ cut here ]------------
WARNING: at kernel/lockdep.c:2706 lockdep_init_map+0xe6/0x505()
Hardware name: M70Vn               
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.34-rc1-0.1-default #27
Call Trace:
 [<ffffffff81038f65>] warn_slowpath_common+0x77/0x8f
 [<ffffffff81038f8c>] warn_slowpath_null+0xf/0x11
 [<ffffffff8105c614>] lockdep_init_map+0xe6/0x505
 [<ffffffff81123e8c>] ? sysfs_new_dirent+0x8a/0xff
 [<ffffffff811235af>] sysfs_add_file_mode+0x61/0xa9
 [<ffffffff811a780e>] ? sprintf+0x40/0x42
 [<ffffffff81123603>] sysfs_add_file+0xc/0xe
 [<ffffffff811236b8>] sysfs_create_file+0x25/0x27
 [<ffffffff8122f60c>] device_create_file+0x14/0x16
 [<ffffffff8124dd4a>] thermal_zone_bind_cooling_device+0x18d/0x278
 [<ffffffff811ffbf8>] acpi_thermal_cooling_device_cb+0x98/0x18f
 [<ffffffff8124d96f>] ? thermal_zone_device_register+0x27d/0x3b7
 [<ffffffff8124dbbd>] ? thermal_zone_bind_cooling_device+0x0/0x278
 [<ffffffff811235d0>] ? sysfs_add_file_mode+0x82/0xa9
 [<ffffffff811ffd11>] acpi_thermal_bind_cooling_device+0x10/0x12
 [<ffffffff8124d9b3>] thermal_zone_device_register+0x2c1/0x3b7
 [<ffffffff811ffee1>] acpi_thermal_add+0x1ce/0x44e
 [<ffffffff81124994>] ? sysfs_do_create_link+0xe2/0x137
 [<ffffffff811d8cf8>] acpi_device_probe+0x4b/0x11d
 [<ffffffff81231a5f>] driver_probe_device+0xa9/0x13a
 [<ffffffff81231b48>] __driver_attach+0x58/0x7c
 [<ffffffff81231af0>] ? __driver_attach+0x0/0x7c
 [<ffffffff81231297>] bus_for_each_dev+0x54/0x89
 [<ffffffff812318cc>] driver_attach+0x19/0x1b
 [<ffffffff81230bf0>] bus_add_driver+0xbb/0x20a
 [<ffffffff81231e23>] driver_register+0x98/0x109
 [<ffffffff8186fe25>] ? acpi_thermal_init+0x0/0x7b
 [<ffffffff811da385>] acpi_bus_register_driver+0x3e/0x41
 [<ffffffff8186fe7e>] acpi_thermal_init+0x59/0x7b
 [<ffffffff810001ef>] do_one_initcall+0x59/0x14e
 [<ffffffff8184a6b2>] kernel_init+0x178/0x206
 [<ffffffff81003754>] kernel_thread_helper+0x4/0x10
 [<ffffffff812fd2bc>] ? restore_args+0x0/0x30
 [<ffffffff8184a53a>] ? kernel_init+0x0/0x206
 [<ffffffff81003750>] ? kernel_thread_helper+0x0/0x10
---[ end trace a7919e7f17c0a725 ]---
BUG: key ffff88013615eba0 not in .data!
thermal LNXTHERM:01: registered as thermal_zone0
ACPI: Thermal Zone [THRM] (33 C)
