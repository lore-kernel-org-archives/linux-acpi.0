From: David <dhardeman@gmail.com>
Subject: Why does my driver (drivers/input/misc/winbond-cir.c) break suspend?
Date: Tue, 9 Feb 2010 09:31:19 +0100
Message-ID: <96eeef951002090031o29529ef4jc43d8f3b0eace42c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:47505 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0BIIbV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2010 03:31:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I've been trying to debug a problem with my driver
(drivers/input/misc/winbond-cir.c) and suspend/resume.

If the driver is loaded, my test computer (Intel DG45FC motherboard)
survives one suspend/resume cycle but hangs (no pings, no magic sysrq,
etc) on the second suspend attempt (tested on 2.6.32.X and currently
testing on a git checkout from yesterday).

After sprinkling a lot of printk's everywhere, it seems that the kernel
freezes either in the below call, or at a random time soon after it:

drivers/pnp/driver.c:pnp_bus_suspend(), calls
pnp_dev->protocol->suspend()

Since this is a pnpacpi device, that is a call to:

drivers/pnp/pnpacpi/core.c:pnpacpi_disable_resources(), which calls the
ACPI "_DIS" method for the "UAR3" object.

Now, if I add a hack to my driver to remove the PNP_DISABLE flag from
device->capabilities (which means, AFAIK, that the above ACPI "_DIS"
method won't get called during suspend), I can reliably suspend and
resume, which is why I believe that this has got something to do with
ACPI even though the crash during suspend doesn't always happen while
"my" drivers _DIS method is being executed.

I've tried debugging the ACPI method by doing:
echo _DIS   >> /sys/module/acpi/parameters/trace_method_name
echo enable >> /sys/module/acpi/parameters/trace_state

and done a suspend/resume/suspend (i.e. caused the system to crash)
while capturing the output via netconsole. I can't derive any
interesting insights from the log though.

The decompiled dsdt table and the log capture from netconsole is
attached to:
http://bugzilla.kernel.org/show_bug.cgi?id=3D15257

The first suspend starts at 203.176799 (the first line of the log) and
ends around 209.083233 (line 2576), the resume starts right after the
suspend and ends around 211.358430 (line 2712), the second suspend
starts at 342.876299 (line 2718) and ends where the log file ends (with
a freeze).

Any suggestions on what to try next?

(Please CC me on any replies)

Regards,
David H=E4rdeman

(I'm using this email address instead of david@hardeman.nu for now
since my mail server is down)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
