From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [BUG] System runs very slow with high cooling_device state
Date: Thu, 28 Jul 2011 10:39:06 +0200
Message-ID: <CANq1E4RGP5P3F+u1t0pCj9G1pSxoiCr3-9E6QaSSfTfJWj+NgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57608 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab1G1IjH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jul 2011 04:39:07 -0400
Received: by vxh35 with SMTP id 35so1738098vxh.19
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2011 01:39:06 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, David Herrmann <dh.herrmann@googlemail.com>

Hi

I tried running:
echo 10 >/sys/class/thermal/cooling_device0/cur_state
echo 10 >/sys/class/thermal/cooling_device1/cur_state
Both "max_state" is 10 and cur_state was 0 before.

After that the whole system runs horribly slow. Running "htop" didn't
show any CPU consuming process, though. Even the kernel threads were
idle. Setting *either of them* to 0 made the system response timer
much better again. Setting one to 10 and the other one to 5 makes the
system slow again, but not as slow as with both at 10 so I think this
is incremental.

Since htop doesn't show anything I guess this attribute either changes
the wrong option or the kernel is running in lots of interrupt
handlers. Also I didn't notice any speed change of my fans. They run
at the same "noise-level" with state 0 and 10.
"cooling_device2" (LCD) doesn't show this behaviour.

I run an Intel Atom N450 @ 1.66ghz (dual core or HT, I am not sure).
Both cooling_devices correspond to one of the CPUs.


Is there an easy way to debug this? Does running oprofile help? Or am
I just misunderstanding what "cooling_deviceX" does?

Regards
David
