From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: GPE handling
Date: Fri, 9 Nov 2007 15:50:48 +0800
Message-ID: <FC1D1B23302A22499C60C967336B2AE001FF2CA9@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3554 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbXKIHw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 02:52:56 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Bob & Ming,
I'm working on adding wakeup GPE support at system runtime, this
capability can help us
Identify which device invokes a wakeup event at runtime, this is
required for runtime device
Power management.

Below is the ASL code. For example, _L0c, USB3 will send a wakeup GPE
and invoke
a notify. In the notify handler, OS will clear USB3's PCI PME status to
avoid wakeup
event flood. But in current code, acpi_ev_asynch_execute_gpe_method will
start an asynchronous
execution of notify and return soon. Just before the return,
acpi_ev_asynch_execute_gpe_method
will reenable GPE 0C. That means GPE is enabled before OS execute
notification handler and USB3's
PCI PME status is cleared, and cause GPE flood. Ideally, I think we
should delay GPE enable
of _L0c till notification handler is finished or simply the method _L0c
is really finished.
What do you think?

Thanks,
Shaohua


        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB7, 0x02)
        }

        Method (_L0E, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB4, 0x02)
        }
