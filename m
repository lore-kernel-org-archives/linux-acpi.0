From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Why does my driver (drivers/input/misc/winbond-cir.c) break
 suspend?
Date: Mon, 8 Feb 2010 11:13:35 +0100
Message-ID: <20100208101335.GA13907@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I've been trying to debug a problem with my driver=20
(drivers/input/misc/winbond-cir.c) and suspend/resume.

If the driver is loaded, my test computer (Intel DG45FC motherboard)=20
survives one suspend/resume cycle but hangs (no pings, no magic sysrq,=20
etc) on the second suspend attempt (tested on 2.6.32.X and currently=20
testing on a git checkout from yesterday).

After sprinkling a lot of printk's everywhere, it seems that the kernel=
=20
freezes either in the below call, or at a random time soon after it:

drivers/pnp/driver.c:pnp_bus_suspend(), calls
pnp_dev->protocol->suspend()

Since this is a pnpacpi device, that is a call to:

drivers/pnp/pnpacpi/core.c:pnpacpi_disable_resources(), which calls the=
=20
ACPI "_DIS" method for the "UAR3" object.

Now, if I add a hack to my driver to remove the PNP_DISABLE flag from=20
device->capabilities (which means, AFAIK, that the above ACPI "_DIS"=20
method won't get called during suspend), I can reliably suspend and=20
resume, which is why I believe that this has got something to do with=20
ACPI even though the crash during suspend doesn't always happen while=20
"my" drivers _DIS method is being executed.

I've tried debugging the ACPI method by doing:
echo _DIS   >> /sys/module/acpi/parameters/trace_method_name
echo enable >> /sys/module/acpi/parameters/trace_state

and done a suspend/resume/suspend (i.e. caused the system to crash)=20
while capturing the output via netconsole. I can't derive any=20
interesting insights from the log though.

The decompiled dsdt table and the log capture from netconsole is=20
attached to:
http://bugzilla.kernel.org/show_bug.cgi?id=3D15257

The first suspend starts at 203.176799 (the first line of the log) and=20
ends around 209.083233 (line 2576), the resume starts right after the=20
suspend and ends around 211.358430 (line 2712), the second suspend=20
starts at 342.876299 (line 2718) and ends where the log file ends (with=
=20
a freeze).

Any suggestions on what to try next?

(Please CC me on any replies)

--=20
David H=E4rdeman
