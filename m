From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI / PM: Make ACPI-based PCI wakeup work for the "freeze" sleep state
Date: Sat, 19 Jul 2014 22:36:53 +0200
Message-ID: <1907495.agrCMfRsQN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59632 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754635AbaGSUUD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2014 16:20:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Peter Zijlstra <peterz@infradead.org>

Hi,

As per the subject, this is to make ACPI-based PCI wakeup (such as WoL on some
systems among other things) work with the "freeze" sleep state.  For this
purpose ACPI wakeup GPEs need to be enabled for wakeup devices before
freeze_enter() is called and it is best to do that when configuring devices
for wakeup.

[1/2] Always enable wakeup GPEs when configuring devices for wakeup
[2/2] Rename one static function to avoid possible future confusion

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
