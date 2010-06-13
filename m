From: Zhang Rui <rui.zhang@intel.com>
Subject: a question about lid input device
Date: Sun, 13 Jun 2010 14:53:31 +0800
Message-ID: <1276412011.19052.19294.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19685 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab0FMHHX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jun 2010 03:07:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Dmitry,

I have a question about the ACPI lid button input device.

By reading commit c0968f0e, I think the acpi lid button is registered as
a switch (EV_SW set), and the lid status is reported via SW_LID bit,
e.g. lid closed when SW_LID is set and vice versa.
Then we update the lid switch status when a Lid notification comes.
right?

Then, IMO, userspace can get the lid status
via /sys/class/input/inputX/uevent, right?

here is a the output of this file on my laptop,
/sys/class/input/input1/modalias:input:b0019v0000p0005e0000-e0,5,kramlsfw0,
/sys/class/input/input1/name:Lid Switch
/sys/class/input/input1/phys:PNP0C0D/button/input0
/sys/class/input/input1/uevent:PRODUCT=19/0/5/0
/sys/class/input/input1/uevent:NAME="Lid Switch"
/sys/class/input/input1/uevent:PHYS="PNP0C0D/button/input0"
/sys/class/input/input1/uevent:EV==21
/sys/class/input/input1/uevent:SW==1
/sys/class/input/input1/uevent:MODALIAS=input:b0019v0000p0005e0000-e0,5,kramlsfw0,

Lid is opened but SW is set, I tried to close/open the lid and found
that this bit never changes. is there something I misunderstand? can we
get the lid status in userspace?

thanks,
rui

