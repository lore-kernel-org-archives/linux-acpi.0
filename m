From: Pavel Troller <patrol@sinus.cz>
Subject: Problem suspending Clevo D650SU notebook in 2.6.18
Date: Sat, 23 Sep 2006 06:59:47 +0200
Message-ID: <20060923045947.GA15012@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:38091 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1751013AbWIWE7u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Sep 2006 00:59:50 -0400
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5.20060308/8.13.5) with ESMTP id k8N4xmx5015261
	for <linux-acpi@vger.kernel.org>; Sat, 23 Sep 2006 06:59:48 +0200
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5.20060308/8.13.5/Submit) id k8N4xlFu015260
	for linux-acpi@vger.kernel.org; Sat, 23 Sep 2006 06:59:47 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
  After a while I've updated my notebook. Formerly it was loaded with 2.6.15
and now it runs 2.6.18.
  All seems to be working well, except suspending, either to RAM or to disk.
  Both is blocked by very similar event. For example, the following is dumped
when attempting to use STR:
pnp: Device 00:09 disabled.
Stopping tasks: ========================================================================|
[ACPI Debug]  String: [0x1B] "===== SST Sleeping S3 ====="
Class driver suspend failed for cpu0
some devices failed to power down
Could not power down device <4 random binary characters>: error -22
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
PM: Writing back config space on device 0000:00:0c.0 at offset 1 (was 2100003, writing 2100007)
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
pnp: Device 00:06 does not support activation.
pnp: Failed to activate device 00:07.
Restarting tasks... done
[ACPI Debug]  String: [0x1A] "===== SST Working S2 ====="
[ACPI Debug]  String: [0x17] "===== SST Working ====="
  Please look at thos 3 lines starting with "Class driver suspend failed for cpu0".
  On the 3rd, there are 4 non-ASCII characters as the name, which were unable
to be transferred by mouse c&p (between text consoles).
There are also another messages regarding device activation, which were not
present in 2.6.15. 
  Any help, how to get the system suspend working again, is highly appreciated.
     With regards, Pavel Troller
