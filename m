From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch] 2.4.x ACPI updates
Date: Fri, 22 Aug 2003 22:15:24 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC3@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo,
A small update to what you pulled this morning --
fixes config options CONFIG_ACPI_HT_ONLY and CONFIG_HOTPLUG_PCI_ACPI.

I'm looking forward to deleting these #ifdef CONFIG_ACPI_HT_ONLY
When we can (again) delete acpitable.[ch] in 2.4.23.

Please 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-2.4.22

This 

This will update the following files:

 drivers/hotplug/Config.in |    5 +++--
 include/asm-i386/acpi.h   |    7 +++++++
 include/linux/acpi.h      |    6 ++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/22 1.1107)
   linux-acpi-2.4.22.patch

ps. the plain patch is also available here:
http://prdownloads.sourceforge.net/acpi/acpi-20030813-2.4.22-rc2.diff?do
wnload
