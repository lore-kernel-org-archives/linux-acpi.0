From: "Erwan Velu" <erwanaliasr1@gmail.com>
Subject: ACPI Error (utglobal-0126)
Date: Tue, 15 Jan 2008 14:10:38 +0100
Message-ID: <b43bf5490801150510v55ddb2feq3be947536c4c28c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:23581 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbYAONKl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jan 2008 08:10:41 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4323179wah.23
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jan 2008 05:10:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hey folks,

I'm running a 2.6.24-rc7 on my Samsung R70 in 64bit mode.
While booting up, the ACPI shows me this error :

ACPI Error (utglobal-0126): Unknown exception code: 0xFFFFFFFE [20070126]
Pid: 1950, comm: modprobe Not tainted 2.6.24-laptop-0.rc7.1mdv #1

Call Trace:
 [<ffffffff8038bd86>] acpi_ut_update_ref_count+0x50/0x9d
 [<ffffffff8038c231>] acpi_format_exception+0x2c/0x35
 [<ffffffff8038afcb>] acpi_ut_exception+0x25/0x8c
 [<ffffffff8037662c>] acpi_evaluate_integer+0xb6/0xc7
 [<ffffffff8821dd0a>] :video:acpi_video_bus_add+0xcc9/0xce2
 [<ffffffff802c45e8>] ifind+0x58/0xd0
 [<ffffffff8038f33c>] acpi_device_probe+0x43/0x91
 [<ffffffff803c31cc>] driver_probe_device+0x9c/0x1b0
 [<ffffffff803c3499>] __driver_attach+0xc9/0xd0
 [<ffffffff803c33d0>] __driver_attach+0x0/0xd0
 [<ffffffff803c23ad>] bus_for_each_dev+0x4d/0x80
 [<ffffffff803c281c>] bus_add_driver+0xac/0x220
 [<ffffffff8822303c>] :video:acpi_video_init+0x3c/0x5e
 [<ffffffff802622ae>] sys_init_module+0x18e/0x19a0
 [<ffffffff802522b0>] autoremove_wake_function+0x0/0x30
 [<ffffffff8020c34e>] system_call+0x7e/0x83

ACPI Exception (video-1721): UNKNOWN_STATUS_CODE, Cant attach device [20070126]
input: Video Bus as /class/input/input7

I would love helping you in fixing that.
How Can I Help ?
