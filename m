From: Gleb Natapov <gleb@redhat.com>
Subject: how CPU hot-plug is suppose to work on Linux?
Date: Tue, 21 Sep 2010 15:41:09 +0200
Message-ID: <20100921134109.GC11145@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40148 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754417Ab0IUNlL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Sep 2010 09:41:11 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: kvm@vger.kernel.org

Hello,

We are trying to add CPU hot-plug/unplug capability to KVM. We want to
be able to initiate hot-plug/unplug from a host. Our current schema
works like this:

We have Processor object in DSDT for each potentially available CPU.
Each Processor object has _MAD, _STA, _EJ0. _MAD of present CPU returns
enabled LAPIC structure. _STA of present CPU return 0xf. _MADT of non
present CPU returns disabled LAPIC. _STA returns 0x0. _EJ0 does nothing.

When CPU is hot plugged:

 1. Bit is set in sts register of gpe
 2. acpi interrupt is sent
 3. Linux ACPI evaluates corespondent gpe's _L() method
 4. _L() method determines which CPU's status is changed
 5. For each CPU that changed status from not present to present
    call Notify(1) to corespondent Processor() object.

When CPU is hot unplugged:

 1. Bit is set in sts register of gpe
 2. acpi interrupt is sent
 3. Linux ACPI evaluates corespondent gpe's _L() method
 4. _L() method determines which CPU's status is changed
 5. For each CPU that changed status from present to non present
    call Notify(3) to corespondent Processor() object.

Now, CPU hot plug appears to be working. But CPU hot unplug does
nothing. I expect that Linux will offline CPU and eject it after
evaluating Notify(3) and seeing that _STA of ejected CPU returns
0x0 now.

Any ideas how it is suppose to work?

--
			Gleb.
